<?php
// actualizar_producto.php
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


$data = json_decode(file_get_contents("php://input"), true);

$id = $data["ProductoId"];
$nombre = $data["NombreProducto"];
$precio = $data["PrecioUnitario"];
$stock = $data["UnidadesEnStock"];

// Actualiza Nombre, Precio y Stock usando el ID
$sql = "UPDATE Productos SET NombreProducto = ?, PrecioUnitario = ?, UnidadesEnStock = ? WHERE ProductoId = ?";
$params = array($nombre, $precio, $stock, $id);

$stmt = sqlsrv_query($conn, $sql, $params);

if($stmt) {
    echo json_encode(["status" => "ok"]);
} else {
    echo json_encode(["status" => "error", "message" => sqlsrv_errors()[0]['message']]);
}

sqlsrv_free_stmt($stmt);
sqlsrv_close($conn);
?>
