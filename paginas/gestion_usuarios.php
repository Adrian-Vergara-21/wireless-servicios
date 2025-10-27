<?php
// Incluye el archivo de conexión. La variable $conn estará disponible aquí.
require_once 'conexion.php'; 

$message = '';
$message_class = '';
$action = isset($_GET['action']) ? $_GET['action'] : ''; 
$edit_data = null; 
$stmt = null; 

// Variables para la búsqueda
$search_term = isset($_GET['search']) ? $conn->real_escape_string($_GET['search']) : '';

// ----------------------------------------------------------------------------------
// LÓGICA DE GESTIÓN DE FORMULARIO (POST: INSERTAR O ACTUALIZAR)
// ----------------------------------------------------------------------------------
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Recolección y saneamiento de datos
    // Usamos real_escape_string para prevenir inyección SQL.
    $user_input = $conn->real_escape_string($_POST['usuario']);
    $nombre_completo = $conn->real_escape_string($_POST['nombre_completo'] ?? ''); 
    $rol = $conn->real_escape_string($_POST['rol'] ?? 'Vendedor'); // Asume un valor por defecto si falta
    
    $id_usuario = isset($_POST['id_usuario']) ? $conn->real_escape_string($_POST['id_usuario']) : null;
    // La clave puede ser nula/vacía en la modificación, pero no en la creación.
    $pass_input = $conn->real_escape_string($_POST['clave'] ?? ''); 

    if ($id_usuario) {
        // --- MODIFICAR (UPDATE) ---
        $set_clause = "nombre_completo = ?, usuario = ?, rol = ?";
        $types = "sss";
        $params = [$nombre_completo, $user_input, $rol];

        if (!empty($pass_input)) {
            // Si se ingresó una nueva clave, la hasheamos y la incluimos
            $hashed_pass = password_hash($pass_input, PASSWORD_DEFAULT);
            $set_clause .= ", clave = ?";
            $types .= "s";
            $params[] = $hashed_pass;
        }

        // Añadir el ID al final para la cláusula WHERE
        $types .= "i";
        $params[] = $id_usuario;

        $sql_update = "UPDATE usuarios SET $set_clause WHERE id_usuario = ?";
        $stmt = $conn->prepare($sql_update);
        
        // El método call_user_func_array es útil para bind_param con arrays dinámicos
        if (call_user_func_array([$stmt, 'bind_param'], array_merge([$types], $params))) {
            if ($stmt->execute()) {
                $message = "Usuario modificado con éxito.";
                $message_class = 'success';
            } else {
                $message = "Error al modificar el usuario: " . $stmt->error;
                $message_class = 'error';
            }
        } else {
             $message = "Error al enlazar parámetros para la modificación.";
             $message_class = 'error';
        }

    } else {
        // --- CREAR (INSERT) ---
        if (empty($pass_input)) {
            $message = "La clave no puede estar vacía al crear un nuevo usuario.";
            $message_class = 'error';
        } else {
            $hashed_pass = password_hash($pass_input, PASSWORD_DEFAULT);
            $sql_insert = "INSERT INTO usuarios (usuario, clave, nombre_completo, rol) VALUES (?, ?, ?, ?)";
            $stmt = $conn->prepare($sql_insert);
            $stmt->bind_param("ssss", $user_input, $hashed_pass, $nombre_completo, $rol);
            if ($stmt->execute()) {
                $message = "Usuario creado con éxito.";
                $message_class = 'success';
            } else {
                $message = "Error al crear el usuario: " . $stmt->error;
                // Manejo de error específico (ej: clave duplicada, si aplica)
                if ($conn->errno == 1062) {
                     $message = "Error: El usuario '{$user_input}' ya existe.";
                }
                $message_class = 'error';
            }
        }
    }
    
    if ($stmt) {
        $stmt->close();
    }
    
    // Redirección POST-a-GET para evitar reenvío de formulario y mostrar el mensaje
    header("Location: gestion_usuarios.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit;
}

// ----------------------------------------------------------------------------------
// LÓGICA DE GESTIÓN (ELIMINAR)
// ----------------------------------------------------------------------------------
if ($action === 'delete_user' && isset($_GET['id'])) {
    $id_to_delete = $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM `usuarios` WHERE `id_usuario` = ?");
    $stmt->bind_param("i", $id_to_delete);
    if ($stmt->execute()) {
        $message = "Usuario eliminado con éxito.";
        $message_class = 'success';
    } else {
        $message = "Error al eliminar el usuario: " . $stmt->error;
        $message_class = 'error';
    }
    $stmt->close();
    
    // Redirección POST-a-GET
    header("Location: gestion_usuarios.php?message=" . urlencode($message) . "&class=" . urlencode($message_class));
    exit;
}

// ----------------------------------------------------------------------------------
// LÓGICA DE CONSULTA (LISTADO Y BÚSQUEDA)
// ----------------------------------------------------------------------------------
$sql = "SELECT id_usuario, usuario, nombre_completo, rol FROM usuarios";

