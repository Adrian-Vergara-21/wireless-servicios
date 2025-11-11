<?php

/**
 * Página principal que muestra la tabla de registros
 *
 * Esta página muestra una tabla que contiene los registros almacenados en la base de datos.
 * Permite visualizar, editar y eliminar registros.*/

require '../conexion.php';

?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gestion De Contratos</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet">
	<link href="../../css/all.min.css" rel="stylesheet">
	<link href="../../css/datatables.min.css" rel="stylesheet">
	<link href="../../css/style3.css" rel="stylesheet">
	<link href="../../css/style4.css" rel="stylesheet">
	   <link rel="icon" type="image/jpg" href="../../images/logo.jpg"/>
</head>

<body>
	<!--style>
        /* Tamaño de fuente LIGERAMENTE MÁS GRANDE para los encabezados */
        #mitabla th {
            font-size: 15px; 
            text-align: center !important; /* Mantenemos el centrado */
        }
        
        /* Tamaño de fuente para el CONTENIDO (filas), hazlo 1 o 2px menor */
        #mitabla td {
            font-size: 12px; /* Reducido para que el TH de 14px resalte */
            text-align: center; /* Mantenemos el centrado del contenido */
        }
    </style-->
	<style>
        /* ----------------------------------------------- */
        /* Estilos personalizados para la tabla DataTables */
        /* ----------------------------------------------- */

        /* Encabezado (thead) - Usando su color principal */
        #mitabla thead th {
            background-color: #2963bbff; /* Azul oscuro */
            color: white;
            font-size: 14px; /* Un poco más pequeño para dejar espacio a DataTables */
            text-align: center !important; 
            padding-top: 12px; 
            padding-bottom: 12px; 
        }

        /* Cuerpo de la tabla (filas) */
        #mitabla tbody tr:nth-child(even) {
            background-color: #f0f4f8; /* Un color de fondo alternativo más claro (gris azulado) */
        }
        
        /* Contenido de las celdas */
        #mitabla td {
            font-size: 12px; /* Reducido para mejor legibilidad con muchas columnas */
            text-align: center; 
            padding: 8px; /* Reducido para compactar la tabla */
        }

        /* Botones de DataTables para integrar con los estilos de la interfaz */
        .dataTables_wrapper .dataTables_paginate .paginate_button.current,
        .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
            background-color: #2196f3 !important; /* Su color azul primario */
            color: white !important;
            border-color: #0d47a1 !important;
            border-radius: 5px;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button {
             border-radius: 5px;
        }

    </style>

	<main class="container">
		<header class="register-header">
		<h1 class="text-center pt-3 texto_modificado">Gestion De Contratos</h1>
		 <p class= "text-center">Wireless Supply, C.A.</p>
		</header>

		<!-- Botón para nuevo registro -->
		 <a href="nuevo.php" class="btn btn-primary my-4 btn_modificado"> Nuevo Registro</a>

		<div class="table-responsive">
			<table class="display table table-bordered" id="mitabla">
				<thead>
					<tr>
						<th class="text-center">ID</th>
						<th class="text-center">IP</th>
						<th class="text-center">Cedula</th>
						<th class="text-center">Nombre Completo</th>
						<th class="text-center">Telefono</th>
						<th class="text-center">Correo</th>
						<th class="text-center">Municipio</th>
						<th class="text-center">Parroquia</th>
						<th class="text-center">Comunidad</th>
						<th class="text-center">Dirección</th>
						<th class="text-center">Plan</th>
						<th class="text-center">Vendedor</th>
						<!--th>Direccion</th-->
						<th class="text-center">Fecha Instalacion</th>
						<th class="text-center">Estado</th>
						<th class="text-center">Identificador Caja Nap</th>
						<th class="text-center">Puerto Nap</th>
						<th class="text-center">Num. Precinto</th>
						<th class="text-center">OLT</th>
						<th class="text-center">Pon</th>
						<!--th class="text-center">PDF</th-->
						<th width="5%"></th>
						<th width="5%"></th>
						<th width="5%"></th>
					</tr>
				</thead>

				<tbody>

				</tbody>
			</table>
		</div>
		<div class="button-group">
                    <!--button type="submit" class="btn btn-primary">Registrar Banco</button-->
                    <a href="../menu.php" class="btn btn-secondary">Volver Al Menú</a>
        </div>
	</main>

	<!-- Modal elimina registro -->
	<div class="modal fade" id="eliminaModal" tabindex="-1" aria-labelledby="eliminaModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Eliminar Registro</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					¿Desea eliminar el registro?
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn_modificado2" data-bs-dismiss="modal" >Cancel</button>
					<a class="btn btn-danger btn-ok">Eliminar</a>
				</div>

			</div>
		</div>
	</div>
