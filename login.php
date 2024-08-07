<?php 
session_start();

// Datos de conexión a la base de datos
$host = 'localhost';
$dbname = 'centromedico';
$usuario_bd = 'root';
$password_bd = '';

// Intenta conectarte a la base de datos
try {
    $conexion = new PDO("mysql:host=$host;dbname=$dbname", $usuario_bd, $password_bd);
    // Establece el modo de error de PDO a excepción
    $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    // Si hay un error al conectarse a la base de datos, muestra el mensaje de error
    echo "Error al conectar a la base de datos: " . $e->getMessage();
}

// Verifica si el usuario ya ha iniciado sesión
if (isset($_SESSION['usuario'])) {
    header('Location: index.php');
}

// Verifica si se ha enviado el formulario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usuario = filter_var(strtolower($_POST['usuario']), FILTER_SANITIZE_STRING);
    $password = $_POST['password'];
    $password = hash('sha512', $password);
    $errores = '';

    try {
        // Prepara la consulta SQL
        $statement = $conexion->prepare('SELECT * FROM usuarios WHERE usuario = :usuario AND pass= :password');

        // Ejecuta la consulta con los parámetros proporcionados
        $statement->execute(array(':usuario' => $usuario, ':password' => $password));

        // Obtiene el resultado de la consulta
        $resultado = $statement->fetch();

        // Verifica si se encontraron resultados
        if ($resultado !== false) {
            // Inicia la sesión y redirige al usuario a la página principal
            $_SESSION['usuario'] = $usuario;
            header('Location: index.php');
        } else {
            // Si no se encontraron resultados, muestra un mensaje de error
            $errores .= 'Datos incorrectos y/o inválidos!';
        }
    } catch (PDOException $e) {
        // Si hay un error al ejecutar la consulta, muestra el mensaje de error
        echo "Error al ejecutar la consulta: " . $e->getMessage();
    }
}

// Carga la vista del formulario de inicio de sesión
require 'vista/login.php';
?>
