<?php
require_once '../conexion.php'; 

// 1. CAPTURA DE PARÁMETROS DE FILTRO
$id_municipio_filtro = isset($_GET['municipio']) ? $_GET['municipio'] : 'TODOS';
$id_parroquia_filtro = isset($_GET['parroquia']) ? $_GET['parroquia'] : 'TODOS';
$estado_contrato_filtro = isset($_GET['estado_contrato']) ? $_GET['estado_contrato'] : 'TODOS';
$id_vendedor_filtro = isset($_GET['vendedor']) ? $_GET['vendedor'] : 'TODOS';
$id_plan_filtro = isset($_GET['plan']) ? $_GET['plan'] : 'TODOS';
$cobros_estado_filtro = isset($_GET['estado_cobros']) ? $_GET['estado_cobros'] : 'TODOS'; 

// --- FILTROS DE OLT Y PON (Por ID) ---
$id_olt_filtro = isset($_GET['olt']) ? $_GET['olt'] : 'TODOS';
$id_pon_filtro = isset($_GET['pon']) ? $_GET['pon'] : 'TODOS'; // Capturamos el ID del PON
// ---------------------------------------

$clientes = [];
$total_clientes = 0;

// Consultas para cargar los filtros
$municipios = $conn->query("SELECT id_municipio, nombre_municipio FROM municipio ORDER BY nombre_municipio")->fetch_all(MYSQLI_ASSOC);
$vendedores = $conn->query("SELECT id_vendedor, nombre_vendedor FROM vendedores ORDER BY nombre_vendedor")->fetch_all(MYSQLI_ASSOC);
$planes = $conn->query("SELECT id_plan, nombre_plan FROM planes ORDER BY nombre_plan")->fetch_all(MYSQLI_ASSOC);
$estados_contrato = ['ACTIVO', 'INACTIVO', 'SUSPENDIDO', 'CANCELADO'];
$estados_cobros = ['PENDIENTE', 'VENCIDO', 'PAGADO', 'TODOS']; 

// --- CONSULTA PARA CARGAR OLTs ---
$olts = $conn->query("SELECT id_olt, nombre_olt FROM olt ORDER BY nombre_olt")->fetch_all(MYSQLI_ASSOC);

// --- CONSULTA PARA CARGAR PONs ---
$pons = $conn->query("SELECT id_pon, nombre_pon FROM pon ORDER BY nombre_pon")->fetch_all(MYSQLI_ASSOC);
// -----------------------------------------------------------

// Carga condicional de parroquias
$parroquias_filtradas = []; 
if ($id_municipio_filtro !== 'TODOS') {
    $stmt_parroquias = $conn->prepare("SELECT id_parroquia, nombre_parroquia FROM parroquia WHERE id_municipio = ? ORDER BY nombre_parroquia");
    if ($stmt_parroquias) {
        $stmt_parroquias->bind_param("i", $id_municipio_filtro);
        $stmt_parroquias->execute();
        $resultado_parroquias = $stmt_parroquias->get_result();
        $parroquias_filtradas = $resultado_parroquias->fetch_all(MYSQLI_ASSOC);
        $stmt_parroquias->close();
    }
}


// 2. CONSTRUCCIÓN DINÁMICA DE LA CLÁUSULA WHERE
$where_clause = " WHERE 1=1 "; 
$params = []; 
$types = ''; 

// Para reportes de clientes, siempre necesitamos JOINs
$join_clause = "
    LEFT JOIN municipio m ON c.id_municipio = m.id_municipio
    LEFT JOIN parroquia pa ON c.id_parroquia = pa.id_parroquia
    LEFT JOIN planes pl ON c.id_plan = pl.id_plan
    LEFT JOIN vendedores v ON c.id_vendedor = v.id_vendedor
    LEFT JOIN olt ol ON c.id_olt = ol.id_olt
    LEFT JOIN pon p ON c.id_pon = p.id_pon 
";
// NOTA: Se usan LEFT JOINs por si alguna columna no está asignada (es NULL), para no perder el cliente.

// 2.1. Filtro por Municipio
if ($id_municipio_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_municipio = ? ";
    $params[] = $id_municipio_filtro;
    $types .= 'i';
}

