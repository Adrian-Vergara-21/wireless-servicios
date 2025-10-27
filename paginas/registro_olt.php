<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';
$parroquias = [];

// --- CONSULTA PARA OBTENER LAS PARROQUIAS ---
$sql_parroquias = "SELECT id_parroquia, nombre_parroquia FROM parroquia ORDER BY nombre_parroquia ASC";
$result_parroquias = $conn->query($sql_parroquias);

if ($result_parroquias && $result_parroquias->num_rows > 0) {
    while ($row = $result_parroquias->fetch_assoc()) {
        $parroquias[] = $row;
    }
}

// Verifica si se ha enviado el formulario
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Captura los datos del formulario
    $id_olt = $_POST['id_olt'];
    $nombre_olt = $_POST['nombre_olt'];
    $marca = $_POST['marca'];
    $modelo = $_POST['modelo'];
    // Captura el ARRAY de parroquias seleccionadas
    $parroquias_seleccionadas = isset($_POST['parroquias_id']) ? $_POST['parroquias_id'] : [];
    $descripcion = $_POST['descripcion'];

    // Iniciar transacción
    $conn->begin_transaction();
    
    try {
        // 1. Insertar la OLT en la tabla 'olt'
        $stmt_olt = $conn->prepare("INSERT INTO olt (id_olt, nombre_olt, marca, modelo, descripcion) VALUES (?, ?, ?, ?, ?)");
        $stmt_olt->bind_param("issss", $id_olt, $nombre_olt, $marca, $modelo, $descripcion); 
        
        if (!$stmt_olt->execute()) {
             if ($stmt_olt->errno == 1062) { // 1062 es el código de error para clave duplicada
                 throw new Exception("Error: El ID de OLT o el Nombre ya existen.");
             }
            throw new Exception("Error al insertar OLT: " . $stmt_olt->error);
        }
        $stmt_olt->close();

        // 2. Insertar las relaciones en la tabla 'olt_parroquia'
        if (!empty($parroquias_seleccionadas)) {
            $stmt_relacion = $conn->prepare("INSERT INTO olt_parroquia (olt_id, parroquia_id) VALUES (?, ?)");
            foreach ($parroquias_seleccionadas as $parroquia_id) {
                // 'i' para olt_id (entero), 'i' para parroquia_id (entero)
                $stmt_relacion->bind_param("ii", $id_olt, $parroquia_id); 
                if (!$stmt_relacion->execute()) {
                    throw new Exception("Error al insertar relación con parroquia: " . $stmt_relacion->error);
                }
            }
            $stmt_relacion->close();
        }

        // Si todo va bien
        $conn->commit();
        $message = "¡OLT registrada y parroquias asignadas con éxito!";
        $message_class = 'success';
        $_POST = array(); // Limpiar el formulario
        
    } catch (Exception $e) {
        $conn->rollback();
        $message = "Error en el registro: " . $e->getMessage();
        $message_class = 'error';
    }

    // Cerramos la conexión después de la transacción
    $conn->close();
} else {
    // Si no se envió el formulario, cerramos la conexión después de obtener las parroquias
    if (isset($conn)) {
        $conn->close();
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de OLT</title>
    <link rel="stylesheet" href="../css/style3.css">
    <style>
        /* Estilos para el contenedor de checkboxes */
        .checkbox-group {
            border: 1px solid #ccc;
            padding: 10px;
            max-height: 200px;
            overflow-y: auto; 
            background-color: #f9f9f9;
        }
        .checkbox-item {
            display: block; 
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Registro de OLT</h1>
            <p>Wireless Supply, C.A.</p>
        </header>

        <?php if ($message): ?>
            <div class="message <?php echo $message_class; ?>">
                <?php echo htmlspecialchars($message); ?>
            </div>
        <?php endif; ?>

        <div class="step-section">
            <form action="registro_olt.php" method="POST">
                <div class="input-group">
                    <label for="id_olt">ID de la OLT:</label>
                    <input type="number" id="id_olt" name="id_olt" min="1" required 
                           value="<?php echo isset($_POST['id_olt']) ? htmlspecialchars($_POST['id_olt']) : ''; ?>">
                </div>
                <div class="input-group">
                    <label for="nombre_olt">Nombre de la OLT:</label>
                    <input type="text" id="nombre_olt" name="nombre_olt" required
                           value="<?php echo isset($_POST['nombre_olt']) ? htmlspecialchars($_POST['nombre_olt']) : ''; ?>">
                </div>
                <div class="input-group">
                    <label for="marca">Marca:</label>
                    <input type="text" id="marca" name="marca" 
                           value="<?php echo isset($_POST['marca']) ? htmlspecialchars($_POST['marca']) : ''; ?>">
                </div>
                <div class="input-group">
                    <label for="modelo">Modelo:</label>
                    <input type="text" id="modelo" name="modelo" 
                           value="<?php echo isset($_POST['modelo']) ? htmlspecialchars($_POST['modelo']) : ''; ?>">
                </div>
                
                <div class="input-group">
                    <label>Parroquias que Atiende (Seleccione una o más):</label>
                    <div class="checkbox-group">
                        <?php if (!empty($parroquias)): ?>
                            <?php 
                            $parroquias_post = isset($_POST['parroquias_id']) ? (array)$_POST['parroquias_id'] : [];
                            foreach ($parroquias as $parroquia): 
                            ?>
                                <div class="checkbox-item">
                                    <input type="checkbox" 
                                           id="parroquia_<?php echo htmlspecialchars($parroquia['id_parroquia']); ?>" 
                                           name="parroquias_id[]" 
                                           value="<?php echo htmlspecialchars($parroquia['id_parroquia']); ?>"
                                           <?php 
                                           if (in_array($parroquia['id_parroquia'], $parroquias_post)) {
                                               echo 'checked';
                                           }
                                           ?>>
                                    <label for="parroquia_<?php echo htmlspecialchars($parroquia['id_parroquia']); ?>">
                                        <?php echo htmlspecialchars($parroquia['nombre_parroquia']); ?>
                                    </label>
                                </div>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <p>No hay parroquias disponibles.</p>
                        <?php endif; ?>
                    </div>
                </div>
                <div class="input-group">
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" rows="4"><?php echo isset($_POST['descripcion']) ? htmlspecialchars($_POST['descripcion']) : ''; ?></textarea>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Registrar OLT</button>
                    <a href="gestion_olt.php" class="btn btn-secondary">Volver</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>