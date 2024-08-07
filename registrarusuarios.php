<?php
session_start();

if(!isset($_SESSION['usuario'])){
    header('Location: login.php');
    exit();
}

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $usuario = filter_var(strtolower($_POST['usuario']), FILTER_SANITIZE_STRING);
    $password = $_POST['password'];
    $password2 = $_POST['password2'];
    $nombres = $_POST['nombres'];
    $apellidos = $_POST['apellidos'];
    $roll = $_POST['roll'];
    $errores ='';

    if(empty($usuario) || empty($password)){
        $errores .= '<li>Por favor rellena todos los datos correctamente</li>';
    } else {
        try{
            $conexion = new PDO('mysql:host=localhost;dbname=centromedico','root','');
            $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e){
            echo "ERROR: " . $e->getMessage();
            die();
        }

        $statement = $conexion->prepare('SELECT * FROM usuarios WHERE usuario = :usuario LIMIT 1');
        $statement->execute(array(':usuario' => $usuario));
        $resultado = $statement->fetch();

        if($resultado !== false){
            $errores .= '<li>El nombre de usuario ya existe</li>';
        }

        if($password2 !== $password){
            $errores .= '<li>Las contraseñas no son iguales</li>';
        }
    }

    if(empty($errores)){
        $password_hash = hash('sha512', $password);
        $statement = $conexion->prepare('INSERT INTO usuarios (usuario, pass, nombres, apellidos, roll) VALUES (:usuario, :pass, :nombres, :apellidos, :roll)');
        $statement->execute(array(
            ':usuario' => $usuario,
            ':pass' => $password_hash,
            ':nombres' => $nombres,
            ':apellidos' => $apellidos,
            ':roll' => $roll
        ));
        header('Location: usuarios.php');
        exit();
    }
}

require 'vista/registro_vista.php';
?>
