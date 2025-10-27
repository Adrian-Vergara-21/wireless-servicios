<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';
$action = isset($_GET['action']) ? $_GET['action'] : '';
$stmt = null; // Inicializamos la variable stmt para evitar errores

// Variables para la búsqueda
$search_term = isset($_GET['search']) ? $_GET['search'] : '';
$sql = "SELECT m.id_municipio, m.nombre_municipio, p.id_parroquia, p.nombre_parroquia 
        FROM `municipio` m
        LEFT JOIN `parroquia` p ON m.id_municipio = p.id_municipio";

// --- LÓGICA DE GESTIÓN (ELIMINAR) ---
if ($action === 'delete_municipio' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    // Se asume eliminación en cascada en la BD o que se maneja la eliminación de dependencias
    $stmt = $conn->prepare("DELETE FROM `municipio` WHERE `id_municipio` = ?");
    $stmt->bind_param("i", $id_to_delete);
    if ($stmt->execute()) {
        $message = "Municipio, parroquias y comunidades eliminados con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar el municipio: " . $stmt->error;
        $message_class = 'error';
    }
} elseif ($action === 'delete_parroquia' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM `parroquia` WHERE `id_parroquia` = ?");
    $stmt->bind_param("i", $id_to_delete);
    if ($stmt->execute()) {
        $message = "Parroquia y sus comunidades eliminadas con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar la parroquia: " . $stmt->error;
        $message_class = 'error';
    }
} elseif ($action === 'delete_comunidad' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM `comunidad` WHERE `id_comunidad` = ?");
    $stmt->bind_param("i", $id_to_delete);
    if ($stmt->execute()) {
        $message = "Comunidad eliminada con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar la comunidad: " . $stmt->error;
        $message_class = 'error';
    }
}

// --- LÓGICA DE MODIFICACIÓN (PROCESAR FORMULARIO POST) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_type'])) {
    $update_type = $_POST['update_type'];
    $stmt = null; // Reiniciar $stmt
    $message_suffix = '';
    $id_principal = null;

    if ($update_type === 'municipio') {
        // BUSCA EL NUEVO NOMBRE ÚNICO: id_municipio_update
        $id_principal = isset($_POST['id_municipio_update']) ? $_POST['id_municipio_update'] : null;
        $nombre = isset($_POST['nombre_municipio']) ? $_POST['nombre_municipio'] : '';
        $stmt = $conn->prepare("UPDATE `municipio` SET `nombre_municipio` = ? WHERE `id_municipio` = ?");
        $stmt->bind_param("si", $nombre, $id_principal);
        $message_suffix = 'Municipio';
    } elseif ($update_type === 'parroquia') {
        // BUSCA EL NUEVO NOMBRE ÚNICO: id_parroquia_update
        $id_principal = isset($_POST['id_parroquia_update']) ? $_POST['id_parroquia_update'] : null;
        $nombre = isset($_POST['nombre_parroquia']) ? $_POST['nombre_parroquia'] : '';
        $id_municipio = isset($_POST['id_municipio']) ? $_POST['id_municipio'] : null;
        $stmt = $conn->prepare("UPDATE `parroquia` SET `nombre_parroquia` = ?, `id_municipio` = ? WHERE `id_parroquia` = ?");
        $stmt->bind_param("sii", $nombre, $id_municipio, $id_principal);
        $message_suffix = 'Parroquia';
    } elseif ($update_type === 'comunidad') { 
        // BUSCA EL NUEVO NOMBRE ÚNICO: id_comunidad_update
        $id_principal = isset($_POST['id_comunidad_update']) ? $_POST['id_comunidad_update'] : null;
        $nombre = isset($_POST['nombre_comunidad']) ? $_POST['nombre_comunidad'] : '';
        $id_parroquia = isset($_POST['id_parroquia_comunidad']) ? $_POST['id_parroquia_comunidad'] : null; 
        $stmt = $conn->prepare("UPDATE `comunidad` SET `nombre_comunidad` = ?, `id_parroquia` = ? WHERE `id_comunidad` = ?");
        $stmt->bind_param("sii", $nombre, $id_parroquia, $id_principal);
        $message_suffix = 'Comunidad';
    }

    if (isset($stmt)) {
        if (empty($id_principal)) {
            $message = "ERROR Crítico: La ID de la {$message_suffix} a modificar no se pudo obtener. Actualización fallida.";
            $message_class = 'error';
        } elseif ($stmt->execute()) {
            // VERIFICACIÓN DE FILAS AFECTADAS (CLAVE PARA SABER SI HUBO CAMBIOS)
            if ($stmt->affected_rows > 0) { 
                $message = "¡" . $message_suffix . " actualizada(o) con éxito!";
                $message_class = 'success';
            } else {
                $message = "ADVERTENCIA: No se realizaron cambios en el registro de " . $message_suffix . ". Los datos ingresados son idénticos a los existentes, o la ID no existe. ID: {$id_principal}";
                $message_class = 'warning'; 
            }
        } else {
            $message = "ERROR Crítico al actualizar " . $message_suffix . ": " . $stmt->error;
            $message_class = 'error';
        }
        if ($stmt) {
            $stmt->close();
        }
    } else {
        $message = "ERROR: Tipo de actualización desconocido.";
        $message_class = 'error';
    }
    
    // Redirigimos para mostrar el mensaje
    header("Location: gestion_municipios.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}


// --- CONSULTA PARA MOSTRAR LOS DATOS ---
if (!empty($search_term)) {
    $sql .= " WHERE m.nombre_municipio LIKE ? OR p.nombre_parroquia LIKE ?";
    $search_param = "%" . $search_term . "%";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $search_param, $search_param);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $sql .= " ORDER BY m.nombre_municipio ASC, p.nombre_parroquia ASC";
    $result = $conn->query($sql);
}

