<?php

$serverName = "localhost";

$connectionOptions = array(
    "Database" => "pos",
    "Uid" => "sa",
    "PWD" => "1234"
);

$conn = sqlsrv_connect($serverName,$connectionOptions);

$data = json_decode(file_get_contents("php://input"),true);

$usuario = $data["usuario"];
$password = $data["password"];

$sql = "SELECT * FROM usuarios WHERE usuario=? AND password=?";

$params = array($usuario,$password);

$stmt = sqlsrv_query($conn,$sql,$params);

if($row = sqlsrv_fetch_array($stmt)){
    echo json_encode(["status"=>"ok"]);
}else{
    echo json_encode(["status"=>"error"]);
}

?>