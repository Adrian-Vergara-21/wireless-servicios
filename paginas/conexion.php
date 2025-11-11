<?php
$hostname = "localhost";
$username = "root";
$password = "";
$database = "wireless";

// Usando mysqli_connect como procedimiento
$conn = mysqli_connect($hostname, $username, $password, $database); 

if ($conn->connect_error) {
	// die() enviará un mensaje y detendrá el script si hay error de conexión
	die("Error de conexión: " . $conn->connect_error);
}
