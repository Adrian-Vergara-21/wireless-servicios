<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Wireless Supply, C.A</title>
    <link rel="stylesheet" href="../css/style2.css">
     <link rel="icon" type="image/jpg" href="../images/logo.jpg"/>
</head>
<body>
    <div class="main-container">
    <aside class="sidebar">
        <header class="sidebar-header">
            <h2>Menú de Opciones</h2>
        </header>
        <nav class="menu-nav">
            <ul class="main-menu">
                <li>
                    <a href="#" class="category-link">Administración</a>
                    <ul class="submenu">
                       <li><a href="principal/gestion_contratos.php">Gestionar Contratos</a></li>
                        <li><a href="gestion_municipios.php">Agregar Municipios</a></li>
                        <li><a href="gestion_planes.php">Agregar Planes</a></li>
                        <li><a href="gestion_bancos.php">Definir Bancos</a></li>
                        <li><a href="gestion_vendedores.php">Gestion De Vendedores</a></li>
                        <li><a href="gestion_pon.php">Gestion De PONs</a></li>
                        <li><a href="gestion_olt.php">Gestion De OLTs</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" class="category-link">Procesos</a>
                    <ul class="submenu">
                        <li><a href="principal/gestion_cobros.php">Cuentas Por Cobrar</a></li>
                        <!--li><a href="#">Opción 2.2</a></li-->
                    </ul>
                </li>
                <li>
                    <a href="#" class="category-link">Reportes</a>
                    <ul class="submenu">
                        <li><a href="reportes_pdf/generar_pdf_municipios.php" class="btn" target="_blank">Lista Municipios</a></li>
                        <li><a href="reportes_pdf/generar_pdf_bancos.php" class="btn" target="_blank">Lista Bancos</a></li>
                        <li><a href="reportes_pdf/generar_pdf_planes.php" class="btn" target="_blank">Lista Planes</a></li>
                        <li><a href="reportes_pdf/generar_pdf_vendedores.php" class="btn" target="_blank">Lista Vendedores</a></li>
                        <li><a href="reportes_pdf/generar_pdf_pon.php" class="btn" target="_blank">Lista De PONs</a></li>
                        <li><a href="reportes_pdf/generar_pdf_olt.php" class="btn" target="_blank">Lista De OLTs</a></li>
                        <li><a href="reportes_pdf/reporte_cobranza.php">Reportes Cobranzas</a></li>
                        <li><a href="reportes_pdf/reporte_clientes.php">Reportes Contratos</a></li>
                         <li><a href="reportes_pdf/generar_lote.php">Generar Contratos</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" class="category-link">Mantenimiento</a>
                    <ul class="submenu">
                        <li><a href="gestion_usuarios.php">Registro De Usuarios</a></li>
                        <!--li><a href="#">Opción 4.2</a></li>
                        <li><a href="#">Opción 4.3</a></li-->
                    </ul>
                </li>
            </ul>
        </nav>
    </aside>
    
     <main class="content">
    <div class="hero-section">
        <img src="../images/logo.jpg" alt="Imagen de bienvenida">
        <h1>Bienvenido a Wireless Supply, C.A.</h1>
       <?php include 'mostrar_frase_random.php'; ?>
        <p> La gestión informática no administra tareas, devuelve tiempo para el pensamiento. <b>Adrian Vergara</b></p>
         <p class="copyright-text">
        &copy; <span id="current-year"></span> Wireless Supply, C.A. Todos los derechos reservados.
    </p>
    </div>
</main>
                 
</div>
    <a href="../index.html" class="logout-btn">
         Cerrar Sesión
    </a>
    <footer>
   
</footer> 

    <script src="../js/menu.js"></script>
    <script>
    document.getElementById("current-year").textContent = new Date().getFullYear();
    </script>
  
</body>
</html>