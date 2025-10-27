<?php
// Incluimos el script de mantenimiento para que actualice la BD antes de mostrar la tabla.
//require_once 'actualizar_vencimientos.php'; 

// ----------------------------------------------------------------------
// 1. LÓGICA DE REDIRECCIÓN PARA MANTENIMIENTO
// ----------------------------------------------------------------------

// Si no existe la bandera 'maintenance_done' en la URL, redirigimos a la pantalla de info.
if (!isset($_GET['maintenance_done'])) {
    // Redirige a la pantalla de información/ejecución y TERMINA la ejecución de este script
    header('Location: actualizacion_info.php');
    exit();
}


// Incluye su archivo de conexión. Asumimos que está en la misma ruta o se accede correctamente.
require_once 'conexion.php'; 

// Lógica para manejar mensajes de éxito/error de procesar_pago.php o el generador de cobro
$message = isset($_GET['message']) ? htmlspecialchars($_GET['message']) : '';
$message_class = isset($_GET['class']) ? htmlspecialchars($_GET['class']) : '';

// Inicializar variables de filtro (Recomendado)
$estado_filtro = isset($_GET['estado']) ? htmlspecialchars($_GET['estado']) : ''; 


// ----------------------------------------------------------------------
// 2. LÓGICA DE PAGINACIÓN
// ----------------------------------------------------------------------

// 1. Definir cuántos registros por página
$registros_por_pagina = 5; // Número de registros por página
$pagina_actual = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($pagina_actual - 1) * $registros_por_pagina;

// 2. Variables para la búsqueda y obtener el total de registros
$search_term = isset($_GET['search']) ? $conn->real_escape_string($_GET['search']) : '';
$where_clause = "";

// Si hay un término de búsqueda, construimos la cláusula WHERE
if (!empty($search_term)) {
    // Buscamos en el nombre del cliente O en el ID de la factura (o ID de contrato)
    $where_clause = " WHERE co.nombre_completo LIKE '%" . $search_term . "%' 
                      OR cxc.id_cobro LIKE '%" . $search_term . "%'
                      OR co.id LIKE '%" . $search_term . "%' ";
}

// 3. Obtener el total de registros (con filtro si aplica)
$sql_count = "SELECT COUNT(*) AS total FROM cuentas_por_cobrar cxc
              JOIN contratos co ON cxc.id_contrato = co.id " . $where_clause;
$resultado_count = $conn->query($sql_count);
$fila_count = $resultado_count->fetch_assoc();
$total_registros = $fila_count['total'];
$total_paginas = ceil($total_registros / $registros_por_pagina);


// ----------------------------------------------------------------------
// 3. CONSULTA SQL CON PAGINACIÓN (Añadimos la verificación de cargo manual)
// ----------------------------------------------------------------------

// Consulta SQL para obtener las cuentas por cobrar paginadas
$sql = "
    SELECT 
        cxc.id_cobro, 
        cxc.fecha_emision, 
        cxc.fecha_vencimiento, 
        cxc.monto_total, 
        cxc.estado,
        co.nombre_completo AS nombre_cliente,
        co.id AS id_contrato,
        -- Añadimos un campo booleano (1 si existe registro en la tabla de historial)
        (SELECT COUNT(h.id) FROM cobros_manuales_historial h WHERE h.id_cobro_cxc = cxc.id_cobro) AS es_manual
    FROM cuentas_por_cobrar cxc
    JOIN contratos co ON cxc.id_contrato = co.id
    " . $where_clause . " 
    ORDER BY 
        CASE cxc.estado 
            WHEN 'PENDIENTE' THEN 1 
            WHEN 'VENCIDO' THEN 2 
            ELSE 3 
        END, 
        cxc.fecha_vencimiento ASC
    LIMIT {$registros_por_pagina} 
    OFFSET {$offset}
