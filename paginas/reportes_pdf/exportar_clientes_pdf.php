<?php
// Archivo: exportar_clientes_pdf.php

// ----------------------------------------------------------------------
// SOLUCIÓN AL ERROR DE MEMORIA: Aumentar el límite de memoria solo para este script
ini_set('memory_limit', '2048M'); 
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
// IMPORTANTE: Asegúrate que esta ruta a Dompdf sea correcta para tu proyecto
// ----------------------------------------------------------------------
require_once '../../dompdf/autoload.inc.php'; 
require_once '../conexion.php'; 
require_once 'encabezado_reporte.php'; 


use Dompdf\Dompdf;
use Dompdf\Options;

// 1. CAPTURA Y SANEO DE PARÁMETROS (IDÉNTICO A reporte_clientes.php)
$id_municipio_filtro = isset($_GET['municipio']) ? $_GET['municipio'] : 'TODOS';
$id_parroquia_filtro = isset($_GET['parroquia']) ? $_GET['parroquia'] : 'TODOS';
$estado_contrato_filtro = isset($_GET['estado_contrato']) ? $_GET['estado_contrato'] : 'TODOS';
$id_vendedor_filtro = isset($_GET['vendedor']) ? $_GET['vendedor'] : 'TODOS';
$id_plan_filtro = isset($_GET['plan']) ? $_GET['plan'] : 'TODOS';
$cobros_estado_filtro = isset($_GET['estado_cobros']) ? $_GET['estado_cobros'] : 'TODOS';

// --- NUEVOS FILTROS ---
$id_olt_filtro = isset($_GET['olt']) ? $_GET['olt'] : 'TODOS';
$id_pon_filtro = isset($_GET['pon']) ? $_GET['pon'] : 'TODOS';
// -----------------------

$where_clause = " WHERE 1=1 "; 
$params = []; 
$types = ''; 
$clientes = [];

$join_clause = "
    LEFT JOIN municipio m ON c.id_municipio = m.id_municipio
    LEFT JOIN parroquia pa ON c.id_parroquia = pa.id_parroquia
    LEFT JOIN planes pl ON c.id_plan = pl.id_plan
    LEFT JOIN vendedores v ON c.id_vendedor = v.id_vendedor
    LEFT JOIN olt ol ON c.id_olt = ol.id_olt    /* AÑADIDO OLT */
    LEFT JOIN pon p ON c.id_pon = p.id_pon      /* AÑADIDO PON */
";

// Lógica de filtros (similar a reporte_clientes.php)
if ($id_municipio_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_municipio = ? "; $params[] = $id_municipio_filtro; $types .= 'i';
}
if ($id_parroquia_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_parroquia = ? "; $params[] = $id_parroquia_filtro; $types .= 'i';
}
if ($estado_contrato_filtro !== 'TODOS') {
    $where_clause .= " AND c.estado = ? "; $params[] = $estado_contrato_filtro; $types .= 's';
}
if ($id_vendedor_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_vendedor = ? "; $params[] = $id_vendedor_filtro; $types .= 'i';
}
if ($id_plan_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_plan = ? "; $params[] = $id_plan_filtro; $types .= 'i';
}

// --- FILTROS OLT Y PON ---
if ($id_olt_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_olt = ? "; $params[] = $id_olt_filtro; $types .= 'i';
}
if ($id_pon_filtro !== 'TODOS') {
    $where_clause .= " AND c.id_pon = ? "; $params[] = $id_pon_filtro; $types .= 'i';
}
// -------------------------

if ($cobros_estado_filtro !== 'TODOS') {
    $join_clause .= " JOIN cuentas_por_cobrar cxc ON c.id = cxc.id_contrato ";
    $where_clause .= " AND cxc.estado = ? ";
    $params[] = $cobros_estado_filtro;
    $types .= 's';
}

