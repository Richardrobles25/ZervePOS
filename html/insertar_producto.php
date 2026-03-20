<?php
// insertar_producto.php
header('Content-Type: application/json; charset=utf-8');

// Configuración de la conexión a la base de datos ZervePos NUBE
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


// Leer los datos del nuevo formulario
$data = json_decode(file_get_contents("php://input"), true);
$nombre = $data["NombreProducto"];
$precio = $data["PrecioUnitario"];
$stock = $data["UnidadesEnStock"];

// Insertar en la base de datos
$sql = "INSERT INTO Productos (NombreProducto, PrecioUnitario, UnidadesEnStock) VALUES (?, ?, ?)";
$params = array($nombre, $precio, $stock);

$stmt = sqlsrv_query($conn, $sql, $params);

if($stmt) {
    echo json_encode(["status" => "ok"]);
} else {
    echo json_encode(["status" => "error", "message" => sqlsrv_errors()[0]['message']]);
}

sqlsrv_free_stmt($stmt);
sqlsrv_close($conn);
?>
