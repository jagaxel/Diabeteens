<?php

include("../conexion.php");

$idPersona = mysqli_real_escape_string($connect, $_POST['id']);
$correo = mysqli_real_escape_string($connect, $_POST['correo']);
$contrasena = mysqli_real_escape_string($connect, $_POST['contrasena']);

$sql = "INSERT INTO Tutor(idPersona, correo, contrasena) VALUES($idPersona, $correo, md5($contransed)) WHERE id = $id;";
$query = mysqli_query($connect, $sql);

if ($query > 0) {
    echo json_encode("Telefono registrado registrado");
} else {
    echo json_encode("Error al registrar el nombre");
}

?>