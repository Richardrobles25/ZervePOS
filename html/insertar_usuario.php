<?php
// insertar_usuario.php
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


// Leer los datos JSON enviados desde el formulario
$data = json_decode(file_get_contents("php://input"), true);

// Asignar variables desde el JSON
$nombre = $data["nombre"];
$apellidos = $data["apellidos"];
$fechaNacimiento = $data["fechaNacimiento"];
$direccion = $data["domicilio"]; // En el HTML el input se llama 'domicilio'
$ciudad = $data["ciudad"];
$codigoPostal = $data["codigoPostal"];
$telefono = $data["telefono"];
$rol = $data["rol"];

$usuario = $data["usuario"];
$contrasena = $data["contrasena"];

// Iniciar transacción
sqlsrv_begin_transaction($conn);

try {
    // 1. Insertar en la tabla Empleados
    // El orden exacto según tu SQL: Apellidos, Nombre, FechaNacimiento, Direccion, Ciudad, CodigoPostal, Telefono, Rol
    $sqlEmpleado = "INSERT INTO Empleados (Apellidos, Nombre, FechaNacimiento, Direccion, Ciudad, CodigoPostal, Telefono, Rol) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?);
                    SELECT SCOPE_IDENTITY() AS NuevoID;";
    
    // Parámetros en el mismo orden que el INSERT
    $paramsEmpleado = array($apellidos, $nombre, $fechaNacimiento, $direccion, $ciudad, $codigoPostal, $telefono, $rol);
    $stmtEmpleado = sqlsrv_query($conn, $sqlEmpleado, $paramsEmpleado);

    if ($stmtEmpleado === false) {
        throw new Exception("Error al insertar el Empleado: " . sqlsrv_errors()[0]['message']);
    }

    // Moverse al siguiente resultado para obtener el ID generado
    sqlsrv_next_result($stmtEmpleado);
    sqlsrv_fetch($stmtEmpleado);
    $empleadoId = sqlsrv_get_field($stmtEmpleado, 0);

    // 2. Insertar en la tabla Usuarios usando el $empleadoId capturado
    // El orden exacto según tu SQL: EmpleadoId, NombreUsuario, Contrasena
    $sqlUsuario = "INSERT INTO Usuarios (EmpleadoId, NombreUsuario, Contrasena) VALUES (?, ?, ?)";
    $paramsUsuario = array($empleadoId, $usuario, $contrasena);
    $stmtUsuario = sqlsrv_query($conn, $sqlUsuario, $paramsUsuario);

    if ($stmtUsuario === false) {
        throw new Exception("Error al insertar el Usuario: " . sqlsrv_errors()[0]['message']);
    }

    // Si ambas consultas fueron exitosas, confirmamos los cambios
    sqlsrv_commit($conn);

    echo json_encode([
        "success" => true, 
        "message" => "Usuario creado correctamente",
        "empleadoId" => $empleadoId
    ]);

} catch (Exception $e) {
    // Si algo falla, deshacemos la transacción
    sqlsrv_rollback($conn);
    
    echo json_encode([
        "success" => false, 
        "message" => $e->getMessage()
    ]);
}

// Liberar recursos
if(isset($stmtEmpleado)) sqlsrv_free_stmt($stmtEmpleado);
if(isset($stmtUsuario)) sqlsrv_free_stmt($stmtUsuario);
sqlsrv_close($conn);
?>
