<?php
// La contraseña que quieres usar, por ejemplo: 'admin123'
$password_plano = 'admin123'; 
$hash = password_hash($password_plano, PASSWORD_DEFAULT);
echo "Copia este hash: " . $hash; 
?>