// 2.2. Filtro por Parroquia
if ($id_parroquia_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_parroquia = ? ";
    $params[] = $id_parroquia_filtro;
    $types .= 'i';
}

// 2.3. Filtro por Estado del Contrato
if ($estado_contrato_filtro !== 'TODOS') {
    $where_clause .= " AND c.estado = ? ";
    $params[] = $estado_contrato_filtro;
    $types .= 's';
}

// 2.4. Filtro por Vendedor
if ($id_vendedor_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_vendedor = ? ";
    $params[] = $id_vendedor_filtro;
    $types .= 'i';
}

// 2.5. Filtro por Plan
if ($id_plan_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_plan = ? ";
    $params[] = $id_plan_filtro;
    $types .= 'i';
}

// 2.6. Filtro por OLT
if ($id_olt_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_olt = ? ";
    $params[] = $id_olt_filtro;
    $types .= 'i';
}

// 2.7. Filtro por PON
if ($id_pon_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_pon = ? ";
    $params[] = $id_pon_filtro;
    $types .= 'i';
}
// -----------------------------------------------------

// 2.8. Filtro por Estado de Cobranza (Requiere un JOIN a cuentas_por_cobrar)
if ($cobros_estado_filtro !== 'TODOS') {
    $join_clause .= " INNER JOIN cuentas_por_cobrar cxc ON c.id = cxc.id_contrato "; 
    $where_clause .= " AND cxc.estado = ? ";
    $params[] = $cobros_estado_filtro;
    $types .= 's';
}


// 3. CONSULTA SQL FINAL
$sql = "
    SELECT 
        c.id, c.nombre_completo, c.cedula, c.telefono, c.estado AS estado_contrato, c.ip,
        m.nombre_municipio AS municipio, pa.nombre_parroquia AS parroquia, 
        pl.nombre_plan AS plan, v.nombre_vendedor AS vendedor,
        ol.nombre_olt AS olt_nombre, p.nombre_pon AS pon_nombre 
    FROM contratos c
    {$join_clause}
    {$where_clause}
    GROUP BY c.id 
    ORDER BY c.nombre_completo ASC
";

$stmt = $conn->prepare($sql);

if (!empty($params)) {
    $stmt->bind_param($types, ...$params); 
}

$stmt->execute();
$resultado = $stmt->get_result();

