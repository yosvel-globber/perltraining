-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ex7
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu0.14.04.1

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
-- Current Database: `ex7`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ex7` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ex7`;

--
-- Table structure for table `figure`
--

DROP TABLE IF EXISTS `figure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `figure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `color` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `figure`
--

LOCK TABLES `figure` WRITE;
/*!40000 ALTER TABLE `figure` DISABLE KEYS */;
/*!40000 ALTER TABLE `figure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point`
--

DROP TABLE IF EXISTS `point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_figure` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_point_1_idx` (`id_figure`),
  CONSTRAINT `fk_point_1` FOREIGN KEY (`id_figure`) REFERENCES `figure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point`
--

LOCK TABLES `point` WRITE;
/*!40000 ALTER TABLE `point` DISABLE KEYS */;
/*!40000 ALTER TABLE `point` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-05 10:25:32
