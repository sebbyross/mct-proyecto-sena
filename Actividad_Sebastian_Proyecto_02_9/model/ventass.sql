-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-11-2024 a las 16:22:53
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ventass`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `identificacion` int(11) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` int(11) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `fechaNacimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `numFactura` int(11) NOT NULL,
  `fechacompra` date NOT NULL,
  `fechaentrega` date NOT NULL,
  `garantia` varchar(10) DEFAULT NULL,
  `formapago` varchar(50) NOT NULL,
  `observaciones` varchar(200) NOT NULL,
  `identificacion` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conductor`
--

CREATE TABLE `conductor` (
  `identificacion` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` int(11) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `foto` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codigoBarras` varchar(40) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `precio` int(11) NOT NULL,
  `fechaCaducidad` date NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `categoria` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transportador`
--

CREATE TABLE `transportador` (
  `placa` varchar(10) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `marca` varchar(20) NOT NULL,
  `empresa` varchar(30) NOT NULL,
  `identificacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE `vendedor` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(70) NOT NULL,
  `apellido` varchar(70) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `telefono` int(11) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `redesSociales` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`identificacion`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`numFactura`),
  ADD KEY `identificacion` (`identificacion`),
  ADD KEY `codigo` (`codigo`),
  ADD KEY `placa` (`placa`);

--
-- Indices de la tabla `conductor`
--
ALTER TABLE `conductor`
  ADD PRIMARY KEY (`identificacion`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigoBarras`);

--
-- Indices de la tabla `transportador`
--
ALTER TABLE `transportador`
  ADD PRIMARY KEY (`placa`),
  ADD KEY `identificacion` (`identificacion`);

--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`codigo`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`identificacion`) REFERENCES `cliente` (`identificacion`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`codigo`) REFERENCES `vendedor` (`codigo`),
  ADD CONSTRAINT `compra_ibfk_3` FOREIGN KEY (`placa`) REFERENCES `transportador` (`placa`);

--
-- Filtros para la tabla `transportador`
--
ALTER TABLE `transportador`
  ADD CONSTRAINT `transportador_ibfk_1` FOREIGN KEY (`identificacion`) REFERENCES `conductor` (`identificacion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
