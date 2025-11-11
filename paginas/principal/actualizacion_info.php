<?php
// Archivo: actualizacion_info.php

// 1. EJECUCIÓN DE LA LÓGICA DE MANTENIMIENTO
// El script de actualización (sin el $conn->close()) se incluye aquí para que se ejecute.
require_once 'actualizar_vencimientos.php'; 

// Las variables $filas_actualizadas y $fecha_hoy son creadas en 'actualizar_vencimientos.php'
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizando Cobranzas</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/jpg" href="../../images/logo.jpg"/>
    <style>
        /* Estilos básicos para centrar la pantalla de información */
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa; /* Fondo claro */
        }
        .info-box {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
            max-width: 500px;
        }
    </style>
</head>
<body>

<div class="info-box">
    <h1 class="text-primary mb-3">⚙️ Mantenimiento en Curso...</h1>
    <p class="lead">Actualizando los estados de cuentas por cobrar al día "<?php echo htmlspecialchars($fecha_hoy); ?>".</p>
    
    <?php if ($filas_actualizadas > 0): ?>
        <p class="text-success h4 mt-4">✅ "<?php echo $filas_actualizadas; ?> Cuentas Marcadas Como VENCIDAS".</p>
    <?php else: ?>
        <p class="text-info h4 mt-4">Información al día. No se detectaron nuevos vencimientos.</p>
    <?php endif; ?>
    
    <div class="spinner-border text-primary mt-4" role="status">
      <span class="visually-hidden">Cargando...</span>
    </div>
    <p class="text-muted mt-3">Redirigiendo a la tabla en 2 segundos...</p>
</div>

<script>
    // ----------------------------------------------------
    // LÓGICA DE CIERRE AUTOMÁTICO (REDIRECCIÓN)
    // ----------------------------------------------------
    document.addEventListener('DOMContentLoaded', function() {
        // Redirige al script principal después de 3 segundos (3000 ms)
        setTimeout(function() {
            window.location.href = 'gestion_cobros.php?maintenance_done=true';
        }, 300); // 1000 ms = 1 segundo
    });
</script>

</body>
</html>