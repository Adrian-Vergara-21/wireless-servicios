<?php

// ----------------------------------------------------------------------
// 1. RESTRICCIÓN DE ACCESO (OPCIONAL PERO RECOMENDADO)
// Se utiliza para evitar que el script se ejecute accidentalmente por navegador.
// ----------------------------------------------------------------------
if (php_sapi_name() !== 'cli') {
    // Si tienes problemas de ejecución, comenta la línea 'die' para probar.
    // die("Acceso directo denegado. Este script solo puede ejecutarse por CLI (Cron Job).");
}
// ----------------------------------------------------------------------

require_once '../conexion.php'; // Incluye tu archivo de conexión

// ----------------------------------------------------------------------
// 2. DEFINICIÓN DE FECHAS
// ----------------------------------------------------------------------
$fecha_emision = date('Y-m-d');
$fecha_vencimiento = date('Y-m-d', strtotime('+30 days')); // Vence 30 días después de la emisión
$mes_actual = date('Y-m'); // Mes y Año actual (ej: 2025-11)

// PRUEBA DE DIAGNÓSTICO: Muestra las fechas generadas en el log del Cron Job
echo "Fecha de Emisión: " . $fecha_emision . "\n";
echo "Fecha de Vencimiento calculada: " . $fecha_vencimiento . "\n";

// ----------------------------------------------------------------------
// 3. CONSULTA PRINCIPAL: Obtener contratos ACTIVO con monto mayor a cero
// ¡CONDICIÓN CLAVE AÑADIDA: p.monto > 0 para excluir planes exonerados!
// ----------------------------------------------------------------------
$sql_contratos = "
    SELECT 
        c.id, 
        p.monto,                    /* <--- MONTO TOMADO DE LA TABLA 'planes' (p) */
        c.id_plan
    FROM contratos c
    JOIN planes p ON c.id_plan = p.id_plan /* <--- UNIÓN PARA OBTENER EL MONTO */
    WHERE c.estado = 'ACTIVO' 
    AND p.monto > 0                 /* <--- EXCLUYE PLANES CON MONTO CERO (EXONERADOS) */
    /*
    La siguiente cláusula se ELIMINÓ previamente para permitir la acumulación:
    AND NOT EXISTS (
        SELECT 1 
        FROM cuentas_por_cobrar cxc 
        WHERE cxc.id_contrato = c.id 
        AND cxc.fecha_emision LIKE '{$mes_actual}%'
    )
    */
";

// Ejecutar consulta de contratos
$resultado_contratos = $conn->query($sql_contratos); 
$contador_facturas = 0;

if ($resultado_contratos === FALSE) {
    // Si hay un error de sintaxis en el SQL, lo reporta aquí.
    die("Error en la consulta de contratos: " . $conn->error . "\n");
}

if ($resultado_contratos->num_rows > 0) {
    echo "Iniciando generación de facturas para el mes " . $mes_actual . ".\n";
    
    // Preparar la inserción de la factura
    $stmt_insert = $conn->prepare("
        INSERT INTO cuentas_por_cobrar 
        (id_contrato, fecha_emision, fecha_vencimiento, monto_total, estado, id_plan_cobrado) 
        VALUES (?, ?, ?, ?, 'PENDIENTE', ?)
    ");

    if ($stmt_insert === FALSE) {
        die("Error al preparar la sentencia INSERT: " . $conn->error . "\n");
    }

    while ($fila = $resultado_contratos->fetch_assoc()) {
        $id_contrato = $fila['id'];
        $monto_base = $fila['monto']; 
        $id_plan_cobrado = $fila['id_plan'];
        
        // Ejecutar la inserción
        // TIPOS DE DATOS CORREGIDOS: "issdi" (S para fechas, D para monto)
        $stmt_insert->bind_param("issdi", 
            $id_contrato, 
            $fecha_emision, 
            $fecha_vencimiento, 
            $monto_base,
            $id_plan_cobrado
        );
        
        if ($stmt_insert->execute()) {
            $contador_facturas++;
        } else {
            echo "Error al generar factura para Contrato ID {$id_contrato}: " . $stmt_insert->error . "\n";
        }
    }

    $stmt_insert->close();
    echo "Proceso completado. {$contador_facturas} facturas generadas exitosamente.\n";

} else {
    echo "No se encontraron contratos activos sin factura para el mes actual o todos son planes exonerados.\n";
}


$conn->close();

?>