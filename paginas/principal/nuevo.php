<?php
// nuevo.php

/**
 * Formulario para agregar un nuevo registro
 *
 * Este formulario permite agregar un nuevo registro a la base de datos.
 *
 * @author MRoblesDev
 * @version 1.0
 * https://github.com/mroblesdev
 *
 */

// 1. CONEXIÓN A LA BASE DE DATOS Y CONSULTAS ESTATICAS (INICIO DEL ARCHIVO)
require_once 'conexion.php'; 

// --- CONSULTA PARA OBTENER TODOS LOS MUNICIPIOS (para el select estático) ---
$sql_municipios = "SELECT id_municipio, nombre_municipio FROM municipio ORDER BY nombre_municipio ASC";
$resultado_municipios = $conn->query($sql_municipios); 

if (!$resultado_municipios) {
    die("Error en la consulta de municipios: " . $conn->error);
}

// --- NUEVA CONSULTA PARA OBTENER TODAS LAS OLTs (para el select estático) ---
$olts = [];
$sql_olts = "SELECT id_olt, nombre_olt FROM olt ORDER BY nombre_olt ASC";
$resultado_olts = $conn->query($sql_olts);

if ($resultado_olts && $resultado_olts->num_rows > 0) {
    while ($row = $resultado_olts->fetch_assoc()) {
        $olts[] = $row;
    }
}
// La conexión se mantendrá abierta para su uso en los bloques PHP dentro del HTML,
// aunque se recomienda cerrarla al final del script si no es necesario.
// $conn->close(); 
?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Nuevo Contrato</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet">
	<link href="../../css/style3.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
	<main class="container">
		<div class="container my-5">
		<header class="register-header">
		<h3 class="text-center pt-3">Nuevo registro</h3>
		<p class= "text-center">Wireless Supply, C.A.</p>
		</header>
