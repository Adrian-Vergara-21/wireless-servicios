<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';
// Variables para mantener los valores en caso de error de POST
$nombre_pon_post = isset($_POST['nombre_pon']) ? $_POST['nombre_pon'] : '';
$id_olt_post = isset($_POST['id_olt']) ? $_POST['id_olt'] : '';
$descripcion_post = isset($_POST['descripcion']) ? $_POST['descripcion'] : '';
// La variable $comunidades_post ha sido eliminada.

// --- CONSULTA PARA OBTENER LAS OLTs DISPONIBLES (para el SELECT) ---
$olts = [];
$sql_olts = "SELECT id_olt, nombre_olt FROM olt ORDER BY nombre_olt ASC";
$result_olts = $conn->query($sql_olts);

if ($result_olts && $result_olts->num_rows > 0) {
    while ($row = $result_olts->fetch_assoc()) {
        $olts[] = $row;
    }
}

// Las consultas y variables de comunidades han sido eliminadas.

// ----------------------------------------------------------------------------------
// LÓGICA DE PROCESAMIENTO DEL FORMULARIO (POST: INSERTAR NUEVO PON)
// ----------------------------------------------------------------------------------
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    try {
        // Validación básica
        if (empty($nombre_pon_post) || empty($id_olt_post)) {
            throw new Exception("Los campos Nombre PON y OLT son obligatorios.");
        }
        
        // 1. Insertar el PON en la tabla 'pon' (Se omite id_pon para que se autoincremente)
        $stmt_pon = $conn->prepare("INSERT INTO pon (nombre_pon, id_olt, descripcion) VALUES (?, ?, ?)");
        
        // Asumiendo que nombre_pon (s), id_olt (i), descripcion (s)
        $stmt_pon->bind_param("sis", $nombre_pon_post, $id_olt_post, $descripcion_post); 
        
        if (!$stmt_pon->execute()) {
            throw new Exception("Error al insertar el PON: " . $stmt_pon->error);
        }
        
        // OBTENEMOS EL ID GENERADO AUTOMÁTICAMENTE 
        $id_referencia = $conn->insert_id; 
        $stmt_pon->close();
        
        // La lógica para insertar en pon_comunidad se elimina.
        
        $message = '✅ ¡PON registrado con éxito! (ID Asignado: ' . $id_referencia . ')';
        $message_class = 'success';
        
        // Limpiar campos después de un registro exitoso (opcional)
        $nombre_pon_post = $id_olt_post = $descripcion_post = '';

    } catch (Exception $e) {
        // Solo manejamos el error, no hay transacción
        $message = '❌ Error al registrar el PON: ' . $e->getMessage();
        $message_class = 'error';
    }
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro PON</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style3.css" rel="stylesheet">
     <link rel="icon" type="image/jpg" href="../images/logo.jpg"/>
</head>

<body>
    <div class="container my-5">
        <div class="card p-4 mx-auto" style="max-width: 600px;">
           <header class="register-header">
            <h1 class="text-center">Registro de Pon</h1>
            <p class="text-center">Wireless Supply, C.A.</p>
        </header>
            <?php if ($message): ?>
                <div class="alert alert-<?php echo $message_class === 'success' ? 'success' : 'danger'; ?>" role="alert">
                    <?php echo htmlspecialchars($message); ?>
                </div>
            <?php endif; ?>

            <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="POST" class="needs-validation" novalidate>
                
                <div class="input-group">
                    <label for="nombre_pon">Nombre PON:</label>
                    <input type="text" id="nombre_pon" name="nombre_pon" value="<?php echo htmlspecialchars($nombre_pon_post); ?>" required>
                    <div class="invalid-feedback">El Nombre del PON es obligatorio.</div>
                </div>

                <div class="input-group">
                    <label for="id_olt">OLT a la que pertenece:</label>
                    <select id="id_olt" name="id_olt" required>
                        <option value="">-- Seleccione una OLT --</option>
                        <?php foreach ($olts as $olt): ?>
                            <option value="<?php echo htmlspecialchars($olt['id_olt']); ?>" 
                                <?php echo ($id_olt_post == $olt['id_olt']) ? 'selected' : ''; ?>>
                                <?php echo htmlspecialchars($olt['nombre_olt']); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                    <div class="invalid-feedback">Debe seleccionar una OLT.</div>
                </div>

                <div class="input-group">
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" rows="4"><?php echo htmlspecialchars($descripcion_post); ?></textarea>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Registrar PON</button>
                    <a href="gestion_pon.php" class="btn btn-secondary">Volver</a>
                </div>
            </form>
        </div>
    </div>
    <script src="../js/bootstrap.bundle.min.js"></script>
    <script>
        // La lógica de validación de checkbox ha sido eliminada.
    </script>
</body>
</html>