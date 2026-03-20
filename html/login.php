<?php
// login.php
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



// Leer los datos JSON enviados desde JavaScript
$data = json_decode(file_get_contents("php://input"), true);
$usuario = $data["NombreUsuario"];
$contrasena = $data["Contrasena"];

// Consulta usando JOIN para validar al usuario y obtener sus datos de empleado
$sql = "SELECT 
            u.NombreUsuario, 
            e.Nombre, 
            e.Apellidos, 
            e.Rol 
        FROM Usuarios u
        INNER JOIN Empleados e ON u.EmpleadoId = e.EmpleadoId
        WHERE u.NombreUsuario = ? AND u.Contrasena = ?";

$params = array($usuario, $contrasena);

$stmt = sqlsrv_query($conn, $sql, $params);

if ($stmt === false) {
    // Si hay un error, mostramos el detalle exacto de SQL Server
    $errores = sqlsrv_errors();
    echo json_encode(["status" => "error", "message" => "Error en la consulta de SQL: " . $errores[0]['message']]);
    exit;
}

// Verificar si se encontró un registro
if ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
    // Las credenciales son correctas
    echo json_encode([
        "status" => "ok", 
        "nombre" => $row['Nombre'] . " " . $row['Apellidos'],
        "rol" => $row['Rol']
    ]);
} else {
    // Si no devuelve nada, los datos son incorrectos
    echo json_encode(["status" => "error", "message" => "Usuario o contraseña incorrectos."]);
}

// Liberar memoria y cerrar conexión
sqlsrv_free_stmt($stmt);
sqlsrv_close($conn);
?>
