<?php
// Incluye el archivo de conexión
require_once 'conexion.php';

$message = '';
$message_class = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Captura los datos del formulario
    $nombre_banco = $_POST['nombre_banco'];
    $numero_cuenta = $_POST['numero_cuenta'];
    $cedula_propietario = $_POST['cedula_propietario'];
    $nombre_propietario = $_POST['nombre_propietario'];

    // Prepara la consulta SQL para insertar los datos
    $stmt = $conn->prepare("INSERT INTO bancos (nombre_banco, numero_cuenta, cedula_propietario, nombre_propietario) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $nombre_banco, $numero_cuenta, $cedula_propietario, $nombre_propietario);

    // Ejecuta la consulta
    if ($stmt->execute()) {
        $message = "¡Banco registrado con éxito!";
        $message_class = 'success';
    } else {
        $message = "Error al registrar el banco: " . $stmt->error;
        $message_class = 'error';
    }

    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Bancos</title>
    <link rel="stylesheet" href="../css/style3.css">
     <link rel="icon" type="image/jpg" href="../images/logo.jpg"/>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Registro de Bancos</h1>
            <p>Wireless Supply, C.A.</p>
        </header>

        <?php if ($message): ?>
            <div class="message <?php echo $message_class; ?>">
                <?php echo htmlspecialchars($message); ?>
            </div>
        <?php endif; ?>

        <div class="step-section">
            <form action="registro_bancos.php" method="POST">
                <div class="input-group">
                    <label for="nombre_banco">Nombre del Banco:</label>
                    <input type="text" id="nombre_banco" name="nombre_banco" required>
                </div>
                <div class="input-group">
                    <label for="numero_cuenta">Número de Cuenta:</label>
                    <input type="text" id="numero_cuenta" name="numero_cuenta" required>
                </div>
                <div class="input-group">
                    <label for="cedula_propietario">Cédula del Propietario:</label>
                    <input type="text" id="cedula_propietario" name="cedula_propietario" required>
                </div>
                <div class="input-group">
                    <label for="nombre_propietario">Nombre del Propietario:</label>
                    <input type="text" id="nombre_propietario" name="nombre_propietario" required>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Registrar Banco</button>
                    <a href="gestion_bancos.php" class="btn btn-secondary">Volver</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>