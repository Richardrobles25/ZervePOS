<?php
// obtener_productos.php
header('Content-Type: application/json; charset=utf-8');

// Configuración de la conexión a la base de datos ZervePos local
$serverName = "zervepos-rasshid-2026.database.windows.net"; 

$connectionOptions = array(
    "Database" => "ZervePos", 
    "Uid" => "adminZerve", 
    "PWD" => "ContraZervePos1234", // Tu contraseña real
    "CharacterSet" => "UTF-8", 
    "TrustServerCertificate" => false, 
    "Encrypt" => true 
);

$conn = sqlsrv_connect($serverName, $connectionOptions);

if ($conn === false) {
    echo json_encode(["status" => "error", "message" => sqlsrv_errors()]);
    exit;
}



// Consulta a la tabla Productos
$sql = "SELECT ProductoId, NombreProducto, PrecioUnitario, UnidadesEnStock FROM Productos";
$stmt = sqlsrv_query($conn, $sql);

if ($stmt === false) {
    echo json_encode(["status" => "error", "message" => sqlsrv_errors()]);
    exit;
}

// Array para almacenar los productos
$productos = [];

// Recorrer los resultados de la consulta
while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
    // Agregamos la fila al array
    $productos[] = $row;
}

// Liberar el conjunto de resultados y cerrar la conexión
sqlsrv_free_stmt($stmt);
sqlsrv_close($conn);

// Devolver los datos en formato JSON
echo json_encode(["status" => "ok", "data" => $productos]);
?>
