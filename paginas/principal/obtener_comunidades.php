<?php
// obtener_comunidades.php
require '../conexion.php'; 

header('Content-Type: application/json');

$response = [];

if (isset($_POST['id_parroquia']) && is_numeric($_POST['id_parroquia'])) {
    $id_parroquia = $conn->real_escape_string($_POST['id_parroquia']);
    
    $sql = "SELECT id_comunidad, nombre_comunidad 
            FROM comunidad 
            WHERE id_parroquia = ? 
            ORDER BY nombre_comunidad ASC";
            
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id_parroquia);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            // El formato es ID: Nombre
            $response[$row['id_comunidad']] = htmlspecialchars($row['nombre_comunidad']);
        }
    }
    $stmt->close();
}

$conn->close();
echo json_encode($response);
?>