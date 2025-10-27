<?php
// generar_pdf_pon.php

// Muestra todos los errores de PHP para una mejor depuración
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Carga el autoloader de Dompdf
require '../../dompdf/vendor/autoload.php';

// Importa las clases de Dompdf
use Dompdf\Dompdf;
use Dompdf\Options;

// Incluye el archivo de conexión a la base de datos y el encabezado
require_once '../conexion.php';
require_once 'encabezado_reporte.php'; 

// Consulta MODIFICADA para obtener todos los PONs y sus COMUNIDADES asociadas.
// Utilizamos GROUP_CONCAT para listar todas las comunidades por cada PON.
$sql = "SELECT 
            p.id_pon, 
            p.nombre_pon, 
            p.descripcion,
            -- Se cambia el nombre de la columna y la tabla de referencia a comunidad
            GROUP_CONCAT(c.nombre_comunidad ORDER BY c.nombre_comunidad SEPARATOR ', ') AS comunidades_atendidas
        FROM pon p
        -- Se cambia la tabla de unión de pon_parroquia a pon_comunidad
        LEFT JOIN pon_comunidad pc ON p.id_pon = pc.pon_id
        -- Se cambia la tabla de referencia de parroquia a comunidad
        LEFT JOIN comunidad c ON pc.comunidad_id = c.id_comunidad
        GROUP BY p.id_pon
        ORDER BY p.nombre_pon ASC";

$result = $conn->query($sql);

$data = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}
$conn->close();

// Construye el HTML para el PDF
$html = '
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de PONs</title>
    <style>
        body { font-family: Arial, sans-serif; font-size: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        /* Ajustamos el padding y la alineación para listas largas */
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; vertical-align: top; } 
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>';

// Usamos la función de encabezado que ya tienes
$html .= generar_encabezado_empresa('Reporte de PONs (Puntos de Distribución)');

// Continuación de la tabla
$html .= '
    <table>
        <thead>
            <tr>
                <th style="width: 5%;">ID</th>
                <th style="width: 20%;">Nombre del PON</th>
                <th style="width: 50%;">Comunidades Atendidas</th>
                <th style="width: 25%;">Descripción</th>
            </tr>
        </thead>
        <tbody>';

if (!empty($data)) {
    foreach ($data as $row) {
        // Se utiliza la nueva columna 'comunidades_atendidas'
        $comunidades = htmlspecialchars($row['comunidades_atendidas'] ?: 'Ninguna'); 
        $html .= '<tr>';
        $html .= '<td>' . htmlspecialchars($row['id_pon']) . '</td>';
        $html .= '<td>' . htmlspecialchars($row['nombre_pon']) . '</td>';
        $html .= '<td>' . $comunidades . '</td>';
        $html .= '<td>' . htmlspecialchars($row['descripcion']) . '</td>';
        $html .= '</tr>';
    }
} else {
    $html .= '<tr><td colspan="4">No se encontraron PONs registrados.</td></tr>';
}

$html .= '
        </tbody>
    </table>
</body>
</html>';

// Instancia y configura Dompdf
$options = new Options();
$dompdf = new Dompdf($options);

// Carga el HTML en Dompdf
$dompdf->loadHtml($html);

// Configura el tamaño y la orientación del papel
$dompdf->setPaper('A4', 'portrait');

// Renderiza el HTML como PDF
$dompdf->render();

// Envía el PDF al navegador
$dompdf->stream("reporte_pons.pdf", ["Attachment" => false]);
exit(0);