$data = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

// Obtener TODAS las ubicaciones para el modal (datos CLAVE para el JS)
$comunidades = $conn->query("SELECT id_comunidad, nombre_comunidad, id_parroquia FROM `comunidad` ORDER BY id_parroquia, nombre_comunidad ASC")->fetch_all(MYSQLI_ASSOC);
$municipios_all = $conn->query("SELECT id_municipio, nombre_municipio FROM `municipio` ORDER BY nombre_municipio ASC")->fetch_all(MYSQLI_ASSOC);
$parroquias_all = $conn->query("SELECT id_parroquia, nombre_parroquia, id_municipio FROM `parroquia` ORDER BY nombre_parroquia ASC")->fetch_all(MYSQLI_ASSOC);

// Manejo del mensaje de redirección
if (isset($_GET['message'])) {
    $message = $_GET['message'];
    $message_class = $_GET['class'];
}

// Cerramos la conexión a la base de datos al final
if ($stmt) {
    $stmt->close();
}
$conn->close();

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Ubicaciones</title>
    <link href="../css/all.min.css" rel="stylesheet">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style3.css">
    <link rel="stylesheet" href="../css/style4.css">
    <style>
        .table-container table {
            width: 100%;
            border-collapse: collapse;
        }
        .municipio-row {
            background-color: #f0f8ff; 
            font-weight: bold;
        }
        .parroquia-row td:nth-child(1), 
        .parroquia-row td:nth-child(2) {
            background-color: #fff; 
            color: #ccc; 
        }
        .table thead th {
            color: white; 
            background-color: #343a40; 
            border-color: #454d55; 
        }
        /* Nuevo estilo para los títulos del modal */
        .texto_modificado_modal {
            color: #0d6efd; /* Color azul de Bootstrap Primary */
            font-size: 1.5rem;
            font-weight: 600;
        }

        /* Estilo para el encabezado del modal (header) */
        .modal-header-styled {
            background-color: #f8f9fa; /* Color de fondo muy claro */
            border-bottom: 2px solid #0d6efd; /* Línea inferior azul */
        }
        
        /* Estilo para los botones de las modales */
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        /*.btn-secondary {
            color: #6c757d;
            border-color: #6c757d;
        }*/
    </style>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Gestión de Ubicaciones Geográficas</h1>
            <p>Wireless Supply, C.A.</p>
        </header>
        
        <div class="header-actions">
            <div>
                <a href="registro_municipios.php" class="btn btn-primary">Nuevo Registro</a>
            </div>
            <div class="step-section search-section">
                <h2 style="margin-top: 0;">Buscar</h2>
                <form action="gestion_municipios.php" method="GET" class="search-form">
                    <input type="text" name="search" placeholder="Buscar por municipio o parroquia..." value="<?php echo htmlspecialchars($search_term); ?>">
                    <button type="submit" class="btn btn-primary">Buscar</button>
                </form>
            </div>
        </div>

        <?php if ($message): ?>
            <div class="message <?php echo $message_class; ?>">
                <?php echo htmlspecialchars($message); ?>
            </div>
        <?php endif; ?>

        <div class="table-container">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th style="width: 10%;">ID Municipio</th>
                        <th style="width: 25%;">Municipio</th>
                        <th style="width: 10%;">ID Parroquia</th>
                        <th style="width: 25%;">Parroquia</th>
                        <th style="width: 15%;">Comunidades</th>
                        <th style="width: 15%;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php 
                    $current_municipio_id = null;
                    if (!empty($data)): ?>
                        <?php foreach ($data as $row): ?>
                            <?php if ($current_municipio_id !== $row['id_municipio']): ?>
                                <tr class="municipio-row">
                                    <td><?php echo htmlspecialchars($row['id_municipio']); ?></td>
                                    <td><?php echo htmlspecialchars($row['nombre_municipio']); ?></td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td class="action-links"> 
                                        <a href="#" 
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalModificacion"
                                            data-id="<?php echo urlencode($row['id_municipio']); ?>"
                                            data-nombre="<?php echo htmlspecialchars($row['nombre_municipio']); ?>"
                                            data-type="municipio"
                                            class="btn btn-sm" title="Modificar Municipio">
                                            <i class="fa-solid fa-pen-to-square text-primary"></i>
                                        </a>
                                        <a href="#" 
                                            data-bs-href="gestion_municipios.php?action=delete_municipio&id=<?php echo urlencode($row['id_municipio']); ?>" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#eliminaModal" 
                                            class="btn btn-sm" 
                                            title="Eliminar Municipio">
                                            <i class="fa-solid fa-trash-can text-danger"></i>
                                        </a>
                                    </td>
                                </tr>
                                <?php $current_municipio_id = $row['id_municipio']; ?>
                            <?php endif; ?>
                            <?php if ($row['id_parroquia']): ?>
                                <tr class="parroquia-row">
                                    <td>-</td>
                                    <td>-</td>
                                    <td><?php echo htmlspecialchars($row['id_parroquia']); ?></td>
                                    <td><?php echo htmlspecialchars($row['nombre_parroquia']); ?></td>
                                    
                                    <td class="action-links">
                                        <a href="#" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#modalComunidades"
                                            data-parroquia-id="<?php echo urlencode($row['id_parroquia']); ?>"
                                            data-parroquia-nombre="<?php echo htmlspecialchars($row['nombre_parroquia']); ?>"
                                            class="btn btn-sm btn-comunidades" 
                                            title="Ver Comunidades Asociadas">
                                            <i class="fa-solid fa-eye text-info"></i> </a>
                                    </td>
                                    
                                    <td class="action-links">
                                        <a href="#" 
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalModificacion"
                                            data-id="<?php echo urlencode($row['id_parroquia']); ?>"
                                            data-nombre="<?php echo htmlspecialchars($row['nombre_parroquia']); ?>"
                                            data-municipio-id="<?php echo urlencode($row['id_municipio']); ?>"
                                            data-type="parroquia"
                                            class="btn btn-sm" title="Modificar Parroquia">
                                            <i class="fa-solid fa-pen-to-square text-primary"></i>
                                        </a>
                                        <a href="#" 
                                            data-bs-href="gestion_municipios.php?action=delete_parroquia&id=<?php echo urlencode($row['id_parroquia']); ?>" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#eliminaModal" 
                                            class="btn btn-sm" 
                                            title="Eliminar Parroquia">
                                            <i class="fa-solid fa-trash-can text-danger"></i>
                                        </a>
                                    </td>
                                </tr>
                            <?php endif; ?>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="6">No se encontraron municipios ni parroquias que coincidan con la búsqueda.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="menu.php" class="btn btn-secondary">Volver al Menú</a>
        </div>
    </div>
    
