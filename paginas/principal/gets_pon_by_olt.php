<?php
// get_pons_by_olt.php

// Asegúrate de que la ruta a tu archivo de conexión sea correcta
// Si este archivo está en la misma carpeta que nuevo.php, probablemente sea:
require_once '../conexion.php'; 

// Especificar que la respuesta es JSON
header('Content-Type: application/json');

// Recoger el ID de la OLT enviado por AJAX (usamos GET o POST, aquí usamos GET para simplicidad en la URL)
$id_olt = isset($_GET['id_olt']) ? (int)$_GET['id_olt'] : 0;

$response = ['error' => true, 'message' => 'ID de OLT no válido.'];

if ($id_olt > 0) {
    // Consulta para obtener los PONs asociados a esa OLT
    $stmt = $conn->prepare("SELECT id_pon, nombre_pon FROM pon WHERE id_olt = ? ORDER BY nombre_pon ASC");
    $stmt->bind_param("i", $id_olt);
    $stmt->execute();
    $result = $stmt->get_result();

    $pons = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $pons[] = $row;
        }
        $response = ['error' => false, 'pons' => $pons];
    } else {
        $response = ['error' => false, 'pons' => [], 'message' => 'No se encontraron PONs para la OLT seleccionada.'];
    }
    $stmt->close();
}

echo json_encode($response);
$conn->close();
?>