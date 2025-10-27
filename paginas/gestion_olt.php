<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';
$action = isset($_GET['action']) ? $_GET['action'] : '';
$stmt = null; 
$parroquias_disponibles = []; 

// Variables para la búsqueda
$search_term = isset($_GET['search']) ? $_GET['search'] : '';

// Consulta base para obtener la lista de OLTs, agrupando las parroquias
$sql_base = "SELECT 
                o.id_olt, 
                o.nombre_olt, 
                o.marca,
                o.modelo,
                o.descripcion,
                GROUP_CONCAT(pa.nombre_parroquia ORDER BY pa.nombre_parroquia SEPARATOR ', ') AS parroquias_atendidas
             FROM olt o
             LEFT JOIN olt_parroquia op ON o.id_olt = op.olt_id
             LEFT JOIN parroquia pa ON op.parroquia_id = pa.id_parroquia";

// --- CONSULTA PARA OBTENER TODAS LAS PARROQUIAS (para el MODAL de modificación) ---
$sql_parroquias = "SELECT id_parroquia, nombre_parroquia FROM parroquia ORDER BY nombre_parroquia ASC";
$result_parroquias = $conn->query($sql_parroquias);

if ($result_parroquias && $result_parroquias->num_rows > 0) {
    while ($row = $result_parroquias->fetch_assoc()) {
        $parroquias_disponibles[] = $row;
    }
}

// --- CONSULTA PARA OBTENER TODAS LAS ASIGNACIONES OLT-PARROQUIA (para el JS del modal) ---
$assigned_parroquias = [];
$sql_assignments = "SELECT olt_id, parroquia_id FROM olt_parroquia";
$result_assignments = $conn->query($sql_assignments);
if ($result_assignments && $result_assignments->num_rows > 0) {
    while ($row = $result_assignments->fetch_assoc()) {
        $olt_id = $row['olt_id'];
        $parroquia_id = $row['parroquia_id'];
        if (!isset($assigned_parroquias[$olt_id])) {
            $assigned_parroquias[$olt_id] = [];
        }
        // Guardamos el ID como INT para la comparación en JS
        $assigned_parroquias[$olt_id][] = (int)$parroquia_id; 
    }
}


// --- LÓGICA DE GESTIÓN (ELIMINAR) ---
if ($action === 'delete_olt' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM olt WHERE id_olt = ?");
    $stmt->bind_param("i", $id_to_delete);
    if ($stmt->execute()) {
        $message = "OLT eliminada con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar la OLT: " . $stmt->error;
        $message_class = 'error';
    }
    $stmt->close();
    header("Location: gestion_olt.php?message=" . urlencode($message) . "&class=" . $message_class);
    exit;
}

