<?php
require_once 'conexion.php'; 

$id_cobro = isset($_GET['id']) ? intval($_GET['id']) : 0;
$cobro_data = null;
$message = '';
$message_class = '';

if ($id_cobro <= 0) {
    die("Error: Cobro no especificado.");
}

// --- LÓGICA DE ACTUALIZACIÓN (Si el formulario fue enviado) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id_cobro_form'])) {
    $id_cobro_update = $_POST['id_cobro_form'];
    $monto_total = $_POST['monto_total'];
    $fecha_vencimiento = $_POST['fecha_vencimiento'];
    $estado = $_POST['estado'];
    
    $stmt = $conn->prepare("UPDATE cuentas_por_cobrar SET monto_total = ?, fecha_vencimiento = ?, estado = ? WHERE id_cobro = ?");
    $stmt->bind_param("dssi", $monto_total, $fecha_vencimiento, $estado, $id_cobro_update);
    
    if ($stmt->execute()) {
        $message = "Cobro #{$id_cobro_update} actualizado con éxito.";
        $message_class = 'success';
        // Si el estado es Pagado, se recomienda usar el modal de pago para registrar la ref/fecha_pago, pero aquí solo actualizamos el estado.
    } else {
        $message = "Error al actualizar: " . $stmt->error;
        $message_class = 'danger';
    }
    $stmt->close();
}
// -----------------------------------------------------------------


// --- LÓGICA PARA CARGAR DATOS (Inicial o después de la actualización) ---
$sql_select = "
    SELECT 
        cxc.*,
        co.nombre_completo AS nombre_cliente
    FROM cuentas_por_cobrar cxc
    JOIN contratos co ON cxc.id_contrato = co.id
    WHERE cxc.id_cobro = ?
";
$stmt_select = $conn->prepare($sql_select);
$stmt_select->bind_param("i", $id_cobro);
$stmt_select->execute();
$resultado = $stmt_select->get_result();

if ($resultado->num_rows === 1) {
    $cobro_data = $resultado->fetch_assoc();
} else {
    die("Error: Factura no encontrada.");
}
$stmt_select->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar Cobro #<?php echo $id_cobro; ?></title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style3.css" rel="stylesheet">


</head>
<body>

<div class="container mt-5">
    <h1 class="text-center pt-3 texto_modificado">Modificar Cobros</h1>
		 <p class= "text-center">Wireless Supply, C.A.</p>
    <p>Cobro #<?php echo htmlspecialchars($cobro_data['id_cobro']); ?></p>
    <?php if ($message): ?>
        <div class="alert alert-<?php echo $message_class; ?>"><?php echo $message; ?></div>
    <?php endif; ?>

    <p>Cliente: <strong><?php echo htmlspecialchars($cobro_data['nombre_cliente']); ?></strong> (Contrato ID: <?php echo htmlspecialchars($cobro_data['id_contrato']); ?>)</p>

    <form action="modifica_cobro.php?id=<?php echo $id_cobro; ?>" method="POST">
        <input type="hidden" name="id_cobro_form" value="<?php echo htmlspecialchars($id_cobro); ?>">

        <div class="mb-3">
            <label for="monto_total" class="form-label">Monto Total ($)</label>
            <input type="number" step="0.01" class="form-control" name="monto_total" 
                   value="<?php echo htmlspecialchars($cobro_data['monto_total']); ?>" required>
        </div>

        <div class="mb-3">
            <label for="fecha_vencimiento" class="form-label">Fecha de Vencimiento</label>
            <input type="date" class="form-control" name="fecha_vencimiento" 
                   value="<?php echo htmlspecialchars($cobro_data['fecha_vencimiento']); ?>" required>
        </div>
        
        <div class="mb-3">
            <label for="estado" class="form-label">Estado</label>
            <select name="estado" class="form-select" required>
                <option value="PENDIENTE" <?php echo ($cobro_data['estado'] == 'PENDIENTE') ? 'selected' : ''; ?>>PENDIENTE</option>
                <option value="PAGADO" <?php echo ($cobro_data['estado'] == 'PAGADO') ? 'selected' : ''; ?>>PAGADO</option>
                <option value="VENCIDO" <?php echo ($cobro_data['estado'] == 'VENCIDO') ? 'selected' : ''; ?>>VENCIDO</option>
                <option value="CANCELADO" <?php echo ($cobro_data['estado'] == 'CANCELADO') ? 'selected' : ''; ?>>CANCELADO</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Referencia de Pago Actual:</label>
            <p><?php echo $cobro_data['referencia_pago'] ? htmlspecialchars($cobro_data['referencia_pago']) : 'N/A'; ?></p>
        </div>

        <button type="submit" class="btn btn-success">Guardar Cambios</button>
        <a href="gestion_cobros.php?maintenance_done=1" class="btn btn-secondary">Cancelar y Volver</a>
    </form>
</div>

</body>
</html>