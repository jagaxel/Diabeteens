<?php

include("../conexion.php");

$id = mysqli_real_escape_string($connect, $_POST['id']);
$telefono = mysqli_real_escape_string($connect, $_POST['telefono']);

$sql = "UPDATE Persona SET telefono = '$telefono' WHERE id = $id;";
$query = mysqli_query($connect, $sql);

if ($query > 0) {
    echo json_encode("Telefono registrado registrado");
} else {
    echo json_encode("Error al registrar el nombre");
}

?>