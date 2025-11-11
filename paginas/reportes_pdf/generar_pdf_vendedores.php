<?php
// Muestra todos los errores de PHP para una mejor depuración
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Carga el autoloader de Dompdf, retrocediendo dos directorios
require '../../dompdf/vendor/autoload.php';

// Importa las clases de Dompdf
use Dompdf\Dompdf;
use Dompdf\Options;

// Incluye el archivo de conexión a la base de datos
require_once '../conexion.php';

// ---------------------------------------------------------------------------------
// AÑADIR: INCLUIR EL ENCABEZADO REUTILIZABLE
// ---------------------------------------------------------------------------------
require_once 'encabezado_reporte.php'; 

// Consulta para obtener todos los vendedores con las columnas correctas
$sql = "SELECT id_vendedor, nombre_vendedor, telefono_vendedor FROM vendedores ORDER BY nombre_vendedor ASC";
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
    <link rel="icon" type="image/jpg" href="../../images/logo.jpg"/>
    <meta charset="UTF-8">
    <title>Reporte de Vendedores</title>
    <style>
        body { font-family: Arial, sans-serif; font-size: 12px; }
        /* Se remueve h1 { text-align: center; } ya que el encabezado lo maneja */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #59acffff; padding: 8px; text-align: left; }
        th { background-color: #8fd0ffff; }
    </style>
</head>
<body>';

// ---------------------------------------------------------------------------------
// REEMPLAZAR: USAR LA FUNCIÓN DEL ENCABEZADO
// ---------------------------------------------------------------------------------
$html .= generar_encabezado_empresa('Reporte de Vendedores');

// Continuación de la tabla
$html .= '
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre del Vendedor</th>
                <th>Teléfono</th>
            </tr>
        </thead>
        <tbody>';

if (!empty($data)) {
    foreach ($data as $row) {
        $html .= '<tr>';
        $html .= '<td>' . htmlspecialchars($row['id_vendedor']) . '</td>';
        $html .= '<td>' . htmlspecialchars($row['nombre_vendedor']) . '</td>';
        $html .= '<td>' . htmlspecialchars($row['telefono_vendedor']) . '</td>';
        $html .= '</tr>';
    }
} else {
    $html .= '<tr><td colspan="3">No se encontraron registros.</td></tr>';
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
$dompdf->stream("reporte_vendedores.pdf", ["Attachment" => false]);
exit(0);