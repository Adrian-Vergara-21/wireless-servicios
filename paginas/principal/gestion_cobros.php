<?php
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
require_once '../conexion.php'; 

// Lógica para manejar mensajes de éxito/error de procesar_pago.php o el generador de cobro
$message = isset($_GET['message']) ? htmlspecialchars($_GET['message']) : '';
$message_class = isset($_GET['class']) ? htmlspecialchars($_GET['class']) : '';

// Inicializar variables de filtro (Recomendado, aunque DataTables se encargará)
$estado_filtro = isset($_GET['estado']) ? htmlspecialchars($_GET['estado']) : ''; 


// ***************************************************************
// ELIMINADA TODA LA LÓGICA DE PAGINACIÓN Y CONSULTAS PHP/SQL AQUÍ
// ***************************************************************

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
    <link href="../../css/datatables.min.css" rel="stylesheet"> <link rel="icon" type="image/jpg" href="../../images/logo.jpg"/>
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
        /* Estilos DataTables para los headers */
        #tablaCobros thead th {
            background-color: #2963bbff; /* Azul oscuro */
            color: white;
            text-align: center !important; 
        }
        #tablaCobros td {
            text-align: center; 
            white-space: nowrap; /* Evita que los botones se rompan en múltiples líneas */
        }

        /* Dentro de la etiqueta <style> en gestion_cobros.php */
        #tablaCobros td, #tablaCobros th {
            white-space: nowrap; /* Evita que el contenido se rompa en varias líneas */
        }

        /* Columna 1: Factura ID (hacemos que sea estrecha) */
        #tablaCobros td:nth-child(1), #tablaCobros th:nth-child(1) {
            width: 5%; 
        }

        /* Columna 2: Cliente (hacemos que sea más ancha) */
        #tablaCobros td:nth-child(2), #tablaCobros th:nth-child(2) {
            width: 25%;
            max-width: 250px; /* Útil para nombres largos */
            overflow: hidden; /* Oculta si el nombre es muy largo */
            text-overflow: ellipsis; /* Añade puntos suspensivos si el texto es cortado */
        }

        /* Columna 7: Acciones (mantenemos un ancho fijo para los botones) */
        #tablaCobros td:nth-child(7), #tablaCobros th:nth-child(7) {
            width: 200px; /* Ancho fijo para los botones */
            min-width: 180px; 
        }

        /* Columna 3, 4, 5, 6 (Emisión, Vencimiento, Monto, Estado) */
        /* El resto de las columnas se ajustarán automáticamente con el espacio restante */
        #tablaCobros td:nth-child(3), 
        #tablaCobros td:nth-child(4), 
        #tablaCobros td:nth-child(5), 
        #tablaCobros td:nth-child(6) {
            width: 10%; 
        }
        /* Reducir el tamaño de fuente para los iconos DENTRO de la columna de acciones */
        #tablaCobros td:nth-child(7) .btn i {
            font-size: 0.9em; /* 90% del tamaño de fuente normal */
        }

        /* Reducir el padding de los botones si son muy grandes */
        #tablaCobros td:nth-child(7) .btn {
            padding: 0.40rem 0.7rem; /* El padding por defecto de btn-sm */
            /* Si quieres reducirlo más: padding: 0.1rem 0.3rem; */
        }
        /* Reducir el tamaño de los badges de estado (columna 6) */
        #tablaCobros td:nth-child(6) .badge {
            font-size: 0.8em; 
            padding: 0.4em 0.7em; /* Ajusta el relleno */
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
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalGenerarCobro">
            <i class="fas fa-plus-circle me-2"></i> Generar Cobro Manual
        </button>
    </div>

    <?php if ($message): ?>
        <div class="alert alert-<?php echo $message_class; ?> alert-dismissible fade show" role="alert">
            <?php echo $message; ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>

<div class="table-responsive">
        <table id="tablaCobros" class="display table table-striped table-bordered">
            <thead>
                <tr>
                    <th class="text-center width=2%">Factura ID</th>
                    <th class="text-center width=25%">Cliente</th>
                    <th class="text-center width=10%">Emisión</th>
                    <th class="text-center width=10%">Vencimiento</th>
                    <th class="text-center width=10%">Monto</th>
                    <th class="text-center width=10%">Estado</th>
                    <th class="text-center width=20%" width="20%">Acciones</th>
                </tr>
            </thead>
            <tbody>
                </tbody>
        </table>
    </div>

</div> <div class="modal fade" id="modalPagar" tabindex="-1" aria-labelledby="modalPagarLabel" aria-hidden="true">
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

