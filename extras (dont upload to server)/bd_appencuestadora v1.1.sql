CREATE DATABASE  IF NOT EXISTS `appencuestadora` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `appencuestadora`;
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
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL,
  `turno` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encuesta`
--

DROP TABLE IF EXISTS `encuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encuesta` (
  `id_encuesta` int(11) NOT NULL,
  `nombre` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_encuesta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encuestaxmateriaxcursoxusuario`
--

DROP TABLE IF EXISTS `encuestaxmateriaxcursoxusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encuestaxmateriaxcursoxusuario` (
  `id_encuesta` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `legajo_usuario` int(11) NOT NULL,
  `fechaCreacion` datetime NOT NULL,
  `cantidadCriterios` int(11) NOT NULL,
  `cantidadVotos` int(11) NOT NULL,
  `fechaFinEtapa2` datetime NOT NULL,
  `fechaFinEtapa1` datetime DEFAULT NULL,
  `criteriosAVotar` varchar(45) DEFAULT NULL,
  `preguntasDefinidas` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_materia`,`id_curso`,`legajo_usuario`,`fechaCreacion`,`id_encuesta`),
  KEY `fk_EncuestaXMateriaXCursoXUsuario_Materia1_idx` (`id_materia`),
  KEY `fk_EncuestaXMateriaXCursoXUsuario_Curso1_idx` (`id_curso`),
  KEY `fk_EncuestaXMateriaXCursoXUsuario_Usuario1_idx` (`legajo_usuario`),
  KEY `fk_EncuestaXMateriaXCursoXUsuario_Encuesta_idx` (`id_encuesta`),
  CONSTRAINT `fk_EncuestaXMateriaXCursoXUsuario_Curso1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXMateriaXCursoXUsuario_Encuesta` FOREIGN KEY (`id_encuesta`) REFERENCES `encuesta` (`id_encuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXMateriaXCursoXUsuario_Materia1` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXMateriaXCursoXUsuario_Usuario` FOREIGN KEY (`legajo_usuario`) REFERENCES `usuario` (`legajo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encuestaxsemana`
--

DROP TABLE IF EXISTS `encuestaxsemana`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encuestaxsemana` (
  `id_encuesta` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `legajo_usuario` int(11) NOT NULL,
  `fechaInicio` datetime DEFAULT NULL,
  `fechaFin` datetime DEFAULT NULL,
  `totalVotosPreguntas` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_encuesta`,`id_materia`,`id_curso`,`legajo_usuario`),
  KEY `fk_EncuestaXSemana_Encuesta1_idx` (`id_encuesta`),
  KEY `fk_EncuestaXSemana_Materia1_idx` (`id_materia`),
  KEY `fk_EncuestaXSemana_Curso1_idx` (`id_curso`),
  KEY `fk_EncuestaXSemana_Usuario_idx` (`legajo_usuario`),
  CONSTRAINT `fk_EncuestaXSemana_Curso1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXSemana_Encuesta1` FOREIGN KEY (`id_encuesta`) REFERENCES `encuesta` (`id_encuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXSemana_Materia1` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXSemana_Usuario` FOREIGN KEY (`legajo_usuario`) REFERENCES `usuario` (`legajo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `materia`
--

DROP TABLE IF EXISTS `materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materia` (
  `id_materia` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `legajo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL COMMENT '	',
  `apellido` varchar(45) NOT NULL,
  `mail` varchar(45) DEFAULT NULL,
  `contrasena` varchar(45) NOT NULL,
  `id_rol` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `legajo_UNIQUE` (`legajo`),
  KEY `fk_Usuario_Rol1_idx` (`id_rol`),
  CONSTRAINT `fk_Usuario_Rol1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarioxencuesta`
--

DROP TABLE IF EXISTS `usuarioxencuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarioxencuesta` (
  `id_encuesta` int(11) NOT NULL,
  `legajo_usuario` int(11) NOT NULL,
  `fechaencuesta` datetime DEFAULT NULL,
  `criteriopropuesto` varchar(45) DEFAULT NULL,
  `votoxcriterioxsemana` int(11) DEFAULT NULL,
  PRIMARY KEY (`legajo_usuario`,`id_encuesta`),
  KEY `fk_UsuarioXEncuesta_Encuesta1_idx` (`id_encuesta`),
  KEY `fk_UsuarioXEncuesta_Usuario1_idx` (`legajo_usuario`),
  CONSTRAINT `fk_UsuarioXEncuesta_Encuesta` FOREIGN KEY (`id_encuesta`) REFERENCES `encuesta` (`id_encuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_UsuarioXEncuesta_Usuario` FOREIGN KEY (`legajo_usuario`) REFERENCES `usuario` (`legajo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-04 20:47:04
