<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message_municipio = '';
$message_parroquia = '';
$message_comunidad = ''; // NUEVO: Mensaje para el registro de comunidad
$message_class = '';

// --- LÓGICA DE REGISTRO DE MUNICIPIO ---
if (isset($_POST['submit_municipio'])) {
    $nombre_municipio = $_POST['nombre_municipio'];

    $stmt = $conn->prepare("INSERT INTO `municipio` (`nombre_municipio`) VALUES (?)");
    $stmt->bind_param("s", $nombre_municipio);

    if ($stmt->execute()) {
        $message_municipio = "¡Municipio registrado con éxito!";
        $message_class = 'success';
    } else {
        $message_municipio = "Error al registrar el municipio: " . $stmt->error;
        $message_class = 'error';
    }
    $stmt->close();
}

// --- LÓGICA DE REGISTRO DE PARROQUIA ---
if (isset($_POST['submit_parroquia'])) {
    $nombre_parroquia = $_POST['nombre_parroquia'];
    $id_municipio = $_POST['id_municipio'];

    $stmt = $conn->prepare("INSERT INTO `parroquia` (`nombre_parroquia`, `id_municipio`) VALUES (?, ?)");
    $stmt->bind_param("si", $nombre_parroquia, $id_municipio);

    if ($stmt->execute()) {
        $message_parroquia = "¡Parroquia registrada con éxito!";
        $message_class = 'success';
    } else {
        $message_parroquia = "Error al registrar la parroquia: " . $stmt->error;
        $message_class = 'error';
    }
    $stmt->close();
}

// --- NUEVA LÓGICA DE REGISTRO DE COMUNIDAD ---
if (isset($_POST['submit_comunidad'])) {
    $nombre_comunidad = $_POST['nombre_comunidad'];
    $id_parroquia = $_POST['id_parroquia_comunidad'];

    $stmt = $conn->prepare("INSERT INTO `comunidad` (`nombre_comunidad`, `id_parroquia`) VALUES (?, ?)");
    $stmt->bind_param("si", $nombre_comunidad, $id_parroquia);

    if ($stmt->execute()) {
        $message_comunidad = "¡Comunidad registrada con éxito!";
        $message_class = 'success';
    } else {
        $message_comunidad = "Error al registrar la comunidad: " . $stmt->error;
        $message_class = 'error';
    }
    $stmt->close();
}


// --- CONSULTAS PARA CARGAR SELECTS ---
// Municipios para el select de Parroquia
$municipios = $conn->query("SELECT id_municipio, nombre_municipio FROM `municipio` ORDER BY nombre_municipio ASC")->fetch_all(MYSQLI_ASSOC);

// NUEVO: Parroquias para el select de Comunidad
$parroquias = $conn->query("SELECT id_parroquia, nombre_parroquia FROM `parroquia` ORDER BY nombre_parroquia ASC")->fetch_all(MYSQLI_ASSOC);

$conn->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Municipios y Parroquias</title>
    <link rel="stylesheet" href="../css/style3.css">
    <style>
        /* Estilos CSS para los tres formularios lado a lado (opcional) */
        .forms-container {
            display: flex;
            justify-content: space-around;
            gap: 20px;
            margin-top: 20px;
        }
        .step-section {
            flex-basis: 30%; /* Para que ocupen un tercio del espacio */
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .register-container {
            max-width: 90%; /* Ajuste para que quepan los tres formularios */
            margin: 50px auto;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Registro Geográfico (Municipio, Parroquia y Comunidad)</h1>
            <p>Wireless Supply, C.A.</p>
        </header>

        <div class="forms-container">
            
            <div class="step-section">
                <h3>Registrar Nuevo Municipio</h3>
                <?php if ($message_municipio): ?>
                    <div class="message <?php echo $message_class; ?>">
                        <?php echo htmlspecialchars($message_municipio); ?>
                    </div>
                <?php endif; ?>
                <form action="registro_municipios.php" method="POST">
                    <div class="input-group">
                        <label for="nombre_municipio">Nombre del Municipio:</label>
                        <input type="text" id="nombre_municipio" name="nombre_municipio" required>
                    </div>
                    <div class="button-group">
                        <button type="submit" name="submit_municipio" class="btn btn-primary">Registrar Municipio</button>
                    </div>
                </form>
            </div>
            
            <div class="step-section">
                <h3>Registrar Nueva Parroquia</h3>
                <?php if ($message_parroquia): ?>
                    <div class="message <?php echo $message_class; ?>">
                        <?php echo htmlspecialchars($message_parroquia); ?>
                    </div>
                <?php endif; ?>
                <form action="registro_municipios.php" method="POST">
                    <div class="input-group">
                        <label for="id_municipio">Seleccionar Municipio:</label>
                        <select id="id_municipio" name="id_municipio" required>
                            <option value="">Seleccione un municipio</option>
                            <?php foreach ($municipios as $municipio): ?>
                                <option value="<?php echo htmlspecialchars($municipio['id_municipio']); ?>">
                                    <?php echo htmlspecialchars($municipio['nombre_municipio']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="nombre_parroquia">Nombre de la Parroquia:</label>
                        <input type="text" id="nombre_parroquia" name="nombre_parroquia" required>
                    </div>
                    <div class="button-group">
                        <button type="submit" name="submit_parroquia" class="btn btn-primary">Registrar Parroquia</button>
                    </div>
                </form>
            </div>

            <div class="step-section">
                <h3>Registrar Nueva Comunidad</h3>
                <?php if ($message_comunidad): ?>
                    <div class="message <?php echo $message_class; ?>">
                        <?php echo htmlspecialchars($message_comunidad); ?>
                    </div>
                <?php endif; ?>
                <form action="registro_municipios.php" method="POST">
                    <div class="input-group">
                        <label for="id_parroquia_comunidad">Seleccionar Parroquia:</label>
                        <select id="id_parroquia_comunidad" name="id_parroquia_comunidad" required>
                            <option value="">Seleccione una parroquia</option>
                            <?php foreach ($parroquias as $parroquia): ?>
                                <option value="<?php echo htmlspecialchars($parroquia['id_parroquia']); ?>">
                                    <?php echo htmlspecialchars($parroquia['nombre_parroquia']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="nombre_comunidad">Nombre de la Comunidad:</label>
                        <input type="text" id="nombre_comunidad" name="nombre_comunidad" required>
                    </div>
                    <div class="button-group">
                        <button type="submit" name="submit_comunidad" class="btn btn-primary">Registrar Comunidad</button>
                    </div>
                </form>
            </div>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="gestion_municipios.php" class="btn btn-secondary">Volver a Gestión</a>
        </div>
    </div>
</body>
</html>