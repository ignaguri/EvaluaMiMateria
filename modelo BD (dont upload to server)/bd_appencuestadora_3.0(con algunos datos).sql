-- phpMyAdmin SQL Dump
-- version 4.7.8
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 09, 2018 at 06:00 PM
-- Server version: 5.7.21
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `appencuestadora`
--

-- --------------------------------------------------------

--
-- Table structure for table `criteriosxencuesta`
--

CREATE TABLE `criteriosxencuesta` (
  `idCriteriosXEncuesta` int(11) NOT NULL,
  `idEncuesta` int(11) NOT NULL,
  `pregunta` tinytext NOT NULL,
  `propuestoPor` int(11) DEFAULT NULL,
  `esDefinitivo` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `curso`
--

CREATE TABLE `curso` (
  `idCurso` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `turno` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `curso`
--

INSERT INTO `curso` (`idCurso`, `nombre`, `turno`) VALUES
(1, '5K1', 'Mañana'),
(2, '5K8', 'Tarde');

-- --------------------------------------------------------

--
-- Table structure for table `encuestas`
--

CREATE TABLE `encuestas` (
  `idEncuestas` int(11) NOT NULL,
  `creador` int(11) NOT NULL,
  `curso` int(11) DEFAULT NULL,
  `materia` int(11) NOT NULL,
  `etapaActual` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaFinEtapaActual` date DEFAULT NULL,
  `cantMaxCriterios` int(11) DEFAULT NULL,
  `cantMaxVotosPorPersona` int(11) DEFAULT NULL,
  `codigo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `encuestas`
--

INSERT INTO `encuestas` (`idEncuestas`, `creador`, `curso`, `materia`, `etapaActual`, `nombre`, `fechaCreacion`, `fechaFinEtapaActual`, `cantMaxCriterios`, `cantMaxVotosPorPersona`, `codigo`) VALUES
(1, 3, 2, 3, 2, 'Probando', '2018-03-03', '2018-03-15', 12, 2, 'Probando5k3'),
(2, 3, 1, 6, 1, 'Otra más', '2018-03-03', '2018-03-16', 23, 21, 'OtraMasChicos');

-- --------------------------------------------------------

--
-- Table structure for table `etapas`
--

CREATE TABLE `etapas` (
  `idEtapas` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `etapas`
--

INSERT INTO `etapas` (`idEtapas`, `nombre`) VALUES
(1, 'Creada'),
(2, 'Votacion Criterios'),
(3, 'Priorizacion'),
(4, 'Habilitada'),
(5, 'Cerrada');

-- --------------------------------------------------------

--
-- Table structure for table `materias`
--

CREATE TABLE `materias` (
  `idMaterias` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `materias`
--

INSERT INTO `materias` (`idMaterias`, `nombre`) VALUES
(1, 'Creatividad'),
(2, 'Big Data'),
(3, 'ARE'),
(4, 'DSI'),
(5, 'Inteligencia Aritficial'),
(6, 'Investigación Operativa');

-- --------------------------------------------------------

--
-- Table structure for table `respuestasxcriterio`
--

CREATE TABLE `respuestasxcriterio` (
  `idRespuestasXCriterio` int(11) NOT NULL,
  `idCriterioXEncuesta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `respuesta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `idRoles` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`idRoles`, `nombre`) VALUES
(1, 'admin'),
(2, 'Alumno'),
(3, 'Profesor');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuarios` int(11) NOT NULL,
  `legajo` int(11) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `password` char(32) NOT NULL,
  `idRol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`idUsuarios`, `legajo`, `apellido`, `nombre`, `mail`, `password`, `idRol`) VALUES
(1, 0, 'admin', 'admin', 'admin', 'admin', 1),
(2, 1, 'Alumno', 'El', 'alumno', 'admin', 2),
(3, 2, 'Profe', 'Mr.', 'profe', 'admin', 3);

-- --------------------------------------------------------

--
-- Table structure for table `usuariosxencuesta`
--

CREATE TABLE `usuariosxencuesta` (
  `idUsuariosXEncuesta` int(11) NOT NULL,
  `idEncuesta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `votosxcriterio`
--

CREATE TABLE `votosxcriterio` (
  `idVotosXCriterio` int(11) NOT NULL,
  `idCriterioXEncuesta` int(11) NOT NULL,
  `idUsuarioVotante` int(11) NOT NULL,
  `idEtapaActual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `criteriosxencuesta`
--
ALTER TABLE `criteriosxencuesta`
  ADD PRIMARY KEY (`idCriteriosXEncuesta`),
  ADD KEY `fk_criterios_encuesta_idx` (`idEncuesta`),
  ADD KEY `fk_criterios_propuestopor_idx` (`propuestoPor`);

--
-- Indexes for table `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`idCurso`);

--
-- Indexes for table `encuestas`
--
ALTER TABLE `encuestas`
  ADD PRIMARY KEY (`idEncuestas`),
  ADD KEY `fk_encuesta_creador_idx` (`creador`),
  ADD KEY `fk_encuesta_curso_idx` (`curso`),
  ADD KEY `fk_encuesta_materia_idx` (`materia`),
  ADD KEY `fk_encuesta_etapa_idx` (`etapaActual`);

--
-- Indexes for table `etapas`
--
ALTER TABLE `etapas`
  ADD PRIMARY KEY (`idEtapas`);

--
-- Indexes for table `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`idMaterias`);

--
-- Indexes for table `respuestasxcriterio`
--
ALTER TABLE `respuestasxcriterio`
  ADD PRIMARY KEY (`idRespuestasXCriterio`),
  ADD KEY `fk_respuestas_criterio_idx` (`idCriterioXEncuesta`),
  ADD KEY `fk_respuestas_usuario_idx` (`idUsuario`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRoles`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuarios`),
  ADD UNIQUE KEY `legajo_UNIQUE` (`legajo`),
  ADD KEY `fk_usuario_rol_idx` (`idRol`);

--
-- Indexes for table `usuariosxencuesta`
--
ALTER TABLE `usuariosxencuesta`
  ADD PRIMARY KEY (`idUsuariosXEncuesta`),
  ADD KEY `fk_userXEncuesta_encuesta_idx` (`idEncuesta`),
  ADD KEY `fk_userXEncuesta_usuario_idx` (`idUsuario`);

--
-- Indexes for table `votosxcriterio`
--
ALTER TABLE `votosxcriterio`
  ADD PRIMARY KEY (`idVotosXCriterio`),
  ADD KEY `fk_votos_criterio_idx` (`idCriterioXEncuesta`),
  ADD KEY `fk_votos_usuario_idx` (`idUsuarioVotante`),
  ADD KEY `fk_votos_etapa_idx` (`idEtapaActual`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `criteriosxencuesta`
--
ALTER TABLE `criteriosxencuesta`
  MODIFY `idCriteriosXEncuesta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `curso`
--
ALTER TABLE `curso`
  MODIFY `idCurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `encuestas`
--
ALTER TABLE `encuestas`
  MODIFY `idEncuestas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `etapas`
--
ALTER TABLE `etapas`
  MODIFY `idEtapas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `materias`
--
ALTER TABLE `materias`
  MODIFY `idMaterias` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `respuestasxcriterio`
--
ALTER TABLE `respuestasxcriterio`
  MODIFY `idRespuestasXCriterio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `idRoles` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuariosxencuesta`
--
ALTER TABLE `usuariosxencuesta`
  MODIFY `idUsuariosXEncuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `votosxcriterio`
--
ALTER TABLE `votosxcriterio`
  MODIFY `idVotosXCriterio` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `criteriosxencuesta`
--
ALTER TABLE `criteriosxencuesta`
  ADD CONSTRAINT `fk_criterios_encuesta` FOREIGN KEY (`idEncuesta`) REFERENCES `encuestas` (`idEncuestas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_criterios_propuestopor` FOREIGN KEY (`propuestoPor`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `encuestas`
--
ALTER TABLE `encuestas`
  ADD CONSTRAINT `fk_encuesta_creador` FOREIGN KEY (`creador`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_encuesta_curso` FOREIGN KEY (`curso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_encuesta_etapa` FOREIGN KEY (`etapaActual`) REFERENCES `etapas` (`idEtapas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_encuesta_materia` FOREIGN KEY (`materia`) REFERENCES `materias` (`idMaterias`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `respuestasxcriterio`
--
ALTER TABLE `respuestasxcriterio`
  ADD CONSTRAINT `fk_respuestas_criterio` FOREIGN KEY (`idCriterioXEncuesta`) REFERENCES `criteriosxencuesta` (`idCriteriosXEncuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_respuestas_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRoles`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuariosxencuesta`
--
ALTER TABLE `usuariosxencuesta`
  ADD CONSTRAINT `fk_userXEncuesta_encuesta` FOREIGN KEY (`idEncuesta`) REFERENCES `encuestas` (`idEncuestas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_userXEncuesta_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `votosxcriterio`
--
ALTER TABLE `votosxcriterio`
  ADD CONSTRAINT `fk_votos_criterio` FOREIGN KEY (`idCriterioXEncuesta`) REFERENCES `criteriosxencuesta` (`idCriteriosXEncuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_votos_etapa` FOREIGN KEY (`idEtapaActual`) REFERENCES `etapas` (`idEtapas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_votos_usuario` FOREIGN KEY (`idUsuarioVotante`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
