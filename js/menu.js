document.addEventListener('DOMContentLoaded', function() {
    // Selecciona todos los enlaces de categoría
    const categoryLinks = document.querySelectorAll('.category-link');

    categoryLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            // Evita que el navegador navegue a la URL del enlace
            event.preventDefault();

            // Busca el submenú directamente después del enlace
            const submenu = this.nextElementSibling;

            // Si existe un submenú, alterna la clase 'active'
            if (submenu && submenu.classList.contains('submenu')) {
                // Si el submenú ya está abierto, lo cierra
                if (submenu.classList.contains('active')) {
                    submenu.classList.remove('active');
                } else {
                    // Cierra cualquier otro submenú abierto
                    document.querySelectorAll('.submenu.active').forEach(openSubmenu => {
                        openSubmenu.classList.remove('active');
                    });
                    // Abre el submenú clicado
                    submenu.classList.add('active');
                }
            }
        });
    });
});