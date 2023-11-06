<?php

include("../conexion.php");

$id = mysqli_real_escape_string($connect, $_POST['id']);
$telefono = mysqli_real_escape_string($connect, $_POST['correo']);

$sql = "INSERT INTO Persona(correo) VALUES($correo) WHERE id = $id;";
$query = mysqli_query($connect, $sql);

if ($query > 0) {
    echo json_encode("Correo registrado registrado");
} else {
    echo json_encode("Error al registrar el nombre");
}

?>