// --- LÓGICA DE MODIFICACIÓN (PROCESAR FORMULARIO POST DEL MODAL) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_olt'])) {
    $id = $_POST['id_olt'];
    $nombre = $_POST['nombre_olt'];
    $marca = $_POST['marca'];
    $modelo = $_POST['modelo'];
    $descripcion = $_POST['descripcion'];
    $parroquias_seleccionadas = isset($_POST['parroquias_id']) ? $_POST['parroquias_id'] : [];

    // Iniciar transacción
    $conn->begin_transaction();
    
    try {
        // 1. Actualizar datos básicos de la OLT
        $stmt_update_olt = $conn->prepare("UPDATE olt SET nombre_olt = ?, marca = ?, modelo = ?, descripcion = ? WHERE id_olt = ?");
        $stmt_update_olt->bind_param("ssssi", $nombre, $marca, $modelo, $descripcion, $id);
        if (!$stmt_update_olt->execute()) {
            throw new Exception("Error al actualizar OLT: " . $stmt_update_olt->error);
        }
        $stmt_update_olt->close();

        // 2. Eliminar todas las relaciones viejas
        $stmt_delete_relaciones = $conn->prepare("DELETE FROM olt_parroquia WHERE olt_id = ?");
        $stmt_delete_relaciones->bind_param("i", $id);
        if (!$stmt_delete_relaciones->execute()) {
             throw new Exception("Error al limpiar relaciones: " . $stmt_delete_relaciones->error);
        }
        $stmt_delete_relaciones->close();

        // 3. Insertar las nuevas relaciones
        if (!empty($parroquias_seleccionadas)) {
            $stmt_insert_relacion = $conn->prepare("INSERT INTO olt_parroquia (olt_id, parroquia_id) VALUES (?, ?)");
            foreach ($parroquias_seleccionadas as $parroquia_id) {
                $parroquia_id_int = (int)$parroquia_id;
                $stmt_insert_relacion->bind_param("ii", $id, $parroquia_id_int);
                if (!$stmt_insert_relacion->execute()) {
                    throw new Exception("Error al insertar nueva relación: " . $stmt_insert_relacion->error);
                }
            }
            $stmt_insert_relacion->close();
        }

        // Si todo va bien
        $conn->commit();
        $message = "¡OLT y Parroquias actualizadas con éxito!";
        $message_class = 'success';
    
    } catch (Exception $e) {
        $conn->rollback();
        $message = "Error al actualizar: " . $e->getMessage();
        $message_class = 'error';
    }
    
    // Redirigir para limpiar los parámetros GET y mostrar el mensaje
    header("Location: gestion_olt.php?message=" . urlencode($message) . "&class=" . $message_class);
    exit;
}

// --- MANEJO DE MENSAJES DE REDIRECCIÓN ---
if (isset($_GET['message'])) {
    $message = $_GET['message'];
    $message_class = $_GET['class'];
}


// --- CONSULTA FINAL PARA MOSTRAR LOS DATOS (INCLUYENDO BÚSQUEDA) ---
$sql_final = $sql_base;
if (!empty($search_term)) {
    // Buscar en el nombre de la OLT o en el nombre de la parroquia
    $sql_final .= " WHERE o.nombre_olt LIKE ? OR pa.nombre_parroquia LIKE ?";
}
$sql_final .= " GROUP BY o.id_olt ORDER BY o.nombre_olt ASC";


if (!empty($search_term)) {
    $search_param = "%" . $search_term . "%";
    $stmt = $conn->prepare($sql_final);
    $stmt->bind_param("ss", $search_param, $search_param); 
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $result = $conn->query($sql_final);
}

$data = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