<div class="modal fade" id="modalDireccion" tabindex="-1" aria-labelledby="modalDireccionLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-md modal-dialog-centered"> 
        <div class="modal-content">
            
            <div class="modal-header bg-primary text-white"> 
                <h5 class="modal-title" id="modalDireccionLabel">
                    <i class="fa-solid fa-map-location-dot me-2"></i> Detalles de la Dirección
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                
                <div class="card mb-3 bg-light border-info">
                    <div class="card-body py-2">
                        <p class="mb-1 text-muted">Cliente:</p>
                        <h5 class="card-title text-dark mb-1" id="cliente_nombre_modal"></h5>
                        <p class="card-text text-secondary">
                            <i class="fa-solid fa-network-wired me-1"></i> IP: <span id="cliente_ip_modal"></span>
                        </p>
                    </div>
                </div>

                <h6><i class="fa-solid fa-location-dot me-1 text-info"></i> Dirección Completa:</h6>
                
                <div class="p-3 border rounded bg-white" style="white-space: pre-wrap; word-wrap: break-word;">
                    <p id="direccion_completa_modal" class="text-secondary m-0"></p> 
                </div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

	<script src="../../js/bootstrap.bundle.min.js"></script>
	<script src="../../js/jquery.min.js"></script>
	<script src="../../js/datatables.min.js"></script>

	<script>
		$(document).ready(function() {
			$('#mitabla').DataTable({
				"order": [
					[0, "asc"]
				],
				"iDisplayLength": 5,
				"language": {
					"lengthMenu": "Mostrar _MENU_ registros por pagina",
					"info": "Mostrando pagina _PAGE_ de _PAGES_",
					"infoEmpty": "No hay registros disponibles",
					"infoFiltered": "(filtrada de _MAX_ registros)",
					"loadingRecords": "Cargando...",
					"processing": "Procesando...",
					"search": "Buscar:",
					"zeroRecords": "No se encontraron registros coincidentes",
					"paginate": {
						"next": "Siguiente",
						"previous": "Anterior"
					},
				},
				"bProcessing": true,
				"bServerSide": true,
				"sAjaxSource": "server_process.php"
			});
		});

		let eliminaModal = document.getElementById('eliminaModal')
		eliminaModal.addEventListener('shown.bs.modal', event => {
			let button = event.relatedTarget
			let url = button.getAttribute('data-bs-href')
			eliminaModal.querySelector('.modal-footer .btn-ok').href = url
		})

    // ----------------------------------------------------
    // LÓGICA CORREGIDA PARA EL MODAL DE DIRECCIÓN
    // ----------------------------------------------------
    $('#modalDireccion').on('show.bs.modal', function (event) {
        // Usa jQuery para seleccionar el botón que disparó el modal
        let button = $(event.relatedTarget); 

        //  CAPTURA CLAVE: Usar .data() de jQuery para leer los atributos
        // jQuery es más fiable que getAttribute() para data-* en tablas dinámicas.
        let direccionCompleta = button.data('direccion');
        let nombreCliente = button.data('nombre');
        let ipCliente = button.data('ip');

        // Busca los elementos del modal (usando jQuery o vanilla JS)
        let modal = $(this);
        
        // Llena el modal con la información
        // Se usa .text() para evitar problemas de inyección y mostrar el texto correctamente
        modal.find('#cliente_nombre_modal').text(nombreCliente);
        modal.find('#cliente_ip_modal').text(ipCliente);
        
        // La dirección se llena con .html() para respetar los posibles espacios y saltos si los hubiera,
        // aunque en PHP los reemplazamos por espacios simples para seguridad.
        // Usamos la propiedad CSS 'white-space: pre-wrap' en el modal para que los espacios largos 
        // o saltos de línea se muestren si son necesarios (aunque en PHP los eliminamos por seguridad).
        modal.find('#direccion_completa_modal').html(direccionCompleta);
    });

	</script>
	</body>
</html>