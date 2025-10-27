<?php
// Incluye el archivo de conexión.
require_once 'conexion.php';

$message = '';
$message_class = '';
$action = isset($_GET['action']) ? $_GET['action'] : '';
$stmt = null; // Inicializamos $stmt

// Variables para la búsqueda
$search_term = isset($_GET['search']) ? $_GET['search'] : '';
$sql_base = "SELECT * FROM `vendedores`";


// --- LÓGICA DE GESTIÓN (ELIMINAR) ---
if ($action === 'delete' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM `vendedores` WHERE `id_vendedor` = ?");
    // El id_vendedor es un string (s) según tu código original
    $stmt->bind_param("s", $id_to_delete); 
    if ($stmt->execute()) {
        $message = "Vendedor con ID '{$id_to_delete}' eliminado con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar el vendedor: " . $stmt->error;
        $message_class = 'error';
    }
    // Redirigimos para limpiar la URL y mostrar el mensaje
    header("Location: gestion_vendedores.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// --- LÓGICA DE MODIFICACIÓN (PROCESAR FORMULARIO POST DEL MODAL) ---
// Usamos 'update_vendedor' como flag para el envío del formulario del modal
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_vendedor'])) {
    $id = $_POST['id_vendedor_update']; // ID viene del campo oculto del modal
    $nombre = $_POST['nombre_vendedor'];
    $telefono = $_POST['telefono_vendedor'];

    $stmt = $conn->prepare("UPDATE `vendedores` SET `nombre_vendedor` = ?, `telefono_vendedor` = ? WHERE `id_vendedor` = ?");
    // Parámetros: string (nombre), string (telefono), string (id)
    $stmt->bind_param("sss", $nombre, $telefono, $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            $message = "¡Vendedor '{$nombre}' actualizado con éxito!";
            $message_class = 'success';
        } else {
            $message = "ADVERTENCIA: No se realizaron cambios en el Vendedor. Los datos ingresados son idénticos.";
            $message_class = 'warning';
        }
    } else {
        $message = "Error al actualizar el vendedor: " . $stmt->error;
        $message_class = 'error';
    }
    
    if ($stmt) {
        $stmt->close();
    }
    // Redirigimos para mostrar el mensaje y limpiar POST
    header("Location: gestion_vendedores.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit();
}

// --- LÓGICA DE CONSULTA (BUSCAR Y MOSTRAR) ---
$sql = $sql_base;
if (!empty($search_term)) {
    $sql .= " WHERE `id_vendedor` LIKE ? OR `nombre_vendedor` LIKE ?";
    $stmt = $conn->prepare($sql);
    $search_param = "%" . $search_term . "%";
    $stmt->bind_param("ss", $search_param, $search_param);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $result = $conn->query($sql);
}

// Manejo del mensaje de redirección (después de eliminar o actualizar)
if (isset($_GET['message'])) {
    $message = $_GET['message'];
    $message_class = $_GET['class'];
}

// Cierre de la conexión (si no se cerró en la lógica de POST/DELETE)
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
    <title>Gestión de Vendedores</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style4.css"> 
    <link rel="stylesheet" href="../css/style3.css"> 
   
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

        .table-container {
            margin-top: 2em;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #c0d1e6;
        }
        th {
            background-color: #0d47a1;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .action-links a {
            color: #2196f3;
            text-decoration: none;
            margin-right: 10px;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 2em;
        }
        .search-form input[type="text"] {
            flex-grow: 1;
            padding: 0.8em;
            border: 1px solid #c0d1e6;
            border-radius: 5px;
        }
        .search-form button {
            padding: 0.8em 1.5em;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Gestión de Vendedores</h1>
            <p>Wireless Supply, C.A.</p>
        </header>
        <div style="margin-bottom: 2em; margin-right:2em; text-align: center;">
            <a href="registro_vendedores.php" class="btn btn-primary">Nuevo Registro</a>
        </div>

        <?php if ($message): ?>
            <div class="message <?php echo $message_class; ?>">
                <?php echo htmlspecialchars($message); ?>
            </div>
        <?php endif; ?>
        
        <div class="step-section">
            <h2>Consultar Vendedores</h2>
            <form action="gestion_vendedores.php" method="GET" class="search-form">
                <input type="text" name="search" placeholder="Buscar por ID o Nombre..." value="<?php echo htmlspecialchars($search_term); ?>">
                <button type="submit" class="btn btn-primary">Buscar</button>
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID Vendedor</th>
                        <th>Nombre</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if ($result && $result->num_rows > 0): ?>
                        <?php while($row = $result->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['id_vendedor']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_vendedor']); ?></td>
                                <td><?php echo htmlspecialchars($row['telefono_vendedor']); ?></td>
                               <td class="action-links">
                                   <a href="#" 
                                       data-bs-toggle="modal"
                                       data-bs-target="#modalModificacionVendedor"
                                       data-id="<?php echo htmlspecialchars($row['id_vendedor']); ?>"
                                       data-nombre="<?php echo htmlspecialchars($row['nombre_vendedor']); ?>"
                                       data-telefono="<?php echo htmlspecialchars($row['telefono_vendedor']); ?>"
                                       class="btn btn-sm" title="Modificar Vendedor">
                                       <i class="fa-solid fa-pen-to-square text-primary"></i>
                                   </a>
                                   <a href="#" 
                                       data-bs-href="gestion_vendedores.php?action=delete&id=<?php echo urlencode($row['id_vendedor']); ?>" 
                                       data-bs-toggle="modal" 
                                       data-bs-target="#eliminaModal" 
                                       class="btn btn-sm" 
                                       title="Eliminar Vendedor">
                                       <i class="fa-solid fa-trash-can text-danger"></i>
                                   </a>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr><td colspan="4">No se encontraron vendedores.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="menu.php" class="btn btn-secondary">Volver al Menú</a>
        </div>
    </div>
    
    <div class="modal fade" id="modalModificacionVendedor" tabindex="-1" aria-labelledby="modalModificacionVendedorLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="modalModificacionVendedorLabel">Modificar Vendedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="form-modificacion-vendedor" action="gestion_vendedores.php" method="POST" novalidate>
                    <div class="modal-body">
                        <input type="hidden" name="update_vendedor" value="1">
                        <input type="hidden" name="id_vendedor_update" id="id_vendedor_modal" value="">
                        
                        <div class="mb-3">
                            <label for="nombre_vendedor_modal" class="form-label">Nombre del Vendedor:</label>
                            <input type="text" id="nombre_vendedor_modal" name="nombre_vendedor" class="form-control" required> 
                        </div>
                        
                        <div class="mb-3">
                            <label for="telefono_vendedor_modal" class="form-label">Teléfono:</label>
                            <input type="text" id="telefono_vendedor_modal" name="telefono_vendedor" class="form-control"> 
                        </div>
                        
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 40%;">Cancelar</button>
                        <button type="button" id="btn-actualizar-vendedor" class="btn btn-primary" style="width: 55%;">Actualizar</button>
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

    // --- LÓGICA DEL MODAL DE MODIFICACIÓN DE VENDEDORES ---
    const modalModificacionVendedor = document.getElementById('modalModificacionVendedor');

    if (modalModificacionVendedor) {
        modalModificacionVendedor.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; 
            
            // 1. Obtener los 3 datos pasados desde la tabla
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const telefono = button.getAttribute('data-telefono');
            
            // 2. Asignar valores a los campos del modal
            document.getElementById('modalModificacionVendedorLabel').textContent = `Modificar Vendedor: ${nombre}`;
            document.getElementById('id_vendedor_modal').value = id;
            document.getElementById('nombre_vendedor_modal').value = nombre;
            document.getElementById('telefono_vendedor_modal').value = telefono;
            
            // 3. Reiniciar la validación
            document.getElementById('form-modificacion-vendedor').classList.remove('was-validated');
        });
    }

    // 4. Lógica para el botón de Actualizar y validación manual
    const btnActualizarVendedor = document.getElementById('btn-actualizar-vendedor');
    const formModificacionVendedor = document.getElementById('form-modificacion-vendedor');

    if (btnActualizarVendedor && formModificacionVendedor) {
        btnActualizarVendedor.addEventListener('click', function(event) {
            
            // Verificar si el formulario es válido (HTML5 validation)
            if (formModificacionVendedor.checkValidity()) {
                formModificacionVendedor.submit(); // Enviar el formulario
            } else {
                // Si no es válido, mostrar los mensajes de error de Bootstrap
                formModificacionVendedor.classList.add('was-validated');
                formModificacionVendedor.reportValidity(); 
            }
        });
    }
</script>
</body>
</html>