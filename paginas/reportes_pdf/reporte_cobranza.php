<?php
require_once '../conexion.php'; 

// 1. CAPTURA Y SANEO DE PARÁMETROS DE FILTRO
// Fechas: Por defecto, un mes atrás hasta hoy.
$fecha_inicio = isset($_GET['fecha_inicio']) ? $_GET['fecha_inicio'] : date('Y-m-d', strtotime('-30 days'));
$fecha_fin = isset($_GET['fecha_fin']) ? $_GET['fecha_fin'] : date('Y-m-d');
$estado_filtro = isset($_GET['estado']) ? $_GET['estado'] : 'TODOS'; // Filtro de estado
$cobros = [];
$total_monto = 0;
$total_vencido = 0;

// 2. CONSTRUCCIÓN DINÁMICA DE LA CLÁUSULA WHERE
$where_clause = " WHERE 1=1 "; // Inicializamos la cláusula WHERE
$params = []; // Array para almacenar los parámetros de la consulta preparada
$types = ''; // Cadena para almacenar los tipos de datos (s, i, d...)

// Filtro por Estado (Si no es 'TODOS')
if ($estado_filtro !== 'TODOS') {
    $where_clause .= " AND cxc.estado = ? ";
    $params[] = $estado_filtro;
    $types .= 's';
}

// Filtro por Rango de Fechas (Aplicado a la fecha de vencimiento)
if (!empty($fecha_inicio) && !empty($fecha_fin)) {
    // Usamos la fecha de vencimiento para que el reporte sea sobre la deuda
    $where_clause .= " AND cxc.fecha_vencimiento >= ? AND cxc.fecha_vencimiento <= ? ";
    $params[] = $fecha_inicio;
    $params[] = $fecha_fin;
    $types .= 'ss';
}

// 3. CONSULTA SQL BASE
$sql = "
    SELECT 
        cxc.id_cobro, 
        cxc.fecha_emision, 
        cxc.fecha_vencimiento, 
        cxc.monto_total, 
        cxc.estado,
        co.nombre_completo AS cliente,
        co.ip,
        DATEDIFF(CURRENT_DATE(), cxc.fecha_vencimiento) AS dias_vencido
    FROM cuentas_por_cobrar cxc
    JOIN contratos co ON cxc.id_contrato = co.id
    " . $where_clause . "
    ORDER BY cxc.fecha_vencimiento ASC
";

$stmt = $conn->prepare($sql);

