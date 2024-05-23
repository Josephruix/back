-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `idEquipos` int(11) NOT NULL,
  `Marca` varchar(45) DEFAULT NULL,
  `Descripcion` varchar(45) DEFAULT NULL,
  `Estado` enum('uso','Guardado','Mantenimiento') DEFAULT NULL,
  `Empresa` enum('Bs','Politecnico') DEFAULT NULL,
  `Tipo_de_Equipo` enum('Pantalla','Mouse','Cpu','Teclado') DEFAULT NULL,
  `fkidsalas` int(11) DEFAULT NULL,
  `Serial` varchar(45) DEFAULT NULL,
  `img` blob DEFAULT NULL,
  PRIMARY KEY (`idEquipos`),
  KEY `Fk_Salas_Equipos_idx` (`fkidsalas`),
  CONSTRAINT `Fk_Salas_Equipos` FOREIGN KEY (`fkidsalas`) REFERENCES `salas` (`idsalas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1,'Dell','Maquina uno','uso','Bs','Cpu',1,'54',NULL),(2,'hP','maquina2','Guardado','','',1,'90',NULL),(3,'HP','maquina3','uso','Bs','Cpu',1,'80',NULL),(4,'Dell','aafafafa','Guardado','Bs','Cpu',1,'64',NULL),(5,'Hp','aafafafa','uso','Bs','Pantalla',1,'164',NULL),(6,'Hp','aafafafa','uso','Bs','Mouse',1,'20',NULL);
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipos_eventos`
--

DROP TABLE IF EXISTS `equipos_eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos_eventos` (
  `idMueven` int(11) NOT NULL AUTO_INCREMENT,
  `ideventos2` int(11) DEFAULT NULL,
  `idequipos` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMueven`),
  KEY `id_eqipos_eventos_idx` (`idequipos`),
  KEY `id_eventos_equipos_idx` (`ideventos2`),
  CONSTRAINT `id_eqipos_eventos` FOREIGN KEY (`idequipos`) REFERENCES `equipos` (`idEquipos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_eventos_equipos` FOREIGN KEY (`ideventos2`) REFERENCES `eventos` (`ideventos`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos_eventos`
--

LOCK TABLES `equipos_eventos` WRITE;
/*!40000 ALTER TABLE `equipos_eventos` DISABLE KEYS */;
INSERT INTO `equipos_eventos` VALUES (1,1,1);
/*!40000 ALTER TABLE `equipos_eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventos` (
  `ideventos` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  PRIMARY KEY (`ideventos`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES (1,'2024-01-24','El evento ocurrido es de fallo del sitema operativo por eso se hizo cambio del equipo'),(2,'0000-00-00','\'czczczczczczc\''),(3,'2024-07-24','czczczczczczc'),(4,'2024-06-23','czczczczczczc'),(5,'2024-04-24','czczczczczczc'),(6,'2024-08-24','czczczczczczc'),(7,'2024-08-24','czczczczczczc'),(8,'2024-09-24','czczczczczczc'),(9,'2024-09-24','czczczczczczc'),(10,'2024-12-12','czczczczczczc'),(11,'2024-06-20','czczczczczczc'),(12,'2024-05-16','czczczczczczc'),(13,'2024-05-14','czczczczczczc');
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salas`
--

DROP TABLE IF EXISTS `salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salas` (
  `idsalas` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) DEFAULT NULL,
  `ubicacion` varchar(45) DEFAULT NULL,
  `N-PR` int(11) DEFAULT NULL,
  `N-PE` int(11) DEFAULT NULL,
  `Capacidad_de_Equipos` varchar(45) DEFAULT NULL,
  `Equipos_en_sala` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsalas`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas`
--

LOCK TABLES `salas` WRITE;
/*!40000 ALTER TABLE `salas` DISABLE KEYS */;
INSERT INTO `salas` VALUES (1,'Icaro','Segundo piso',18,20,'18',8),(2,'Poseidon','Segundo Piso',25,NULL,'25',10);
/*!40000 ALTER TABLE `salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salas_enventos`
--

DROP TABLE IF EXISTS `salas_enventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salas_enventos` (
  `idReorganizan` int(11) NOT NULL AUTO_INCREMENT,
  `idsalas` int(11) DEFAULT NULL,
  `ideventos` int(11) DEFAULT NULL,
  PRIMARY KEY (`idReorganizan`),
  KEY `id_eventos_salasfk_idx` (`ideventos`),
  KEY `id_salas_eventossfk_idx` (`idsalas`),
  CONSTRAINT `id_eventos_salasfk` FOREIGN KEY (`ideventos`) REFERENCES `eventos` (`ideventos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_salas_eventossfk` FOREIGN KEY (`idsalas`) REFERENCES `salas` (`idsalas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas_enventos`
--

LOCK TABLES `salas_enventos` WRITE;
/*!40000 ALTER TABLE `salas_enventos` DISABLE KEYS */;
INSERT INTO `salas_enventos` VALUES (1,1,1);
/*!40000 ALTER TABLE `salas_enventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idusuarios` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) DEFAULT NULL,
  `Correo` varchar(45) DEFAULT NULL,
  `Contraseña` varchar(45) DEFAULT NULL,
  `Rol` enum('admind','soporte','lector') DEFAULT NULL,
  PRIMARY KEY (`idusuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Joseph','Josephruix@gmail.com','12345','soporte'),(2,'carlos','carlos@gamil.com','13245','admind'),(17,'Luz Marina Nieto','12345','luzmarina@gmail.com','soporte'),(18,'Luz Marina Nieto','12345','luzmarina@gmail.com','soporte'),(19,'Joseph','josephruix@gmail.com','12345','lector'),(20,'oscar','josephruix@gmail.com','12345','soporte'),(21,'Joseph','josephruix@gmail.com','12345','soporte'),(22,'Joseph','josephruix@gmail.com','12345','soporte'),(23,'Joseph','josephruix@gmail.com','12345','soporte'),(24,'Joseph','josephruix@gmail.com','12345','soporte'),(25,'Joseph','josephruix@gmail.com','12345','soporte'),(26,'Joseph','josephruix@gmail.com','12345','admind'),(27,'Joseph','josephruix@gmail.com','12345','soporte'),(28,'','','',''),(29,'luis','luislaiton@gmail.com','123456','lector');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios-equipos`
--

DROP TABLE IF EXISTS `usuarios-equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios-equipos` (
  `idAdministracion` int(11) NOT NULL AUTO_INCREMENT,
  `idusuarios` int(11) DEFAULT NULL,
  `idEquipos` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAdministracion`),
  KEY `Fk_Equipos_Usuarios_Equipos_idx` (`idEquipos`),
  KEY `F_Usuarios_Equipos_Usuarios_idx` (`idusuarios`),
  CONSTRAINT `F_Usuarios_Equipos_Usuarios` FOREIGN KEY (`idusuarios`) REFERENCES `usuarios` (`idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Fk_Equipos_Usuarios_Equipos` FOREIGN KEY (`idEquipos`) REFERENCES `equipos` (`idEquipos`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios-equipos`
--

LOCK TABLES `usuarios-equipos` WRITE;
/*!40000 ALTER TABLE `usuarios-equipos` DISABLE KEYS */;
INSERT INTO `usuarios-equipos` VALUES (1,1,1);
/*!40000 ALTER TABLE `usuarios-equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_eventos`
--

DROP TABLE IF EXISTS `usuarios_eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_eventos` (
  `idRealizan` int(11) NOT NULL AUTO_INCREMENT,
  `idusuariofk` int(11) DEFAULT NULL,
  `ideventofk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRealizan`),
  KEY `Fk_Usuarios_Eventos_idx` (`ideventofk`),
  KEY `Fk_Eventos_Usuarios` (`idusuariofk`),
  CONSTRAINT `Fk_Eventos_Usuarios` FOREIGN KEY (`idusuariofk`) REFERENCES `usuarios` (`idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Fk_Usuarios_Eventos` FOREIGN KEY (`ideventofk`) REFERENCES `eventos` (`ideventos`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_eventos`
--

LOCK TABLES `usuarios_eventos` WRITE;
/*!40000 ALTER TABLE `usuarios_eventos` DISABLE KEYS */;
INSERT INTO `usuarios_eventos` VALUES (1,1,1);
/*!40000 ALTER TABLE `usuarios_eventos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-23 11:24:23