<div class="modal fade" id="modalModificacion" tabindex="-1" aria-labelledby="modalModificacionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="modalModificacionLabel">Modificar Ubicación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="form-modificacion" action="gestion_municipios.php" method="POST" novalidate>
                    <div class="modal-body">
                        <input type="hidden" name="update_type" id="update_type_modal" value="">
                        <input type="hidden" name="id_municipio_update" id="id_municipio_modal" value="">
                        <input type="hidden" name="id_parroquia_update" id="id_parroquia_modal" value="">
                        <input type="hidden" name="id_comunidad_update" id="id_comunidad_modal" value="">
                        
                        <div id="modal-content-municipio" style="display:none;">
                            <div class="mb-3">
                                <label for="nombre_municipio_modal" class="form-label">Nombre del Municipio:</label>
                                <input type="text" id="nombre_municipio_modal" name="nombre_municipio" class="form-control"> 
                            </div>
                        </div>
                        
                        <div id="modal-content-parroquia" style="display:none;">
                            <div class="mb-3">
                                <label for="id_municipio_parroquia_modal" class="form-label">Municipio:</label>
                                <select id="id_municipio_parroquia_modal" name="id_municipio" class="form-select"> 
                                    <option value="">Seleccione un municipio</option>
                                    <?php foreach ($municipios_all as $mun_row): ?>
                                        <option value="<?php echo htmlspecialchars($mun_row['id_municipio']); ?>">
                                            <?php echo htmlspecialchars($mun_row['nombre_municipio']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="nombre_parroquia_modal" class="form-label">Nombre de la Parroquia:</label>
                                <input type="text" id="nombre_parroquia_modal" name="nombre_parroquia" class="form-control"> 
                            </div>
                        </div>

                        <div id="modal-content-comunidad" style="display:none;">
                            <div class="mb-3">
                                <label for="id_municipio_comunidad_modal" class="form-label">Municipio:</label>
                                <select id="id_municipio_comunidad_modal" class="form-select" onchange="filterParroquias(this.value, 'id_parroquia_comunidad_modal')"> 
                                    <option value="">Seleccione un municipio</option>
                                    <?php foreach ($municipios_all as $mun_row): ?>
                                        <option value="<?php echo htmlspecialchars($mun_row['id_municipio']); ?>">
                                            <?php echo htmlspecialchars($mun_row['nombre_municipio']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="id_parroquia_comunidad_modal" class="form-label">Parroquia:</label>
                                <select id="id_parroquia_comunidad_modal" name="id_parroquia_comunidad" class="form-select"> 
                                    <option value="">Seleccione un municipio primero</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="nombre_comunidad_modal" class="form-label">Nombre de la Comunidad:</label>
                                <input type="text" id="nombre_comunidad_modal" name="nombre_comunidad" class="form-control"> 
                            </div>
                        </div>
                        
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 40%;">Cancelar</button>
                        <button type="button" id="btn-actualizar-modal" class="btn btn-primary" style="width: 55%;">Actualizar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="eliminaModal" tabindex="-1" aria-labelledby="eliminaModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="eliminaModalLabel">Eliminar Registro</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Desea eliminar el registro?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn_modificado2" data-bs-dismiss="modal" >Cancelar</button>
                    <a class="btn btn-danger btn-ok">Eliminar</a> 
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="modalComunidades" tabindex="-1" aria-labelledby="modalComunidadesLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalComunidadesLabel">Comunidades de Parroquia: <span id="parroquia-name-modal"></span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-sm table-striped table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 10%;">ID</th>
                                    <th style="width: 60%;">Comunidad</th>
                                    <th style="width: 25%;">Acciones</th>
                                </tr>
                            </thead>
                            <tbody id="comunidades-list-body">
                                </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/bootstrap.bundle.min.js"></script> 

    <script>
        // DATOS DE UBICACIONES SERIALIZADOS DESDE PHP A JAVASCRIPT
        const ALL_COMUNIDADES = <?php echo json_encode($comunidades); ?>;
        const ALL_MUNICIPIOS = <?php echo json_encode($municipios_all); ?>;
        const ALL_PARROQUIAS = <?php echo json_encode($parroquias_all); ?>;

        // --- FUNCIÓN CLAVE PARA LA VALIDACIÓN DINÁMICA ---
        function setRequiredFields(containerId) {
            const formModificacion = document.getElementById('form-modificacion');
            
            // 1. Eliminar la clase de validación (para reinicio visual)
            formModificacion.classList.remove('was-validated'); 

            // 2. Reiniciar TODOS los atributos 'required'
            document.querySelectorAll('#form-modificacion input, #form-modificacion select').forEach(field => {
                field.removeAttribute('required');
            });
            
            // 3. Asignar 'required' solo a los campos del contenedor visible
            const container = document.getElementById(containerId);
            container.querySelectorAll('input, select').forEach(field => {
                field.setAttribute('required', 'required');
            });
        }
        // -----------------------------------------------------------------


        // Función para filtrar dinámicamente el select de Parroquias
        function filterParroquias(municipioId, targetSelectId, selectedParroquiaId = null) {
            const targetSelect = document.getElementById(targetSelectId);
            
            targetSelect.innerHTML = '';
            
            if (!municipioId || municipioId === "") {
                targetSelect.innerHTML = '<option value="">Seleccione un municipio primero</option>';
                return;
            }

            const parroquiasFiltradas = ALL_PARROQUIAS.filter(p => p.id_municipio == municipioId);

            const defaultOption = document.createElement('option');
            defaultOption.value = "";
            defaultOption.textContent = "Seleccione una parroquia";
            targetSelect.appendChild(defaultOption);

            parroquiasFiltradas.forEach(p => {
                const option = document.createElement('option');
                option.value = p.id_parroquia;
                option.textContent = p.nombre_parroquia;
                if (selectedParroquiaId && p.id_parroquia == selectedParroquiaId) {
                    option.selected = true;
                }
                targetSelect.appendChild(option);
            });
        }
        
        // Ejecutar código solo cuando el DOM está completamente cargado
        document.addEventListener('DOMContentLoaded', function() {
            
            // ----------------------------------------------------
            // LÓGICA DEL MODAL DE MODIFICACIÓN
            // ----------------------------------------------------
            const modalModificacion = document.getElementById('modalModificacion');
            const formModificacion = document.getElementById('form-modificacion');

            if (modalModificacion) {
                modalModificacion.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget; 
                    
                    const id = button.getAttribute('data-id');
                    const nombre = button.getAttribute('data-nombre');
                    const type = button.getAttribute('data-type');
                    
                    // --- DIAGNÓSTICO ---
                    console.log(`Abriendo Modal. Tipo: ${type}, ID leída del botón: ${id}`);
                    
                    const modalTitle = document.getElementById('modalModificacionLabel');
                    const typeInput = document.getElementById('update_type_modal');
                    
                    // 1. Ocultar todos los contenedores y limpiar IDs
                    document.getElementById('modal-content-municipio').style.display = 'none';
                    document.getElementById('modal-content-parroquia').style.display = 'none';
                    document.getElementById('modal-content-comunidad').style.display = 'none';
                    
                    // Limpieza de IDs ocultas
                    document.getElementById('id_municipio_modal').value = '';
                    document.getElementById('id_parroquia_modal').value = '';
                    document.getElementById('id_comunidad_modal').value = '';

                    typeInput.value = type;

                    if (type === 'municipio') {
                        const munId = button.getAttribute('data-id');
                        const munNombre = button.getAttribute('data-nombre');
                        modalTitle.textContent = `Modificar Municipio: ${munNombre}`;
                        document.getElementById('modal-content-municipio').style.display = 'block';
                        
                        document.getElementById('id_municipio_modal').value = munId; 
                        console.log(`[CHECK 1] ID Municipio asignada en show.bs.modal: ${document.getElementById('id_municipio_modal').value}`);
                        
                        document.getElementById('nombre_municipio_modal').value = munNombre;
                        setRequiredFields('modal-content-municipio'); 

                    } else if (type === 'parroquia') {
                        const parId = button.getAttribute('data-id');
                        const parNombre = button.getAttribute('data-nombre');
                        const municipioId = button.getAttribute('data-municipio-id');
                        
                        modalTitle.textContent = `Modificar Parroquia: ${parNombre}`;
                        document.getElementById('modal-content-parroquia').style.display = 'block';

                        document.getElementById('id_parroquia_modal').value = parId; 
                        console.log(`[CHECK 1] ID Parroquia asignada en show.bs.modal: ${document.getElementById('id_parroquia_modal').value}`);
                        
                        document.getElementById('nombre_parroquia_modal').value = parNombre;
                        document.getElementById('id_municipio_parroquia_modal').value = municipioId;
                        setRequiredFields('modal-content-parroquia'); 

                    } else if (type === 'comunidad') {
                        const comId = button.getAttribute('data-id');
                        const comNombre = button.getAttribute('data-nombre');
                        const parroquiaId = button.getAttribute('data-parroquia-id');
                        
                        const parroquiaData = ALL_PARROQUIAS.find(p => p.id_parroquia == parroquiaId);
                        const municipioId = parroquiaData ? parroquiaData.id_municipio : null;
                        
                        modalTitle.textContent = `Modificar Comunidad: ${comNombre}`;
                        document.getElementById('modal-content-comunidad').style.display = 'block';
                        
                        document.getElementById('id_comunidad_modal').value = comId; 
                        console.log(`[CHECK 1] ID Comunidad asignada en show.bs.modal: ${document.getElementById('id_comunidad_modal').value}`);

                        document.getElementById('nombre_comunidad_modal').value = comNombre;
                        document.getElementById('id_municipio_comunidad_modal').value = municipioId;
                        
                        filterParroquias(municipioId, 'id_parroquia_comunidad_modal', parroquiaId);
                        setRequiredFields('modal-content-comunidad'); 
                    }
                });
            }

            // ----------------------------------------------------
            // FIX: ENVÍO MANUAL DEL FORMULARIO
            // ----------------------------------------------------
            const btnActualizar = document.getElementById('btn-actualizar-modal');

            if (btnActualizar && formModificacion) {
                btnActualizar.addEventListener('click', function(event) {
                    
                    const currentType = document.getElementById('update_type_modal').value;
                    let currentId;
                    if (currentType === 'municipio') currentId = document.getElementById('id_municipio_modal').value;
                    else if (currentType === 'parroquia') currentId = document.getElementById('id_parroquia_modal').value;
                    else if (currentType === 'comunidad') currentId = document.getElementById('id_comunidad_modal').value;
                    
                    console.log(`[CHECK 2] ID del campo oculto al hacer clic en Actualizar (${currentType}): ${currentId}`);
                    
                    if (formModificacion.checkValidity()) {
                        formModificacion.submit();
                    } else {
                        formModificacion.classList.add('was-validated'); 
                        formModificacion.reportValidity(); 
                    }
                });
            } 
            
            // ----------------------------------------------------
            // LÓGICA DE ELIMINAR (general)
            // ----------------------------------------------------
            const eliminaModal = document.getElementById('eliminaModal');
            if (eliminaModal) {
                eliminaModal.addEventListener('shown.bs.modal', event => {
                    const button = event.relatedTarget;
                    const url = button.getAttribute('data-bs-href');
                    eliminaModal.querySelector('.modal-footer .btn-ok').href = url;
                });
            }
            
            // ----------------------------------------------------
            // LÓGICA DEL MODAL DE COMUNIDADES (Apertura y enlaces de edición/eliminación)
            // ----------------------------------------------------
            const modalComunidades = document.getElementById('modalComunidades');
            if (modalComunidades) {
                modalComunidades.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget; 
                    const parroquiaId = button.getAttribute('data-parroquia-id');
                    const parroquiaNombre = button.getAttribute('data-parroquia-nombre');
                    
                    const parroquiaData = ALL_PARROQUIAS.find(p => p.id_parroquia == parroquiaId);
                    const municipioId = parroquiaData ? parroquiaData.id_municipio : null;
                    
                    document.getElementById('parroquia-name-modal').textContent = parroquiaNombre;
                    
                    const comunidadesFiltradas = ALL_COMUNIDADES.filter(c => c.id_parroquia == parroquiaId);

                    let htmlContent = '';
                    if (comunidadesFiltradas.length > 0) {
                        comunidadesFiltradas.forEach(c => {
                            // Enlaces de edición y eliminación usan data-attributes para el modal de Modificación/Eliminación
                            const editAttributes = `
                                data-bs-toggle="modal" 
                                data-bs-target="#modalModificacion"
                                data-id="${c.id_comunidad}"
                                data-nombre="${c.nombre_comunidad}"
                                data-parroquia-id="${parroquiaId}"
                                data-municipio-id="${municipioId}"
                                data-type="comunidad"
                            `;
                            const deleteUrl = `gestion_municipios.php?action=delete_comunidad&id=${c.id_comunidad}`;
                            
                            htmlContent += `
                                <tr>
                                    <td>${c.id_comunidad}</td>
                                    <td>${c.nombre_comunidad}</td>
                                    <td class="action-links">
                                        <a href="#" ${editAttributes}
                                            class="btn btn-sm" title="Modificar Comunidad">
                                            <i class="fa-solid fa-pen-to-square text-primary"></i> 
                                        </a>
                                        <a href="#" 
                                            data-bs-href="${deleteUrl}" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#eliminaModal" 
                                            class="btn btn-sm" 
                                            title="Eliminar Comunidad">
                                            <i class="fa-solid fa-trash-can text-danger"></i>
                                        </a>
                                    </td>
                                </tr>
                            `;
                        });
                    } else {
                        htmlContent = '<tr><td colspan="3" class="text-center">No hay comunidades registradas para esta parroquia.</td></tr>';
                    }

                    document.getElementById('comunidades-list-body').innerHTML = htmlContent;
                    
                    // Lógica para cerrar el modal de comunidades si se abre otro
                    const handleModalToggle = () => {
                        const modalComunidadesBS = bootstrap.Modal.getInstance(modalComunidades);
                        if (modalComunidadesBS) {
                            modalComunidadesBS.hide();
                        }
                    };

                    document.querySelectorAll('#modalComunidades a[data-bs-target="#modalModificacion"], #modalComunidades a[data-bs-target="#eliminaModal"]').forEach(link => {
                        link.addEventListener('click', handleModalToggle);
                    });
                    
                    const showComunidadesAgain = function() {
                        const modalComunidadesBS = new bootstrap.Modal(modalComunidades);
                        modalComunidadesBS.show();
                        eliminaModal.removeEventListener('hidden.bs.modal', showComunidadesAgain);
                    };
                    
                    if (event.relatedTarget.closest('.btn-comunidades')) {
                        eliminaModal.addEventListener('hidden.bs.modal', showComunidadesAgain);
                    }
                });
            }

        }); // Fin del DOMContentLoaded
    </script>
</body>
</html>