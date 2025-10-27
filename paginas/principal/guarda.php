<?php

/**
 * Script para insertar nuevos datos de registro
 *
 * Este script recibe los nuevos datos del registro a través del método POST
 * y realiza la inserción en la base de datos. También permite la carga de archivos adjuntos.
 *
 * @author MRoblesDev
 * @version 1.0
 * https://github.com/mroblesdev
 *
 */
// Conexión a la base de datos
require 'conexion.php';

// 1. CAPTURA Y SANEO DE DATOS
// Se usa real_escape_string para prevenir inyección SQL.
$ip = $conn->real_escape_string($_POST['ip']);
$cedula = $conn->real_escape_string($_POST['cedula']);
$nombre_completo = $conn->real_escape_string($_POST['nombre_completo']);
$telefono = $conn->real_escape_string($_POST['telefono']);
$correo = $conn->real_escape_string($_POST['correo']);
$id_municipio = $conn->real_escape_string($_POST['id_municipio']);
$id_parroquia = $conn->real_escape_string($_POST['id_parroquia']);
// ⚠️ NUEVO CAMPO: Captura de id_comunidad
$id_comunidad = $conn->real_escape_string($_POST['id_comunidad']); 
$id_plan = $conn->real_escape_string($_POST['id_plan']);
$id_vendedor = $conn->real_escape_string($_POST['id_vendedor']);
$direccion = $conn->real_escape_string($_POST['direccion']);
$fecha_instalacion = $conn->real_escape_string($_POST['fecha_instalacion']);
$ident_caja_nap = $conn->real_escape_string($_POST['ident_caja_nap']);
$puerto_nap = $conn->real_escape_string($_POST['puerto_nap']);
$num_presinto_odn = $conn->real_escape_string($_POST['num_presinto_odn']);
$id_olt = $conn->real_escape_string($_POST['id_olt']);
$id_pon = $conn->real_escape_string($_POST['id_pon']);
$estado = 'ACTIVO'; // Estado inicial por defecto

// Variable para manejar mensajes de error específicos
$error_mensaje = null;
$resultado = false; // Inicializamos a falso por si hay errores de validación

// =========================================================================
// 2. <<<< VALIDACIÓN AGREGADA >>>>: Verificar si la IP ya existe 
// =========================================================================
$sql_check_ip = "SELECT * FROM contratos WHERE ip = ?";
$stmt_check_ip = $conn->prepare($sql_check_ip);
$stmt_check_ip->bind_param("s", $ip);
$stmt_check_ip->execute();
$stmt_check_ip->store_result();

