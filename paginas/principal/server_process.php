<?php
// ¡AÑADE ESTO PARA DEBUGGING!
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
// FIN DE DEBUGGING

/**
 * Script para cargar datos del lado del servidor en DataTables
 *
 * @author MRoblesDev
 * @version 1.1 - Incluye nombres en lugar de IDs para Municipio, Parroquia, Plan y Vendedor
 * https://github.com/mroblesdev
 *
 */

require 'conexion.php';

// 1. Definición de la tabla principal y las uniones (JOINs)
// Usamos alias (c, m, pa, pl, v) para simplificar la consulta
$sTabla = "
    contratos c
   LEFT JOIN municipio m ON c.id_municipio = m.id_municipio /* Asumiendo que el PK es id_municipio */
   LEFT JOIN parroquia pa ON c.id_parroquia = pa.id_parroquia /* Asumiendo que el PK es id_parroquia */
   LEFT JOIN comunidad com ON c.id_comunidad = com.id_comunidad /* Asumiendo que el PK es id_comunidad */
   LEFT JOIN planes pl ON c.id_plan = pl.id_plan
   LEFT JOIN vendedores v ON c.id_vendedor = v.id_vendedor
   LEFT JOIN olt ol ON c.id_olt = ol.id_olt
   LEFT JOIN pon pn ON c.id_pon = pn.id_pon
";

// 2. Definición de las columnas
// Usamos el alias de la tabla y el nombre de la columna para la búsqueda y ordenamiento de DataTables.
$aColumnas = [
    'c.id', 
    'c.ip',
    'c.cedula',
    'c.nombre_completo',
    'c.telefono',
    'c.correo',
    'm.nombre_municipio',           // Nombre del Municipio
    'pa.nombre_parroquia',          // Nombre de la Parroquia
    'com.nombre_comunidad',
    'c.direccion',                  // <-- COLUMNA DE DIRECCIÓN
    'pl.nombre_plan',               // Nombre del Plan
    'v.nombre_vendedor',            // Nombre completo del Vendedor
    'c.fecha_instalacion', 
    'c.estado', 
    'c.ident_caja_nap',
    'c.puerto_nap',
    'c.num_presinto_odn',
    'ol.nombre_olt',               // Nombre de la OLT
    'pn.nombre_pon'           // Nombre del PON
];
$sIndexColumn = "c.id"; // Usamos c.id como índice

// El resto de la lógica de paginación, ordenamiento y búsqueda es la misma...

$sLimit = '';
$start = $_GET['iDisplayStart'] ?? 0;
$length = $_GET['iDisplayLength'] ?? -1;

$sLimit = '';
if ($length != -1) {
    $sLimit = "LIMIT {$start}, {$length}";
}

$sOrder = '';
if (isset($_GET['iSortCol_0'])) {
    $sOrder = 'ORDER BY ';
    $sortingCols = intval($_GET['iSortingCols'] ?? 0); 
    for ($i = 0; $i < $sortingCols; $i++) {
        $colIndex = intval($_GET["iSortCol_{$i}"] ?? -1);
        $bSortable = $_GET["bSortable_{$i}"] ?? "false"; 
        
        if ($colIndex >= 0 && $colIndex < count($aColumnas) && $bSortable == "true") {
            $sortDir = $_GET["sSortDir_{$i}"] ?? "asc";
            $sOrder .= "{$aColumnas[$colIndex]} {$sortDir}, ";
        }
    }
    $sOrder = rtrim($sOrder, ', ');
}

$searchConditions = [];
$searchValue = $_GET['sSearch'] ?? ''; 
if ($searchValue != "") {
    foreach ($aColumnas as $column) {
        $searchConditions[] = "$column LIKE '%$searchValue%'";
    }
}

$individualSearchConditions = [];

for ($i = 0; $i < intval($_GET['iColumns'] ?? 0); $i++) {
    $isSearchable = $_GET['bSearchable_' . $i] ?? 'false';
    $sSearchTerm = $_GET['sSearch_' . $i] ?? '';
    
    if ($isSearchable == 'true' && $sSearchTerm != '') {
        // Usamos el nombre de la columna definido en $aColumnas
        $individualSearchConditions[] = "{$aColumnas[$i]} LIKE '%{$conn->real_escape_string($sSearchTerm)}%'";
    }
}

$whereConditions = [];
if (!empty($searchConditions) || !empty($individualSearchConditions)) {
    // La búsqueda global busca en todas las columnas (OR). 
    $whereConditions[] = "(" . implode(' OR ', $searchConditions) . ")";

    // La búsqueda individual se añade con AND
    if (!empty($individualSearchConditions)) {
        $whereConditions[] = "(" . implode(' AND ', $individualSearchConditions) . ")";
    }
}

$sWhere = '';
if (!empty($whereConditions)) {
    $sWhere = "WHERE " . implode(' AND ', $whereConditions);
}

// 3. Construcción de la consulta SELECT
// Seleccionamos las columnas con sus prefijos para que el resultado coincida con lo esperado
$sQuery = "
    SELECT SQL_CALC_FOUND_ROWS " . implode(', ', $aColumnas) . "
    FROM $sTabla
    $sWhere
    $sOrder
    $sLimit
