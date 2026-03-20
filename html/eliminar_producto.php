<?php
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


// Recibir los datos del producto a eliminar
$data = json_decode(file_get_contents("php://input"), true);
$productoId = $data["ProductoId"];

// Ejecutar la consulta de eliminación
$sql = "DELETE FROM Productos WHERE ProductoId = ?";
$params = array($productoId);
$stmt = sqlsrv_query($conn, $sql, $params);

// Devolver la respuesta al frontend
if($stmt) {
    echo json_encode(["status" => "ok"]);
} else {
    echo json_encode(["status" => "error", "message" => sqlsrv_errors()[0]['message']]);
}
?>
