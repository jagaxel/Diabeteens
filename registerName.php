<?php
include("../conexion.php");

$nombre = mysqli_real_escape_string($connect, $_POST['nombre']);
$primerApellido = mysqli_real_escape_string($connect, $_POST['primerApellido']);
$segundoApellido = mysqli_real_escape_string($connect, $_POST['segundoApellido']);

$sql = "INSERT INTO Persona(nombre, primerApellido, segundoApellido) VALUES($nombre, $primerApellido, $segundoApellido)";
$query = mysqli_query($connect, $sql);

if ($query > 0) {
    echo json_encode("Nombre registrado");
} else {
    echo json_encode("Error al registrar el nombre");
}

?>