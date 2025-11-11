<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';
$action = isset($_GET['action']) ? $_GET['action'] : '';
$stmt = null; // Inicializamos la variable stmt para evitar el error

// Variables para la búsqueda
$search_term = isset($_GET['search']) ? $_GET['search'] : '';
$sql = "SELECT * FROM planes";

// --- LÓGICA DE GESTIÓN (ELIMINAR) ---
if ($action === 'delete_plan' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM planes WHERE id_plan = ?");
    $stmt->bind_param("i", $id_to_delete);
    if ($stmt->execute()) {
        $message = "Plan eliminado con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar el plan: " . $stmt->error;
        $message_class = 'error';
    }
    // Redirigimos para limpiar la URL
    header("Location: gestion_planes.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// --- LÓGICA DE MODIFICACIÓN (PROCESAR FORMULARIO POST) ---
// La lógica de obtener datos en GET (action=edit_plan) se elimina, 
// pues los datos se pasan directamente al modal vía data-attributes.

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_plan'])) {
    $id = $_POST['id_plan_update']; // Usamos un nombre único para el ID del modal
    $nombre = $_POST['nombre_plan'];
    $monto = $_POST['monto'];
    $descripcion = $_POST['descripcion'];
    
    // Convertir el monto a un formato numérico adecuado si es necesario (ej: reemplazar comas)
    $monto_float = str_replace(',', '.', $monto);
    
    $stmt = $conn->prepare("UPDATE planes SET nombre_plan = ?, monto = ?, descripcion = ? WHERE id_plan = ?");
    // Usamos 'dsi' (string, float/double, string, integer)
    // Nota: MySQLi puede requerir 's' para el monto si el campo es DECIMAL o VARCHAR, pero 'd' es más seguro si es FLOAT/DOUBLE.
    // Usaremos 's' para mantener la compatibilidad con el uso anterior en el archivo original, que no especificaba el tipo de campo $monto.
    $stmt->bind_param("sssi", $nombre, $monto_float, $descripcion, $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            $message = "¡Plan actualizado con éxito!";
            $message_class = 'success';
        } else {
            $message = "ADVERTENCIA: No se realizaron cambios en el Plan. Los datos ingresados son idénticos.";
            $message_class = 'warning';
        }
    } else {
        $message = "Error al actualizar el plan: " . $stmt->error;
        $message_class = 'error';
    }
    
    if ($stmt) {
        $stmt->close();
    }
    // Redirigimos para mostrar el mensaje y limpiar POST
    header("Location: gestion_planes.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// --- CONSULTA PARA MOSTRAR LOS DATOS ---
if (!empty($search_term)) {
    $sql .= " WHERE nombre_plan LIKE ?";
    $search_param = "%" . $search_term . "%";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $search_param);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $sql .= " ORDER BY nombre_plan ASC";
    $result = $conn->query($sql);
}

$data = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

// Cierre de la conexión
if ($stmt) {
    $stmt->close();
}
$conn->close();

// Manejo del mensaje de redirección
if (isset($_GET['message'])) {
    $message = $_GET['message'];
    $message_class = $_GET['class'];
}

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Planes</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style3.css">
    <link rel="stylesheet" href="../css/style4.css">
     <link rel="icon" type="image/jpg" href="../images/logo.jpg"/>
    <style>
        /* Estilos del modal para coherencia con gestion_municipios.php */
        .texto_modificado_modal {
            color: #0d6efd; /* Color azul de Bootstrap Primary */
            font-size: 1.5rem;
            font-weight: 600;
        }

        .modal-header-styled {
            background-color: #f8f9fa; /* Color de fondo muy claro */
            border-bottom: 2px solid #0d6efd; /* Línea inferior azul */
        }
        
        .form-label {
            font-weight: bold;
            display: block;
            margin-bottom: .5rem;
        }
        
        /* Aseguramos que los campos del modal usen el diseño estándar de Bootstrap */
        .modal-body .mb-3 {
            display: flex;
            flex-direction: column;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Gestión de Planes</h1>
            <p>Wireless Supply, C.A.</p>
        </header>
        
        <div class="header-actions">
            <div>
                <a href="registro_planes.php" class="btn btn-primary">Nuevo Registro</a>
            </div>
            <div class="step-section search-section">
                <h2 style="margin-top: 0; text-align: center;">Buscar</h2>
                <form action="gestion_planes.php" method="GET" class="search-form" style="display: inline-flex; width: 100%;">
                    <input type="text" name="search" placeholder="Buscar por nombre de plan..." value="<?php echo htmlspecialchars($search_term); ?>">
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
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Monto (USD)</th>
                        <th>Descripción</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($data)): ?>
                        <?php foreach ($data as $row): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['id_plan']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_plan']); ?></td>
                                <td><?php echo htmlspecialchars($row['monto']); ?></td>
                                <td><?php echo htmlspecialchars($row['descripcion']); ?></td>
                                <td class="action-links">
                                   <a href="#" 
                                       data-bs-toggle="modal"
                                       data-bs-target="#modalModificacionPlan"
                                       data-id="<?php echo htmlspecialchars($row['id_plan']); ?>"
                                       data-nombre="<?php echo htmlspecialchars($row['nombre_plan']); ?>"
                                       data-monto="<?php echo htmlspecialchars($row['monto']); ?>"
                                       data-descripcion="<?php echo htmlspecialchars($row['descripcion']); ?>"
                                       class="btn btn-sm" title="Modificar Plan">
                                       <i class="fa-solid fa-pen-to-square text-primary"></i>
                                   </a>
                                   <a href="#" 
                                       data-bs-href="gestion_planes.php?action=delete_plan&id=<?php echo urlencode($row['id_plan']); ?>" 
                                       data-bs-toggle="modal" 
                                       data-bs-target="#eliminaModal" 
                                       class="btn btn-sm" 
                                       title="Eliminar Plan">
                                       <i class="fa-solid fa-trash-can text-danger"></i>
                                   </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="5">No se encontraron planes.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="menu.php" class="btn btn-secondary">Volver al Menú</a>
        </div>
    </div>
    
    <div class="modal fade" id="modalModificacionPlan" tabindex="-1" aria-labelledby="modalModificacionPlanLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="modalModificacionPlanLabel">Modificar Plan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="form-modificacion-plan" action="gestion_planes.php" method="POST" novalidate>
                    <div class="modal-body">
                        <input type="hidden" name="update_plan" value="1">
                        <input type="hidden" name="id_plan_update" id="id_plan_modal" value="">
                        
                        <div class="mb-3">
                            <label for="nombre_plan_modal" class="form-label">Nombre del Plan:</label>
                            <input type="text" id="nombre_plan_modal" name="nombre_plan" class="form-control" required> 
                        </div>
                        
                        <div class="mb-3">
                            <label for="monto_modal" class="form-label">Monto (USD):</label>
                            <input type="number" id="monto_modal" name="monto" step="0.01" class="form-control" required> 
                        </div>

                        <div class="mb-3">
                            <label for="descripcion_modal" class="form-label">Descripción:</label>
                            <textarea id="descripcion_modal" name="descripcion" class="form-control" rows="4"></textarea> 
                        </div>
                        
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 40%;">Cancelar</button>
                        <button type="button" id="btn-actualizar-plan" class="btn btn-primary" style="width: 55%;">Actualizar</button>
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
    <script src="../js/bootstrap.bundle.min.js"></script> 

<script>
    // Lógica para pasar la URL de eliminación al modal de Bootstrap (Ya estaba bien)
    let eliminaModal = document.getElementById('eliminaModal')
    if (eliminaModal) {
        eliminaModal.addEventListener('shown.bs.modal', event => {
            let button = event.relatedTarget
            let url = button.getAttribute('data-bs-href') 
            eliminaModal.querySelector('.modal-footer .btn-ok').href = url
        })
    }

    // --- LÓGICA DEL MODAL DE MODIFICACIÓN DE PLANES ---
    const modalModificacionPlan = document.getElementById('modalModificacionPlan');

    if (modalModificacionPlan) {
        modalModificacionPlan.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; 
            
            // 1. Obtener los datos pasados desde la tabla
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const monto = button.getAttribute('data-monto');
            const descripcion = button.getAttribute('data-descripcion');
            
            // 2. Asignar valores a los campos del modal
            document.getElementById('modalModificacionPlanLabel').textContent = `Modificar Plan: ${nombre}`;
            document.getElementById('id_plan_modal').value = id;
            document.getElementById('nombre_plan_modal').value = nombre;
            // Aseguramos que el monto se muestre con dos decimales, aunque el tipo sea number
            document.getElementById('monto_modal').value = parseFloat(monto).toFixed(2);
            document.getElementById('descripcion_modal').value = descripcion;
            
            // 3. Reiniciar la validación
            document.getElementById('form-modificacion-plan').classList.remove('was-validated');
        });
    }

    // 4. Lógica para el botón de Actualizar y validación manual
    const btnActualizarPlan = document.getElementById('btn-actualizar-plan');
    const formModificacionPlan = document.getElementById('form-modificacion-plan');

    if (btnActualizarPlan && formModificacionPlan) {
        btnActualizarPlan.addEventListener('click', function(event) {
            
            // Verificar si el formulario es válido (HTML5 validation)
            if (formModificacionPlan.checkValidity()) {
                formModificacionPlan.submit(); // Enviar el formulario
            } else {
                // Si no es válido, mostrar los mensajes de error de Bootstrap
                formModificacionPlan.classList.add('was-validated');
                formModificacionPlan.reportValidity(); 
            }
        });
    }

</script>
</body>
</html>