if ($stmt) {
    // 4. ENLAZAR PARÁMETROS Y EJECUTAR
    if (!empty($params)) {
        // La función call_user_func_array es necesaria para bind_param cuando se usan parámetros dinámicos
        $stmt->bind_param($types, ...$params);
    }
    
    $stmt->execute();
    $resultado = $stmt->get_result();
    
    while ($fila = $resultado->fetch_assoc()) {
        $cobros[] = $fila;
        $total_monto += $fila['monto_total'];
        
        // Sumamos el total vencido si la factura está pendiente y vencida
        if ($fila['estado'] !== 'PAGADO' && $fila['dias_vencido'] > 0) {
            $total_vencido += $fila['monto_total'];
        }
    }
    $stmt->close();
} else {
    $error = "Error al preparar la consulta: " . $conn->error;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Cuentas por Cobrar</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style3.css" rel="stylesheet">
    <link href="../../css/style4.css" rel="stylesheet">
    <style>
        .badge.bg-success { background-color: #198754 !important; }
        .badge.bg-danger { background-color: #dc3545 !important; }
        .badge.bg-warning { background-color: #ffc107 !important; color: #000; }
        .vencido { background-color: #f8d7da; } /* Estilo para filas vencidas */
    </style>
</head>
<body>

<div class="container mt-5">
     <header class="register-header">
            <h1 class="text-center">Reporte Dinámico de Cuentas por Cobrar</h1>
            <p class="text-center">Wireless Supply, C.A.</p>
        </header>
    <a href="../menu.php" class="btn btn-secondary mb-3">Volver al Menu</a>

    <div class="card mb-4">
        <div class="card-header">Filtros</div>
        <div class="card-body">
            <form action="reporte_cobranza.php" method="GET" class="row g-3">
                
                <div class="col-md-3">
                    <label for="estado" class="form-label">Filtrar por Estado</label>
                    <select class="form-select" name="estado" id="estado">
                        <option value="TODOS" <?php echo ($estado_filtro == 'TODOS') ? 'selected' : ''; ?>>TODOS</option>
                        <option value="PENDIENTE" <?php echo ($estado_filtro == 'PENDIENTE') ? 'selected' : ''; ?>>PENDIENTE (Por Vencer)</option>
                        <option value="VENCIDO" <?php echo ($estado_filtro == 'VENCIDO') ? 'selected' : ''; ?>>VENCIDO</option>
                        <option value="PAGADO" <?php echo ($estado_filtro == 'PAGADO') ? 'selected' : ''; ?>>PAGADO</option>
                        <option value="CANCELADO" <?php echo ($estado_filtro == 'CANCELADO') ? 'selected' : ''; ?>>CANCELADO</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <label for="fecha_inicio" class="form-label">Vencimiento Desde</label>
                    <input type="date" class="form-control" name="fecha_inicio" value="<?php echo htmlspecialchars($fecha_inicio); ?>">
                </div>
                <div class="col-md-3">
                    <label for="fecha_fin" class="form-label">Vencimiento Hasta</label>
                    <input type="date" class="form-control" name="fecha_fin" value="<?php echo htmlspecialchars($fecha_fin); ?>">
                </div>

                <div class="col-md-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary me-2">Aplicar Filtros</button>

                <?php 
                    // 1. $_GET contiene todos los filtros (estado, fecha_inicio, fecha_fin)
                    // 2. http_build_query() convierte ese array en la cadena de URL:
                    //    ej: estado=VENCIDO&fecha_inicio=2025-01-01...
                    $export_params = http_build_query($_GET); 
                ?>

                <a href="exportar_cuentas_por_cobrar.php?<?php echo $export_params; ?>" class="btn btn-danger" target="_blank">
                    Exportar PDF
                </a>
                </div>
            </form>
        </div>
    </div>
    
    <?php if (isset($error)): ?>
        <div class="alert alert-danger"><?php echo $error; ?></div>
    <?php elseif (empty($cobros)): ?>
        <div class="alert alert-info">No se encontraron facturas con los filtros aplicados.</div>
    <?php else: ?>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <div class="card text-white bg-primary">
                    <div class="card-body">
                        <h5 class="card-title">TOTAL REPORTADO</h5>
                        <p class="card-text fs-2">$<?php echo number_format($total_monto, 2); ?></p>
                        <p class="card-text">Total del monto de todas las facturas en el reporte.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card text-white bg-danger">
                    <div class="card-body">
                        <h5 class="card-title">DEUDA VENCIDA</h5>
                        <p class="card-text fs-2">$<?php echo number_format($total_vencido, 2); ?></p>
                        <p class="card-text">Monto Pendiente con vencimiento en el pasado.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th style="color: white;">ID</th>
                        <th style="color: white;">Cliente</th>
                        <th style="color: white;">Emisión</th>
                        <th style="color: white;">Vencimiento</th>
                        <th style="color: white;">Días Vencido</th>
                        <th style="color: white;">Monto</th>
                        <th style="color: white;">Estado</th>
                        <th style="color: white;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($cobros as $fila): 
                        // Aplicar clase para destacar facturas vencidas
                        $row_class = '';
                        if ($fila['estado'] !== 'PAGADO' && $fila['dias_vencido'] > 0) {
                             $row_class = 'vencido';
                        }
                    ?>
                    <tr class="<?php echo $row_class; ?>">
                        <td><?php echo htmlspecialchars($fila['id_cobro']); ?></td>
                        <td><?php echo htmlspecialchars($fila['cliente']); ?></td>
                        <td><?php echo htmlspecialchars($fila['fecha_emision']); ?></td>
                        <td><?php echo htmlspecialchars($fila['fecha_vencimiento']); ?></td>
                        <td>
                            <?php 
                                if ($fila['estado'] !== 'PAGADO' && $fila['dias_vencido'] > 0) {
                                    echo "<span class='badge bg-danger'>{$fila['dias_vencido']} días</span>";
                                } elseif ($fila['estado'] == 'PAGADO') {
                                    echo "N/A";
                                } else {
                                    echo "A tiempo";
                                }
                            ?>
                        </td>
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
                            <a href="../principal/modifica_cobro.php?id=<?php echo $fila['id_cobro']; ?>" class="btn btn-sm btn-info">Detalles</a>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>

</div>

<script src="../../js/bootstrap.bundle.min.js"></script>
</body>
</html>