// 2. CONSULTA SQL FINAL
$sql = "
    SELECT 
        c.id, c.nombre_completo, c.cedula, c.telefono, c.estado AS estado_contrato,
        c.ip, 
        m.nombre_municipio AS municipio, pa.nombre_parroquia AS parroquia, 
        pl.nombre_plan AS plan, v.nombre_vendedor AS vendedor,
        ol.nombre_olt AS olt_nombre, p.nombre_pon AS pon_nombre /* SELECCIONAR NOMBRES DE OLT Y PON */
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
} else {
    $total_clientes = 0;
}

// ----------------------------------------------------------------------
// 3. GENERACIÓN DEL HTML PARA DOMPDF
// ----------------------------------------------------------------------

// Inicia la captura del buffer de salida
ob_start();
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte de Clientes_PDF</title>
       <link rel="icon" type="image/jpg" href="../../images/logo.jpg"/>
    <style>
        body { font-family: Arial, sans-serif; font-size: 10px; }
        h1 { font-size: 16px; text-align: center; margin-bottom: 5px; }
        .subtitle { font-size: 11px; text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #59acffff; padding: 4px; text-align: left; }
        th { background-color: #8fd0ffff; text-align: center; font-size: 11px; }
        .center { text-align: center; }
        .right { text-align: right; }
    </style>
</head>
<body>

     <?php 
    // Llamada a la función para obtener el encabezado estandarizado
    echo generar_encabezado_empresa('Reporte Filtrado De Contratos'); 
    ?>
    <div style="font-size: 11px; text-align: right; margin-bottom: 5px;">Total de Clientes Filtrados: <?php echo $total_clientes; ?></div>

    <table>
        <thead>
            <tr>
                <th style="width: 4%;">ID</th>
                <th style="width: 6%;">IP</th>
                <th style="width: 22%;">Cliente</th>
                <th style="width: 8%;">Cédula</th>
                <th style="width: 8%;">Teléfono</th>
                <th style="width: 8%;">Municipio</th>
                <th style="width: 8%;">Parroquia</th>
                <th style="width: 8%;">Plan</th>
                <th style="width: 8%;">Vendedor</th>
                <th style="width: 4%;">OLT</th>         <th style="width: 4%;">PON</th>         <th style="width: 10%;">Estado</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($total_clientes > 0): ?>
            <?php foreach ($clientes as $fila): ?>
            <tr>
                <td class="center"><?php echo $fila['id']; ?></td>
                <td class="center"><?php echo $fila['ip']; ?></td>
                <td><?php echo $fila['nombre_completo']; ?></td>
                <td class="center"><?php echo $fila['cedula']; ?></td>
                <td class="center"><?php echo $fila['telefono']; ?></td>
                <td><?php echo $fila['municipio']; ?></td>
                <td><?php echo $fila['parroquia']; ?></td>
                <td><?php echo $fila['plan']; ?></td>
                <td><?php echo $fila['vendedor']; ?></td>
                <td class="center"><?php echo $fila['olt_nombre'] ?? 'N/A'; ?></td>   <td class="center"><?php echo $fila['pon_nombre'] ?? 'N/A'; ?></td>   <td class="center"><?php echo $fila['estado_contrato']; ?></td>
            </tr>
            <?php endforeach; ?>
            <?php else: ?>
            <tr><td colspan="12" class="center">No hay clientes con los filtros seleccionados.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>

</body>
</html>

<?php
// Captura el contenido del buffer
$html = ob_get_clean();

// 4. CONFIGURACIÓN Y GENERACIÓN DEL PDF
$options = new Options();
$options->set('isHtml5ParserEnabled', true);
$options->set('isRemoteEnabled', true);
$options->set('defaultFont', 'Arial');

$dompdf = new Dompdf($options);
$dompdf->loadHtml($html, 'UTF-8'); 
$dompdf->setPaper('letter', 'landscape'); // Usamos landscape (horizontal) por la cantidad de columnas

// Renderiza el HTML a PDF
$dompdf->render();

// Envía el PDF al navegador
$dompdf->stream("Reporte_Clientes_" . date('Ymd_His') . ".pdf", ["Attachment" => false]);
exit(0);
?>