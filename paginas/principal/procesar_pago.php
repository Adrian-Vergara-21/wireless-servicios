<?php
require_once 'conexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Capturar y sanear los datos
    $id_cobro = $_POST['id_cobro'];
    // Aunque el monto pagado puede ser útil para auditoría, no lo necesitamos para el UPDATE de estado.
    // $monto_pagado = $_POST['monto_pagado']; 
    $referencia_pago = $conn->real_escape_string($_POST['referencia_pago']);

    // 2. Preparar la consulta UPDATE
    $estado = 'PAGADO';
    $fecha_pago = date('Y-m-d H:i:s'); 
    
    // Actualizamos el estado, la fecha de pago y la referencia.
    $stmt = $conn->prepare("UPDATE cuentas_por_cobrar SET estado = ?, fecha_pago = ?, referencia_pago = ? WHERE id_cobro = ?");
    
    if ($stmt === false) {
        header("Location: gestion_cobros.php?message=Error al preparar la consulta de pago.&class=danger");
        exit();
    }
    
    $stmt->bind_param("sssi", $estado, $fecha_pago, $referencia_pago, $id_cobro);

    // 3. Ejecutar la consulta
    if ($stmt->execute()) {
        header("Location: gestion_cobros.php?pago_exitoso=" . $id_cobro);
    } else {
        header("Location: gestion_cobros.php?message=Error al registrar el pago: " . urlencode($stmt->error) . "&class=danger");
    }

    $stmt->close();
    $conn->close();
} else {
    // Si no es un método POST, redirigir
    header("Location: gestion_cobros.php");
}
exit();
?>