";
$rResult = $conn->query($sQuery);


// El resto del código que cuenta registros e itera sobre los resultados es el mismo...

$rResultFilterTotal = $conn->query("SELECT FOUND_ROWS()");
$iFilteredTotal = $rResultFilterTotal->fetch_array()[0];

// Usamos el mismo JOIN para el conteo total por si la tabla principal tiene alias
$rResultTotal = $conn->query("SELECT COUNT({$sIndexColumn}) FROM $sTabla"); 
$iTotal = $rResultTotal->fetch_array()[0];

$output = [
    "sEcho" => intval($_GET['sEcho'] ?? 0), 
    "iTotalRecords" => $iTotal,
    "iTotalDisplayRecords" => $iFilteredTotal,
    "aaData" => []
];

// Mapeo de campos para facilitar la lectura del array de resultado
// La columna 'c.direccion' está en el índice 8, 'c.nombre_completo' en el 3 y 'c.ip' en el 1.
// Los índices de columna en $aColumnas son:
// 0: c.id, 1: c.ip, 2: c.cedula, 3: c.nombre_completo, 4: c.telefono, 5: c.correo, 
// 6: m.nombre_municipio, 7: pa.nombre_parroquia, 8: c.direccion, 9: pl.nombre_plan, 
// 10: v.nombre_vendedor, 11: c.fecha_instalacion, 12: c.estado, 13: c.ident_caja_nap, 
// 14: c.puerto_nap, 15: c.num_presinto_odn, 16: c.pon
$INDEX_ID = 0;
$INDEX_IP = 1;
$INDEX_NOMBRE_COMPLETO = 3;
$INDEX_DIRECCION = 9; // <-- Índice de la columna 'c.direccion'

$rResult->field_seek(0);
$fields = $rResult->fetch_fields();

while ($aRow = $rResult->fetch_array(MYSQLI_NUM)) {
    $row = [];
    $id_registro = $aRow[$INDEX_ID]; 

    // ⭐ PASO CLAVE: Extracción y Sanitización de Datos
    // 1. Extraer la dirección, nombre e IP.
    $direccion_raw = trim($aRow[$INDEX_DIRECCION] ?? '');
    $nombre_completo_raw = trim($aRow[$INDEX_NOMBRE_COMPLETO] ?? ''); 
    $ip_raw = trim($aRow[$INDEX_IP] ?? ''); 

    // 2. Reemplazar saltos de línea con un espacio para evitar romper el atributo HTML.
    $direccion_sin_newlines = str_replace(["\r", "\n"], ' ', $direccion_raw);
    
    // 3. Escapar para uso SEGURO en un atributo HTML (maneja comillas simples y dobles).
    $direccion = htmlspecialchars($direccion_sin_newlines, ENT_QUOTES, 'UTF-8'); 
    $nombre_completo = htmlspecialchars($nombre_completo_raw, ENT_QUOTES, 'UTF-8'); 
    $ip = htmlspecialchars($ip_raw, ENT_QUOTES, 'UTF-8'); 
    
    for ($i = 0; $i < count($fields); $i++) {
        $column = $fields[$i]->name;
        $value = $aRow[$i];

        if ($column == 'fecha_instalacion') {
            // Lógica de formato de fecha
            if (!empty($value) && $value != '0000-00-00') {
                $row[] = date('d/m/Y', strtotime($value));
            } else {
                $row[] = $value; 
            }
        } elseif ($column == 'direccion') {
            // LÓGICA CLAVE: Reemplazar el valor de la dirección con el botón/icono
            // Usamos las variables $direccion, $nombre_completo, $ip ya sanitizadas.
            $button_html = "
                <a class='btn btn-sm' href='#' 
                   data-bs-toggle='modal' 
                   data-bs-target='#modalDireccion' 
                   data-direccion='{$direccion}'
                   data-nombre='{$nombre_completo}'
                   data-ip='{$ip}'
                   title='Ver Dirección Completa'>
                    <i class='fa-solid fa-eye text-info'></i> </a>
            ";
            $row[] = $button_html;
        } elseif ($column == "version") {
            $row[] = ($value == "0") ? '-' : $value;
        } else {
            // Añadir el valor de la columna como está
            $row[] = $value;
        }
    }
    
    // Botón Modificar 
    $row[] = "<a class='btn btn-sm' href='modifica.php?id={$id_registro}' title='Modificar Contrato'><i class='fa-solid fa-pen-to-square text-primary'></i></a>";
    
    // Botón Eliminar 
    $row[] = "<a class='btn btn-sm' href='#' data-bs-href='elimina.php?id={$id_registro}' data-bs-toggle='modal' data-bs-target='#eliminaModal' title='Eliminar Contrato'><i class='fa-solid fa-trash-can text-danger'></i></a>";

    $output['aaData'][] = $row;
}

echo json_encode($output, JSON_UNESCAPED_UNICODE);

?>