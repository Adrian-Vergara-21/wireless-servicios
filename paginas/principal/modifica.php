<?php

/**
 * Formulario para editar un registro existente
 *
 * Este formulario permite editar los datos de un registro existente en la base de datos.
 *
 * @author MRoblesDev
 * @version 1.0
 * https://github.com/mroblesdev
 *
 */

require '../conexion.php';

// Obtener el ID del registro a editar desde la URL
$id = $conn->real_escape_string($_GET['id']);

$sql = "SELECT * FROM contratos WHERE id = '$id'";
$resultado = $conn->query($sql);
$row = $resultado->fetch_assoc();

//$interesesArray = explode(' ', $row['intereses']);
//$listaIntereses = ["Libros", "Música", "Deportes", "Otros"];

/*function esImagen($ruta)
{
	$extensionesImagen = ["jpg", "jpeg", "png", "gif"];
	$extension = strtolower(pathinfo($ruta, PATHINFO_EXTENSION));
	return in_array($extension, $extensionesImagen);
}*/

?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Modifica Contratos</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet">
	<link href="../../css/all.min.css" rel="stylesheet">
	<link href="../../css/style3.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
	<main class="container">
		<p> </p>
		<header class="register-header"> 
		<h3 class="text-center pt-3 texto_modificado">Modificar Registro</h3>
		<p class= "text-center">Wireless Supply, C.A.</p>
		</header>
		<form class="row g-3" method="POST" action="actualiza.php" enctype="multipart/form-data" autocomplete="off">

			<input type="hidden" id="id" name="id" value="<?php echo $row['id']; ?>" />

			<div class="col-md-6">
				<label for="ip" class="form-label">IP</label>
				<input type="text" class="form-control" id="ip" name="ip" value="<?php echo $row['ip']; ?>" required autofocus>
			</div>

			<div class="col-md-6">
				<label for="cedual" class="form-label">Cedula</label>
				<input type="text" class="form-control" id="cedula" name="cedula" value="<?php echo $row['cedula']; ?>" required>
			</div>

			<div class="col-md-6">
				<label for="nombre_completo" class="form-label">Nombre Completo</label>
				<input type="text" class="form-control" id="nombre_completo" name="nombre_completo" value="<?php echo $row['nombre_completo']; ?>">
			</div>

			<div class="col-md-6">
				<label for="telefono" class="form-label">Teléfono</label>
				<input type="text" class="form-control" id="telefono" name="telefono" value="<?php echo $row['telefono']; ?>">
			</div>

			<div class="col-md-6">
				<label for="correo" class="form-label">Correo</label>
				<input type="text" class="form-control" id="correo" name="correo" value="<?php echo $row['correo']; ?>">
			</div>

			<?php
			
			// ⚠️ 1. OBTENER EL ID DEL CONTRATO A EDITAR 
			$idContrato = $row['id']; 

			// 2. CONSULTA PARA OBTENER DATOS ACTUALES (INCLUYENDO MUNICIPIO, PARROQUIA y COMUNIDAD)
			// 🔑 MODIFICADO: Se agrega id_comunidad a la selección
			$sql_contrato = "SELECT id_municipio, id_parroquia, id_comunidad 
			                 FROM contratos 
			                 WHERE id = $idContrato";
			$resultado_contrato = $conn->query($sql_contrato);

			if ($resultado_contrato->num_rows === 0) {
			    die("Contrato no encontrado.");
			}

			$datos_actuales = $resultado_contrato->fetch_assoc();
			$municipio_seleccionado = $datos_actuales['id_municipio']; // ID guardado
			$parroquia_seleccionada = $datos_actuales['id_parroquia']; // ID guardado
			$comunidad_seleccionada = $datos_actuales['id_comunidad']; // 🔑 NUEVO: ID guardado
			
			// 3. CONSULTA PARA OBTENER TODOS LOS MUNICIPIOS, PLANES Y VENDEDORES (para llenar la lista)
			$sql_municipios = "SELECT id_municipio, nombre_municipio FROM municipio ORDER BY nombre_municipio ASC";
			$resultado_municipios = $conn->query($sql_municipios);
			
			// OBTENER VALORES SELECCIONADOS DEL CONTRATO (RED)
			// ----------------------------------------------------
			$vendedor_seleccionado = $row['id_vendedor'];
			$plan_seleccionado = $row['id_plan'];
			$pon_seleccionado = $row['id_pon'];
			$olt_seleccionado = $row['id_olt'];
			// ----------------------------------------------------
			
			// CONSULTAS PARA LLENAR LAS LISTAS (STATIC)
			// ----------------------------------------------------

			// Consulta para Vendedores
			$sql_vendedores = "SELECT id_vendedor, nombre_vendedor FROM vendedores ORDER BY nombre_vendedor ASC";
			$resultado_vendedores = $conn->query($sql_vendedores);

			// Consulta para Planes
			$sql_planes = "SELECT id_plan, nombre_plan FROM planes ORDER BY nombre_plan ASC";
			$resultado_planes = $conn->query($sql_planes);

			$estado_actual = $row['estado']; 

			// Consulta para OLTs
			$sql_olt = "SELECT id_olt, nombre_olt FROM olt ORDER BY nombre_olt ASC";
			$resultado_olt = $conn->query($sql_olt);

			// 🔑 NUEVO: Quitar la consulta de todos los PONs (se hará por AJAX)
			// $sql_pon = "SELECT id_pon, nombre_pon FROM pon ORDER BY nombre_pon ASC";
			// $resultado_pon = $conn->query($sql_pon);
			
			// 🔑 NUEVO: Consulta rápida para obtener el nombre del PON seleccionado (Para el label inicial)
			$nombre_pon_actual = 'Cargando...';
			if (!empty($pon_seleccionado)) {
			    $sql_nombre_pon = "SELECT nombre_pon FROM pon WHERE id_pon = $pon_seleccionado";
			    $res_nombre_pon = $conn->query($sql_nombre_pon);
			    if ($res_nombre_pon && $res_nombre_pon->num_rows > 0) {
			        $nombre_pon_actual = $res_nombre_pon->fetch_assoc()['nombre_pon'];
			    }
			}
			// 🔑 NUEVO: Consulta rápida para obtener el nombre de la OLT seleccionada (Para el label inicial, aunque el select lo hará)
			$nombre_olt_actual = 'Cargando...';
			if (!empty($olt_seleccionado)) {
			    $sql_nombre_olt = "SELECT nombre_olt FROM olt WHERE id_olt = $olt_seleccionado";
			    $res_nombre_olt = $conn->query($sql_nombre_olt);
			    if ($res_nombre_olt && $res_nombre_olt->num_rows > 0) {
			        $nombre_olt_actual = $res_nombre_olt->fetch_assoc()['nombre_olt'];
			    }
			}

			// CONVERSIÓN DE FECHA PARA VISUALIZACIÓN
			// ----------------------------------------------------
			$fecha_sql = $row['fecha_instalacion'];

			// Convertir YYYY-MM-DD (SQL) a DD/MM/YYYY (Venezolano) para mostrar
			if (!empty($fecha_sql) && $fecha_sql != '0000-00-00') {
			    $fecha_venezolana = date('d/m/Y', strtotime($fecha_sql));
			} else {
			    $fecha_venezolana = "No definida";
			}


			?>
			<div class="col-md-6">
			<label for="municipio" class="form-label">Municipio</label>
			<select name="id_municipio" id="municipio" class="form-select" required>
			    <option value="">-- Seleccione un Municipio --</option>

			    <?php
			    if ($resultado_municipios->num_rows > 0) {
			        while($fila = $resultado_municipios->fetch_assoc()) {
			            $id = htmlspecialchars($fila["id_municipio"]);
			            $nombre = htmlspecialchars($fila["nombre_municipio"]);
					
			            // 🔑 Lógica de Selección: Compara el ID de la base de datos con el del contrato
			            $selected = ($id == $municipio_seleccionado) ? 'selected' : ''; 
					
			            echo "<option value=\"$id\" $selected>$nombre</option>";
			        }
			    }
			    ?>
			</select>
			</div>

			<br>

			<div class="col-md-6">
			<label for="parroquia" class="form-label">Parroquia</label>
			<select name="id_parroquia" id="parroquia" class="form-select" required>
			    <option value="<?php echo $parroquia_seleccionada; ?>">
			        <?php 
			        // Consulta rápida para mostrar el nombre de la parroquia actual
			        $sql_nombre = "SELECT nombre_parroquia FROM parroquia WHERE id_parroquia = $parroquia_seleccionada";
			        $res_nombre = $conn->query($sql_nombre);
			        // Asegurar que solo se muestre el nombre si la consulta fue exitosa
			        $nombre_parroquia_actual = $res_nombre->num_rows > 0 ? $res_nombre->fetch_assoc()['nombre_parroquia'] : 'Cargando...';
			        echo htmlspecialchars($nombre_parroquia_actual);
			        ?> (Actual)
			    </option>
			</select>
			</div>
			
			<div class="col-md-6">
				<label for="comunidad" class="form-label">Comunidad</label>
				<select name="id_comunidad" id="comunidad" class="form-select">
				    <option value="<?php echo $comunidad_seleccionada; ?>">
					    <?php 
			            // Consulta rápida para mostrar el nombre de la comunidad actual
			            $sql_nombre = "SELECT nombre_comunidad FROM comunidad WHERE id_comunidad = $comunidad_seleccionada";
			            $res_nombre = $conn->query($sql_nombre);
			            $nombre_comunidad_actual = $res_nombre->num_rows > 0 ? $res_nombre->fetch_assoc()['nombre_comunidad'] : 'Cargando...';
			            echo htmlspecialchars($nombre_comunidad_actual);
			            ?> (Actual)
					</option>
				</select>
			</div>


			<div class="col-md-6">
  			  <label for="id_plan" class="form-label">Plan</label>
  			  <select name="id_plan" id="id_plan" class="form-select" required>
  			      <option value="">-- Seleccione un Plan --</option>

  			      <?php
  			      if ($resultado_planes->num_rows > 0) {
  			          while($fila = $resultado_planes->fetch_assoc()) {
  			              $id = htmlspecialchars($fila["id_plan"]);
  			              $nombre = htmlspecialchars($fila["nombre_plan"]);

  			              // Lógica CLAVE: Marca la opción guardada
  			              $selected = ($id == $plan_seleccionado) ? 'selected' : ''; 

  			              echo "<option value=\"$id\" $selected>$nombre</option>";
  			          }
  			      }
  			      ?>
  			  </select>
			</div>

			<div class="col-md-6">
    		<label for="id_vendedor" class="form-label">Vendedor</label>
    		<select name="id_vendedor" id="id_vendedor" class="form-select" required>
    		    <option value="">-- Seleccione un Vendedor --</option>

    		    <?php
    		    if ($resultado_vendedores->num_rows > 0) {
    		        while($fila = $resultado_vendedores->fetch_assoc()) {
    		            $id = htmlspecialchars($fila["id_vendedor"]);
    		            $nombre = htmlspecialchars($fila["nombre_vendedor"]);
					
    		            // Lógica CLAVE: Marca la opción guardada
    		            $selected = ($id == $vendedor_seleccionado) ? 'selected' : ''; 
					
    		            echo "<option value=\"$id\" $selected>$nombre</option>";
    		        }
    		    }
    		    ?>
    		</select>
			</div>

			<div class="col-md-6">
				<label for="direccion" class="form-label">Direccion</label>
				<textarea class="form-control" id="direccion" name="direccion" rows="3"><?php echo htmlspecialchars($row['direccion']); ?></textarea>
			</div>

			<div class="col-md-6">
		    <label for="fecha_instalacion" class="form-label">Fecha de Instalación</label>

		    <input 
		        type="date" 
		        class="form-control" 
		        id="fecha_instalacion" 
		        name="fecha_instalacion" 

		        value="<?php echo $row['fecha_instalacion']; ?>"
		  	  >

		    <?php if ($row['fecha_instalacion']): ?>
		        <small class="form-text text-muted">
		          <?php //echo $fecha_venezolana; ?>
		        </small>
		    <?php endif; ?>
		</div>

		<div class="col-md-6">
    	<label for="estado" class="form-label">Estado del Contrato</label>
   	 	<select class="form-select" id="estado" name="estado" required>
       	 <option value="">-- Seleccione el Estado --</option>
        
     	   <option value="ACTIVO" 
     	       <?php if ($estado_actual == 'ACTIVO') echo 'selected'; ?>>
      	      ACTIVO
     	   </option>
        
      	  <option value="INACTIVO" 
     	       <?php if ($estado_actual == 'INACTIVO') echo 'selected'; ?>>
    	        INACTIVO
     	   </option>
        
     	   <option value="SUSPENDIDO" 
       	     <?php if ($estado_actual == 'SUSPENDIDO') echo 'selected'; ?>>
        	    SUSPENDIDO
        	</option>
        
    	</select>
		</div>
			
			<div class="col-md-6">
				<label for="ident_caja_nap" class="form-label">Identificacion Caja Nap</label>
				<input type="text" class="form-control" id="ident_caja_nap" name="ident_caja_nap" value="<?php echo $row['ident_caja_nap']; ?>">
			</div>

			<div class="col-md-6">
				<label for="puerto_nap" class="form-label">Puerto_Nap</label>
				<input type="text" class="form-control" id="puerto_nap" name="puerto_nap" value="<?php echo $row['puerto_nap']; ?>">
			</div>

			<div class="col-md-6">
				<label for="num_presinto_odn" class="form-label">Numero_Presinto_ODN</label>
				<input type="text" class="form-control" id="num_presinto_odn" name="num_presinto_odn" value="<?php echo $row['num_presinto_odn']; ?>">
			</div>

			<div class="col-md-6">
    		<label for="id_olt" class="form-label">OLT</label>
    		<select name="id_olt" id="id_olt" class="form-select" required>
    		    <option value="">-- Seleccione una OLT --</option>

    		    <?php
    		    if ($resultado_olt->num_rows > 0) {
    		        while($fila = $resultado_olt->fetch_assoc()) {
    		            $id = htmlspecialchars($fila["id_olt"]);
    		            $nombre = htmlspecialchars($fila["nombre_olt"]);
					
    		            // Lógica CLAVE: Marca la opción guardada
    		            $selected = ($id == $olt_seleccionado) ? 'selected' : ''; 
					
    		            echo "<option value=\"$id\" $selected>$nombre</option>";
    		        }
    		    }
    		    ?>
    		</select>
			</div>

			<div class="col-md-6">
    		<label for="id_pon" class="form-label">PON</label>
    		<select name="id_pon" id="id_pon" class="form-select" required disabled> 
    		    <option value="<?php echo $pon_seleccionado; ?>" selected>
    		        <?php echo htmlspecialchars($nombre_pon_actual); ?> (Actual)
    		    </option>
    		</select>
			</div>

			<div class="row mt-4">
				<?php
				$path = 'files/' . $id;
				if (file_exists($path)) {
					$directorio = opendir($path);
					while ($archivo = readdir($directorio)) {
						if (!is_dir($archivo)) {
							echo '<div class="col-md-3">';
							echo '<div>';

							$archivoPath = $path . "/" . $archivo;
							echo "<a href='$archivoPath' target='_blank' title='Ver Archivo'><i class='fa-solid fa-eye'></i> Ver Archivo </a>";
							echo "<a href='#' data='$archivoPath' class='delete ms-2' title='Elimiar Archivo'><i class='fa-solid fa-trash'></i> Eliminar Archivo</a>";

							if (function_exists('esImagen') && esImagen($archivoPath)) {
								echo "<img src='$archivoPath' class='img-thumbnail'>";
							}

							echo '</div>';
							echo '</div>';
						}
					}
				}
				?>
			</div>

			<div class="col-12">
				<a href="index.php" class="btn btn-secondary">Regresar</a>
				<button type="submit" class="btn btn-success">Guardar</button>
			</div>
		</form>
	</main>

	<script src="assets/js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript">
		let deleteButtons = document.querySelectorAll('.delete');

		for (let i = 0; i < deleteButtons.length; i++) {
			deleteButtons[i].addEventListener('click', function() {
				var file = this.getAttribute('data');
				var dataString = 'file=' + file;

				fetch('del_file.php', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded'
						},
						body: dataString
					})
					.then(function(response) {
						if (response.ok) {
							location.reload();
						}
					})
					.catch(function(error) {
						console.error('Error:', error);
					});
			});
		}
	</script>

	<script>
    $(document).ready(function() {
        
        // 🔑 OBTENER LOS VALORES INICIALES DE PHP (UBICACIÓN)
        var parroquiaSeleccionadaId = "<?php echo $parroquia_seleccionada; ?>";
        var municipioInicialId = "<?php echo $municipio_seleccionado; ?>";
        var comunidadSeleccionadaId = "<?php echo $comunidad_seleccionada; ?>"; 

        // 🔑 NUEVOS: OBTENER LOS VALORES INICIALES DE PHP (RED)
        var oltInicialId = "<?php echo $olt_seleccionado; ?>";
        var ponSeleccionadoId = "<?php echo $pon_seleccionado; ?>";

        // =========================================================================
        // 2. FUNCIONES DE CARGA EN CASCADA
        // =========================================================================

        // Función para cargar comunidades 
        function cargarComunidadesIniciales(parroquiaID, comunidadIDaSeleccionar) {
            
            $('#comunidad').html('<option value="">Cargando comunidades...</option>');
            $('#comunidad').prop('disabled', true);

            if (parroquiaID) {
                $.ajax({
                    url: 'obtener_comunidades.php', 
                    type: 'POST',
                    data: { id_parroquia: parroquiaID },
                    dataType: 'json',
                    success: function(comunidades) {
                        $('#comunidad').html('<option value="">-- Seleccione una Comunidad --</option>');
                        
                        $.each(comunidades, function(key, value) {
                            var selectedAttr = (key == comunidadIDaSeleccionar) ? 'selected' : '';
                            $('#comunidad').append('<option value="' + key + '" ' + selectedAttr + '>' + value + '</option>');
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
        

        // Función para cargar parroquias (MODIFICADA: Llama a cargarComunidades)
        function cargarParroquiasIniciales(municipioID, parroquiaIDaSeleccionar, comunidadIDaSeleccionar) {
            
            $('#parroquia').html('<option value="">Cargando parroquias...</option>');
            $('#parroquia').prop('disabled', true);
            
            // Resetear Comunidad
            $('#comunidad').html('<option value="">-- Primero seleccione una parroquia --</option>');
            $('#comunidad').prop('disabled', true);


            if (municipioID) {
                $.ajax({
                    url: 'get_parroquias.php', 
                    type: 'POST',
                    data: { id: municipioID }, // El script get_parroquias.php espera 'id'
                    dataType: 'json',
                    success: function(parroquias) {
                        $('#parroquia').html('<option value="">-- Seleccione una Parroquia --</option>');
                        var parroquiaSeleccionadaPostCarga = null;
                        
                        $.each(parroquias, function(key, value) {
                            var selectedAttr = (key == parroquiaIDaSeleccionar) ? 'selected' : '';
                            
                            if (selectedAttr) {
                                parroquiaSeleccionadaPostCarga = key;
                            }

                            $('#parroquia').append('<option value="' + key + '" ' + selectedAttr + '>' + value + '</option>');
                        });
                        
                        $('#parroquia').prop('disabled', false);

                        // Si hay una parroquia pre-seleccionada, cargar sus comunidades
                        if (parroquiaSeleccionadaPostCarga) {
                             cargarComunidadesIniciales(parroquiaSeleccionadaPostCarga, comunidadIDaSeleccionada);
                        } else {
                            cargarComunidadesIniciales(null, null); // Deshabilita la comunidad
                        }
                    },
                    error: function() {
                        $('#parroquia').html('<option value="">Error al cargar parroquias</option>');
                    }
                });
            } else {
                $('#parroquia').html('<option value="">-- Primero seleccione un municipio --</option>');
            }
        }
        
        // 🔑 NUEVA: Función para cargar PONs (OLT -> PON)
        function cargarPonsIniciales(oltID, ponIDaSeleccionar) {
            var $ponSelect = $('#id_pon');
            
            $ponSelect.html('<option value="">Cargando PONs...</option>').prop('disabled', true);

            if (oltID) {
                // Realizar la llamada AJAX al endpoint que filtra
                $.ajax({
                    url: 'gets_pon_by_olt.php', // *** IMPORTANTE: NECESITAS ESTE ARCHIVO ***
                    type: 'GET', 
                    data: { id_olt: oltID },
                    dataType: 'json',
                    success: function(response) {
                        $ponSelect.empty();
                        
                        if (!response.error && response.pons && response.pons.length > 0) {
                            $ponSelect.append('<option value="">-- Seleccione un PON --</option>');
                            
                            $.each(response.pons, function(index, pon) {
                                // Lógica de pre-selección
                                var selectedAttr = (pon.id_pon == ponIDaSeleccionar) ? 'selected' : '';
                                $ponSelect.append('<option value="' + pon.id_pon + '" ' + selectedAttr + '>' + pon.nombre_pon + '</option>');
                            });
                            $ponSelect.prop('disabled', false); 
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


        // =========================================================================
        // 3. EVENTOS y LLAMADAS INICIALES
        // =========================================================================

        // Al cargar la página, iniciar la carga de ubicación pre-seleccionada
        if (municipioInicialId) {
            cargarParroquiasIniciales(municipioInicialId, parroquiaSeleccionadaId, comunidadSeleccionadaId);
        }
        
        // 🔑 NUEVA: Al cargar la página, iniciar la carga de PONs pre-seleccionados
        if (oltInicialId) {
            cargarPonsIniciales(oltInicialId, ponSeleccionadoId);
        }

        // Manejar cambio de Municipio
        $('#municipio').on('change', function() {
            var nuevoMunicipioID = $(this).val(); 
            
            if (nuevoMunicipioID) {
                // Al cambiar municipio, reiniciamos parroquia y comunidad (null, null)
                cargarParroquiasIniciales(nuevoMunicipioID, null, null); 
            } else {
                $('#parroquia').html('<option value="">-- Primero seleccione un municipio --</option>').prop('disabled', true);
                $('#comunidad').html('<option value="">-- Primero seleccione una parroquia --</option>').prop('disabled', true);
            }
        });
        
        // Manejar cambio de Parroquia
        $('#parroquia').on('change', function() {
            var idParroquia = $(this).val();
            // Al cambiar parroquia, cargamos comunidades
            cargarComunidadesIniciales(idParroquia, null);
        });
        
        // 🔑 NUEVO: Manejar cambio de OLT
        $('#id_olt').on('change', function() {
            var idOlt = $(this).val();
            // Al cambiar OLT, no hay PON pre-seleccionado, pasamos 'null'
            cargarPonsIniciales(idOlt, null); 
        });

    });
</script>
</body>

</html>