<div class="modal fade" id="modalGenerarCobro" tabindex="-1" aria-labelledby="modalGenerarCobroLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="modalGenerarCobroLabel">Generar Cargo Manual</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="generar_cobro_manual.php" method="POST">
        <div class="modal-body">
          
            <div class="mb-3 position-relative">
                <label for="contrato_search_modal" class="form-label">Buscar Contrato (Cliente)</label>
                <input type="text" class="form-control" id="contrato_search_modal" placeholder="Escribe ID o Nombre del Cliente" required autocomplete="off">
                
                <input type="hidden" name="id_contrato" id="id_contrato_hidden_modal" required>
                
                <div id="contrato_search_results_modal" class="list-group">
                    </div>
            </div>

            <div class="mb-3">
                <label for="monto_modal" class="form-label">Monto del Cargo ($)</label>
                <input type="number" step="0.01" min="0.01" class="form-control" name="monto" id="monto_modal" required>
            </div>
            
            <div class="mb-3">
                <label for="autorizado_por_modal" class="form-label">Autorizado por</label>
                <input type="text" class="form-control" name="autorizado_por" id="autorizado_por_modal" required placeholder="Ej: Juan Pérez / Gerente General">
            </div>

            <div class="mb-3">
                <label for="justificacion_modal" class="form-label">Justificación / Motivo Detallado</label>
                <textarea class="form-control" name="justificacion" id="justificacion_modal" rows="3" required placeholder="Ej: Costo de re-instalación de antena tras mudanza."></textarea>
            </div>
            
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

<div class="modal fade" id="modalExito" tabindex="-1" aria-labelledby="modalExitoLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="modalExitoLabel">✅ Operación Exitosa</h5> <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p id="modal_exito_mensaje_principal">El cobro ha sido registrado con éxito.</p> 
        <p id="modal_exito_mensaje_secundario">Factura ID: <strong id="id_cobro_operacion"></strong></p> </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">Aceptar</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="modalEliminarLabel">⚠️ Confirmar Eliminación</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="formEliminar" method="GET"> <div class="modal-body">
          <input type="hidden" name="id" id="id_cobro_eliminar">
          <p>¿Estás seguro de que deseas eliminar la cuenta por cobrar número <strong id="id_display_eliminar"></strong></p>
          <p>Asociada al cliente: <strong id="cliente_nombre_eliminar"></strong>?</p>
          <p class="text-danger">Esta acción no se puede deshacer.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-success" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-danger">Sí, Eliminar Permanentemente</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
<script src="../../js/jquery.min.js"></script>
<script src="../../js/datatables.min.js"></script> <script>
$(document).ready(function() {
    
    // -----------------------------------------------------
    // 1. INICIALIZACIÓN DE DATATABLES
    // -----------------------------------------------------
    $('#tablaCobros').DataTable({
        "order": [ // Ordenamiento por defecto (columna 3: Vencimiento, y luego Estado)
            [3, "asc"] 
        ],
        "iDisplayLength": 10, // Registros por página
        "language": { // Idioma
            "lengthMenu": "Mostrar _MENU_ registros por página",
            "info": "Mostrando página _PAGE_ de _PAGES_",
            "infoEmpty": "No hay registros disponibles",
            "infoFiltered": "(filtrada de _MAX_ registros)",
            "loadingRecords": "Cargando...",
            "processing": "Procesando...",
            "search": "Buscar:",
            "zeroRecords": "No se encontraron registros coincidentes",
            "paginate": {
                "next": "Siguiente",
                "previous": "Anterior"
            },
        },
        "bProcessing": true, // Habilita la barra de "Procesando"
        "bServerSide": true, // ¡Habilita el modo Server-Side!
        "sAjaxSource": "server_process_cobro.php", // ¡Apunta al nuevo script!
        "aoColumnDefs": [ // Definición de columnas
            { "bSortable": true, "aTargets": [ 0, 1, 2, 3, 4, 5 ] }, // Columnas ordenables
            { "bSearchable": true, "aTargets": [ 0, 1, 5 ] }, // Columnas buscables (ID, Cliente, Estado)
            { "bSortable": false, "bSearchable": false, "aTargets": [ 6 ] } // Columna Acciones
        ],
        "columnDefs": [
            // Definimos la última columna para que no se extienda y no se pueda ordenar/buscar
            { "targets": 6, "orderable": false, "searchable": false } 
        ]
    });
    
    // -----------------------------------------------------
    // 2. LÓGICA PARA EL MODAL DE PAGO (Ajustada a DataTables)
    // -----------------------------------------------------
    $('#modalPagar').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Botón que dispara el modal
        
        // Capturamos los datos que pasamos desde server_process_cobros.php
        var idCobro = button.data('id');
        var montoTotal = button.data('monto');
        var nombreCliente = button.data('nombre'); // Capturado desde el botón
        
        var modal = $(this);
        
        modal.find('#id_cobro_modal').val(idCobro);
        modal.find('#monto_pagado_modal').val(montoTotal);
        modal.find('#monto_display_modal').text('$' + parseFloat(montoTotal).toFixed(2));
        modal.find('#cliente_nombre_modal').text(nombreCliente);
    });
    
    // -----------------------------------------------------
    // 3. LÓGICA DE AUTOCOMPLETADO DENTRO DEL MODAL (Se mantiene)
    // -----------------------------------------------------
    const searchContratoInput = document.getElementById('contrato_search_modal');
    const hiddenContratoInput = document.getElementById('id_contrato_hidden_modal');
    const resultsContratoContainer = document.getElementById('contrato_search_results_modal');

    // ... (El código de autocompletado es idéntico al que tenías) ...
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
    // 3. LÓGICA PARA EL MODAL DE ELIMINACIÓN (Nuevo)
    // -----------------------------------------------------
    $('#modalEliminar').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Botón que dispara el modal
        
        // Capturamos los datos que pasamos desde server_process_cobros.php
        var idCobro = button.data('id');
        var nombreCliente = button.data('nombre');
        
        var modal = $(this);
        
        // Configuramos la URL de acción del formulario para que apunte a elimina_cobro.php
        modal.find('#formEliminar').attr('action', 'elimina_cobro.php'); 
        
        // Llenamos los campos y display del modal
        modal.find('#id_cobro_eliminar').val(idCobro);
        modal.find('#id_display_eliminar').text(idCobro);
        modal.find('#cliente_nombre_eliminar').text(nombreCliente);
    });

   // -----------------------------------------------------
