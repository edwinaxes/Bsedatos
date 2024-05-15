-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-05-2024 a las 15:10:18
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
-- Base de datos: `final2`
--
CREATE DATABASE IF NOT EXISTS `final2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `final2`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `ActualizarCliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCliente` (IN `_id` INT, IN `_nombre` VARCHAR(255), IN `_direccion` VARCHAR(255), IN `_correo_electronico` VARCHAR(255), IN `_numero_telefono` VARCHAR(20))   BEGIN
    UPDATE clientes SET nombre = _nombre, direccion = _direccion, correo_electronico = _correo_electronico, numero_telefono = _numero_telefono WHERE id = _id;
END$$

DROP PROCEDURE IF EXISTS `BorrarCliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BorrarCliente` (IN `_id` INT)   BEGIN
    DELETE FROM clientes WHERE id = _id;
END$$

DROP PROCEDURE IF EXISTS `CrearCliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearCliente` (IN `_nombre` VARCHAR(255), IN `_direccion` VARCHAR(255), IN `_correo_electronico` VARCHAR(255), IN `_numero_telefono` VARCHAR(20))   BEGIN
    INSERT INTO clientes (nombre, direccion, correo_electronico, numero_telefono) VALUES (_nombre, _direccion, _correo_electronico, _numero_telefono);
END$$

DROP PROCEDURE IF EXISTS `LeerCliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LeerCliente` (IN `_id` INT)   BEGIN
    SELECT * FROM clientes WHERE id = _id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canchas`
--

DROP TABLE IF EXISTS `canchas`;
CREATE TABLE `canchas` (
  `id` int(11) NOT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `tamano` varchar(255) DEFAULT NULL,
  `tipo_superficie` varchar(255) DEFAULT NULL,
  `disponibilidad` tinyint(1) DEFAULT NULL,
  `precio_por_hora` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `correo_electronico` varchar(255) DEFAULT NULL,
  `numero_telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` VALUES
(2, 'edwin', 'cr2', 'Edwins@ejemplo.com', '3112');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

DROP TABLE IF EXISTS `reservas`;
CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `cancha_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `indumentaria` tinyint(1) DEFAULT NULL,
  `arbitraje` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_arbitraje`
--

DROP TABLE IF EXISTS `servicios_arbitraje`;
CREATE TABLE `servicios_arbitraje` (
  `id` int(11) NOT NULL,
  `reserva_id` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_indumentaria`
--

DROP TABLE IF EXISTS `servicios_indumentaria`;
CREATE TABLE `servicios_indumentaria` (
  `id` int(11) NOT NULL,
  `reserva_id` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `canchas`
--
ALTER TABLE `canchas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `cancha_id` (`cancha_id`);

--
-- Indices de la tabla `servicios_arbitraje`
--
ALTER TABLE `servicios_arbitraje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reserva_id` (`reserva_id`);

--
-- Indices de la tabla `servicios_indumentaria`
--
ALTER TABLE `servicios_indumentaria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reserva_id` (`reserva_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `canchas`
--
ALTER TABLE `canchas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios_arbitraje`
--
ALTER TABLE `servicios_arbitraje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios_indumentaria`
--
ALTER TABLE `servicios_indumentaria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`cancha_id`) REFERENCES `canchas` (`id`);

--
-- Filtros para la tabla `servicios_arbitraje`
--
ALTER TABLE `servicios_arbitraje`
  ADD CONSTRAINT `servicios_arbitraje_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`);

--
-- Filtros para la tabla `servicios_indumentaria`
--
ALTER TABLE `servicios_indumentaria`
  ADD CONSTRAINT `servicios_indumentaria_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