</div>
		<form class="row g-3" method="POST" action="guarda.php" enctype="multipart/form-data" autocomplete="off">

			<div class="col-md-6">
				<label for="ip" class="form-label">IP</label>
				<input type="text" class="form-control" id="ip" name="ip" required autofocus>
			</div>

			<div class="col-md-6">
				<label for="cedula" class="form-label">Cedula</label>
				<input type="text" class="form-control" id="cedula" name="cedula" required>
			</div>

			<div class="col-md-6">
				<label for="nombre_completo" class="form-label">Nombre Completo</label>
				<input type="text" class="form-control" id="nombre_completo" name="nombre_completo" required>
			</div>

			<div class="col-md-6">
				<label for="telefono" class="form-label">Teléfono</label>
				<input type="text" class="form-control" id="telefono" name="telefono" >
			</div>

			<div class="col-md-6">
				<label for="correo" class="form-label">Correo</label>
				<input type="text" class="form-control" id="correo" name="correo" >
			</div>

			<div class="col-md-6">
			    <label for="municipio" class="form-label">Municipio</label>
			    <select name="id_municipio" id="municipio" class="form-select" required>
			        <option value="">-- Seleccione un Municipio --</option>
			        <?php
			        if ($resultado_municipios->num_rows > 0) {
			            while($fila = $resultado_municipios->fetch_assoc()) {
			                echo '<option value="' . htmlspecialchars($fila["id_municipio"]) . '">' . 
			                     htmlspecialchars($fila["nombre_municipio"]) . 
			                     '</option>';
			            }
			        }
			        ?>
			    </select>
			</div>

			<div class="col-md-6">
			    <label for="parroquia" class="form-label" >Parroquia</label>
			    <select name="id_parroquia" id="parroquia" class="form-select" disabled required>
			        <option value="">-- Primero seleccione un municipio --</option>
			    </select>
			</div>

			<div class="col-md-6">
				<label for="comunidad" class="form-label">Comunidad</label>
				<select name="id_comunidad" id="comunidad" class="form-select" disabled>
					<option value="">-- Primero seleccione una parroquia --</option>
				</select>
			</div>
			<div class="col-md-6">
			<?php
				// ⚠️ RE-USANDO LA CONEXIÓN ABIERTA
				$sql_planes = "SELECT id_plan, nombre_plan FROM planes ORDER BY nombre_plan ASC";
				$resultado_planes = $conn->query($sql_planes);

				if (!$resultado_planes) {
				    die("Error en la consulta SQL de planes: " . $conn->error);
				}
			?>
			 <label for="id_plan" class="form-label">Planes</label>
    
      		    <select name="id_plan" id="id_plan"  class="form-select" required>
            	<option  value="">-- Seleccione un Plan --</option>

				<?php
            if ($resultado_planes->num_rows > 0) {
                while($fila = $resultado_planes->fetch_assoc()) {
                    echo '<option value="' . htmlspecialchars($fila["id_plan"]) . '">' . 
                         htmlspecialchars($fila["nombre_plan"]) . 
                         '</option>';
                }
            } else {
                echo '<option value="" disabled>No se encontraron planes en la base de datos.</option>';
            }
            ?>
            
        </select>
        
			</div>
			

			<div class="col-md-6">
				<?php
				// ⚠️ RE-USANDO LA CONEXIÓN ABIERTA
				$sql_vendedores = "SELECT id_vendedor, nombre_vendedor FROM vendedores ORDER BY nombre_vendedor ASC";
				$resultado_vendedores = $conn->query($sql_vendedores);

				if (!$resultado_vendedores) {
				    die("Error en la consulta SQL de vendedores: " . $conn->error);
				}
			?>
			 <label for="vendedor_id" class="form-label">Vendedor</label>
    
      		    <select name="id_vendedor" id="id_vendedor"  class="form-select" required>
            	<option  value="">-- Seleccione un Vendedor --</option>

				<?php
            if ($resultado_vendedores->num_rows > 0) {
                while($fila = $resultado_vendedores->fetch_assoc()) {
                    echo '<option value="' . htmlspecialchars($fila["id_vendedor"]) . '">' . 
                         htmlspecialchars($fila["nombre_vendedor"]) . 
                         '</option>';
                }
            } else {
                echo '<option value="" disabled>No se encontraron vendedores en la base de datos.</option>';
            }
            ?>
            
        </select>
        
			</div>

			<div class="col-md-6">
				<label for="direccion" class="form-label">Direccion</label>
				<textarea class="form-control" id="direccion" name="direccion" rows="3" required></textarea>
			</div>

			<div class="col-md-6">
				<label for="fecha_instalacion" class="form-label">Fecha_Instalacion</label>
				<input type="date" class="form-control" id="fecha_instalacion" name="fecha_instalacion" required>
			</div>

			<div class="col-md-6">
			    <label for="estado_contrato" class="form-label">Estado del Contrato</label>
			    <select class="form-select" id="estado_contrato" name="estado_contrato" required>
			        <option value="">-- Seleccione el Estado --</option>
					
			        <option value="ACTIVO" selected>ACTIVO</option>
			        <option value="INACTIVO">INACTIVO</option>
			        <option value="SUSPENDIDO">SUSPENDIDO</option>
			    </select>
			</div>
			
			<div class="col-md-6">
				<label for="ident_caja_nap" class="form-label">Identificacion Caja Nap</label>
				<input type="text" class="form-control" id="ident_caja_nap" name="ident_caja_nap" >
			</div>

			<div class="col-md-6">
				<label for="puerto_nap" class="form-label">Puerto_Nap</label>
				<input type="text" class="form-control" id="puerto_nap" name="puerto_nap" >
			</div>

			<div class="col-md-6">
				<label for="num_presinto_odn" class="form-label">Numero_Presinto_ODN</label>
				<input type="text" class="form-control" id="num_presinto_odn" name="num_presinto_odn" >
			</div>

			<div class="col-md-6">
			 <label for="id_olt" class="form-label">OLT</label>
    
      		    <select name="id_olt" id="id_olt"  class="form-select" required>
            	<option  value="">-- Seleccione una OLT --</option>

				<?php
            if (!empty($olts)) {
                foreach($olts as $olt) {
                    echo '<option value="' . htmlspecialchars($olt["id_olt"]) . '">' . 
                         htmlspecialchars($olt["nombre_olt"]) . 
                         '</option>';
                }
            } else {
                echo '<option value="" disabled>No se encontraron OLTs en la base de datos.</option>';
            }
            ?>
            
        </select>
        
			</div>

			<div class="col-md-6">
			 <label for="id_pon" class="form-label">PON</label>
    
      		    <select name="id_pon" id="id_pon"  class="form-select" required disabled>
            	    <option  value="">-- Seleccione una OLT primero --</option>
            </select>
        
			</div>
			<div class="col-12">
				<a href="index.php" class="btn btn-secondary">Regresar</a>
				<button type="submit" class="btn btn-success ">Guardar</button>
			</div>

		</form>
	</main>

	<script>
    // CÓDIGO PARA nuevo.php (Lógica de Cascada)
    
    $(document).ready(function() {

        // ======================================================
        // LÓGICA DE UBICACIÓN (Municipio -> Parroquia -> Comunidad)
        // ======================================================

        // 1. FUNCIÓN para cargar dinámicamente las Comunidades
        function cargarComunidades(idParroquia) {
            $('#comunidad').html('<option value="">Cargando comunidades...</option>');
            $('#comunidad').prop('disabled', true);

            if (idParroquia) {
                $.ajax({
                    url: 'obtener_comunidades.php', 
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        id_parroquia: idParroquia
                    },
                    success: function(comunidades) {
                        $('#comunidad').html('<option value="">-- Seleccione una Comunidad --</option>');

                        $.each(comunidades, function(key, value) {
                            $('#comunidad').append('<option value="' + key + '">' + value + '</option>');
                        });

                        $('#comunidad').prop('disabled', false);
                    },
                    error: function() {
                        $('#comunidad').html('<option value="">Error al cargar comunidades</option>');
                    }
                });
            } else {
                $('#comunidad').html('<option value="">-- Primero seleccione una parroquia --</option>');
            }
        }
        
        // 2. FUNCIÓN para cargar dinámicamente las Parroquias
        function cargarParroquias(idMunicipio) {
            $('#parroquia').html('<option value="">Cargando parroquias...</option>');
            $('#parroquia').prop('disabled', true);
            
            // Resetear y deshabilitar Comunidad
            $('#comunidad').html('<option value="">-- Primero seleccione una parroquia --</option>');
            $('#comunidad').prop('disabled', true);

            if (idMunicipio) {
                $.ajax({
                    url: 'get_parroquias.php',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        id: idMunicipio 
                    },
                    success: function(parroquias) {
                        $('#parroquia').html('<option value="">-- Seleccione una Parroquia --</option>');
                        
                        $.each(parroquias, function(key, value) {
                            $('#parroquia').append('<option value="' + key + '">' + value + '</option>');
                        });
                        
                        $('#parroquia').prop('disabled', false);
                    },
                    error: function() {
                        $('#parroquia').html('<option value="">Error al cargar parroquias</option>');
                    }
                });
            } else {
                $('#parroquia').html('<option value="">-- Primero seleccione un municipio --</option>');
            }
        }

        // 3. MANEJAR CAMBIO DE MUNICIPIO
        $('#municipio').on('change', function() {
            var idMunicipio = $(this).val(); 
            cargarParroquias(idMunicipio);
        });
        
        // 4. MANEJAR CAMBIO DE PARROQUIA
        $('#parroquia').on('change', function() {
            var idParroquia = $(this).val();
            cargarComunidades(idParroquia);
        });


        // ======================================================
        // LÓGICA DE RED (OLT -> PON) -- NUEVA FUNCIÓN
        // ======================================================

        // 5. FUNCIÓN para cargar dinámicamente los PONs
        function cargarPons(idOlt) {
            var $ponSelect = $('#id_pon');
            
            // Limpiar el select de PON y deshabilitarlo
            $ponSelect.html('<option value="">Cargando PONs...</option>').prop('disabled', true);

            if (idOlt) {
                $.ajax({
                    // *** RUTA CLAVE: Apunta al archivo endpoint ***
                    url: 'gets_pon_by_olt.php', 
                    type: 'GET', 
                    data: { id_olt: idOlt },
                    dataType: 'json',
                    success: function(response) {
                        $ponSelect.empty();
                        
                        if (!response.error && response.pons && response.pons.length > 0) {
                            $ponSelect.append('<option value="">-- Seleccione un PON --</option>');
                            
                            $.each(response.pons, function(index, pon) {
                                $ponSelect.append('<option value="' + pon.id_pon + '">' + pon.nombre_pon + '</option>');
                            });
                            $ponSelect.prop('disabled', false); // Habilitar select de PON
                        } else {
                            var msg = response.message || 'No se encontraron PONs.';
                            $ponSelect.append('<option value="" disabled>' + msg + '</option>');
                            $ponSelect.prop('disabled', true); 
                        }
                    },
                    error: function() {
                        $ponSelect.html('<option value="" disabled>Error de comunicación al cargar PONs.</option>');
                        $ponSelect.prop('disabled', true);
                    }
                });
            } else {
                $ponSelect.html('<option value="">-- Seleccione una OLT primero --</option>');
            }
        }

        // 6. MANEJAR CAMBIO DE OLT (Llama a cargarPons)
        $('#id_olt').on('change', function() {
            var idOlt = $(this).val();
            cargarPons(idOlt);
        });

    });
    </script>

	<script src="../../js/bootstrap.bundle.min.js"></script>
</body>

</html>