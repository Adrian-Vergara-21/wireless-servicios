<?php

/**
 * Script para actualizar los datos del registro
 *
 * Este script recibe los datos del registro a través del método POST
 * y realiza la actualización en la base de datos. También permite la carga de archivos adjuntos.
 *
 * @author MRoblesDev
 * @version 1.0
 * https://github.com/mroblesdev
 *
 */

require '../conexion.php';

// 1. CAPTURA Y SANEO DE DATOS
$id = $conn->real_escape_string($_POST['id']);
$ip = $conn->real_escape_string($_POST['ip']);
$cedula = $conn->real_escape_string($_POST['cedula']);
$nombre_completo = $conn->real_escape_string($_POST['nombre_completo']);
$telefono = $conn->real_escape_string($_POST['telefono']);
$correo = $conn->real_escape_string($_POST['correo']);
$id_municipio = $conn->real_escape_string($_POST['id_municipio']);
$id_parroquia = $conn->real_escape_string($_POST['id_parroquia']);
$id_comunidad = $conn->real_escape_string($_POST['id_comunidad'] ?? null); // 🔑 NUEVO: Captura de id_comunidad
$id_plan = $conn->real_escape_string($_POST['id_plan']);
$id_vendedor = $conn->real_escape_string($_POST['id_vendedor']);
$direccion = $conn->real_escape_string($_POST['direccion']);
$fecha_instalacion = $conn->real_escape_string($_POST['fecha_instalacion']);
$estado = $conn->real_escape_string($_POST['estado']);
$ident_caja_nap = $conn->real_escape_string($_POST['ident_caja_nap']);
$puerto_nap = $conn->real_escape_string($_POST['puerto_nap']);
$num_presinto_odn = $conn->real_escape_string($_POST['num_presinto_odn']);
$id_olt = $conn->real_escape_string($_POST['id_olt']);
$id_pon = $conn->real_escape_string($_POST['id_pon']?? null);

$errores = '';

// 2. VALIDACIÓN DE IP DUPLICADA (Excluyendo el ID actual)
$stmt_ip = $conn->prepare("SELECT * FROM contratos WHERE ip = ? AND id != ? LIMIT 1");
$stmt_ip->bind_param('si', $ip, $id);
$stmt_ip->execute();
$stmt_ip->store_result();

if ($stmt_ip->num_rows > 0) {
    // Si se encuentra una fila, significa que la IP ya existe en OTRO registro
    $errores .= "La IP '{$ip}' ya está registrada en otro contrato. Por favor, ingrese una IP única.<br>";
}
$stmt_ip->close();


// 3. EJECUCIÓN DE LA ACTUALIZACIÓN SOLO SI NO HAY ERRORES
if (empty($errores)) {
    // 🔑 MODIFICADO: Se agrega el campo id_comunidad
    $sql = "UPDATE contratos SET ip='$ip', cedula='$cedula', nombre_completo='$nombre_completo', telefono='$telefono', correo='$correo',
	 id_municipio='$id_municipio', id_parroquia='$id_parroquia', id_comunidad='$id_comunidad', id_plan='$id_plan', id_vendedor='$id_vendedor', direccion='$direccion',
	  fecha_instalacion='$fecha_instalacion', estado='$estado', ident_caja_nap='$ident_caja_nap', puerto_nap='$puerto_nap',
	   num_presinto_odn='$num_presinto_odn', id_olt='$id_olt', id_pon='$id_pon' WHERE id = $id";

    $resultado = $conn->query($sql);

    // ... (El código de manejo de archivos adjuntos comentado permanece igual)
    // ...
} else {
    // Si hay errores, forzamos $resultado a false para mostrar el mensaje de error
    $resultado = false;
}

// ... (El resto del script HTML permanece igual)
?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Actualizando Contrato</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet">
	<link href="../../css/style4.css" rel="stylesheet">
	 <link rel="icon" type="image/jpg" href="../../images/logo.jpg"/>
	<style>
		.text-success { color: #198754 !important; }
		.text-danger { color: #dc3545 !important; }
	</style>
</head>

<body>
	<main class="container">

		<?php if ($resultado) { ?>
			<h3 class="text-center">REGISTRO ACTUALIZADO ✅</h3>
			<p class="text-center">El contrato con ID: <b><?php echo $id; ?></b> ha sido actualizado correctamente.</p>
			<div class="col-12 text-center">
		        	<div class="col-md-12">
		        		<a href="gestion_contratos.php" class="btn btn-primary">Regresar</a>
		        	</div>
		        </div>
		<?php } else { ?>
			<h3 class="text-center text-danger">ERROR AL ACTUALIZAR ❌</h3>
            <?php if (!empty($errores)) { ?>
                <div class="alert alert-danger" role="alert">
                    <?php echo $errores; ?>	
                </div>
				 <div class="col-12 text-center">
		        	<div class="col-md-12">
		        		<a href="gestion_contratos.php" class="btn btn-primary btn-danger">Regresar</a>
		        	</div>
		        </div>
            <?php } else { ?>
			    <p class="text-center">Hubo un error al intentar actualizar el registro.</p>
            <?php } ?>
		<?php } ?>

		</main>
</body>

</html>