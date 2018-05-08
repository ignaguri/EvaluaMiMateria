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
-- Dumping data for table `criteriosxencuesta`
--

LOCK TABLES `criteriosxencuesta` WRITE;
/*!40000 ALTER TABLE `criteriosxencuesta` DISABLE KEYS */;
INSERT INTO `criteriosxencuesta` VALUES (1,1,'Un criterio de prueba',2,1),(2,1,'Otro criterio para votar',2,1),(3,1,'otrrrrrrrrra',2,1),(4,1,'daaaaaaaaale',2,0),(5,2,'Unnnn mega criterio',2,0),(8,2,'OOOOOOOOOtro criterio por aquí',2,0),(9,2,'Que se yo Que se yo Que se yo Que se yo Que se yo Que se yo',2,0),(11,1,'hola manga de hijos de puta',2,0);
/*!40000 ALTER TABLE `criteriosxencuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'5K1','Mañana'),(2,'5K8','Tarde');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `encuestas`
--

LOCK TABLES `encuestas` WRITE;
/*!40000 ALTER TABLE `encuestas` DISABLE KEYS */;
INSERT INTO `encuestas` VALUES (1,3,2,3,4,'Probando','2018-03-03','2018-04-28',7,2,'Probando5k3'),(2,3,1,6,2,'Otra más','2018-03-03','2018-03-31',6,2,'OtraMasChicos');
/*!40000 ALTER TABLE `encuestas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `etapas`
--

LOCK TABLES `etapas` WRITE;
/*!40000 ALTER TABLE `etapas` DISABLE KEYS */;
INSERT INTO `etapas` VALUES (1,'Creada'),(2,'Votacion Criterios'),(3,'Priorizacion'),(4,'Habilitada'),(5,'Cerrada');
/*!40000 ALTER TABLE `etapas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (1,'Creatividad'),(2,'Big Data'),(3,'ARE'),(4,'DSI'),(5,'Inteligencia Aritficial'),(6,'Investigación Operativa');
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `respuestasxcriterio`
--

LOCK TABLES `respuestasxcriterio` WRITE;
/*!40000 ALTER TABLE `respuestasxcriterio` DISABLE KEYS */;
INSERT INTO `respuestasxcriterio` VALUES (1,1,2,'2018-04-28',5,17),(2,2,2,'2018-04-28',1,17),(4,3,3,'2018-04-28',5,17),(7,3,2,'2018-04-28',3,17);
/*!40000 ALTER TABLE `respuestasxcriterio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(2,'Alumno'),(3,'Profesor');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,0,'admin','admin','admin','admin',1),(2,1,'Alumno','El','alumno','admin',2),(3,2,'Profe','Mr.','profe','admin',3);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuariosxencuesta`
--

LOCK TABLES `usuariosxencuesta` WRITE;
/*!40000 ALTER TABLE `usuariosxencuesta` DISABLE KEYS */;
INSERT INTO `usuariosxencuesta` VALUES (1,1,2),(2,2,2);
/*!40000 ALTER TABLE `usuariosxencuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `votosxcriterio`
--

LOCK TABLES `votosxcriterio` WRITE;
/*!40000 ALTER TABLE `votosxcriterio` DISABLE KEYS */;
INSERT INTO `votosxcriterio` VALUES (84,5,2,2),(85,9,2,2),(90,1,2,2),(91,11,2,2),(92,1,2,3),(93,2,2,3);
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

-- Dump completed on 2018-04-28 14:04:14
