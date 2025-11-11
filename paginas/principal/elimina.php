<?php
// ¡AÑADE ESTO PARA DEBUGGING!
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require '../conexion.php';

$id = $conn->real_escape_string($_GET['id']);
$resultado = false; // Inicializamos para el flujo de la página

// 1. INICIAR TRANSACCIÓN para asegurar que todas las eliminaciones sean exitosas
$conn->begin_transaction();

try {
    // -------------------------------------------------------------------
    // PASO 1: ELIMINAR REGISTROS ASOCIADOS EN TABLAS HIJAS (Cobros e Historial)
    // -------------------------------------------------------------------
    
    // A. Encontrar todos los id_cobro asociados al id_contrato para limpiar el historial
    $sql_cobros_ids = "SELECT id_cobro FROM cuentas_por_cobrar WHERE id_contrato = $id";
    $result_cobros_ids = $conn->query($sql_cobros_ids);
    
    if ($result_cobros_ids && $result_cobros_ids->num_rows > 0) {
        $cobro_ids = [];
        while ($row = $result_cobros_ids->fetch_assoc()) {
            $cobro_ids[] = $row['id_cobro'];
        }
        $cobro_ids_list = implode(',', $cobro_ids);
        
        // B. Eliminar registros en la tabla más dependiente: cobros_manuales_historial
        // Esto evita el error de clave foránea que te estaba dando.
        $sql_historial = "DELETE FROM cobros_manuales_historial WHERE id_cobro_cxc IN ($cobro_ids_list)";
        $conn->query($sql_historial);
    }
    
    // C. Eliminar registros de la tabla cuentas_por_cobrar (dependiente del contrato)
    $sql_cxc = "DELETE FROM cuentas_por_cobrar WHERE id_contrato = $id";
    $conn->query($sql_cxc);
    
    // -------------------------------------------------------------------
    // PASO 2: ELIMINAR EL REGISTRO PADRE (CONTRATO)
    // -------------------------------------------------------------------
    $sql_contrato = "DELETE FROM contratos WHERE id = $id";
    $conn->query($sql_contrato);
    
    // Si todo fue exitoso, confirmamos los cambios
    $conn->commit();
    $resultado = true;

} catch (Exception $e) {
    // Si algo falla (ej. error de SQL), revertimos todos los cambios.
    $conn->rollback();
    // Opcional: Para depuración, loguea el error: error_log("Error de eliminación: " . $e->getMessage());
    $resultado = false; 
}


/* Código para eliminar archivos si aplica (mantener comentado si no lo usas)
$carpeta = 'files/' . $id;

if (is_dir($carpeta)) {
	$archivos = glob($carpeta . '/*'); 
	foreach ($archivos as $archivo) {
		unlink($archivo); 
	}
	rmdir($carpeta);
}
*/
?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Elimina Contratos</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<main class="container">
		<?php if ($resultado) { ?>
			<h3 class="text-center">REGISTRO ELIMINADO</h3>
		<?php } else { ?>
			<h3 class="text-center">ERROR AL ELIMINAR</h3>
            <p class="text-center text-danger">Ocurrió un error en la base de datos al intentar la eliminación del contrato y sus cobros asociados.</p>
		<?php } ?>

		<div class="col-12 text-center">
			<a href="gestion_contratos.php" class="btn btn-primary">Regresar</a>
		</div>
	</main>
	<script src="../../js/bootstrap.bundle.min.js"></script>
</body>

</html>