if ($resultado->num_rows > 0) {
    $clientes = $resultado->fetch_all(MYSQLI_ASSOC);
    $total_clientes = count($clientes);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Clientes</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style4.css" rel="stylesheet"> 
    <link href="../../css/style3.css" rel="stylesheet"> 
    <link href="../../css/all.min.css" rel="stylesheet">
       <link rel="icon" type="image/jpg" href="../../images/logo.jpg"/>
</head>
<body>
<style>
    .btn-personalizado {
    background-color: #1E8449; 
    border-color: #1E8449;
    color: white; 
}

.btn-personalizado:hover {
    background-color: #145A32;
    border-color: #145A32;
}
/* Estilos del botón Limpiar Búsqueda (Verdoso) */
    .btn-limpiar {
        background-color: #5cb85c; /* Verde claro/medio */
        border-color: #5cb85c;
        color: white;
    }
    
    .btn-limpiar:hover {
        background-color: #349634ff; /* Verde ligeramente más oscuro al pasar el mouse */
        border-color: #349634ff;
    }
</style>

<div class="container mt-5">
    <header class="register-header">
            <h1 class="text-center pt-3 texto_modificado">📊 Reporte y Análisis de Clientes</h1>
            <p class="text-center">Wireless Supply, C.A.</p>
        </header>
    <form method="GET" class="mb-4 p-4 border rounded bg-light">
        <div class="row g-3 align-items-end">
            
            <div class="col-md-3">
                <label for="estado_contrato" class="form-label">Estado de Contrato:</label>
                <select name="estado_contrato" id="estado_contrato" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php foreach ($estados_contrato as $estado): ?>
                        <option value="<?php echo $estado; ?>" <?php echo ($estado_contrato_filtro === $estado) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($estado); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3">
                <label for="municipio" class="form-label">Municipio:</label>
                <select name="municipio" id="municipio" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php foreach ($municipios as $m): ?>
                        <option value="<?php echo $m['id_municipio']; ?>" <?php echo ($id_municipio_filtro == $m['id_municipio']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($m['nombre_municipio']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3">
                <label for="parroquia" class="form-label">Parroquia:</label>
                <select name="parroquia" id="parroquia" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php 
                    if (!empty($parroquias_filtradas)):
                        foreach ($parroquias_filtradas as $p): ?>
                            <option value="<?php echo $p['id_parroquia']; ?>" <?php echo ($id_parroquia_filtro == $p['id_parroquia']) ? 'selected' : ''; ?>>
                                <?php echo htmlspecialchars($p['nombre_parroquia']); ?>
                            </option>
                        <?php endforeach;
                    endif;
                    ?>
                </select>
            </div>
            
            <div class="col-md-3">
                <label for="plan" class="form-label">Plan:</label>
                <select name="plan" id="plan" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php foreach ($planes as $pl): ?>
                        <option value="<?php echo $pl['id_plan']; ?>" <?php echo ($id_plan_filtro == $pl['id_plan']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($pl['nombre_plan']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3">
                <label for="vendedor" class="form-label">Vendedor:</label>
                <select name="vendedor" id="vendedor" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php foreach ($vendedores as $v): ?>
                        <option value="<?php echo $v['id_vendedor']; ?>" <?php echo ($id_vendedor_filtro == $v['id_vendedor']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($v['nombre_vendedor']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3">
                <label for="olt" class="form-label">OLT:</label>
                <select name="olt" id="olt" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php foreach ($olts as $o): ?>
                        <option value="<?php echo $o['id_olt']; ?>" <?php echo ($id_olt_filtro == $o['id_olt']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($o['nombre_olt']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            
            <div class="col-md-3">
                <label for="pon" class="form-label">PON:</label>
                <select name="pon" id="pon" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php foreach ($pons as $p): ?>
                        <option value="<?php echo htmlspecialchars($p['id_pon']); ?>" <?php echo ($id_pon_filtro == $p['id_pon']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($p['nombre_pon']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3">
                <label for="estado_cobros" class="form-label">Estado de Cobranza (Factura):</label>
                <select name="estado_cobros" id="estado_cobros" class="form-select">
                    <option value="TODOS">TODOS</option>
                    <?php foreach ($estados_cobros as $est): ?>
                        <option value="<?php echo $est; ?>" <?php echo ($cobros_estado_filtro === $est) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($est); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3 offset-md-3">
                <button type="submit" class="btn btn-primary w-100 "><i class="fas fa-filter"></i> Aplicar Filtros</button>
            </div>
            
             <div class="col-md-3">
                <a href="reporte_clientes.php" class="btn btn-limpiar w-100"><i class="fas fa-redo"></i> Limpiar Búsqueda</a>
            </div>
            
        </div>
    </form>
    
    <div class="alert alert-info text-center h4" role="alert">
        Se Han Encontrado "<?php echo number_format($total_clientes, 0, ',', '.'); ?>" Clientes Con Los Filtros Seleccionados.
    </div>
    
    
    <div class="d-flex justify-content-between mb-3">
    
    <a href="../menu.php" class="btn btn-secondary">
        Volver al Menú
    </a>

    <a href="exportar_clientes_pdf.php?<?php echo http_build_query($_GET); ?>" 
       class="btn btn-danger" 
       target="_blank">
        <i class="fas fa-file-pdf"></i> Exportar a PDF (<?php echo $total_clientes; ?>)
    </a>
    <a href="exportar_clientes_excel.php?municipio=<?php echo $id_municipio_filtro; ?>&parroquia=<?php echo $id_parroquia_filtro; ?>&estado_contrato=<?php echo $estado_contrato_filtro; ?>&vendedor=<?php echo $id_vendedor_filtro; ?>&plan=<?php echo $id_plan_filtro; ?>&olt=<?php echo $id_olt_filtro; ?>&pon=<?php echo $id_pon_filtro; ?>&estado_cobros=<?php echo $cobros_estado_filtro; ?>" class="btn btn-personalizado">
    Exportar a Excel (.CSV) 📊
</a>
    
</div>

    <?php if ($total_clientes > 0): ?>
        <div class="table-responsive-sm mt-4">
            <table class="table table-striped table-bordered table-sm">
                <thead>
                    <tr>
                        <th class="text-center" style="color: white;">ID</th>
                        <th class="text-center" style="color: white;">IP</th>
                        <th class="text-center" style="color: white;">Cliente</th>
                        <th class="text-center" style="color: white;">Cédula</th>
                        <th class="text-center" style="color: white;">Teléfono</th>
                        <th class="text-center" style="color: white;">Municipio</th>
                        <th class="text-center" style="color: white;">Parroquia</th>
                        <th class="text-center" style="color: white;">Plan</th>
                        <th class="text-center" style="color: white;">Vendedor</th>
                        <th class="text-center" style="color: white;">OLT</th>
                        <th class="text-center" style="color: white;">PON</th>
                        <th class="text-center" style="color: white;">Estado Contrato</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($clientes as $fila): ?>
                    <tr>
                        <td class="text-center"><?php echo htmlspecialchars($fila['id']); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['ip']); ?></td>
                        <td><?php echo htmlspecialchars($fila['nombre_completo']); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['cedula']); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['telefono']); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['municipio'] ?? 'N/A'); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['parroquia'] ?? 'N/A'); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['plan'] ?? 'N/A'); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['vendedor'] ?? 'N/A'); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['olt_nombre'] ?? 'N/A'); ?></td>
                        <td class="text-center"><?php echo htmlspecialchars($fila['pon_nombre'] ?? 'N/A'); ?></td>
                        <td class="text-center">
                            <span class="badge bg-<?php 
                                switch ($fila['estado_contrato']) {
                                    case 'ACTIVO': echo 'success'; break;
                                    case 'SUSPENDIDO': echo 'warning'; break;
                                    case 'INACTIVO': echo 'secondary'; break;
                                    case 'CANCELADO': echo 'danger'; break;
                                    default: echo 'info';
                                }
                            ?>">
                                <?php echo htmlspecialchars($fila['estado_contrato']); ?>
                            </span>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php else: ?>
        <div class="alert alert-warning text-center mt-4" role="alert">
            No se encontraron clientes que coincidan con los filtros aplicados.
        </div>
    <?php endif; ?>

</div>

<script src="../../js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const selectMunicipio = document.getElementById('municipio');
        const selectParroquia = document.getElementById('parroquia');
        
        // Guardar el valor de la parroquia seleccionada en el filtro inicial
        const parroquiaFiltroInicial = selectParroquia.value;

        selectMunicipio.addEventListener('change', function() {
            const idMunicipio = this.value;

            // Limpiar el select de Parroquias, manteniendo la opción 'TODOS'
            selectParroquia.innerHTML = '<option value="TODOS">TODOS</option>';

            if (idMunicipio !== 'TODOS') {
                // Realizar la petición AJAX
                fetch('obtener_parroquias.php?id_municipio=' + idMunicipio)
                    .then(response => response.json())
                    .then(parroquias => {
                        parroquias.forEach(parroquia => {
                            const option = document.createElement('option');
                            option.value = parroquia.id_parroquia;
                            option.textContent = parroquia.nombre_parroquia;
                            
                            // Si estamos en la carga inicial y el municipio fue cambiado por JS, 
                            // necesitamos que la parroquia filtrada se mantenga seleccionada.
                            if (parroquia.id_parroquia == parroquiaFiltroInicial) {
                                option.selected = true;
                            }
                            
                            selectParroquia.appendChild(option);
                        });
                    })
                    .catch(error => console.error('Error al obtener parroquias:', error));
            }
        });
        
        // Ejecutar el evento 'change' en la carga inicial si hay un municipio preseleccionado
        // Esto asegura que si el usuario regresa con filtros aplicados, la lista de parroquias sea correcta.
        if (selectMunicipio.value !== 'TODOS' && selectParroquia.options.length <= 1) {
            selectMunicipio.dispatchEvent(new Event('change'));
        }
        
    });
</script>
</body>
</html>