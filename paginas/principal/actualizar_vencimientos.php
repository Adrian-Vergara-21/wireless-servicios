<?php
// Script de mantenimiento que se puede ejecutar con Cron o al inicio del día.
require_once '../conexion.php'; 

// 1. Obtener la fecha actual en formato 'YYYY-MM-DD'
$fecha_hoy = date('Y-m-d');

// 2. Consulta SQL para actualizar los estados
// Criterios de actualización:
// - El estado actual debe ser 'PENDIENTE'.
// - La fecha de vencimiento (fecha_vencimiento) debe ser estrictamente menor a la fecha de hoy.
$sql = "
    UPDATE cuentas_por_cobrar
    SET estado = 'VENCIDO'
    WHERE estado = 'PENDIENTE'
    AND fecha_vencimiento < ? 
";

$stmt = $conn->prepare($sql);

if ($stmt) {
    // Vincula la fecha de hoy al placeholder (?)
    $stmt->bind_param("s", $fecha_hoy);
    $stmt->execute();
    
    // Obtener cuántas filas fueron afectadas
    $filas_actualizadas = $stmt->affected_rows;
    
  /*  echo "Proceso de actualización de vencimientos finalizado.\n";
    echo "Se marcaron {$filas_actualizadas} cuentas como 'VENCIDO'.\n";*/
    
    $stmt->close();
} else {
    echo "Error al preparar la consulta de actualización: " . $conn->error . "\n";
}

//$conn->close();

?>