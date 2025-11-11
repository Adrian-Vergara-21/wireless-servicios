<?php
// Asegúrate de incluir tu archivo de conexión aquí también para que $conn esté disponible
require_once '../conexion.php'; 

// Asegurarse de que el script solo devuelva datos JSON
header('Content-Type: application/json');

if (isset($_POST['id']) && !empty($_POST['id'])) {
    
    // ⚠️ Usamos $conn para la sanitización
    $municipioID = $conn->real_escape_string($_POST['id']);

    // Consulta con el ID del municipio
    $sql = "SELECT id_parroquia, nombre_parroquia 
            FROM parroquia 
            WHERE id_municipio = '$municipioID' 
            ORDER BY nombre_parroquia ASC";
    
    // ⚠️ Usamos $conn para la consulta
    $resultado = $conn->query($sql);
    
    $parroquias = array();

    if ($resultado && $resultado->num_rows > 0) {
        while ($fila = $resultado->fetch_assoc()) {
            $parroquias[$fila['id_parroquia']] = $fila['nombre_parroquia'];
        }
    }
    
    echo json_encode($parroquias);
    
} else {
    // Retorna una lista vacía si el ID no es válido
    echo json_encode([]);
}

// ⚠️ NOTA: El cierre de la conexión ($conn->close()) generalmente se hace
// al final de la ejecución de tu script principal, no necesariamente aquí.
// Pero si solo usas la conexión para esta consulta, podrías cerrarla aquí.
?>