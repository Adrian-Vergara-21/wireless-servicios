<?php
// Incluye el archivo de conexión. La variable $conn estará disponible aquí.
require_once 'conexion.php';

// Variables para los mensajes
$message = '';
$message_class = '';

// Verifica si el formulario fue enviado
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_vendedor = $_POST['id_vendedor'];
    $nombre_vendedor = $_POST['nombre_vendedor'];
    $telefono_vendedor = $_POST['telefono_vendedor'];

    // Validar que el ID de vendedor no exista
    $stmt = $conn->prepare("SELECT `id_vendedor` FROM `vendedores` WHERE `id_vendedor` = ?");
    $stmt->bind_param("s", $id_vendedor);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        // El ID ya existe
        $message = "El ID de vendedor '{$id_vendedor}' ya está registrado. Por favor, elige otro.";
        $message_class = 'error';
    } else {
        // El ID no existe, se puede registrar
        $stmt = $conn->prepare("INSERT INTO `vendedores` (`id_vendedor`, `nombre_vendedor`, `telefono_vendedor`) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $id_vendedor, $nombre_vendedor, $telefono_vendedor);

        if ($stmt->execute()) {
            $message = "¡Vendedor '{$nombre_vendedor}' registrado con éxito!";
            $message_class = 'success';
        } else {
            $message = "Error al registrar el vendedor: " . $stmt->error;
            $message_class = 'error';
        }
    }
    $stmt->close();
}
$conn->close();

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Vendedor</title>
    <link rel="stylesheet" href="../css/style3.css">
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Registro de Vendedor</h1>
            <p>Wireless Supply, C.A.</p>
        </header>

        <?php if ($message): ?>
            <div class="message <?php echo $message_class; ?>">
                <?php echo htmlspecialchars($message); ?>
            </div>
        <?php endif; ?>

        <div class="step-section">
            <h2>Registrar nuevo Vendedor</h2>
            <form action="registro_vendedores.php" method="POST">
                <div class="input-group">
                    <label for="id_vendedor">ID de Vendedor:</label>
                    <input type="text" id="id_vendedor" name="id_vendedor" required>
                </div>
                <div class="input-group">
                    <label for="nombre_vendedor">Nombre del Vendedor:</label>
                    <input type="text" id="nombre_vendedor" name="nombre_vendedor" required>
                </div>
                <div class="input-group">
                    <label for="telefono_vendedor">Teléfono:</label>
                    <input type="text" id="telefono_vendedor" name="telefono_vendedor">
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Registrar</button>
                    <a href="gestion_vendedores.php" class="btn btn-secondary">Volver</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>