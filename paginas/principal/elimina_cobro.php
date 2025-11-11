<?php
// ¡AÑADE ESTO PARA DEBUGGING!
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require '../conexion.php';

// Asegúrate de que el ID esté presente y sea un número
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    $error_message = "Error: ID de cobro no válido.";
    header("Location: gestion_cobros.php?maintenance_done=1&message=" . urlencode($error_message) . "&class=danger");
    exit();
}

$id_cobro = (int)$_GET['id'];
$success_message = "";

// 1. Obtener el estado del cobro antes de eliminar (para validación)
$stmt_check = $conn->prepare("SELECT estado FROM cuentas_por_cobrar WHERE id_cobro = ?");
$stmt_check->bind_param("i", $id_cobro);
$stmt_check->execute();
$result_check = $stmt_check->get_result();
$cobro = $result_check->fetch_assoc();
$stmt_check->close();

if (!$cobro) {
    $error_message = "Error: El cobro #{$id_cobro} no existe.";
    header("Location: gestion_cobros.php?maintenance_done=1&message=" . urlencode($error_message) . "&class=danger");
    exit();
}

if ($cobro['estado'] == 'PAGADO') {
    $error_message = "Error: No se puede eliminar un cobro que ya está PAGADO.";
    header("Location: gestion_cobros.php?maintenance_done=1&message=" . urlencode($error_message) . "&class=danger");
    exit();
}

// ***************************************************************
// PASO 1: ELIMINAR REGISTROS DE LA TABLA HIJA (cobros_manuales_historial)
// ***************************************************************
$stmt_historial = $conn->prepare("DELETE FROM cobros_manuales_historial WHERE id_cobro_cxc = ?");
$stmt_historial->bind_param("i", $id_cobro);
$stmt_historial->execute(); 
$stmt_historial->close();
// Si esta ejecución falla, no se detiene el script, pero deberías considerarlo para manejo de errores avanzado.

// ***************************************************************
// PASO 2: ELIMINAR EL REGISTRO DE LA TABLA PADRE (cuentas_por_cobrar)
// ***************************************************************
$stmt = $conn->prepare("DELETE FROM cuentas_por_cobrar WHERE id_cobro = ?");
$stmt->bind_param("i", $id_cobro);

if ($stmt->execute()) {
    $success_message = "Éxito: La cuenta por cobrar #{$id_cobro} ha sido eliminada correctamente.";
    header("Location: gestion_cobros.php?maintenance_done=1&eliminacion_exitosa=" . $id_cobro);
} else {
    $error_message = "Error al eliminar la cuenta por cobrar #{$id_cobro}: " . $stmt->error;
    header("Location: gestion_cobros.php?maintenance_done=1&message=" . urlencode($error_message) . "&class=danger");
}

$stmt->close();
$conn->close();
exit();

?>