if ($stmt_check_ip->num_rows > 0) {
    // Si la IP ya existe, configuramos el error. No se ejecuta el código de inserción.
    $error_mensaje = "Error de Validación: La dirección IP <strong>'{$ip}'</strong> ya se encuentra registrada en otro contrato.";
    $stmt_check_ip->close();
} else {
    // La IP es única, podemos continuar con la inserción del contrato.
    $stmt_check_ip->close(); 

    // 3. INSERCIÓN EN LA TABLA DE CONTRATOS
    // ⚠️ Se agregó id_comunidad a la lista de columnas
    $sql = "INSERT INTO contratos (ip, cedula, nombre_completo, telefono, correo, id_municipio, id_parroquia, id_comunidad, id_plan, id_vendedor, direccion, fecha_instalacion, estado, ident_caja_nap, puerto_nap, num_presinto_odn, id_olt, id_pon) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    // Usando prepared statements para mayor seguridad
    // ⚠️ Se agregó una 'i' al string de tipos de parámetros
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssssiiiiissssssii", 
        $ip, 
        $cedula, 
        $nombre_completo, 
        $telefono, 
        $correo, 
        $id_municipio, 
        $id_parroquia, 
        $id_comunidad, // ⚠️ Nueva variable
        $id_plan, 
        $id_vendedor, 
        $direccion, 
        $fecha_instalacion, 
        $estado,
        $ident_caja_nap, 
        $puerto_nap, 
        $num_presinto_odn, 
        $id_olt,
        $id_pon
    );

    $resultado = $stmt->execute();
    $id_contrato = $conn->insert_id; // Obtiene el ID del contrato recién insertado
    $stmt->close();

    // 4. GENERACIÓN DE LA PRIMERA CUENTA POR COBRAR (Solo si el contrato fue exitoso)
    if ($resultado && $id_contrato > 0) {
        
        // Obtener el monto total del plan
        $sql_monto = "SELECT monto FROM planes WHERE id_plan = ? LIMIT 1";
        $stmt_monto = $conn->prepare($sql_monto);
        $stmt_monto->bind_param("i", $id_plan);
        $stmt_monto->execute();
        $result_monto = $stmt_monto->get_result();
        
        if ($result_monto->num_rows > 0) {
            $row_monto = $result_monto->fetch_assoc();
            $monto_total = $row_monto['monto'];
            
            // Define fechas para la factura
            $fecha_emision = $fecha_instalacion; // La fecha de instalación es la de emisión
            $fecha_vencimiento = date('Y-m-d', strtotime($fecha_emision . ' + 30 days'));
            
            // Inserción en la tabla de cuentas por cobrar (cxc)
            $sql_cobro = "INSERT INTO cuentas_por_cobrar (id_contrato, fecha_emision, fecha_vencimiento, monto_total)
            VALUES (?, ?, ?, ?)";
            
            $stmt_cobro = $conn->prepare($sql_cobro);
            $stmt_cobro->bind_param("issd", 
                $id_contrato, 
                $fecha_emision, 
                $fecha_vencimiento, 
                $monto_total
            );

            if (!$stmt_cobro->execute()) {
                // El contrato se guardó ($resultado sigue siendo true), pero la factura falló.
                $error_mensaje = "ADVERTENCIA: Contrato guardado, pero falló la generación de la primera factura. (No se encontró el plan o error interno)";
            }
            $stmt_cobro->close();
        } else {
            // El contrato se guardó ($resultado sigue siendo true), pero no se encontró el plan.
            $error_mensaje = "ADVERTENCIA: Contrato guardado, pero no se pudo generar la factura: Plan de servicio no encontrado.";
        }
        
        $stmt_monto->close();
    }
} 
// Cierre de la conexión (asegúrate de que todas las ramas la cierren o la cierras al final)
$conn->close();
?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Nuevo Contrato</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style4.css" rel="stylesheet">

    <style>
        .text-success { color: #198754 !important; }
        .text-danger { color: #dc3545 !important; }
        .text-warning { color: #ffc107 !important; }
    </style>
</head>

<body>
	<main class="container">

		<?php if ($resultado) { ?>
			<h3 class="text-center text-success">✅ REGISTRO GUARDADO</h3>
            <?php if ($error_mensaje && strpos($error_mensaje, 'ADVERTENCIA') !== false) { ?>
                <p class="text-center text-warning">El nuevo contrato ha sido registrado, pero se generó una advertencia: <?php echo $error_mensaje; ?></p>
            <?php } else { ?>
			    <p class="text-center">El nuevo contrato ha sido registrado exitosamente y se ha generado la primera factura.</p>
                <div class="col-12 text-center">
		        	<div class="col-md-12">
		        		<a href="nuevo.php" class="btn btn-primary">Regresar</a>
		        	</div>
		        </div>
            <?php } ?>
		<?php } else { ?>
			<h3 class="text-center text-danger">❌ ERROR AL GUARDAR</h3>
            <?php if ($error_mensaje) { ?>
                <p class="text-center text-danger"><?php echo $error_mensaje; ?></p>
                <div class="col-12 text-center">
		        	<div class="col-md-12">
		        		<a href="nuevo.php" class="btn btn-primary btn-danger">Regresar</a>
		        	</div>
		        </div>
            <?php } else { ?>
			    <p class="text-center">Hubo un problema desconocido al registrar el contrato o un error al ejecutar la consulta.</p>
		    <?php } ?>
        <?php } ?>

		
	</main>
</body>

</html>