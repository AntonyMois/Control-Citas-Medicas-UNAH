-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-04-2024 a las 07:25:19
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `centromedico`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `idcita` int(11) NOT NULL,
  `citfecha` date NOT NULL,
  `cithora` time NOT NULL,
  `citPaciente` int(11) NOT NULL,
  `citMedico` int(11) NOT NULL,
  `citConsultorio` int(11) NOT NULL,
  `citestado` enum('Asignado','atendido') NOT NULL,
  `citobservaciones` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`idcita`, `citfecha`, `cithora`, `citPaciente`, `citMedico`, `citConsultorio`, `citestado`, `citobservaciones`) VALUES
(8, '2024-04-13', '11:45:00', 0, 0, 0, 'Asignado', ''),
(9, '2024-04-17', '11:45:00', 0, 0, 0, 'Asignado', ''),
(10, '2024-04-15', '11:45:00', 0, 0, 0, 'Asignado', 'mucha '),
(11, '2024-04-18', '09:45:00', 0, 0, 0, 'Asignado', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultorios`
--

CREATE TABLE `consultorios` (
  `idConsultorio` int(11) NOT NULL,
  `conNombre` char(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `consultorios`
--

INSERT INTO `consultorios` (`idConsultorio`, `conNombre`) VALUES
(1, 'Clinica Jerusal'),
(2, 'Jerusalem 2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `idespecialidad` int(11) NOT NULL,
  `espNombre` char(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`idespecialidad`, `espNombre`) VALUES
(4, 'cirugía'),
(3, 'pediatria'),
(5, 'resonancia'),
(2, 'terapia2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `idMedico` int(11) NOT NULL,
  `medidentificacion` char(15) NOT NULL,
  `mednombres` varchar(50) NOT NULL,
  `medapellidos` varchar(50) NOT NULL,
  `medEspecialidad` varchar(50) NOT NULL,
  `medtelefono` char(15) NOT NULL,
  `medcorreo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`idMedico`, `medidentificacion`, `mednombres`, `medapellidos`, `medEspecialidad`, `medtelefono`, `medcorreo`) VALUES
(3, '0315196100112', 'Nasralla', 'perez', 'terapia', '99651587', 'lamador@gmailcom'),
(4, '0801198500556', 'cristiano', 'RONALDO', 'terapia', '98745236', 'CR7@GMAIL.COM'),
(5, '0801199915388', 'messi', 'GOAT', 'pediatria', '98744545668', 'GoatLeo@unah.hn');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `idPaciente` int(11) NOT NULL,
  `pacIdentificacion` char(15) NOT NULL,
  `pacNombre` varchar(50) NOT NULL,
  `pacApellidos` varchar(50) NOT NULL,
  `pacFechaNacimiento` date NOT NULL,
  `pacSexo` enum('Femenino','Masculino') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`idPaciente`, `pacIdentificacion`, `pacNombre`, `pacApellidos`, `pacFechaNacimiento`, `pacSexo`) VALUES
(1, '0315199400106', 'edgar', 'Amador', '1994-06-17', 'Masculino'),
(3, '0801199900112', 'juan carlos', 'Mendoza', '1999-12-08', 'Masculino');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(20) NOT NULL,
  `pass` varchar(200) DEFAULT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `Roll` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `pass`, `nombres`, `apellidos`, `Roll`) VALUES
(6, 'jorge', '6c3d38e697548832678da3a85f70b61115639a468d51313ad8d84e89950b13668015bbb77fe54ea862d360a96e64e020c601e6f1e2682abeb1642fafa511c9f9', 'Jorge Luis', 'Aviles', 'admin'),
(7, 'jose', 'c06897c409616c7eb3ab5ea028b2f971b2d63d066a40e44aea4e4ed36477582efa4b073a2e75c6b38d6c7d6af7f07db2329e3370e41202a742b19dd49df3c2d9', 'Jose', 'Lopez', 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`idcita`),
  ADD KEY `cithora` (`cithora`),
  ADD KEY `idPaciente` (`citPaciente`),
  ADD KEY `idMedico` (`citMedico`),
  ADD KEY `idConsultorio` (`citConsultorio`);

--
-- Indices de la tabla `consultorios`
--
ALTER TABLE `consultorios`
  ADD PRIMARY KEY (`idConsultorio`),
  ADD UNIQUE KEY `conNombre` (`conNombre`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`idespecialidad`),
  ADD UNIQUE KEY `espNombre` (`espNombre`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`idMedico`),
  ADD UNIQUE KEY `medidentificacion` (`medidentificacion`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`idPaciente`),
  ADD UNIQUE KEY `pacIdentificacion` (`pacIdentificacion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `idcita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `consultorios`
--
ALTER TABLE `consultorios`
  MODIFY `idConsultorio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `idespecialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `idMedico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `idPaciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
