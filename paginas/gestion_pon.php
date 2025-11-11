<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';
$action = isset($_GET['action']) ? $_GET['action'] : '';
$stmt = null; 
// Variables de comunidades y asignaciones eliminadas
$olts_disponibles = []; 

// Variables para la búsqueda
$search_term = isset($_GET['search']) ? $conn->real_escape_string($_GET['search']) : '';

// ----------------------------------------------------------------------------------
// OBTENCIÓN DE DATOS PARA LOS SELECTS DEL MODAL
// ----------------------------------------------------------------------------------

// --- CONSULTA PARA OBTENER TODAS LAS OLTs (para el SELECT del MODAL de modificación) ---
$sql_olts = "SELECT id_olt, nombre_olt FROM olt ORDER BY nombre_olt ASC";
$result_olts = $conn->query($sql_olts);

if ($result_olts && $result_olts->num_rows > 0) {
    while ($row = $result_olts->fetch_assoc()) {
        $olts_disponibles[] = $row;
    }
}
// Las consultas de comunidades y asignaciones han sido eliminadas.

// ----------------------------------------------------------------------------------
// LÓGICA DE GESTIÓN (MODIFICAR - POST)
// ----------------------------------------------------------------------------------
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_pon'])) {
    $id = $_POST['id_pon']; 
    $nombre = $_POST['nombre_pon'];
    $olt_id = $_POST['olt_id'];
    $descripcion = $_POST['descripcion'];
    // El manejo de comunidades ha sido eliminado.

    $message = '';
    $message_class = '';

    try {
        // 1. Actualizar la tabla principal (pon)
        // Ya no se requiere transacción
        $stmt_update_pon = $conn->prepare("UPDATE pon SET nombre_pon = ?, id_olt = ?, descripcion = ? WHERE id_pon = ?");
        // "sisi" = string (nombre), integer (olt_id), string (descripcion), integer (id)
        $stmt_update_pon->bind_param("sisi", $nombre, $olt_id, $descripcion, $id);
        
        if (!$stmt_update_pon->execute()) {
            throw new Exception("Error al actualizar el registro PON: " . $stmt_update_pon->error);
        }

        if ($stmt_update_pon->affected_rows > 0) {
            $message = "¡PON actualizado con éxito!";
            $message_class = 'success';
        } else {
             $message = "ADVERTENCIA: No se realizaron cambios en el PON. Los datos ingresados son idénticos.";
            $message_class = 'warning';
        }
        $stmt_update_pon->close();

        // La lógica de eliminación e inserción de pon_comunidad ha sido eliminada.

    } catch (Exception $e) {
        $message = "Error al actualizar el PON: " . $e->getMessage();
        $message_class = 'error';
    }

    // Redirigir para limpiar el POST y mostrar el mensaje
    header("Location: gestion_pon.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// ----------------------------------------------------------------------------------
// LÓGICA DE GESTIÓN (ELIMINAR - GET)
// ----------------------------------------------------------------------------------
if ($action === 'delete_pon' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    
    // Eliminamos la transacción ya que solo se toca la tabla 'pon'
    try {
        // La eliminación de pon_comunidad ha sido eliminada

        // 2. Eliminar de la tabla principal (pon)
        $stmt = $conn->prepare("DELETE FROM pon WHERE id_pon = ?");
        $stmt->bind_param("i", $id_to_delete);
        if (!$stmt->execute()) {
            throw new Exception("Error al eliminar el registro PON.");
        }
        $stmt->close();

        $message = "PON eliminado con éxito.";
        $message_class = 'success';

    } catch (Exception $e) {
        $message = "Error al eliminar el PON: " . $e->getMessage();
        $message_class = 'error';
    }
    // Redirigir para limpiar la URL
    header("Location: gestion_pon.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// ----------------------------------------------------------------------------------
// LÓGICA DE BÚSQUEDA Y LISTADO
// ----------------------------------------------------------------------------------

// Consulta simplificada para obtener la lista de PONs, solo con OLT
$sql_list = "SELECT 
                p.id_pon, 
                p.nombre_pon, 
                p.descripcion,
                p.id_olt,
                o.nombre_olt
             FROM pon p
             LEFT JOIN olt o ON p.id_olt = o.id_olt"; // Se eliminaron los JOINs a pon_comunidad y comunidad

$where_clause = " WHERE 1=1 ";
if (!empty($search_term)) {
    // Escapa el término de búsqueda para usar en LIKE
    $search_param = '%' . $search_term . '%';
    // La búsqueda por comunidad ha sido eliminada
    $where_clause .= " AND (p.nombre_pon LIKE '{$search_param}' OR p.descripcion LIKE '{$search_param}' OR o.nombre_olt LIKE '{$search_param}')";
}

$sql_list .= $where_clause . " ORDER BY p.nombre_pon ASC";

$result = $conn->query($sql_list);
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Puntos de Distribución (PON)</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/all.min.css" rel="stylesheet"> 
    <link href="../css/style3.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style4.css">
     <link rel="icon" type="image/jpg" href="../images/logo.jpg"/>
    <style>
        /* Estilos de comunidades eliminados */
        .texto_modificado_modal {
            color: #0d6efd; 
            font-size: 1.5rem;
            font-weight: 600;
        }

        .modal-header-styled {
            background-color: #f8f9fa; 
            border-bottom: 2px solid #0d6efd; 
        }
    </style>
</head>

<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Gestión de Puntos de Distribución (PON)</h1>
            <p>Wireless Supply, C.A.</p>
        </header>

        <?php 
        // Mostrar mensajes de la redirección
        $get_message = isset($_GET['message']) ? $_GET['message'] : $message;
        $get_class = isset($_GET['class']) ? $_GET['class'] : $message_class;

        if (!empty($get_message)): ?>
             <div class="message <?php echo htmlspecialchars($get_class); ?>">
                <?php echo htmlspecialchars($get_message); ?>
            </div>
        <?php endif; ?>

        <div class="header-actions">
            <div>
                <a href="registro_pon.php" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nuevo PON
                </a>
            </div>

            <div class="step-section search-section">
                <h2 style="margin-top: 0; text-align: center;">Buscar</h2>
                <form action="gestion_pon.php" method="GET" class="search-form" style="display: inline-flex; width: 100%;">
                    <input type="text" name="search" placeholder="Buscar..." value="<?php echo htmlspecialchars($search_term); ?>">
                    <button type="submit" class="btn btn-primary">Buscar</button>
                    <?php if (!empty($search_term)): ?>
                        <a href="gestion_pon.php" class="btn btn-outline-secondary ms-2">Borrar</a>
                    <?php endif; ?>
                </form>
            </div>
            </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre del PON</th>
                        <th>OLT Asignada</th>
                        <th>Descripción</th>
                        <th>Acciones</th> 
                    </tr>
                </thead>
                <tbody>
                    <?php if ($result && $result->num_rows > 0): ?>
                        <?php while ($row = $result->fetch_assoc()): ?>
                            <tr data-id="<?php echo htmlspecialchars($row['id_pon']); ?>" 
                                data-nombre="<?php echo htmlspecialchars($row['nombre_pon']); ?>" 
                                data-olt-id="<?php echo htmlspecialchars($row['id_olt']); ?>" 
                                data-descripcion="<?php echo htmlspecialchars($row['descripcion']); ?>">
                                
                                <td><?php echo htmlspecialchars($row['id_pon']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_pon']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_olt']); ?></td>
                                <td><?php echo htmlspecialchars($row['descripcion']); ?></td>
                                
                                <td class="action-links">
                                    <a href="#" class="btn btn-sm" title="Modificar PON"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#modificaModal" 
                                            data-id="<?php echo htmlspecialchars($row['id_pon']); ?>">
                                        <i class="fa-solid fa-pen-to-square text-primary"></i>
                                    </a>
                                    
                                    <a href="#" class="btn btn-sm" title="Eliminar PON"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#eliminaModal" 
                                            data-bs-href="gestion_pon.php?action=delete_pon&id=<?php echo htmlspecialchars($row['id_pon']); ?>">
                                        <i class="fa-solid fa-trash-can text-danger"></i>
                                    </a>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="5" class="text-center">No se encontraron registros de PONs.</td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="menu.php" class="btn btn-secondary">Volver al Menú</a>
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
                <div class="modal-footer d-flex justify-content-end gap-2">
                    <button type="button" class="btn btn-secondary btn_modificado2" data-bs-dismiss="modal" >Cancelar</button>
                    <a href="#" class="btn btn-danger btn-ok">Eliminar</a> 
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modificaModal" tabindex="-1" aria-labelledby="modificaModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="modificaModalLabel">Modificar PON</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="formModificacionPON" class="needs-validation" method="POST" action="gestion_pon.php" novalidate>
                    <div class="modal-body">
                        <input type="hidden" name="update_pon" value="1"> 
                        <input type="hidden" name="id_pon" id="modal-id_pon">
                        
                        <div class="mb-3">
                            <label for="modal-nombre_pon" class="form-label">Nombre del PON</label>
                            <input type="text" class="form-control" id="modal-nombre_pon" name="nombre_pon" required>
                            <div class="invalid-feedback">Por favor ingrese el nombre del PON.</div>
                        </div>

                        <div class="mb-3">
                            <label for="modal-olt_id" class="form-label">OLT Asignada</label>
                            <select class="form-select" id="modal-olt_id" name="olt_id" required>
                                <option value="">-- Seleccione una OLT --</option>
                                <?php foreach ($olts_disponibles as $olt): ?>
                                    <option value="<?php echo htmlspecialchars($olt['id_olt']); ?>">
                                        <?php echo htmlspecialchars($olt['nombre_olt']); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                            <div class="invalid-feedback">Por favor seleccione una OLT.</div>
                        </div>

                        <div class="mb-3">
                            <label for="modal-descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="modal-descripcion" name="descripcion" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer d-flex justify-content-end gap-2">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btn-actualizar-pon">Guardar Cambios</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="../js/bootstrap.bundle.min.js"></script> 
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> 
    
    <script>
    // La variable assignedComms ha sido eliminada.

    // -----------------------------------------------------
    // 1. LÓGICA DEL MODAL DE MODIFICACIÓN (modificaModal)
    // -----------------------------------------------------
    const modificaModalElement = document.getElementById('modificaModal');
    const formModificacionPON = document.getElementById('formModificacionPON');
    
    if (modificaModalElement) {
        modificaModalElement.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            const row = document.querySelector(`tr[data-id="${id}"]`);

            if (row) {
                const nombre = row.getAttribute('data-nombre');
                const olt_id = row.getAttribute('data-olt-id'); 
                const descripcion = row.getAttribute('data-descripcion');
                
                document.getElementById('modal-id_pon').value = id;
                document.getElementById('modal-nombre_pon').value = nombre;
                document.getElementById('modal-olt_id').value = olt_id; 
                document.getElementById('modal-descripcion').value = descripcion;

                // El manejo de checkboxes ha sido eliminado.
                
                formModificacionPON.classList.remove('was-validated');
            }
        });

        const btnActualizarPON = document.getElementById('btn-actualizar-pon');

        if (btnActualizarPON && formModificacionPON) {
            btnActualizarPON.addEventListener('click', function(event) {
                
                // La validación de comunidades ha sido eliminada.
                const bootstrapValido = formModificacionPON.checkValidity();

                if (!bootstrapValido) {
                    event.preventDefault(); 
                    event.stopPropagation();

                    formModificacionPON.classList.add('was-validated');
                    
                    formModificacionPON.reportValidity(); 
                } else {
                    formModificacionPON.submit(); 
                }
            });
        }
    }

    // -----------------------------------------------------
    // 2. LÓGICA DEL MODAL DE ELIMINACIÓN (eliminaModal)
    // -----------------------------------------------------
    const eliminaModalElement = document.getElementById('eliminaModal');
    
    if (eliminaModalElement) { 
        eliminaModalElement.addEventListener('shown.bs.modal', function(event) {
            const button = event.relatedTarget;
            const url = button.getAttribute('data-bs-href'); 
            
            const btnOk = eliminaModalElement.querySelector('.modal-footer .btn-ok');
            if (btnOk) {
                btnOk.href = url;
            }
        });
    }
    </script>
</body>
</html>