-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: wall
-- ------------------------------------------------------
-- Server version	5.5.49-log

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `message_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comments_messages1_idx` (`message_id`),
  KEY `fk_comments_users1_idx` (`user_id`),
  CONSTRAINT `fk_comments_messages1` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'Let\'s try posting a comment here.','2016-07-13 10:44:35','2016-07-13 10:44:35',11,1),(2,'Try again. Haha','2016-07-13 10:46:04','2016-07-13 10:46:04',10,1),(3,'Leave another comment to see if all cmts display right','2016-07-13 10:57:22','2016-07-13 10:57:22',11,1),(4,'Just wanna leave some random comments','2016-07-13 14:12:55','2016-07-13 14:12:55',9,1),(5,'I know it\'s not the best way of rendering data when you don\'t want the entire page to reload','2016-07-13 14:13:28','2016-07-13 14:13:28',9,1);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_messages_users_idx` (`user_id`),
  CONSTRAINT `fk_messages_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'This works or not?','2016-07-12 21:05:11','2016-07-12 21:05:11',1),(2,'Keep typing','2016-07-12 21:05:42','2016-07-12 21:05:42',1),(3,'Let\'s keep trying','2016-07-12 21:06:15','2016-07-12 21:06:15',1),(4,'One last test','2016-07-12 21:06:39','2016-07-12 21:06:39',1),(5,'Xiaofei\'s first message','2016-07-12 21:07:22','2016-07-12 21:07:22',4),(6,'Why is my name favicon?','2016-07-12 21:10:55','2016-07-12 21:10:55',4),(7,'This finally worked!!!','2016-07-12 21:59:48','2016-07-12 21:59:48',1),(8,'Here\'s a new post. I just don\'t know what to say, I\'m so tired','2016-07-12 23:25:40','2016-07-12 23:25:40',1),(9,'Post post post post post post','2016-07-12 23:47:52','2016-07-12 23:47:52',1),(10,'I\'m Yi. I\'m currently working at Coding Dojo. Jasmine and Emma are my friends. They\'ve been either working or studying at coding dojo for a while. Good day.','2016-07-13 07:44:19','2016-07-13 07:44:19',5),(11,'I am a fake person. This is just a test run. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quo velit eos impedit asperiores tenetur ut repudiandae quaerat sit ducimus, est officia eius delectus, corrupti quae animi laborum quibusdam ipsa quasi.','2016-07-13 08:18:34','2016-07-13 08:18:34',7);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Juemin','Wei','weijueminjas@gmail.com','$2b$12$HD1SvaNLyjVrKatmGNtD3ewZmEN/6W/dmIM2XegafHLDPoPth9AMi','2016-07-12 13:39:07','2016-07-12 13:39:07'),(4,'Xiaofei','Zhang','xiaofei.zhang1988@gmail.com','$2b$12$ulF8x5qQgOMe8or43AWfLuTglPWS7sUPrRJdfeUS0JI0okFGd9xkO','2016-07-12 15:37:10','2016-07-12 15:37:10'),(5,'Yi','Hong','yihongmaster2011@gmail.com','$2b$12$rPrJxASQUcKJVjvlGm6X5OFIcRUFjOzk8iL0MfYlISAvUlblQ1RgW','2016-07-12 15:48:44','2016-07-12 15:48:44'),(6,'Qiaoqiao','Yang','jossie.young@gmail.com','$2b$12$h2TtbIRrbrnhYr5uf4705uQDbbX/jkM6UdWFYj31Xl4vLc4ly7qta','2016-07-12 15:49:47','2016-07-12 15:49:47'),(7,'Test','Person','testperson@gmail.com','$2b$12$vQBY90d4j8JaKbfl8TtV8uyn4M.vaKe6k0wlFzCVaqrhfC0dohwc2','2016-07-13 08:17:07','2016-07-13 08:17:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-13 14:17:06
