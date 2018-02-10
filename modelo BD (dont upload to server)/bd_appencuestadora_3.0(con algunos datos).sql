-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: appencuestadora
-- ------------------------------------------------------
-- Server version	5.6.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `criteriosxencuesta`
--

DROP TABLE IF EXISTS `criteriosxencuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criteriosxencuesta` (
  `idCriteriosXEncuesta` int(11) NOT NULL AUTO_INCREMENT,
  `idEncuesta` int(11) NOT NULL,
  `pregunta` tinytext NOT NULL,
  `propuestoPor` int(11) DEFAULT NULL,
  `esDefinitivo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idCriteriosXEncuesta`),
  KEY `fk_criterios_encuesta_idx` (`idEncuesta`),
  KEY `fk_criterios_propuestopor_idx` (`propuestoPor`),
  CONSTRAINT `fk_criterios_encuesta` FOREIGN KEY (`idEncuesta`) REFERENCES `encuestas` (`idEncuestas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_criterios_propuestopor` FOREIGN KEY (`propuestoPor`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criteriosxencuesta`
--

LOCK TABLES `criteriosxencuesta` WRITE;
/*!40000 ALTER TABLE `criteriosxencuesta` DISABLE KEYS */;
/*!40000 ALTER TABLE `criteriosxencuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `idCurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `turno` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encuestas`
--

DROP TABLE IF EXISTS `encuestas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encuestas` (
  `idEncuestas` int(11) NOT NULL AUTO_INCREMENT,
  `creador` int(11) NOT NULL,
  `curso` int(11) DEFAULT NULL,
  `materia` int(11) NOT NULL,
  `etapaActual` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaFinEtapaActual` date NOT NULL,
  `cantMaxCriterios` int(11) DEFAULT NULL,
  `cantMaxVotosPorPersona` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEncuestas`),
  KEY `fk_encuesta_creador_idx` (`creador`),
  KEY `fk_encuesta_curso_idx` (`curso`),
  KEY `fk_encuesta_materia_idx` (`materia`),
  KEY `fk_encuesta_etapa_idx` (`etapaActual`),
  CONSTRAINT `fk_encuesta_creador` FOREIGN KEY (`creador`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_encuesta_curso` FOREIGN KEY (`curso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_encuesta_etapa` FOREIGN KEY (`etapaActual`) REFERENCES `etapas` (`idEtapas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_encuesta_materia` FOREIGN KEY (`materia`) REFERENCES `materias` (`idMaterias`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encuestas`
--

LOCK TABLES `encuestas` WRITE;
/*!40000 ALTER TABLE `encuestas` DISABLE KEYS */;
/*!40000 ALTER TABLE `encuestas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etapas`
--

DROP TABLE IF EXISTS `etapas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etapas` (
  `idEtapas` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idEtapas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapas`
--

LOCK TABLES `etapas` WRITE;
/*!40000 ALTER TABLE `etapas` DISABLE KEYS */;
/*!40000 ALTER TABLE `etapas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materias` (
  `idMaterias` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idMaterias`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (1,'Creatividad'),(2,'Big Data'),(3,'ARE'),(4,'DSI'),(5,'Inteligencia Aritficial'),(6,'Investigación Operativa'),(9,'Prueba'),(10,'Probando');
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `respuestasxcriterio`
--

DROP TABLE IF EXISTS `respuestasxcriterio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respuestasxcriterio` (
  `idRespuestasXCriterio` int(11) NOT NULL AUTO_INCREMENT,
  `idCriterioXEncuesta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `respuesta` int(11) NOT NULL,
  PRIMARY KEY (`idRespuestasXCriterio`),
  KEY `fk_respuestas_criterio_idx` (`idCriterioXEncuesta`),
  KEY `fk_respuestas_usuario_idx` (`idUsuario`),
  CONSTRAINT `fk_respuestas_criterio` FOREIGN KEY (`idCriterioXEncuesta`) REFERENCES `criteriosxencuesta` (`idCriteriosXEncuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuestas_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respuestasxcriterio`
--

LOCK TABLES `respuestasxcriterio` WRITE;
/*!40000 ALTER TABLE `respuestasxcriterio` DISABLE KEYS */;
/*!40000 ALTER TABLE `respuestasxcriterio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `idRoles` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idRoles`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(2,'Alumno'),(3,'Profesor');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `idUsuarios` int(11) NOT NULL AUTO_INCREMENT,
  `legajo` int(11) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `password` char(32) NOT NULL,
  `idRol` int(11) NOT NULL,
  PRIMARY KEY (`idUsuarios`),
  UNIQUE KEY `legajo_UNIQUE` (`legajo`),
  KEY `fk_usuario_rol_idx` (`idRol`),
  CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRoles`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,0,'admin','admin','admin','admin',1),(2,1,'test','test','test','test',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariosxencuesta`
--

DROP TABLE IF EXISTS `usuariosxencuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuariosxencuesta` (
  `idUsuariosXEncuesta` int(11) NOT NULL AUTO_INCREMENT,
  `idEncuesta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idUsuariosXEncuesta`),
  KEY `fk_userXEncuesta_encuesta_idx` (`idEncuesta`),
  KEY `fk_userXEncuesta_usuario_idx` (`idUsuario`),
  CONSTRAINT `fk_userXEncuesta_encuesta` FOREIGN KEY (`idEncuesta`) REFERENCES `encuestas` (`idEncuestas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_userXEncuesta_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariosxencuesta`
--

LOCK TABLES `usuariosxencuesta` WRITE;
/*!40000 ALTER TABLE `usuariosxencuesta` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuariosxencuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votosxcriterio`
--

DROP TABLE IF EXISTS `votosxcriterio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votosxcriterio` (
  `idVotosXCriterio` int(11) NOT NULL AUTO_INCREMENT,
  `idCriterioXEncuesta` int(11) NOT NULL,
  `idUsuarioVotante` int(11) NOT NULL,
  `idEtapaActual` int(11) NOT NULL,
  PRIMARY KEY (`idVotosXCriterio`),
  KEY `fk_votos_criterio_idx` (`idCriterioXEncuesta`),
  KEY `fk_votos_usuario_idx` (`idUsuarioVotante`),
  KEY `fk_votos_etapa_idx` (`idEtapaActual`),
  CONSTRAINT `fk_votos_criterio` FOREIGN KEY (`idCriterioXEncuesta`) REFERENCES `criteriosxencuesta` (`idCriteriosXEncuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_votos_etapa` FOREIGN KEY (`idEtapaActual`) REFERENCES `etapas` (`idEtapas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_votos_usuario` FOREIGN KEY (`idUsuarioVotante`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votosxcriterio`
--

LOCK TABLES `votosxcriterio` WRITE;
/*!40000 ALTER TABLE `votosxcriterio` DISABLE KEYS */;
/*!40000 ALTER TABLE `votosxcriterio` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-09 21:19:58
