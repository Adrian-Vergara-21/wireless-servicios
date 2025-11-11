<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';


$message = '';
$message_class = '';
$action = isset($_GET['action']) ? $_GET['action'] : '';
$stmt = null; // Inicializamos $stmt

// Variables para la búsqueda
$search_term = isset($_GET['search']) ? $_GET['search'] : '';
$sql = "SELECT * FROM bancos";

// --- LÓGICA DE GESTIÓN (ELIMINAR) ---
if ($action === 'delete_banco' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM bancos WHERE id_banco = ?");
    $stmt->bind_param("i", $id_to_delete);
    if ($stmt->execute()) {
        $message = "Banco eliminado con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar el banco: " . $stmt->error;
        $message_class = 'error';
    }
    // Redirigimos para limpiar la URL y mostrar el mensaje
    header("Location: gestion_bancos.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// --- LÓGICA DE MODIFICACIÓN (PROCESAR FORMULARIO POST DEL MODAL) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_banco'])) {
    $id = $_POST['id_banco_update']; // El ID viene del campo oculto del modal
    $nombre_banco = $_POST['nombre_banco'];
    $numero_cuenta = $_POST['numero_cuenta'];
    $cedula_propietario = $_POST['cedula_propietario'];
    $nombre_propietario = $_POST['nombre_propietario'];
    
    // Asegúrate de que el número de parámetros de bind_param coincida con los '?' en el UPDATE
    $stmt = $conn->prepare("UPDATE bancos SET nombre_banco = ?, numero_cuenta = ?, cedula_propietario = ?, nombre_propietario = ? WHERE id_banco = ?");
    $stmt->bind_param("ssssi", $nombre_banco, $numero_cuenta, $cedula_propietario, $nombre_propietario, $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            $message = "¡Banco actualizado con éxito!";
            $message_class = 'success';
        } else {
            $message = "ADVERTENCIA: No se realizaron cambios en el Banco. Los datos ingresados son idénticos.";
            $message_class = 'warning';
        }
    } else {
        $message = "Error al actualizar el banco: " . $stmt->error;
        $message_class = 'error';
    }
    
    if ($stmt) {
        $stmt->close();
    }
    // Redirigimos para mostrar el mensaje y limpiar POST
    header("Location: gestion_bancos.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// --- CONSULTA PARA MOSTRAR LOS DATOS ---
if (!empty($search_term)) {
    $sql .= " WHERE nombre_banco LIKE ?";
    $search_param = "%" . $search_term . "%";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $search_param);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $sql .= " ORDER BY nombre_banco ASC";
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
    <title>Gestión de Bancos</title>
    <link rel="stylesheet" href="../css/all.min.css">
    <link href="../css/bootstrap.min.css" rel="stylesheet"> 
    <link rel="stylesheet" href="../css/style3.css">
    <link rel="stylesheet" href="../css/style4.css">
    <link rel="icon" type="image/jpg" href="../images/logo.jpg"/>
    <style>
        /* Estilos del modal para coherencia */
        .texto_modificado_modal {
            color: #0d6efd; /* Azul Bootstrap Primary */
            font-size: 1.5rem;
            font-weight: 600;
        }

        .modal-header-styled {
            background-color: #f8f9fa; 
            border-bottom: 2px solid #0d6efd;
        }
        
        .form-label {
            font-weight: bold;
            display: block;
            margin-bottom: .5rem;
        }
        
        .modal-body .mb-3 {
            display: flex;
            flex-direction: column;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Gestión de Bancos</h1>
            <p>Wireless Supply, C.A.</p>
        </header>
        
        <div class="header-actions">
            <div>
                <a href="registro_bancos.php" class="btn btn-primary">Nuevo Registro</a>
            </div>
            <div class="step-section search-section">
                <h2 style="margin-top: 0; text-align: center;">Buscar</h2>
                <form action="gestion_bancos.php" method="GET" class="search-form" style="display: inline-flex; width: 100%;">
                    <input type="text" name="search" placeholder="Buscar por nombre de banco..." value="<?php echo htmlspecialchars($search_term); ?>">
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
                        <th>Nombre del Banco</th>
                        <th>Número de Cuenta</th>
                        <th>Cédula Propietario</th>
                        <th>Nombre Propietario</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($data)): ?>
                        <?php foreach ($data as $row): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['id_banco']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_banco']); ?></td>
                                <td><?php echo htmlspecialchars($row['numero_cuenta']); ?></td>
                                <td><?php echo htmlspecialchars($row['cedula_propietario']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_propietario']); ?></td>
                                <td class="action-links">
                                  <a href="#" 
                                       data-bs-toggle="modal"
                                       data-bs-target="#modalModificacionBanco"
                                       data-id="<?php echo htmlspecialchars($row['id_banco']); ?>"
                                       data-nombre="<?php echo htmlspecialchars($row['nombre_banco']); ?>"
                                       data-cuenta="<?php echo htmlspecialchars($row['numero_cuenta']); ?>"
                                       data-cedula="<?php echo htmlspecialchars($row['cedula_propietario']); ?>"
                                       data-propietario="<?php echo htmlspecialchars($row['nombre_propietario']); ?>"
                                       class="btn btn-sm" title="Modificar Banco">
                                       <i class="fa-solid fa-pen-to-square text-primary"></i>
                                   </a>
                                   <a href="#" 
                                      data-bs-href="gestion_bancos.php?action=delete_banco&id=<?php echo urlencode($row['id_banco']); ?>" 
                                       data-bs-toggle="modal" 
                                       data-bs-target="#eliminaModal" 
                                       class="btn btn-sm" 
                                       title="Eliminar Banco">
                                                            
                                        <i class="fa-solid fa-trash-can text-danger"></i>
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="6">No se encontraron bancos.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="menu.php" class="btn btn-secondary">Volver al Menú</a>
        </div>
    </div>
    
    <div class="modal fade" id="modalModificacionBanco" tabindex="-1" aria-labelledby="modalModificacionBancoLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="modalModificacionBancoLabel">Modificar Banco</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="form-modificacion-banco" action="gestion_bancos.php" method="POST" novalidate>
                    <div class="modal-body">
                        <input type="hidden" name="update_banco" value="1">
                        <input type="hidden" name="id_banco_update" id="id_banco_modal" value="">
                        
                        <div class="mb-3">
                            <label for="nombre_banco_modal" class="form-label">Nombre del Banco:</label>
                            <input type="text" id="nombre_banco_modal" name="nombre_banco" class="form-control" required> 
                        </div>
                        
                        <div class="mb-3">
                            <label for="numero_cuenta_modal" class="form-label">Número de Cuenta:</label>
                            <input type="text" id="numero_cuenta_modal" name="numero_cuenta" class="form-control" required> 
                        </div>

                        <div class="mb-3">
                            <label for="cedula_propietario_modal" class="form-label">Cédula del Propietario:</label>
                            <input type="text" id="cedula_propietario_modal" name="cedula_propietario" class="form-control" required> 
                        </div>

                        <div class="mb-3">
                            <label for="nombre_propietario_modal" class="form-label">Nombre del Propietario:</label>
                            <input type="text" id="nombre_propietario_modal" name="nombre_propietario" class="form-control" required> 
                        </div>
                        
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 40%;">Cancelar</button>
                        <button type="button" id="btn-actualizar-banco" class="btn btn-primary" style="width: 55%;">Actualizar</button>
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
    // Lógica para pasar la URL de eliminación al modal de Bootstrap 
    let eliminaModal = document.getElementById('eliminaModal')
    if (eliminaModal) {
        eliminaModal.addEventListener('shown.bs.modal', event => {
            let button = event.relatedTarget
            let url = button.getAttribute('data-bs-href') 
            eliminaModal.querySelector('.modal-footer .btn-ok').href = url
        })
    }

    // --- LÓGICA DEL MODAL DE MODIFICACIÓN DE BANCOS ---
    const modalModificacionBanco = document.getElementById('modalModificacionBanco');

    if (modalModificacionBanco) {
        modalModificacionBanco.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; 
            
            // 1. Obtener los 4 datos pasados desde la tabla
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const cuenta = button.getAttribute('data-cuenta');
            const cedula = button.getAttribute('data-cedula');
            const propietario = button.getAttribute('data-propietario');
            
            // 2. Asignar valores a los campos del modal
            document.getElementById('modalModificacionBancoLabel').textContent = `Modificar Banco: ${nombre}`;
            document.getElementById('id_banco_modal').value = id;
            document.getElementById('nombre_banco_modal').value = nombre;
            document.getElementById('numero_cuenta_modal').value = cuenta;
            document.getElementById('cedula_propietario_modal').value = cedula;
            document.getElementById('nombre_propietario_modal').value = propietario;
            
            // 3. Reiniciar la validación
            document.getElementById('form-modificacion-banco').classList.remove('was-validated');
        });
    }

    // 4. Lógica para el botón de Actualizar y validación manual
    const btnActualizarBanco = document.getElementById('btn-actualizar-banco');
    const formModificacionBanco = document.getElementById('form-modificacion-banco');

    if (btnActualizarBanco && formModificacionBanco) {
        btnActualizarBanco.addEventListener('click', function(event) {
            
            // Verificar si el formulario es válido (HTML5 validation)
            if (formModificacionBanco.checkValidity()) {
                formModificacionBanco.submit(); // Enviar el formulario
            } else {
                // Si no es válido, mostrar los mensajes de error de Bootstrap
                formModificacionBanco.classList.add('was-validated');
                formModificacionBanco.reportValidity(); 
            }
        });
    }

</script>
</body>
</html>