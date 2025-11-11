<?php
// Script para buscar contratos por ID o nombre del cliente (usado por AJAX)

header('Content-Type: application/json');

// Incluye su archivo de conexión
require_once '../conexion.php'; 

$resultados = [];
$search_query = isset($_GET['q']) ? $conn->real_escape_string($_GET['q']) : '';

if (strlen($search_query) >= 3) {
    // Buscamos contratos activos (o según su lógica de contratos)
    $sql = "SELECT id, nombre_completo 
            FROM contratos 
            WHERE nombre_completo LIKE '%" . $search_query . "%' 
               OR id LIKE '%" . $search_query . "%'
            LIMIT 10"; // Limitar a 10 resultados para no sobrecargar
    
    $resultado = $conn->query($sql);

    if ($resultado && $resultado->num_rows > 0) {
        while ($fila = $resultado->fetch_assoc()) {
            $resultados[] = $fila;
        }
    }
}

echo json_encode($resultados);

$conn->close();
?>
