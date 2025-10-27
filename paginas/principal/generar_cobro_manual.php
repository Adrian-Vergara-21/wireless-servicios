<?php
// Script para insertar una cuenta por cobrar generada manualmente y registrar el detalle en el historial.
// Este script es el procesador del formulario que se encuentra ahora dentro de gestion_cobros.php (modal).

require_once 'conexion.php'; 

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // 1. Obtener y sanitizar datos del formulario
    $id_contrato = isset($_POST['id_contrato']) ? intval($_POST['id_contrato']) : 0;
    $monto_total = isset($_POST['monto']) ? floatval($_POST['monto']) : 0.0;
    
    // CAMPOS DE JUSTIFICACIÓN
    $autorizado_por = isset($_POST['autorizado_por']) ? $conn->real_escape_string($_POST['autorizado_por']) : ''; 
    $justificacion = isset($_POST['justificacion']) ? $conn->real_escape_string($_POST['justificacion']) : 'No especificada.'; 
    
    $fecha_vencimiento = isset($_POST['fecha_vencimiento']) ? $conn->real_escape_string($_POST['fecha_vencimiento']) : '';
    
    // Generar datos automáticos
    $fecha_emision = date('Y-m-d'); 
    $estado = 'PENDIENTE'; 

    $message = "Error desconocido.";
    $class = "danger";

    if ($id_contrato > 0 && $monto_total > 0 && !empty($fecha_vencimiento) && !empty($autorizado_por) && !empty($justificacion)) {
        
        // Iniciar transacción: CRUCIAL para evitar datos incompletos.
        $conn->begin_transaction();
        
        try {
            // 2. INSERTAR la Cuenta Por Cobrar (CXC)
            $sql_cxc = "INSERT INTO cuentas_por_cobrar (
                id_contrato, 
                fecha_emision, 
                fecha_vencimiento, 
                monto_total, 
                estado
            ) VALUES (
                '$id_contrato', 
                '$fecha_emision', 
                '$fecha_vencimiento', 
                '$monto_total', 
                '$estado'
            )";

            if ($conn->query($sql_cxc) === TRUE) {
                // Obtener el ID de cobro generado automáticamente
                $id_cobro_cxc = $conn->insert_id; 

                // 3. INSERTAR el Registro en la Tabla de Historial (cobros_manuales_historial)
                $sql_historial = "INSERT INTO cobros_manuales_historial (
                    id_cobro_cxc, 
                    id_contrato, 
                    autorizado_por, 
                    justificacion, 
                    monto_cargado
                ) VALUES (
                    '$id_cobro_cxc', 
                    '$id_contrato', 
                    '$autorizado_por', 
                    '$justificacion', 
                    '$monto_total'
                )";

                if ($conn->query($sql_historial) === TRUE) {
                    // Confirmar si ambos se guardaron
                    $conn->commit();
                    $message = "Cobro manual de $$monto_total registrado con éxito (Factura #$id_cobro_cxc).";
                    $class = "success";
                } else {
                    // Revertir si falla la inserción del historial
                    throw new Exception("Error al registrar el detalle del historial. SQL Error: " . $conn->error);
                }

            } else {
                // Revertir si falla la inserción de la cuenta por cobrar principal
                throw new Exception("Error al registrar la cuenta por cobrar principal. SQL Error: " . $conn->error);
            }

        } catch (Exception $e) {
            $conn->rollback(); // Revertir si hubo cualquier error
            $message = "ERROR al registrar el cobro: " . $e->getMessage();
            $class = "danger";
        }
    } else {
        $message = "Error: Faltan datos obligatorios para registrar el cobro manual.";
        $class = "danger";
    }

    $conn->close();

    // Redirigir siempre a gestion_cobros.php para mostrar el mensaje de éxito/error en la lista.
    header("Location: gestion_cobros.php?maintenance_done=1&message=" . urlencode($message) . "&class=" . $class);
    exit();
} else {
    // Si acceden directamente al procesador, los enviamos a la lista
    header("Location: gestion_cobros.php?maintenance_done=1");
    exit();
}
?>