// 4. MANEJO DE MENSAJES DE URL (ÉXITO O ERROR)
// -----------------------------------------------------
const urlParams = new URLSearchParams(window.location.search);
const message = urlParams.get('message');
const classType = urlParams.get('class');
const pagoExitosoId = urlParams.get('pago_exitoso'); 
const eliminacionExitosaId = urlParams.get('eliminacion_exitosa'); // <-- NUEVA BANDERA

const modalExitoElement = document.getElementById('modalExito');

// Función para mostrar el modal de éxito con un mensaje dinámico
function showSuccessModal(title, primaryMessage, operacionId) {
    if (!modalExitoElement) return;

    // Configurar el modal
    modalExitoElement.querySelector('#modalExitoLabel').textContent = title;
    modalExitoElement.querySelector('#modal_exito_mensaje_principal').textContent = primaryMessage;
    
    // Configurar el ID de la factura/operación
    modalExitoElement.querySelector('#id_cobro_operacion').textContent = operacionId; 
    
    // Mostrar el modal
    var modalExito = new bootstrap.Modal(modalExitoElement, { keyboard: false });
    modalExito.show();

    // Recargar DataTables (muy importante para reflejar la eliminación/pago)
    $('#tablaCobros').DataTable().ajax.reload(null, false); 

    // Limpiar la URL después de mostrar
    if (history.replaceState) {
        let newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
        
        const paramsToKeep = ['maintenance_done']; // Solo mantenemos la bandera
        let keptParams = [];

        urlParams.forEach((value, key) => {
            if (paramsToKeep.includes(key)) {
                keptParams.push(`${key}=${value}`);
            }
        });

        if (keptParams.length > 0) {
             newUrl += '?' + keptParams.join('&');
        }
        
        window.history.replaceState({path: newUrl}, '', newUrl);
    }
}

// 1. Manejo de ELIMINACIÓN EXITOSA
if (eliminacionExitosaId) {
    showSuccessModal(
        '✅ Eliminación Exitosa',
        'La cuenta por cobrar ha sido eliminada correctamente.',
        eliminacionExitosaId
    );
    return; // Salir después de mostrar el modal
} 

// 2. Manejo de PAGO EXITOSO
if (pagoExitosoId) {
    showSuccessModal(
        '✅ Pago Registrado',
        'El pago ha sido registrado con éxito.',
        pagoExitosoId
    );
    return;
} 

// 3. Manejo de COBRO MANUAL EXITOSO (aún usa el viejo método de 'message' y 'class')
if (message && classType === 'success') {
    // Intentar extraer el ID de la factura del mensaje
    const match = message.match(/Factura #(\d+)/);
    const idCobro = match ? match[1] : 'N/A';
    
    showSuccessModal(
        '✅ Cobro Registrado',
        'El cobro manual ha sido registrado con éxito.',
        idCobro
    );
    return;
}

// 4. Manejo de ERRORES (Se mantiene como alerta inline)
if (message && classType === 'danger') {
    // Si es un error, solo limpiamos la URL (la alerta se muestra por el PHP inicial)
    if (history.replaceState) {
        let newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
        const paramsToKeep = ['maintenance_done']; 
        let keptParams = [];
        urlParams.forEach((value, key) => {
            if (paramsToKeep.includes(key)) {
                keptParams.push(`${key}=${value}`);
            }
        });

        if (keptParams.length > 0) {
             newUrl += '?' + keptParams.join('&');
        }
        window.history.replaceState({path: newUrl}, '', newUrl);
    }
}

});
</script>

</body>
</html>