$conn->close();

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de OLTs</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style3.css">
    <link rel="stylesheet" href="../css/style4.css">
    <style>
        /* Estilos del modal para coherencia (AZUL solicitado) */
        .texto_modificado_modal {
            color: #0d6efd; /* Azul Bootstrap Primary */
            font-size: 1.5rem;
            font-weight: 600;
        }

        .modal-header-styled {
            background-color: #f8f9fa; 
            border-bottom: 2px solid #0d6efd;
        }
        
        .table-container table td:nth-child(6),
        .table-container table th:nth-child(6) {
            min-width: 150px; /* Ancho para las acciones */
        }
        
        .table-container table td:nth-child(5),
        .table-container table th:nth-child(5) {
            min-width: 250px; /* Ancho para Parroquias */
        }
        
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
            <h1>Gestión de OLTs</h1>
            <p>Wireless Supply, C.A.</p>
        </header>
        
        <div class="header-actions">
            <div>
                <a href="registro_olt.php" class="btn btn-primary">Nuevo Registro</a>
            </div>
            <div class="step-section search-section">
                <h2 style="margin-top: 0; text-align: center;">Buscar</h2>
                <form action="gestion_olt.php" method="GET" class="search-form" style="display: inline-flex; width: 100%;">
                    <input type="text" name="search" placeholder="Buscar por nombre de OLT o Parroquia..." value="<?php echo htmlspecialchars($search_term); ?>">
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
            <table>
                <thead>
                    <tr>
                        <th>ID OLT</th>
                        <th>Nombre</th>
                        <th>Marca</th>
                        <th>Modelo</th>
                        <th>Parroquias Atendidas</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($data)): ?>
                        <?php foreach ($data as $row): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['id_olt']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_olt']); ?></td>
                                <td><?php echo htmlspecialchars($row['marca']); ?></td>
                                <td><?php echo htmlspecialchars($row['modelo']); ?></td>
                                <td><?php echo htmlspecialchars($row['parroquias_atendidas'] ?: 'N/A'); ?></td>
                                <td class="action-links">
                                   <?php 
                                        // Preparamos el array de IDs asignados para pasarlo al JS (JSON)
                                        $olt_id = $row['id_olt'];
                                        $assigned_ids = isset($assigned_parroquias[$olt_id]) ? json_encode($assigned_parroquias[$olt_id]) : '[]';
                                   ?>
                                   <a href="#" 
                                       data-bs-toggle="modal"
                                       data-bs-target="#modalModificacionOLT"
                                       data-id="<?php echo htmlspecialchars($olt_id); ?>"
                                       data-nombre="<?php echo htmlspecialchars($row['nombre_olt']); ?>"
                                       data-marca="<?php echo htmlspecialchars($row['marca']); ?>"
                                       data-modelo="<?php echo htmlspecialchars($row['modelo']); ?>"
                                       data-descripcion="<?php echo htmlspecialchars($row['descripcion']); ?>"
                                       data-assigned-parroquias='<?php echo htmlspecialchars($assigned_ids, ENT_QUOTES, 'UTF-8'); ?>'
                                       class="btn btn-sm" title="Modificar OLT">
                                       <i class="fa-solid fa-pen-to-square text-primary"></i>
                                   </a>
                                   <a href="#" 
                                       data-bs-href="gestion_olt.php?action=delete_olt&id=<?php echo urlencode($olt_id); ?>" 
                                       data-bs-toggle="modal" 
                                       data-bs-target="#eliminaModal" 
                                       class="btn btn-sm" 
                                       title="Eliminar OLT">
                                       <i class="fa-solid fa-trash-can text-danger"></i>
                                   </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="6">No se encontraron OLTs.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="menu.php" class="btn btn-secondary">Volver al Menú</a>
        </div>
    </div>

    <div class="modal fade" id="modalModificacionOLT" tabindex="-1" aria-labelledby="modalModificacionOLTLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="modalModificacionOLTLabel">Modificar OLT</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="form-modificacion-olt" action="gestion_olt.php" method="POST" novalidate>
                    <div class="modal-body">
                        <input type="hidden" name="update_olt" value="1">
                        <input type="hidden" name="id_olt" id="id_olt_modal" value="">
                        
                        <div class="row">
                             <div class="col-md-6 mb-3">
                                <label for="nombre_olt_modal" class="form-label">Nombre OLT:</label>
                                <input type="text" id="nombre_olt_modal" name="nombre_olt" class="form-control" required> 
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="marca_modal" class="form-label">Marca:</label>
                                <input type="text" id="marca_modal" name="marca" class="form-control" required> 
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="modelo_modal" class="form-label">Modelo:</label>
                                <input type="text" id="modelo_modal" name="modelo" class="form-control" required> 
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Parroquias que Atiende (Seleccione una o más):</label>
                                <div class="checkbox-group" id="parroquias-checkbox-container">
                                    <?php if (!empty($parroquias_disponibles)): ?>
                                        <?php foreach ($parroquias_disponibles as $parroquia): ?>
                                            <div class="checkbox-item">
                                                <input type="checkbox" 
                                                       id="modal_parroquia_<?php echo htmlspecialchars($parroquia['id_parroquia']); ?>" 
                                                       name="parroquias_id[]" 
                                                       value="<?php echo htmlspecialchars($parroquia['id_parroquia']); ?>">
                                                <label for="modal_parroquia_<?php echo htmlspecialchars($parroquia['id_parroquia']); ?>">
                                                    <?php echo htmlspecialchars($parroquia['nombre_parroquia']); ?>
                                                </label>
                                            </div>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <p>No hay parroquias disponibles.</p>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="descripcion_modal" class="form-label">Descripción:</label>
                            <textarea id="descripcion_modal" name="descripcion" class="form-control" rows="3"></textarea>
                        </div>
                        
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 40%;">Cancelar</button>
                        <button type="button" id="btn-actualizar-olt" class="btn btn-primary" style="width: 55%;">Actualizar</button>
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
                    <a class="btn btn-danger btn-ok" href="#">Eliminar</a> 
                </div>
            </div>
        </div>
    </div>