if (!empty($search_term)) {
    // Usamos la variable saneada $search_term
    $sql .= " WHERE nombre_completo LIKE ? OR usuario LIKE ? OR rol LIKE ?";
}
$sql .= " ORDER BY id_usuario ASC";

$result = null;

if (!empty($search_term)) {
    $search_param = "%" . $search_term . "%";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sss", $search_param, $search_param, $search_param);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $result = $conn->query($sql);
}

$data = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

// Manejo de mensajes de redirección
if (isset($_GET['message'])) {
    $message = $_GET['message'];
    $message_class = $_GET['class'];
}

$conn->close();

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios</title>
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
        
        /* Asegurar que la tabla y el contenedor mantengan el ancho original */
        .table-container {
            width: 100%;
            overflow-x: auto;
        }
        
        .register-container {
            max-width: 900px; /* Limitar el ancho del contenedor principal si era así antes */
            margin: auto;
            padding: 20px;
        }
        
        /* Estilos del formulario dentro del modal (para usar las clases de Bootstrap dentro del modal) */
        #form-modificacion-usuario .form-label {
            margin-bottom: 0.25rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <header class="register-header">
            <h1>Gestión de Usuarios</h1>
            <p>Wireless Supply, C.A.</p>
        </header>

        <div class="header-actions">
            <div>
                <button type="button" class="btn btn-primary" 
                    data-bs-toggle="modal" 
                    data-bs-target="#modalModificacionUsuario" 
                    data-id="" data-nombre="" data-usuario="" data-rol="">
                    Nuevo Registro
                </button>
            </div>
            <div class="step-section search-section">
                <h2 style="margin-top: 0; text-align: center;">Buscar</h2>
                <form action="gestion_usuarios.php" method="GET" class="search-form" style="display: inline-flex; width: 100%;">
                    <input type="text" name="search" placeholder="Buscar por nombre o usuario..." value="<?php echo htmlspecialchars($search_term); ?>">
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
                        <th>Nombre Completo</th>
                        <th>Usuario (Login)</th>
                        <th>Rol</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($data)): ?>
                        <?php foreach ($data as $row): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['id_usuario']); ?></td>
                                <td><?php echo htmlspecialchars($row['nombre_completo']); ?></td>
                                <td><?php echo htmlspecialchars($row['usuario']); ?></td>
                                <td><?php echo htmlspecialchars($row['rol']); ?></td>
                                <td class="action-links">
                                   <a href="#" 
                                       data-bs-toggle="modal"
                                       data-bs-target="#modalModificacionUsuario"
                                       data-id="<?php echo htmlspecialchars($row['id_usuario']); ?>"
                                       data-nombre="<?php echo htmlspecialchars($row['nombre_completo']); ?>"
                                       data-usuario="<?php echo htmlspecialchars($row['usuario']); ?>"
                                       data-rol="<?php echo htmlspecialchars($row['rol']); ?>"
                                       class="btn btn-sm" title="Modificar Usuario">
                                       <i class="fa-solid fa-pen-to-square text-primary"></i>
                                   </a>
                                   <a href="#" 
                                       data-bs-href="gestion_usuarios.php?action=delete_user&id=<?php echo urlencode($row['id_usuario']); ?>" 
                                       data-bs-toggle="modal" 
                                       data-bs-target="#eliminaModal" 
                                       class="btn btn-sm" 
                                       title="Eliminar Usuario">
                                       <i class="fa-solid fa-trash-can text-danger"></i>
                                   </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="5">No se encontraron usuarios.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 2em; text-align: center;">
            <a href="menu.php" class="btn btn-secondary">Volver al Menú</a>
        </div>
    </div>

    <div class="modal fade" id="modalModificacionUsuario" tabindex="-1" aria-labelledby="modalModificacionUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-styled">
                    <h5 class="modal-title texto_modificado_modal" id="modalModificacionUsuarioLabel">Modificar Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="form-modificacion-usuario" class="row g-3 p-3" method="POST" action="gestion_usuarios.php" novalidate>
                    <div class="modal-body">
                        <input type="hidden" name="id_usuario" id="id_usuario_modal" value="">
                        
                        <div class="col-12 mb-3">
                            <label for="nombre_completo_modal" class="form-label">Nombre Completo:</label>
                            <input type="text" id="nombre_completo_modal" name="nombre_completo" class="form-control" required> 
                            <div class="invalid-feedback">
                                Por favor, ingrese el nombre completo.
                            </div>
                        </div>

                        <div class="col-12 mb-3">
                            <label for="usuario_modal" class="form-label">Usuario (Login):</label>
                            <input type="text" id="usuario_modal" name="usuario" class="form-control" required> 
                            <div class="invalid-feedback">
                                Por favor, ingrese el nombre de usuario.
                            </div>
                        </div>
                        
                        <div class="col-12 mb-3">
                            <label for="rol_modal" class="form-label">Rol:</label>
                            <select id="rol_modal" name="rol" class="form-select" required>
                                <option value="Administrador">Administrador</option>
                                <option value="Operador">Operador</option>
                            </select>
                            <div class="invalid-feedback">
                                Por favor, seleccione un rol.
                            </div>
                        </div>

                        <div class="col-12 mb-3">
                            <label for="clave_modal" class="form-label" id="clave_label">Clave:</label>
                            <input type="password" id="clave_modal" name="clave" class="form-control" placeholder="Dejar vacío para no cambiar" minlength="4">
                             <small class="form-text text-muted" id="clave_hint">Solo ingrese una clave si desea cambiarla.</small>
                             <div class="invalid-feedback" id="clave_feedback">
                                La clave es obligatoria para nuevos usuarios y debe tener al menos 4 caracteres.
                             </div>
                        </div>
                        
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 40%;">Cancelar</button>
                        <button type="button" id="btn-actualizar-usuario" class="btn btn-primary" style="width: 55%;">Guardar</button>
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
    // 1. LÓGICA DEL MODAL DE MODIFICACIÓN/CREACIÓN
    // -----------------------------------------------------
    const modalModificacionUsuario = document.getElementById('modalModificacionUsuario');
    const formModificacionUsuario = document.getElementById('form-modificacion-usuario');

    if (modalModificacionUsuario) {
        modalModificacionUsuario.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; 
            
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const usuario = button.getAttribute('data-usuario');
            const rol = button.getAttribute('data-rol');

            const modalTitle = document.getElementById('modalModificacionUsuarioLabel');
            const claveInput = document.getElementById('clave_modal');
            const claveHint = document.getElementById('clave_hint');
            const btnSubmit = document.getElementById('btn-actualizar-usuario');
            
            // Limpiar clave al abrir
            claveInput.value = '';
            
            if (id) {
                // Modo Modificación
                modalTitle.textContent = `Modificar Usuario ID: ${id}`;
                document.getElementById('id_usuario_modal').value = id;
                document.getElementById('nombre_completo_modal').value = nombre;
                document.getElementById('usuario_modal').value = usuario;
                document.getElementById('rol_modal').value = rol;
                
                // Clave: Opcional, solo si el usuario la teclea
                claveInput.required = false; 
                claveHint.textContent = "Solo ingrese una clave si desea cambiarla. Debe tener al menos 4 caracteres.";
                btnSubmit.textContent = "Actualizar";

            } else {
                // Modo Creación (Nuevo Registro)
                modalTitle.textContent = 'Crear Nuevo Usuario';
                document.getElementById('id_usuario_modal').value = ''; // ID vacío para inserción
                document.getElementById('nombre_completo_modal').value = '';
                document.getElementById('usuario_modal').value = '';
                // Establecer un rol por defecto si es creación
                document.getElementById('rol_modal').value = 'Vendedor'; 

                // Clave: Requerida para nuevo usuario
                claveInput.required = true; 
                claveHint.textContent = "La clave es obligatoria para un nuevo usuario y debe tener al menos 4 caracteres.";
                btnSubmit.textContent = "Guardar";
            }
            
            // Reiniciar la validación de Bootstrap
            formModificacionUsuario.classList.remove('was-validated');
        });

        // 2. Lógica para el botón de Guardar/Actualizar y validación manual
        const btnActualizarUsuario = document.getElementById('btn-actualizar-usuario');

        if (btnActualizarUsuario && formModificacionUsuario) {
            btnActualizarUsuario.addEventListener('click', function(event) {
                
                // Forzar la validación de la contraseña solo si está en modo CREACIÓN o si se llenó el campo
                const claveInput = document.getElementById('clave_modal');
                const isCreation = document.getElementById('id_usuario_modal').value === '';
                
                if (isCreation) {
                    claveInput.required = true;
                } else {
                    // Si es modificación, solo se requiere si tiene contenido
                    claveInput.required = claveInput.value.length > 0;
                    // También debe cumplir el minlength si tiene contenido
                    if (claveInput.value.length > 0 && claveInput.value.length < 4) {
                        claveInput.setCustomValidity("La clave debe tener al menos 4 caracteres.");
                    } else {
                        claveInput.setCustomValidity(""); // Resetear la validez
                    }
                }

                // Usamos checkValidity para validar los campos requeridos
                if (formModificacionUsuario.checkValidity()) {
                    formModificacionUsuario.submit(); // Enviar el formulario
                } else {
                    formModificacionUsuario.classList.add('was-validated');
                    // Opcional: enfocar el primer campo inválido
                    formModificacionUsuario.reportValidity(); 
                }
            });
        }
    }

    // -----------------------------------------------------
    // 3. LÓGICA DEL MODAL DE ELIMINACIÓN
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