";
$resultado = $conn->query($sql);
?>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Cuentas por Cobrar</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
     <link href="../../css/style3.css" rel="stylesheet">
     <link href="../../css/style4.css" rel="stylesheet">
     <!-- Asegúrate de tener Font Awesome para los iconos (si aplica) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Estilos CSS para los badges */
        .badge.bg-warning { background-color: #ffc107 !important; color: #000; }
        .badge.bg-danger { background-color: #dc3545 !important; }
        .badge.bg-success { background-color: #198754 !important; }
        /* Estilo para el autocompletado en modal */
        #contrato_search_results_modal { 
            max-height: 200px; 
            overflow-y: auto; 
            border: 1px solid #ccc; 
            border-top: none; 
            position: absolute; 
            width: 100%; 
            background-color: white;
            z-index: 1050; 
        }
    </style>
</head>
<body>

<div class="container mt-5">
     <header class="register-header">
        <h1 class="text-center pt-3 texto_modificado">Gestios De Cuentas Por Cobrar</h1>
		<p class= "text-center">Wireless Supply, C.A.</p>
    </header>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="../menu.php" class="btn btn-secondary">Volver al Menú</a>
        <!-- BOTÓN QUE AHORA ABRE EL MODAL DE COBRO MANUAL -->
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalGenerarCobro">
            <i class="fas fa-plus-circle me-2"></i> Generar Cobro Manual
        </button>
    </div>

    <!-- Mensajes de éxito/error (Se mostrarán aquí al volver del procesador PHP) -->
    <?php if ($message): ?>
        <div class="alert alert-<?php echo $message_class; ?> alert-dismissible fade show" role="alert">
            <?php echo $message; ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>

<!-- -----------------------------------------------------
// FORMULARIO DE BÚSQUEDA
// ----------------------------------------------------- -->
<form action="" method="get" class="search-form mb-4">
    <div class="input-group">
        
        <input type="hidden" name="maintenance_done" value="1">
        <input type="hidden" name="estado" value="<?php echo htmlspecialchars($estado_filtro); ?>"> 

        <!-- Input con ID para JavaScript -->
        <input type="text" 
               name="search" 
               id="searchInput" 
               class="form-control" 
               placeholder="Buscar por Contrato" 
               value="<?php echo htmlspecialchars($search_term); ?>"
               
               <?php 
               // Lógica para deshabilitar el campo si ya hay un término de búsqueda
               if (!empty($search_term)) {
                   echo 'disabled title="Limpie la búsqueda actual para escribir una nueva."';
               } 
               ?>
               autocomplete="off">
        
        <?php if (empty($search_term)): ?>
        <!-- Botón 'Buscar' - Solo visible si NO hay término de búsqueda -->
        <button type="submit" id="searchButton" class="btn btn-primary">Buscar
            <i class="fas fa-search"></i>
        </button>
        <?php else: ?>
        <!-- Botón 'Limpiar Búsqueda' - Solo visible si SÍ hay término de búsqueda -->
        <a href="gestion_cobros.php?maintenance_done=1" id="clearButton" class="btn btn-primary btn-danger" title="Limpiar Búsqueda">Limpiar Búsqueda
            <i class="fas fa-times"></i>
        </a>
        <?php endif; ?>
    </div>
</form>

    <div class="table-responsive">
        <table id="tablaCobros" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th style="color: white;">Factura ID</th>
                    <th style="color: white;">Cliente</th>
                    <th style="color: white;">Emisión</th>
                    <th style="color: white;">Vencimiento</th>
                    <th style="color: white;">Monto</th>
                    <th style="color: white;">Estado</th>
                    <th style="color: white;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                // -----------------------------------------------------
                // LÓGICA PARA VERIFICAR REGISTROS (PAGINACIÓN Y BÚSQUEDA)
                // -----------------------------------------------------
                if ($resultado->num_rows > 0): 
                ?>
                    <?php while ($fila = $resultado->fetch_assoc()): ?>
                    <tr>
                        <td>
                            <?php echo htmlspecialchars($fila['id_cobro']); ?>
                            <?php if ($fila['es_manual'] > 0): ?>
                                <span class="badge bg-info text-dark" title="Cargo generado manualmente">
                                    <i class="fas fa-pencil-alt"></i> Manual
                                </span>
                            <?php endif; ?>
                        </td>
                        <td><?php echo htmlspecialchars($fila['nombre_cliente']); ?></td>
                        <td><?php echo htmlspecialchars($fila['fecha_emision']); ?></td>
                        <td><?php echo htmlspecialchars($fila['fecha_vencimiento']); ?></td>
                        <td>$<?php echo number_format($fila['monto_total'], 2); ?></td>
                        
                        <td>
                            <span class="badge bg-<?php 
                                switch ($fila['estado']) {
                                    case 'PAGADO': echo 'success'; break;
                                    case 'VENCIDO': echo 'danger'; break;
                                    default: echo 'warning'; // PENDIENTE
                                }
                            ?>"><?php echo htmlspecialchars($fila['estado']); ?></span>
                        </td>
                        
                        <td>
                            <a href="modifica_cobro1.php?id=<?php echo $fila['id_cobro']; ?>" class="btn btn-sm btn-warning me-2">Modificar</a>

                            <a href="historial_pagos.php?id=<?php echo $fila['id_contrato']; ?>" class="btn btn-sm btn-info me-2">Historial</a>
                            
                            <!-- NUEVO BOTÓN PARA COBROS MANUALES -->
                            <?php if ($fila['es_manual'] > 0): ?>
                                <a href="acceder_historial.php?id_cobro=<?php echo $fila['id_cobro']; ?>" class="btn btn-sm btn-dark me-2" title="Ver Justificación y Autorización">
                                    <i class="fas fa-eye"></i> Justificación
                                </a>
                            <?php endif; ?>

                            <?php if ($fila['estado'] == 'PENDIENTE' || $fila['estado'] == 'VENCIDO'): ?>
                                <button type="button" class="btn btn-sm btn-success" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#modalPagar" 
                                    data-id="<?php echo $fila['id_cobro']; ?>"
                                    data-monto="<?php echo $fila['monto_total']; ?>">
                                    Registrar Pago
                                </button>
                            <?php else: ?>
                                <button class="btn btn-sm btn-secondary" disabled>Pagado</button>
                            <?php endif; ?>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                <?php else: ?>
                    <!-- Fila que se muestra cuando NO hay registros -->
                    <tr>
                        <td colspan="7" class="text-center p-4">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <strong>No se encontraron registros</strong> 
                            <?php if (!empty($search_term)): ?>
                                para el término de búsqueda "<?php echo htmlspecialchars($search_term); ?>".
                            <?php else: ?>
                                en el sistema.
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

<!-- -----------------------------------------------------
// NAVEGACIÓN DE PAGINACIÓN (CON BOTONES DE PRIMERA Y ÚLTIMA PÁGINA)
// ----------------------------------------------------- -->
<div class="container mt-3 mb-5">
    <?php 
    if ($total_paginas > 0): 
        // Calcular los límites de visualización
        $registro_inicial = $registros_por_pagina * ($pagina_actual - 1) + 1;
        // El registro final es el mínimo entre el límite de la página y el total real de registros
        $registro_final = min($registros_por_pagina * $pagina_actual, $total_registros);
    ?>
    <nav>
        <ul class="pagination justify-content-center">
            
            <!-- BOTÓN: PRIMERA PÁGINA (<<) -->
            <li class="page-item <?php echo ($pagina_actual <= 1) ? 'disabled' : ''; ?>">
                <a class="page-link" 
                   href="?maintenance_done=1&page=1&search=<?php echo htmlspecialchars($search_term); ?>" 
                   aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; Primera</span>
                </a>
            </li>

            <!-- BOTÓN: ANTERIOR (<) -->
            <li class="page-item <?php echo ($pagina_actual <= 1) ? 'disabled' : ''; ?>">
                <a class="page-link" 
                   href="?maintenance_done=1&page=<?php echo $pagina_actual - 1; ?>&search=<?php echo htmlspecialchars($search_term); ?>" 
                   aria-label="Previous">
                    <span aria-hidden="true">&laquo; Anterior</span>
                </a>
            </li>
            
            <!-- Generación de enlaces numerados -->
            <?php 
            // Definimos un rango de 5 páginas para mostrar (página actual - 2 a página actual + 2)
            $start_page = max(1, $pagina_actual - 2);
            $end_page = min($total_paginas, $pagina_actual + 2);

            if ($start_page > 1) { echo '<li class="page-item disabled"><span class="page-link">...</span></li>'; }

            for ($i = $start_page; $i <= $end_page; $i++): 
            ?>
                <li class="page-item <?php echo ($i == $pagina_actual) ? 'active' : ''; ?>">
                    <a class="page-link" 
                       href="?maintenance_done=1&page=<?php echo $i; ?>&search=<?php echo htmlspecialchars($search_term); ?>">
                       <?php echo $i; ?>
                    </a>
                </li>
            <?php 
            endfor; 
            
            if ($end_page < $total_paginas) { echo '<li class="page-item disabled"><span class="page-link">...</span></li>'; }
            ?>
            
            <!-- BOTÓN: SIGUIENTE (>) -->
            <li class="page-item <?php echo ($pagina_actual >= $total_paginas) ? 'disabled' : ''; ?>">
                <a class="page-link" 
                   href="?maintenance_done=1&page=<?php echo $pagina_actual + 1; ?>&search=<?php echo htmlspecialchars($search_term); ?>" 
                   aria-label="Next">
                    <span aria-hidden="true">Siguiente &raquo;</span>
                </a>
            </li>

            <!-- BOTÓN: ÚLTIMA PÁGINA (>>) -->
            <li class="page-item <?php echo ($pagina_actual >= $total_paginas) ? 'disabled' : ''; ?>">
                <a class="page-link" 
                   href="?maintenance_done=1&page=<?php echo $total_paginas; ?>&search=<?php echo htmlspecialchars($search_term); ?>" 
                   aria-label="Last">
                    <span aria-hidden="true">Última &raquo;&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
    
    <!-- RESUMEN DE REGISTROS CLARIFICADO -->
    <p class="text-center text-muted">
        Mostrando registros <strong><?php echo $registro_inicial; ?></strong> al <strong><?php echo $registro_final; ?></strong> de un total de <strong><?php echo $total_registros; ?></strong>.
    </p>

    <?php endif; ?>
</div>

</div> <!-- Cierre del container mt-5 inicial -->


<!-- ======================================================= -->
<!-- MODAL PARA REGISTRAR PAGO (Se mantiene) -->
<!-- ======================================================= -->
<div class="modal fade" id="modalPagar" tabindex="-1" aria-labelledby="modalPagarLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalPagarLabel">Registrar Pago</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="procesar_pago.php" method="POST">
        <div class="modal-body">
          <input type="hidden" name="id_cobro" id="id_cobro_modal">
          <p>Cliente: <strong id="cliente_nombre_modal"></strong></p>
          <p>Monto a pagar: <strong id="monto_display_modal"></strong></p>
          
          <div class="mb-3">
            <label for="monto_pagado" class="form-label">Monto Recibido ($)</label>
            <input type="number" step="0.01" class="form-control" name="monto_pagado" id="monto_pagado_modal" required>
          </div>
          <div class="mb-3">
            <label for="referencia_pago" class="form-label">Referencia/Transferencia/Recibo</label>
            <input type="text" class="form-control" name="referencia_pago" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          <button type="submit" class="btn btn-success">Confirmar y Registrar Pago</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- ======================================================= -->
<!-- MODAL PARA GENERAR COBRO MANUAL (NUEVA VERSIÓN DENTRO DE GESTION_COBROS) -->
<!-- ======================================================= -->
<div class="modal fade" id="modalGenerarCobro" tabindex="-1" aria-labelledby="modalGenerarCobroLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="modalGenerarCobroLabel">Generar Cargo Manual</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <!-- ACTION APUNTA AL PROCESADOR PHP, QUE AHORA DEBE MANEJAR LA REDIRECCIÓN -->
      <form action="generar_cobro_manual.php" method="POST">
        <div class="modal-body">
          
            <!-- 1. Búsqueda de Contrato -->
            <div class="mb-3 position-relative">
                <label for="contrato_search_modal" class="form-label">Buscar Contrato (Cliente)</label>
                <input type="text" class="form-control" id="contrato_search_modal" placeholder="Escribe ID o Nombre del Cliente" required autocomplete="off">
                
                <!-- ID real del contrato (Se usará el mismo ID del formulario anterior) -->
                <input type="hidden" name="id_contrato" id="id_contrato_hidden_modal" required>
                
                <!-- Contenedor de resultados de búsqueda -->
                <div id="contrato_search_results_modal" class="list-group">
                    <!-- Resultados de búsqueda se insertarán aquí -->
                </div>
            </div>

            <!-- 2. Monto -->
            <div class="mb-3">
                <label for="monto_modal" class="form-label">Monto del Cargo ($)</label>
                <input type="number" step="0.01" min="0.01" class="form-control" name="monto" id="monto_modal" required>
            </div>
            
            <!-- 3. Autorizado Por (Detalle de Historial) -->
            <div class="mb-3">
                <label for="autorizado_por_modal" class="form-label">Autorizado por</label>
                <input type="text" class="form-control" name="autorizado_por" id="autorizado_por_modal" required placeholder="Ej: Juan Pérez / Gerente General">
            </div>

            <!-- 4. Justificación (Detalle de Historial) -->
            <div class="mb-3">
                <label for="justificacion_modal" class="form-label">Justificación / Motivo Detallado</label>
                <textarea class="form-control" name="justificacion" id="justificacion_modal" rows="3" required placeholder="Ej: Costo de re-instalación de antena tras mudanza."></textarea>
            </div>
            
            <!-- 5. Fecha de Vencimiento -->
            <div class="mb-3">
                <label for="fecha_vencimiento_manual_modal" class="form-label">Fecha de Vencimiento</label>
                <input type="date" class="form-control" name="fecha_vencimiento" id="fecha_vencimiento_manual_modal" required>
            </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-success">Guardar Cobro Manual</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL DE ÉXITO (Se mantiene) -->
<div class="modal fade" id="modalExito" tabindex="-1" aria-labelledby="modalExitoLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="modalExitoLabel">✅ Cobro Registrado</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>El cobro manual ha sido registrado con éxito.</p>
        <p>Factura ID: <strong id="id_cobro_exitoso"></strong></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">Aceptar</button>
      </div>
    </div>
  </div>
</div>


<script src="../../js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function () {
    
    // -----------------------------------------------------
    // 1. LÓGICA DE AUTOCOMPLETADO DENTRO DEL MODAL
    // -----------------------------------------------------
    const searchContratoInput = document.getElementById('contrato_search_modal');
    const hiddenContratoInput = document.getElementById('id_contrato_hidden_modal');
    const resultsContratoContainer = document.getElementById('contrato_search_results_modal');

    searchContratoInput.addEventListener('input', function() {
        const searchTerm = this.value.trim();
        resultsContratoContainer.innerHTML = ''; 
        
        if (searchTerm.length < 3) {
            hiddenContratoInput.value = ''; 
            return;
        }

        if (this.timer) clearTimeout(this.timer);
        this.timer = setTimeout(() => {
            // Utilizamos el script buscar_contratos.php para la búsqueda AJAX
            fetch(`buscar_contratos.php?q=${encodeURIComponent(searchTerm)}`)
                .then(response => response.json())
                .then(data => {
                    resultsContratoContainer.innerHTML = '';
                    if (data.length > 0) {
                        data.forEach(contrato => {
                            const item = document.createElement('a');
                            item.href = '#';
                            item.classList.add('list-group-item', 'list-group-item-action');
                            item.innerHTML = `<strong>ID ${contrato.id}</strong>: ${contrato.nombre_completo}`;
                            
                            // Cuando el usuario selecciona un resultado
                            item.addEventListener('click', function(e) {
                                e.preventDefault();
                                searchContratoInput.value = `ID ${contrato.id}: ${contrato.nombre_completo}`;
                                hiddenContratoInput.value = contrato.id; // Guarda el ID del contrato
                                resultsContratoContainer.innerHTML = ''; // Oculta los resultados
                            });
                            resultsContratoContainer.appendChild(item);
                        });
                    } else {
                        const item = document.createElement('div');
                        item.classList.add('list-group-item', 'disabled');
                        item.textContent = 'No se encontraron clientes.';
                        resultsContratoContainer.appendChild(item);
                    }
                })
                .catch(error => console.error('Error fetching contracts:', error));
        }, 300); 
    });

    // Ocultar resultados de búsqueda si hacen clic fuera del campo
    document.addEventListener('click', function(e) {
        if (!searchContratoInput.contains(e.target) && !resultsContratoContainer.contains(e.target)) {
            resultsContratoContainer.innerHTML = '';
        }
    });

    // -----------------------------------------------------
    // 2. MANEJO DE MENSAJES DE URL (ÉXITO O ERROR)
    // -----------------------------------------------------
    const urlParams = new URLSearchParams(window.location.search);
    const message = urlParams.get('message');
    const classType = urlParams.get('class');
    const pagoExitosoId = urlParams.get('pago_exitoso'); // Usamos este para el modal de pago

    if (message && classType) {
        // Si hay un mensaje, significa que venimos de generar_cobro_manual.php
        // Si fue éxito, mostramos el modal de éxito de cobro
        if (classType === 'success') {
             // El procesador PHP incluye el ID del cobro en el mensaje. Lo extraemos si es necesario.
             const match = message.match(/Factura #(\d+)/);
             const idCobro = match ? match[1] : 'N/A';
             
             document.getElementById('id_cobro_exitoso').textContent = idCobro;
             
             var modalExitoCobro = new bootstrap.Modal(document.getElementById('modalExito'), {
                keyboard: false
            });
            modalExitoCobro.show();
        } 
        
        // Limpiamos la URL después de mostrar
        if (history.replaceState) {
            let newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
            
            const paramsToKeep = ['maintenance_done', 'page', 'search'];
            let keptParams = [];

            urlParams.forEach((value, key) => {
                if (paramsToKeep.includes(key) && key !== 'message' && key !== 'class') {
                    keptParams.push(`${key}=${value}`);
                }
            });

            if (keptParams.length > 0) {
                 newUrl += '?' + keptParams.join('&');
            }
            
            window.history.replaceState({path: newUrl}, '', newUrl);
        }
    } else if (pagoExitosoId) {
        // Lógica de modal de pago exitoso (la que ya tenía)
        document.getElementById('id_cobro_exitoso').textContent = pagoExitosoId;
        if (typeof bootstrap !== 'undefined') {
            var modalExitoPago = new bootstrap.Modal(document.getElementById('modalExito'), {
                keyboard: false
            });
            modalExitoPago.show();
            // Limpiar la URL después de mostrar (mejorado)
            if (history.replaceState) {
                let newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
                
                const paramsToKeep = ['maintenance_done', 'page', 'search'];
                let keptParams = [];

                urlParams.forEach((value, key) => {
                    if (paramsToKeep.includes(key) && key !== 'pago_exitoso') {
                        keptParams.push(`${key}=${value}`);
                    }
                });

                if (keptParams.length > 0) {
                     newUrl += '?' + keptParams.join('&');
                }
                
                window.history.replaceState({path: newUrl}, '', newUrl);
            }
        }
    }


    // -----------------------------------------------------
    // 3. LÓGICA PARA EL MODAL DE PAGO (Se mantiene)
    // -----------------------------------------------------
    var modalPagar = document.getElementById('modalPagar');
    modalPagar.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget; 
        var idCobro = button.getAttribute('data-id');
        var montoTotal = button.getAttribute('data-monto');
        
        var nombreCliente = button.closest('tr').querySelector('td:nth-child(2)').textContent;

        var modalIdCobro = modalPagar.querySelector('#id_cobro_modal');
        var modalMontoPagado = modalPagar.querySelector('#monto_pagado_modal');
        var modalMontoDisplay = modalPagar.querySelector('#monto_display_modal');
        var modalNombreCliente = modalPagar.querySelector('#cliente_nombre_modal');
        
        modalIdCobro.value = idCobro;
        modalMontoPagado.value = montoTotal;
        modalMontoDisplay.textContent = '$' + parseFloat(montoTotal).toFixed(2);
        modalNombreCliente.textContent = nombreCliente;
    });

});
</script>

</body>
</html>