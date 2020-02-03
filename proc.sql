-- MariaDB dump 10.17  Distrib 10.4.10-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: android_project
-- ------------------------------------------------------
-- Server version	10.4.10-MariaDB

CREATE DATABASE  IF NOT EXISTS `android_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `android_project`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `collector`
--

DROP TABLE IF EXISTS `collector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collector` (
  `username` varchar(45) NOT NULL,
  `passwordHash` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collector`
--

LOCK TABLES `collector` WRITE;
/*!40000 ALTER TABLE `collector` DISABLE KEYS */;
INSERT INTO `collector` VALUES ('Nick','$6$rounds=656000$S.TfXF5pHnZOMgEe$NDU/93NwdlLSgWGs9ARSX.shWW9CY3IdR26t0/mZpJJ7k076MDW9GM7qJwKmaHKftAfE.aOlXvAUXwaqF3Xwn.'),('TestUser','$6$rounds=656000$XJZP5C85CU1vYSMD$r8YN09e4LUDw7AteI66nBfm/9rw7/YLRJhJITpMMbzSjehOkR.MK6XWIOJZU4xOiWXxy9H.zueT9cjrKx4.Ey/'),('User3','$6$rounds=656000$JVpUtay5P6ZnkS0a$23xc0hZOMPFUrUI00C.dyTWFmPrwfQl30VypVJy7eHsDkwnxL6rqIhWsWT8KdDb3ZQ8NvHprBMQWiu52dcJFz1'),('User4','$6$rounds=656000$qS2mjmfYeudCn995$I.W1TtERVh07GvMdnuL1xjBwfkFWwtropVoRLhUg2yMeg8IVSqxrghg/l4cBmrCyc5pM1AOZP9APPdaLk3rqY1'),('YeahBoi','$6$rounds=656000$gFlEVEibLEkdlKel$xGaHmiS7zHmJEQK.ae8X0xin8ARPIYAmsDxndU.5dNMORQ0MZY99WvDO/3NFKi4thVhrXzcrni.WbrLa8sdpE1');
/*!40000 ALTER TABLE `collector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('Atlus'),('Bandai-Namco'),('BlueSky Software'),('Bungie'),('Capcom'),('Entertainment Japan'),('From Software'),('Konami'),('Konami Computer'),('Microsoft Game Studios'),('Nintendo'),('Nintendo Creative Department'),('Nintendo EAD'),('Nintendo EPD'),('Nintendo R&D1'),('Nintendo SPD'),('Obsidian Entertainment'),('P-Studio'),('Private Division'),('Retro Studios'),('Sega'),('Sonic Team'),('Sony'),('TNX Music Recordings');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `develops`
--

DROP TABLE IF EXISTS `develops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `develops` (
  `gameName` varchar(45) NOT NULL,
  `comName` varchar(45) NOT NULL,
  PRIMARY KEY (`gameName`,`comName`),
  KEY `Company_idx` (`comName`),
  CONSTRAINT `Company` FOREIGN KEY (`comName`) REFERENCES `company` (`Name`),
  CONSTRAINT `Game` FOREIGN KEY (`gameName`) REFERENCES `game` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `develops`
--

LOCK TABLES `develops` WRITE;
/*!40000 ALTER TABLE `develops` DISABLE KEYS */;
INSERT INTO `develops` VALUES ('Dark Souls','From Software'),('Halo 2','Bungie'),('Mega Man 3','Capcom'),('Metal Gear Solid','Konami Computer'),('Metroid','Nintendo R&D1'),('Metroid Prime','Retro Studios'),('Persona 5','P-Studio'),('Rhythm Heaven','Nintendo SPD'),('Rhythm Heaven','TNX Music Recordings'),('Ristar','Sega'),('Sonic the Hedgehog','Sonic Team'),('Super Mario 64','Nintendo EAD'),('Super Mario Bros.','Nintendo Creative Department'),('Super Mario Bros. 2','Nintendo EAD'),('The Outer Worlds','Obsidian Entertainment');
/*!40000 ALTER TABLE `develops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `Name` varchar(45) NOT NULL,
  `Release_Date` date NOT NULL,
  `Series` varchar(45) DEFAULT NULL,
  `Cover_Art` varchar(500) DEFAULT NULL,
  `Genre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`),
  KEY `Genre_idx` (`Genre`),
  CONSTRAINT `Genre` FOREIGN KEY (`Genre`) REFERENCES `genre` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES ('Dark Souls','2011-09-22','Dark Souls','https://upload.wikimedia.org/wikipedia/en/8/8d/Dark_Souls_Cover_Art.jpg','Action RPG'),('Halo 2','2004-11-09','Halo','https://upload.wikimedia.org/wikipedia/en/9/92/Halo2-cover.png','First-Person Shooter'),('Mega Man 3','1990-09-28','Mega Man','https://upload.wikimedia.org/wikipedia/en/4/49/Megaman3_box.jpg','Action Platformer'),('Metal Gear Solid','1998-09-03','Metal Gear','https://upload.wikimedia.org/wikipedia/en/3/33/Metal_Gear_Solid_cover_art.png','Stealth'),('Metroid','1987-08-06','Metroid','https://upload.wikimedia.org/wikipedia/en/5/5d/Metroid_boxart.jpg','Action-Adventure'),('Metroid Prime','2002-11-17','Metroid','https://upload.wikimedia.org/wikipedia/en/b/ba/MetroidPrimebox.jpg','Action-Adventure'),('Persona 5','2016-09-15','Persona','https://upload.wikimedia.org/wikipedia/en/b/b0/Persona_5_cover_art.jpg','Role-playing'),('Rhythm Heaven','2008-07-31','Rhythm Heaven','https://upload.wikimedia.org/wikipedia/en/3/38/RhythmHeaven.PNG','Rhythm'),('Ristar','1995-02-16','N/A','https://upload.wikimedia.org/wikipedia/en/2/2a/Ristar_cover_EU.jpg','Platformer'),('Sonic the Hedgehog','1991-06-23','Sonic the Hedgehog','https://upload.wikimedia.org/wikipedia/en/b/ba/Sonic_the_Hedgehog_1_Genesis_box_art.jpg','Platformer'),('Super Mario 64','1996-06-23','Super Mario','https://upload.wikimedia.org/wikipedia/en/6/6a/Super_Mario_64_box_cover.jpg','Platformer'),('Super Mario Bros.','1985-09-13','Super Mario','https://upload.wikimedia.org/wikipedia/en/0/03/Super_Mario_Bros._box.png','Platformer'),('Super Mario Bros. 2','1988-10-09','Super Mario','https://upload.wikimedia.org/wikipedia/en/0/00/Super_Mario_Bros_2.jpg','Platformer'),('The Outer Worlds','2019-10-25','N/A','https://upload.wikimedia.org/wikipedia/en/e/e7/The_Outer_Worlds_cover_art.png','Action role-playing');
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_platform`
--

DROP TABLE IF EXISTS `game_platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_platform` (
  `gameName` varchar(45) NOT NULL,
  `platName` varchar(45) NOT NULL,
  PRIMARY KEY (`gameName`,`platName`),
  KEY `platGame_idx` (`platName`),
  CONSTRAINT `gamePlat` FOREIGN KEY (`gameName`) REFERENCES `game` (`Name`),
  CONSTRAINT `platGame` FOREIGN KEY (`platName`) REFERENCES `platform` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_platform`
--

LOCK TABLES `game_platform` WRITE;
/*!40000 ALTER TABLE `game_platform` DISABLE KEYS */;
INSERT INTO `game_platform` VALUES ('Dark Souls','PC'),('Dark Souls','PlayStation 3'),('Dark Souls','XBOX 360'),('Halo 2','Xbox'),('Mega Man 3','NES'),('Metal Gear Solid','PlayStation'),('Metroid','NES'),('Metroid Prime','GameCube'),('Persona 5','PlayStation 3'),('Persona 5','PlayStation 4'),('Rhythm Heaven','Nintendo DS'),('Ristar','Sega Genesis'),('Sonic the Hedgehog','Sega Genesis'),('Super Mario 64','Nintendo 64'),('Super Mario Bros.','NES'),('Super Mario Bros. 2','NES'),('The Outer Worlds','Nintendo Switch'),('The Outer Worlds','PC'),('The Outer Worlds','PlayStation 4'),('The Outer Worlds','Xbox One');
/*!40000 ALTER TABLE `game_platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES ('3D Platformer'),('Action Platformer'),('Action role-playing'),('Action RPG'),('Action-Adventure'),('First-Person Shooter'),('Platformer'),('Rhythm'),('Role-playing'),('Stealth');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufactures`
--

DROP TABLE IF EXISTS `manufactures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufactures` (
  `platName` varchar(45) NOT NULL,
  `comName` varchar(45) NOT NULL,
  PRIMARY KEY (`platName`),
  KEY `ComPlat_idx` (`comName`),
  CONSTRAINT `ComPlat` FOREIGN KEY (`comName`) REFERENCES `company` (`Name`),
  CONSTRAINT `Plat` FOREIGN KEY (`platName`) REFERENCES `platform` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufactures`
--

LOCK TABLES `manufactures` WRITE;
/*!40000 ALTER TABLE `manufactures` DISABLE KEYS */;
INSERT INTO `manufactures` VALUES ('Nintendo 64','Nintendo');
/*!40000 ALTER TABLE `manufactures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owns`
--

DROP TABLE IF EXISTS `owns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owns` (
  `colName` varchar(45) NOT NULL,
  `gameName` varchar(45) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `favorite` tinyint(4) NOT NULL DEFAULT 0,
  `platform` varchar(45) NOT NULL,
  PRIMARY KEY (`colName`,`gameName`,`platform`),
  KEY `GameOwn_idx` (`gameName`),
  KEY `GameOwnPlatform_idx` (`platform`),
  CONSTRAINT `Colon` FOREIGN KEY (`colName`) REFERENCES `collector` (`username`),
  CONSTRAINT `GameOwn` FOREIGN KEY (`gameName`) REFERENCES `game` (`Name`),
  CONSTRAINT `Platform` FOREIGN KEY (`platform`) REFERENCES `platform` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owns`
--

LOCK TABLES `owns` WRITE;
/*!40000 ALTER TABLE `owns` DISABLE KEYS */;
INSERT INTO `owns` VALUES ('Nick','Dark Souls',5,1,'PC'),('Nick','Halo 2',4,1,'Xbox'),('Nick','Mega Man 3',3,1,'NES'),('Nick','Sonic the Hedgehog',4,0,'Sega Genesis'),('YeahBoi','Mega Man 3',5,0,'NES');
/*!40000 ALTER TABLE `owns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform`
--

DROP TABLE IF EXISTS `platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform` (
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform`
--

LOCK TABLES `platform` WRITE;
/*!40000 ALTER TABLE `platform` DISABLE KEYS */;
INSERT INTO `platform` VALUES (' Nintendo Switch'),('GameCube'),('Mega Drive'),('NES'),('Nintendo 64'),('Nintendo DS'),('Nintendo Switch'),('PC'),('PlayStation'),('PlayStation 3'),('PlayStation 4'),('Sega Genesis'),('Wii U'),('Xbox'),('XBOX 360'),('Xbox One');
/*!40000 ALTER TABLE `platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishes`
--

DROP TABLE IF EXISTS `publishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publishes` (
  `gameName` varchar(45) NOT NULL,
  `comName` varchar(45) NOT NULL,
  PRIMARY KEY (`gameName`),
  KEY `Game_idx` (`comName`),
  KEY `Pub_idx` (`comName`),
  CONSTRAINT `Companypub` FOREIGN KEY (`comName`) REFERENCES `company` (`Name`),
  CONSTRAINT `Gamepub` FOREIGN KEY (`gameName`) REFERENCES `game` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishes`
--

LOCK TABLES `publishes` WRITE;
/*!40000 ALTER TABLE `publishes` DISABLE KEYS */;
INSERT INTO `publishes` VALUES ('Persona 5','Atlus'),('Dark Souls','Bandai-Namco'),('Mega Man 3','Capcom'),('Metal Gear Solid','Konami'),('Halo 2','Microsoft Game Studios'),('Metroid','Nintendo'),('Metroid Prime','Nintendo'),('Rhythm Heaven','Nintendo'),('Super Mario 64','Nintendo'),('Super Mario Bros.','Nintendo'),('Super Mario Bros. 2','Nintendo'),('The Outer Worlds','Private Division'),('Ristar','Sega'),('Sonic the Hedgehog','Sega');
/*!40000 ALTER TABLE `publishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlists` (
  `colName` varchar(45) NOT NULL,
  `gameName` varchar(45) NOT NULL,
  PRIMARY KEY (`colName`,`gameName`),
  KEY `gameWsh_idx` (`gameName`),
  CONSTRAINT `ColWish` FOREIGN KEY (`colName`) REFERENCES `collector` (`username`),
  CONSTRAINT `gameWsh` FOREIGN KEY (`gameName`) REFERENCES `game` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists`
--

LOCK TABLES `wishlists` WRITE;
/*!40000 ALTER TABLE `wishlists` DISABLE KEYS */;
INSERT INTO `wishlists` VALUES ('Nick','Halo 2'),('Nick','Metroid Prime'),('YeahBoi','Metroid');
/*!40000 ALTER TABLE `wishlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'android_project'
--
/*!50003 DROP PROCEDURE IF EXISTS `spCreateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `spCreateUser`(
IN p_Username varchar(45),
IN p_PassHash varchar(128)
)
BEGIN
if ( select exists (select 1 from collector where username = p_Username) ) THEN
	select 'Username Exists !!';

else

insert into collector
(
	username,
    passwordHash
)
values
(
	p_Username,
    p_PassHash
);

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddCompany` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddCompany`(
IN p_company VARCHAR(45)
)
BEGIN
INSERT IGNORE INTO company values(p_company);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddGame`(
IN p_name VARCHAR(45),
IN p_release VARCHAR(45),
IN p_series VARCHAR(45),
IN p_cover VARCHAR(500),
IN p_genre VARCHAR(45)
)
BEGIN
INSERT IGNORE INTO game values(
p_name,
p_release,
p_series,
p_cover,
p_genre
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddGameDeveloper` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddGameDeveloper`(
IN p_name VARCHAR(45),
IN p_dev VARCHAR(45)
)
BEGIN
INSERT IGNORE INTO develops values(
p_name,
p_dev
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddGamePlatform` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddGamePlatform`(
IN p_name VARCHAR(45),
IN p_plat VARCHAR(45)
)
BEGIN
INSERT IGNORE INTO game_platform values(
p_name,
p_plat
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddGamePublisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddGamePublisher`(
IN p_name VARCHAR(45),
IN p_pub VARCHAR(45)
)
BEGIN
INSERT IGNORE INTO publishes values(
p_name,
p_pub
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddGenre`(
IN p_genre VARCHAR(45)
)
BEGIN
INSERT IGNORE INTO genre values(p_genre);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddPlatform` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddPlatform`(
IN p_platform VARCHAR(45)
)
BEGIN
INSERT IGNORE INTO platform values(p_platform);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddToFavorites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddToFavorites`(
in p_username VARCHAR(45),
in p_game VARCHAR(45),
in p_platform VARCHAR(45)
)
BEGIN
    update owns set Favorite = 1
    where colname = p_username
    and gameName = p_game
    and platform = p_platform;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddToLibrary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddToLibrary`(
in p_username VARCHAR(45),
in p_game VARCHAR(45),
in p_platform VARCHAR(45)
)
BEGIN
    insert ignore into owns
    values(
    p_username,
    p_game,
    null,
    0,
    p_platform
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddToWishlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AddToWishlist`(
in p_username VARCHAR(45),
in p_game VARCHAR(45)
)
BEGIN
    insert ignore into wishlists
    values(
    p_username,
    p_game
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AuthenticateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AuthenticateUser`(
IN p_username VARCHAR(45)
)
BEGIN

     select * from collector where username = p_username;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllGames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetAllGames`(
in p_lowerLimit int,
in p_upperLimit int
)
BEGIN
    select game.*,develops.*,AVG(owns.rating) from game join develops left join owns ON Name = owns.gameName
    WHERE Name = develops.gameName
    GROUP BY Name
    ORDER BY Name
    LIMIT p_lowerLimit,p_upperLimit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetDeveloper` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetDeveloper`(
in p_GameName VARCHAR(45)
)
BEGIN
    select * from develops where gameName = p_GameName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetFavorites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetFavorites`(
in p_lowerLimit int,
in p_upperLimit int,
in p_username VARCHAR(45)
)
BEGIN
    select * from game join develops join owns
    where game.Name = develops.gameName 
    and colName = p_username 
    and game.Name = owns.gameName
    and favorite = 1
    order by Name
    limit p_lowerLimit,p_upperLimit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetGame`(
in p_GameName VARCHAR(45)
)
BEGIN
    select * from game where Name = p_GameName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetLibrary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetLibrary`(
in p_lowerLimit int,
in p_upperLimit int,
in p_username VARCHAR(45)
)
BEGIN
    select * from game join develops join owns
    where game.Name = develops.gameName 
    and colName = p_username 
    and game.Name = owns.gameName
    order by Name
    limit p_lowerLimit,p_upperLimit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetPlatform` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetPlatform`(
in p_GameName VARCHAR(45)
)
BEGIN
    select * from game_platform where gameName = p_GameName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetPublisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetPublisher`(
in p_GameName VARCHAR(45)
)
BEGIN
    select * from publishes where gameName = p_GameName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetWishlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_GetWishlist`(
in p_lowerLimit int,
in p_upperLimit int,
in p_username VARCHAR(45)
)
BEGIN
    select game.*,develops.*,AVG(owns.rating) from game join develops join wishlists left join owns ON Name = owns.gameName
    WHERE game.Name = develops.gameName
    AND wishlists.colName = p_username
    AND wishlists.gameName = game.Name
    GROUP BY Name
    ORDER BY Name
    LIMIT p_lowerLimit,p_upperLimit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RateGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RateGame`(
IN p_rating INT,
IN p_username VARCHAR(45),
IN p_gamename VARCHAR(45),
IN p_platform VARCHAR(45)
)
BEGIN
UPDATE owns
SET rating = p_rating
WHERE gameName = p_gamename
AND platform = p_platform
AND colName = p_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RemoveFromFavorites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RemoveFromFavorites`(
in p_username VARCHAR(45),
in p_game VARCHAR(45),
in p_platform VARCHAR(45)
)
BEGIN
    update owns set Favorite = 0
    where colname = p_username
    and gameName = p_game
    and platform = p_platform;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RemoveFromLibrary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RemoveFromLibrary`(
in p_username VARCHAR(45),
in p_game VARCHAR(45),
in p_platform VARCHAR(45)
)
BEGIN
    delete from owns
    where colName = p_username
    and gameName = p_game
    and platform = p_platform;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RemoveFromWishlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RemoveFromWishlist`(
in p_username VARCHAR(45),
in p_game VARCHAR(45)
)
BEGIN
    delete from wishlists
    where gameName = p_game
    and colName = p_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RemoveGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RemoveGame`(
in p_name VARCHAR(45)
)
BEGIN
    DELETE FROM game_platform
    WHERE gameName = p_name;

    DELETE FROM develops
    WHERE gameName = p_name;

    DELETE FROM publishes
    WHERE gameName = p_name;

    DELETE FROM owns
    WHERE gameName = p_name;
 
    DELETE FROM wishlists
    WHERE gameName = p_name;

    DELETE FROM game
    WHERE Name = p_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-08 21:46:03
