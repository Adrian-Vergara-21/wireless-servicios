<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';

// Verifica si se ha enviado el formulario
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Captura los datos del formulario
    $nombre_plan = $_POST['nombre_plan'];
    $monto = $_POST['monto'];
    $descripcion = $_POST['descripcion'];

    // Prepara la consulta SQL para insertar los datos
    $stmt = $conn->prepare("INSERT INTO planes (nombre_plan, monto, descripcion) VALUES (?, ?, ?)");
    $stmt->bind_param("sds", $nombre_plan, $monto, $descripcion); // 's' para string, 'd' para double/decimal

    // Ejecuta la consulta
    if ($stmt->execute()) {
        $message = "¡Plan registrado con éxito!";
        $message_class = 'success';
    } else {
        $message = "Error al registrar el plan: " . $stmt->error;
        $message_class = 'error';
    }

    // Cierra la declaración y la conexión
    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Planes</title>
    <link rel="stylesheet" href="../css/style3.css">
     <link rel="icon" type="image/jpg" href="../images/logo.jpg"/>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Registro de Planes</h1>
            <p>Wireless Supply, C.A.</p>
        </header>

        <?php if ($message): ?>
            <div class="message <?php echo $message_class; ?>">
                <?php echo htmlspecialchars($message); ?>
            </div>
        <?php endif; ?>

        <div class="step-section">
            <form action="registro_planes.php" method="POST">
                <div class="input-group">
                    <label for="nombre_plan">Nombre del Plan:</label>
                    <input type="text" id="nombre_plan" name="nombre_plan" required>
                </div>
                <div class="input-group">
                    <label for="monto">Monto (USD):</label>
                    <input type="number" id="monto" name="monto" step="0.01" required>
                </div>
                <div class="input-group">
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" rows="4"></textarea>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Registrar Plan</button>
                    <a href="gestion_planes.php" class="btn btn-secondary">Volver</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>