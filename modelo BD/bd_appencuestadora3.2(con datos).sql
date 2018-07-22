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
  `criterio` tinytext NOT NULL,
  `propuestoPor` int(11) DEFAULT NULL,
  `esDefinitivo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idCriteriosXEncuesta`),
  KEY `fk_criterios_encuesta_idx` (`idEncuesta`),
  KEY `fk_criterios_propuestopor_idx` (`propuestoPor`),
  CONSTRAINT `fk_criterios_encuesta` FOREIGN KEY (`idEncuesta`) REFERENCES `encuestas` (`idEncuestas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_criterios_propuestopor` FOREIGN KEY (`propuestoPor`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criteriosxencuesta`
--

LOCK TABLES `criteriosxencuesta` WRITE;
/*!40000 ALTER TABLE `criteriosxencuesta` DISABLE KEYS */;
INSERT INTO `criteriosxencuesta` VALUES (1,1,'Un criterio de prueba',2,1),(2,1,'Otro criterio para votar',2,1),(3,1,'otrrrrrrrrra',2,1),(4,1,'daaaaaaaaale',2,0),(5,2,'Dinámica de la clase',2,1),(8,2,'Relacion de los temas con la profesión',2,1),(9,2,'Material de estudio',2,1),(11,1,'holiiiiiiiiiiiiiiiiiiiiiis',2,0),(13,2,'El profesor explica muy bien las clases',2,0),(14,2,'Las clases son puro PowerPoint',4,0),(15,4,'Dinamica de la clase',2,1),(16,4,'Material de estudio',2,1),(17,4,'Puros powerpoint',2,1),(18,4,'Relacion de los temas con la profesión',2,1),(19,3,'El primer criterio de esta encuesta',2,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'5K1','Mañana'),(2,'5K8','Tarde');
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
  `fechaFinEtapaActual` date DEFAULT NULL,
  `cantMaxCriterios` int(11) DEFAULT NULL,
  `cantMaxVotosPorPersona` int(11) DEFAULT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idEncuestas`),
  KEY `fk_encuesta_creador_idx` (`creador`),
  KEY `fk_encuesta_curso_idx` (`curso`),
  KEY `fk_encuesta_materia_idx` (`materia`),
  KEY `fk_encuesta_etapa_idx` (`etapaActual`),
  CONSTRAINT `fk_encuesta_creador` FOREIGN KEY (`creador`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_encuesta_curso` FOREIGN KEY (`curso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_encuesta_etapa` FOREIGN KEY (`etapaActual`) REFERENCES `etapas` (`idEtapas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_encuesta_materia` FOREIGN KEY (`materia`) REFERENCES `materias` (`idMaterias`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encuestas`
--

LOCK TABLES `encuestas` WRITE;
/*!40000 ALTER TABLE `encuestas` DISABLE KEYS */;
INSERT INTO `encuestas` VALUES (1,3,2,3,4,'Probando','2018-03-03','2018-04-28',7,2,'Probando5k3'),(2,3,1,6,3,'Otra más','2018-03-03','2018-07-29',6,3,'OtraMasChicos'),(3,3,1,5,2,'IAr 5k1','2018-05-16','2018-07-29',7,3,'iar'),(4,5,1,1,4,'Demo','2018-05-16','2018-07-18',7,3,'codigo');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapas`
--

LOCK TABLES `etapas` WRITE;
/*!40000 ALTER TABLE `etapas` DISABLE KEYS */;
INSERT INTO `etapas` VALUES (1,'Creada'),(2,'Votacion Criterios'),(3,'Priorizacion'),(4,'Habilitada'),(5,'Cerrada');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (1,'Creatividad'),(2,'Big Data'),(3,'ARE'),(4,'DSI'),(5,'Inteligencia Artificial'),(6,'Investigación Operativa');
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
  `fecha` date DEFAULT NULL,
  `respuesta` int(11) NOT NULL,
  `semana` int(11) NOT NULL,
  PRIMARY KEY (`idRespuestasXCriterio`),
  KEY `fk_respuestas_criterio_idx` (`idCriterioXEncuesta`),
  KEY `fk_respuestas_usuario_idx` (`idUsuario`),
  CONSTRAINT `fk_respuestas_criterio` FOREIGN KEY (`idCriterioXEncuesta`) REFERENCES `criteriosxencuesta` (`idCriteriosXEncuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuestas_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respuestasxcriterio`
--

LOCK TABLES `respuestasxcriterio` WRITE;
/*!40000 ALTER TABLE `respuestasxcriterio` DISABLE KEYS */;
INSERT INTO `respuestasxcriterio` VALUES (1,1,2,'2018-04-28',5,17),(2,2,2,'2018-04-28',1,17),(4,3,3,'2018-04-28',5,17),(7,3,2,'2018-04-28',3,17),(8,1,2,'2018-05-05',3,18),(9,2,2,'2018-05-01',3,18),(10,3,2,'2018-05-01',1,18),(11,1,3,'2018-04-28',5,17),(12,2,3,'2018-04-28',2,17),(13,3,3,'2018-04-28',3,17),(14,1,2,'2018-05-16',4,20),(15,15,2,'2018-05-16',1,20),(16,16,2,'2018-05-16',1,20),(17,17,2,'2018-05-16',1,20),(18,18,2,'2018-05-16',1,20),(19,3,2,'2018-05-16',4,20),(20,2,2,'2018-05-16',3,20);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,0,'admin','admin','admin','admin',1),(2,1,'Falso','UnAlumno','alumno@fake.com','admin',2),(3,2,'NoCuevas','Juan','juan@nosoycuevas.com','admin',3),(4,12345,'Perez','Juan','juan@perez.com','admin',2),(5,123,'Cuevas','Juan Carlos','1234@sistemas.frc.utn.edu.ar','123456',3),(6,303456,'Mana','Franco','otroprofe@utn.com.ar','123456',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariosxencuesta`
--

LOCK TABLES `usuariosxencuesta` WRITE;
/*!40000 ALTER TABLE `usuariosxencuesta` DISABLE KEYS */;
INSERT INTO `usuariosxencuesta` VALUES (1,1,2),(2,2,2),(3,2,4),(4,4,2),(5,3,2);
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
  `priorizacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVotosXCriterio`),
  KEY `fk_votos_criterio_idx` (`idCriterioXEncuesta`),
  KEY `fk_votos_usuario_idx` (`idUsuarioVotante`),
  KEY `fk_votos_etapa_idx` (`idEtapaActual`),
  CONSTRAINT `fk_votos_criterio` FOREIGN KEY (`idCriterioXEncuesta`) REFERENCES `criteriosxencuesta` (`idCriteriosXEncuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_votos_etapa` FOREIGN KEY (`idEtapaActual`) REFERENCES `etapas` (`idEtapas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_votos_usuario` FOREIGN KEY (`idUsuarioVotante`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votosxcriterio`
--

LOCK TABLES `votosxcriterio` WRITE;
/*!40000 ALTER TABLE `votosxcriterio` DISABLE KEYS */;
INSERT INTO `votosxcriterio` VALUES (90,1,2,2,NULL),(91,11,2,2,NULL),(100,5,4,2,NULL),(101,14,4,2,NULL),(102,13,2,2,NULL),(103,5,2,2,NULL),(107,15,2,2,NULL),(108,18,2,2,NULL),(109,16,2,2,NULL),(123,5,2,3,2),(124,8,2,3,3),(125,5,4,3,3),(126,9,4,3,1);
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

-- Dump completed on 2018-07-22 19:50:14
