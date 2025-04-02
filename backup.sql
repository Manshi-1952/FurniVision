-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: furnivision
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `product_name` varchar(255) NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (40,10,3,1,'Leather Sofa',11000),(41,10,6,1,'Luxury Leather ',10000),(42,10,8,1,'Sofa sofa',120000),(43,10,9,1,'ahfwoei',123445),(44,10,10,1,'Luxury Leather Sofa',123433),(45,10,11,1,'Luxury Leather Sofa',120000),(48,12,9,1,'ahfwoei',123445),(49,12,10,1,'Luxury Leather Sofa',123433),(50,12,3,1,'Leather Sofa',11000),(51,12,8,1,'Sofa sofa',120000),(52,12,17,1,'Platform Bed',11000),(53,12,6,1,'Luxury Leather ',10000),(54,12,11,1,'Luxury Leather Sofa',120000);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `property_type` varchar(50) DEFAULT NULL,
  `rooms` text,
  `furniture` text,
  `material` varchar(100) DEFAULT NULL,
  `budget` decimal(10,2) DEFAULT NULL,
  `timeline` date DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (1,'Manshi Gohil','manshi.gohil832@gmail.com','8320101567','apartment','livingRoom, bedroom','sofa','feferergerger',20000.00,'2025-04-16','kjbnjbbgtriugberbgarar'),(2,'Souvik Sen','souvik123@gmail.com','2837487897','house','livingRoom, bedroom, kitchen','sofa, table','feferergerger',1000000.00,'2025-04-23','bh nuwiegf naiwehibnf nfiwebf');
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('PENDING','PAID','FAILED') DEFAULT 'PENDING',
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int NOT NULL,
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  `category` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (3,'Leather Sofa',11000,'best leather sofa','uploads/1738929016961_Eddie_Boucle_Sofa_-_Green___Chair-removebg-preview.png','Sofas'),(6,'Luxury Leather ',10000,'best sofa sofa set for your dream ','uploads/1739279555807_pre.png','Sofas'),(8,'Sofa sofa',120000,'sffa ndwneiubfn nfeikrng ','uploads/1739253036750_Buy Sofas, Couches & Lounges Online.jpeg','Sofas'),(9,'ahfwoei',123445,'skjfdibskjfdibskjfdibskjfdibskjfdibskjfdib s','uploads/1739282900115_sofa-2.png','Sofas'),(10,'Luxury Leather Sofa',123433,'skjfdibskjfdibskjfdibskjfdib','uploads/1739282925290_1739093058530_chair.png','Sofas'),(11,'Luxury Leather Sofa',120000,'luxurious sofa for you house','uploads/1739283593215_1738930714209_sofa.jpeg','Sofas'),(17,'Platform Bed',11000,' A sleek, modern bed frame with a sturdy base that eliminates the need for a box spring.','uploads/1742076397904_bed1.png','Beds'),(18,' Canopy Bed ',12000,'A luxurious bed with four tall posts connected by a frame, often draped with curtains for a regal look.','uploads/1742076445296_bed2.png','Beds'),(19,' Sleigh Bed',13000,' A stylish bed with curved head and footboards resembling a sleigh, adding a touch of elegance to any bedroom.','uploads/1742076467074_bed3.png','Beds'),(20,'Bunk Bed',14000,' A space-saving design featuring two or more stacked beds, perfect for kids’ rooms or dormitories.','uploads/1742076498375_bed6.png','Beds'),(21,'Murphy Bed',15000,' A foldable bed that tucks into a wall or cabinet, ideal for maximizing small spaces.','uploads/1742076523852_bed4.png','Beds'),(22,' Loft Bed ',16000,'A raised bed with open space underneath, commonly used for desks, seating, or storage.','uploads/1742079800754_bed5.png','Beds'),(23,' Four-Poster Bed ',17000,'A traditional bed with four tall corner posts, adding a classic and decorative touch.','uploads/1742076576078_bed8.png','Beds'),(25,'Club Chair',12000,'A deep, cushioned armchair with a low back, perfect for lounging.','uploads/1743002947804_chair01.png','Chairs'),(26,'Chesterfield Chair',13000,'A luxurious, tufted leather chair with rolled arms, adding elegance.','uploads/1743004412034_chair02.png','Chairs'),(27,'Recliner Sofa Chair',14000,'A comfy chair with a reclining back and footrest for ultimate relaxation.','uploads/1743003939301_chair03.png','Chairs'),(28,'Accent Chair',15000,'A stylish, single-seater designed to add personality to a room.','uploads/1743004435599_chair04.png','Chairs'),(29,'Lounge Chair ',16000,'A spacious, cushioned chair with a sloped back for casual seating.','uploads/1743004191201_chair05.png','Chairs'),(30,'Comfy chair',111000,'A deep, cushioned armchair with a low back, perfect for lounging.','uploads/1743004757377_chair06.png','Chairs'),(31,'Table',123333,'table is table','uploads/1743604518893_dinning.png','Tables');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  `email` varchar(255) DEFAULT NULL,
  `role` enum('Admin','Moderator','Customer') DEFAULT 'Customer',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Active','Suspended') DEFAULT 'Active',
  `reset_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',1,NULL,'Admin','2025-02-13 17:10:24','Active',NULL),(7,'admin1','e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc7',1,'admin123@gmail.com','Admin','2025-02-13 18:01:38','Active',NULL),(8,'admin2','7f484e682c9cf4c42e9cba611bcf04c18d1372bb920756c657c8c0233a2693ae',1,'admin456@gmail.com','Admin','2025-02-13 18:42:32','Active',NULL),(10,'Motii','7226da673fb9deb093a14f226740fd90480dd14f30474e7c73225f1bc2a5b2a4',0,'moti1234@gmail.com','Customer','2025-02-14 09:42:15','Active',NULL),(11,'Suhani','4ea67e5210094e0d61e148db2361be2b57723ce538002acaf50e81eff5b0b850',0,'suhani123@gmail.com','Customer','2025-02-16 12:44:05','Active',NULL),(12,'Somvik','f8b525ed550cef2503423001ce3dfd24109beb9a2f9c3c62d3d49c3d96af3c66',0,'somvik1234@gmail.com','Customer','2025-02-16 12:47:08','Active',NULL),(13,'Mayank','cfb71286ceaf71093e96c724b91edd2e826f9a8b62d0a0a92e9dff4da9b5ae27',0,'mayank1233@gmail.com','Customer','2025-04-02 03:59:55','Active',NULL);
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

-- Dump completed on 2025-04-02 21:40:55