<script src="../js/bootstrap.bundle.min.js"></script> 

<script>
    // -----------------------------------------------------
    // 1. LÓGICA DEL MODAL DE MODIFICACIÓN
    // -----------------------------------------------------
    const modalModificacionOLT = document.getElementById('modalModificacionOLT');
    const formModificacionOLT = document.getElementById('form-modificacion-olt');

    if (modalModificacionOLT) {
        modalModificacionOLT.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; 
            
            // 1. Obtener los datos (incluyendo el JSON de parroquias asignadas)
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const marca = button.getAttribute('data-marca');
            const modelo = button.getAttribute('data-modelo');
            const descripcion = button.getAttribute('data-descripcion');
            const assignedParroquiasJson = button.getAttribute('data-assigned-parroquias');
            
            // Convertir el JSON de IDs a un array de números
            let assignedParroquiasIds = [];
            try {
                // El atributo está codificado como string HTML, lo parseamos a JSON
                assignedParroquiasIds = JSON.parse(assignedParroquiasJson);
            } catch (e) {
                console.error("Error al parsear parroquias asignadas:", e);
            }

            // 2. Asignar valores a los campos simples del modal
            document.getElementById('modalModificacionOLTLabel').textContent = `Modificar OLT ID: ${id}`;
            document.getElementById('id_olt_modal').value = id;
            document.getElementById('nombre_olt_modal').value = nombre;
            document.getElementById('marca_modal').value = marca;
            document.getElementById('modelo_modal').value = modelo;
            document.getElementById('descripcion_modal').value = descripcion;
            
            // 3. Limpiar y Chequear Checkboxes de Parroquias
            const checkboxes = document.querySelectorAll('#parroquias-checkbox-container input[type="checkbox"]');
            
            checkboxes.forEach(checkbox => {
                // Primero, desmarcar todos los checkboxes
                checkbox.checked = false; 

                // Convertir el valor del checkbox (string) a número para la comparación
                const parroquiaId = parseInt(checkbox.value);

                // Si el ID de la parroquia está en el array de IDs asignados, chequearlo
                if (assignedParroquiasIds.includes(parroquiaId)) {
                    checkbox.checked = true;
                }
            });
            
            // 4. Reiniciar la validación de Bootstrap
            formModificacionOLT.classList.remove('was-validated');
        });

        // 5. Lógica para el botón de Actualizar y validación manual
        const btnActualizarOLT = document.getElementById('btn-actualizar-olt');

        if (btnActualizarOLT && formModificacionOLT) {
            btnActualizarOLT.addEventListener('click', function(event) {
                // Evita el envío por defecto si la validación falla
                if (!formModificacionOLT.checkValidity()) {
                    event.preventDefault(); 
                    formModificacionOLT.classList.add('was-validated');
                } else {
                    formModificacionOLT.submit(); // Enviar el formulario
                }
            });
        }
    }

    // -----------------------------------------------------
    // 2. LÓGICA DEL MODAL DE ELIMINACIÓN
    // -----------------------------------------------------
    let eliminaModal = document.getElementById('eliminaModal');
    
    if (eliminaModal) { 
        eliminaModal.addEventListener('shown.bs.modal', event => {
            let button = event.relatedTarget;
            // Obtenemos la URL del atributo data-bs-href (que es lo que se envía al PHP)
            let url = button.getAttribute('data-bs-href'); 
            
            // Asignamos la URL al botón de confirmación 'Eliminar' (clase .btn-ok)
            let btnOk = eliminaModal.querySelector('.modal-footer .btn-ok');
            if (btnOk) {
                btnOk.href = url;
            }
        });
    }
</script>
</body>
</html>