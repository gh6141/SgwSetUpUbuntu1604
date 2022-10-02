-- MySQL dump 10.13  Distrib 5.5.25, for Win64 (x86)
--
-- Host: localhost    Database: skt
-- ------------------------------------------------------
-- Server version	5.5.25

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
-- Table structure for table `groupname`
--

DROP TABLE IF EXISTS `groupname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupname` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `member` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupname`
--

LOCK TABLES `groupname` WRITE;
/*!40000 ALTER TABLE `groupname` DISABLE KEYS */;
INSERT INTO `groupname` VALUES (2,'グループ２','1,2,8'),(4,'aa','1,2,8'),(5,'f','9,8');
/*!40000 ALTER TABLE `groupname` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `henko`
--

DROP TABLE IF EXISTS `henko`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `henko` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jikan` int(3) unsigned DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `class` varchar(20) DEFAULT NULL,
  `kyoka` varchar(10) DEFAULT NULL,
  `tanto` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `henko`
--

LOCK TABLES `henko` WRITE;
/*!40000 ALTER TABLE `henko` DISABLE KEYS */;
INSERT INTO `henko` VALUES (1,1,'2014/12/03','sxxd','ssssssss','ss');
/*!40000 ALTER TABLE `henko` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kairan`
--

DROP TABLE IF EXISTS `kairan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kairan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `msg` text,
  `date` varchar(45) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `hyoji` text,
  `tenpu` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kairan`
--

LOCK TABLES `kairan` WRITE;
/*!40000 ALTER TABLE `kairan` DISABLE KEYS */;
INSERT INTO `kairan` VALUES (86,'user','ttttttttttt','tttttt<strong><font style=\"background-color: green;\">ttttttt</font></strong>\n<img alt=\"../tenpu/kimg/20160220222141_P1300587.JPG\" src=\"../tenpu/kimg/20160220222141_P1300587.JPG\">','2016/02/20 2221','user','9,1,2,8',''),(87,'2ban','d','d\n<img src=\"../tenpu/kimg/20160409141909_PC127167.JPG\" alt=\"../tenpu/kimg/20160409141909_PC127167.JPG\">','2016/04/09 1419','2ban','2,9,1,8','<N>'),(88,'2ban','s','s','2016/04/09 1521','2ban','2,9,1,8','<N>');
/*!40000 ALTER TABLE `kairan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kairanlog`
--

DROP TABLE IF EXISTS `kairanlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kairanlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kairanid` varchar(10) DEFAULT NULL,
  `shokuinid` varchar(10) DEFAULT NULL,
  `kidoku` varchar(20) DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kairanlog`
--

LOCK TABLES `kairanlog` WRITE;
/*!40000 ALTER TABLE `kairanlog` DISABLE KEYS */;
INSERT INTO `kairanlog` VALUES (202,'86','9','既読','2016/02/20'),(203,'86','2','既読','2016/04/02'),(204,'87','2','既読','2016/04/09'),(205,'88','2','既読','2016/04/09');
/*!40000 ALTER TABLE `kairanlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keijiban`
--

DROP TABLE IF EXISTS `keijiban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keijiban` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `msg` text,
  `kikan_s` varchar(20) DEFAULT NULL,
  `kikan_e` varchar(20) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `tenpu` text,
  `user` varchar(20) DEFAULT NULL,
  `userid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keijiban`
--

LOCK TABLES `keijiban` WRITE;
/*!40000 ALTER TABLE `keijiban` DISABLE KEYS */;
INSERT INTO `keijiban` VALUES (1,'user','test','2016/04/23','2016/05/02','test','<N>','user','9');
/*!40000 ALTER TABLE `keijiban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link`
--

DROP TABLE IF EXISTS `link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(100) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `other` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link`
--

LOCK TABLES `link` WRITE;
/*!40000 ALTER TABLE `link` DISABLE KEYS */;
INSERT INTO `link` VALUES (1,'testxxxxxxx','http://localhost:8080/',NULL);
/*!40000 ALTER TABLE `link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `past_keijiban`
--

DROP TABLE IF EXISTS `past_keijiban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `past_keijiban` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `msg` text,
  `kikan_s` varchar(20) DEFAULT NULL,
  `kikan_e` varchar(20) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `tenpu` text,
  `user` varchar(20) DEFAULT NULL,
  `userid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `past_keijiban`
--

LOCK TABLES `past_keijiban` WRITE;
/*!40000 ALTER TABLE `past_keijiban` DISABLE KEYS */;
INSERT INTO `past_keijiban` VALUES (78,'user','s\n<img alt=\"../tenpu/oimg/20160206213341_月山麓植物.JPG\" src=\"../tenpu/oimg/20160206213341_月山麓植物.JPG\">','2016/02/06','2016/02/15','s','<N>','user','9'),(79,'user','t\n<img alt=\"../tenpu/oimg/20160220222014_P1300587.JPG\" src=\"../tenpu/oimg/20160220222014_P1300587.JPG\"><img alt=\"../tenpu/oimg/20160220222039_P1300592.JPG\" src=\"../tenpu/oimg/20160220222039_P1300592.JPG\">','2016/02/20','2016/02/29','t','<N>','user','9'),(80,'2ban','test\n','2016/04/02','2016/04/11','test','<br><a href=\"FileDownloadServlet?filename=\\\\192.168.1.1\\HomeICT\\月山麓植物.JPG\">月山麓植物.JPG</a>','2ban','2'),(81,'2ban','xx','2016/04/09','2016/04/18','xx','<br><a href=\"FileDownloadServlet?filename=\\\\192.168.1.1\\HomeICT\\月山麓.JPG\">月山麓.JPG</a>','2ban','2');
/*!40000 ALTER TABLE `past_keijiban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shokuin`
--

DROP TABLE IF EXISTS `shokuin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shokuin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT 'pass',
  `user` varchar(45) DEFAULT NULL,
  `HostName` varchar(45) DEFAULT NULL,
  `mail` varchar(45) DEFAULT NULL,
  `pop3` varchar(45) DEFAULT NULL,
  `mailpass` varchar(45) DEFAULT NULL,
  `haisin_ad` varchar(45) DEFAULT NULL,
  `renraku_ad` varchar(45) DEFAULT NULL,
  `sid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shokuin`
--

LOCK TABLES `shokuin` WRITE;
/*!40000 ALTER TABLE `shokuin` DISABLE KEYS */;
INSERT INTO `shokuin` VALUES (1,'admin','pass','admin',NULL,'','','pass','','null',2),(2,'2ban','pass','2ban',NULL,NULL,NULL,NULL,NULL,NULL,4),(8,'8ban','pass','8ban',NULL,NULL,NULL,NULL,'','null',5),(9,'user','pass','user',NULL,'null','null','',NULL,NULL,1);
/*!40000 ALTER TABLE `shokuin` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-23 10:52:49
