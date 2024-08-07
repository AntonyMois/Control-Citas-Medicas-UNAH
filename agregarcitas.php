<?php
session_start();

if(!isset($_SESSION['usuario'])){
    header('Location: login.php');
    exit();
}

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $citfecha = $_POST['citfecha'];
    $cithora = $_POST['cithora'];
    $citPaciente = $_POST['citPaciente'];
    $citMedico = $_POST['citMedico'];
    $citConsultorio = $_POST['citConsultorio'];
    $citestado = $_POST['citestado'];
    $citobservaciones = $_POST['citobservaciones'];
    $mensaje='';

    // Validación de campos
    if(empty($citfecha) || empty($cithora) || empty($citConsultorio) || empty($citPaciente) || empty($citestado) || empty($citMedico)){
        $mensaje .= 'Por favor rellena todos los datos correctamente'."<br />";
    } else {   
        try {
            // Conexión a la base de datos
            $conexion = new PDO('mysql:host=localhost;dbname=centromedico','root','');
            $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            echo "Error de conexión: ". $e->getMessage();
            exit();
        }

        try {
            // Preparar la consulta SQL con marcadores de posición
            $statement = $conexion->prepare(
                'INSERT INTO citas (citfecha, cithora, citPaciente, citMedico, citConsultorio, citestado, citobservaciones) VALUES (:citfecha, :cithora, :citPaciente, :citMedico, :citConsultorio, :citestado, :citobservaciones)'
            );

            // Ejecutar la consulta preparada con los valores proporcionados por el usuario
            $statement->execute(array(
                ':citfecha' => $citfecha,
                ':cithora' => $cithora,
                ':citPaciente' => $citPaciente,
                ':citMedico' => $citMedico,
                ':citConsultorio' => $citConsultorio,
                ':citestado' => $citestado,
                ':citobservaciones' => $citobservaciones
            ));

            // Verificar si hubo errores en la ejecución de la consulta
            if($statement->rowCount() > 0){
                header('Location: citas.php');
                exit();
            } else {
                $mensaje .= 'Error al agregar la cita.';
            }
        } catch(PDOException $e) {
            echo "Error al ejecutar la consulta: ". $e->getMessage();
            exit();
        }
    }
}

require 'vista/agregarcitas_vista.php';
?>
