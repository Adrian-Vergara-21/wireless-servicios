<?php

/**
 * Script para conectarse a la base de datos
 *
 * Este script crea una conexión a la base de datos MySQL utilizando la extensión mysqli.
 * Si la conexión falla, muestra un mensaje de error.
 *
 * @author MRoblesDev
 * @version 1.0
 * https://github.com/mroblesdev
 *
 */

// Parámetros de conexión a la base de datos
$hostname = "localhost";
$username = "root";
$password = "";
$database = "wireless";

$conn =mysqli_connect($hostname, $username, $password, $database);

if ($conn->connect_error) {
	die("Error de conexión" . $conn->connect_error);
}
