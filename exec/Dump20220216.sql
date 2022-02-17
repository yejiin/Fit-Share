-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: i6a405.p.ssafy.io    Database: fitshare
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `cloth`
--

DROP TABLE IF EXISTS `cloth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cloth` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '옷 id',
  `room_participant_id` int NOT NULL,
  `cloth_url` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '옷 이미지 주소',
  `cloth_path` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '옷 구매 사이트 주소',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_cloth_room_participant1_idx` (`room_participant_id`),
  CONSTRAINT `fk_cloth_room_participant1` FOREIGN KEY (`room_participant_id`) REFERENCES `room_participant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cloth`
--

LOCK TABLES `cloth` WRITE;
/*!40000 ALTER TABLE `cloth` DISABLE KEYS */;
INSERT INTO `cloth` VALUES (1,5,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/5_4_20220216_044632.png','images/5_4_20220216_044632.png','2022-02-16 13:46:33'),(2,5,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/5_4_20220216_044652.png','images/5_4_20220216_044652.png','2022-02-16 13:46:52'),(3,5,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/5_4_20220216_044702.png','images/5_4_20220216_044702.png','2022-02-16 13:47:03'),(5,8,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/8_7_20220216_045534.png','images/8_7_20220216_045534.png','2022-02-16 13:55:35'),(7,12,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/11_6_20220216_074447.png','images/11_6_20220216_074447.png','2022-02-16 16:44:48'),(8,12,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/11_6_20220216_074610.png','images/11_6_20220216_074610.png','2022-02-16 16:46:11'),(9,18,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/16_4_20220216_083006.png','images/16_4_20220216_083006.png','2022-02-16 17:30:07'),(11,18,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/16_4_20220216_083616.png','images/16_4_20220216_083616.png','2022-02-16 17:36:17'),(12,18,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/16_4_20220216_083716.png','images/16_4_20220216_083716.png','2022-02-16 17:37:17'),(13,19,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/17_4_20220216_083942.png','images/17_4_20220216_083942.png','2022-02-16 17:39:42'),(14,36,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/31_4_20220216_113259.png','images/31_4_20220216_113259.png','2022-02-16 20:33:00'),(15,36,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/31_4_20220216_113306.png','images/31_4_20220216_113306.png','2022-02-16 20:33:07'),(16,36,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/31_4_20220216_113326.png','images/31_4_20220216_113326.png','2022-02-16 20:33:27'),(17,35,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/31_2_20220216_113338.png','images/31_2_20220216_113338.png','2022-02-16 20:33:38'),(18,38,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/32_4_20220216_113515.png','images/32_4_20220216_113515.png','2022-02-16 20:35:16'),(19,38,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/32_4_20220216_113521.png','images/32_4_20220216_113521.png','2022-02-16 20:35:22'),(20,38,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/32_4_20220216_113720.png','images/32_4_20220216_113720.png','2022-02-16 20:37:21'),(21,60,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/48_4_20220216_133842.png','images/48_4_20220216_133842.png','2022-02-16 22:38:43'),(22,60,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/48_4_20220216_133905.png','images/48_4_20220216_133905.png','2022-02-16 22:39:06'),(23,65,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/51_4_20220216_135411.png','images/51_4_20220216_135411.png','2022-02-16 22:54:12'),(25,65,'https://fitshare-bucket.s3.ap-northeast-2.amazonaws.com/images/51_4_20220216_135554.png','images/51_4_20220216_135554.png','2022-02-16 22:55:55');
/*!40000 ALTER TABLE `cloth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '친구관계 id',
  `member_id` int NOT NULL COMMENT '사용자 id',
  `friend_id` int NOT NULL COMMENT '사용자의 친구 id',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `FK_friend_member_idx` (`member_id`),
  KEY `FK_friend_friend_id_member_id_idx` (`friend_id`),
  CONSTRAINT `FK_friend_friend_id_member_id` FOREIGN KEY (`friend_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FK_friend_member_id_member_id` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
INSERT INTO `friend` VALUES (2,6,4,'2022-02-16 13:43:15'),(3,4,6,'2022-02-16 13:43:15'),(4,7,4,'2022-02-16 13:44:54'),(5,4,7,'2022-02-16 13:44:54'),(8,5,2,'2022-02-16 07:14:05'),(9,2,5,'2022-02-16 07:14:10'),(10,7,5,'2022-02-16 07:14:35'),(11,5,7,'2022-02-16 07:14:39'),(12,3,7,'2022-02-16 07:14:53'),(13,7,3,'2022-02-16 07:14:57'),(20,6,7,'2022-02-16 16:51:24'),(21,7,6,'2022-02-16 16:51:24'),(24,2,4,'2022-02-16 20:26:23'),(25,4,2,'2022-02-16 20:26:23'),(26,9,5,'2022-02-16 20:59:32'),(27,5,9,'2022-02-16 20:59:32'),(28,4,3,'2022-02-16 23:13:51'),(29,3,4,'2022-02-16 23:13:51');
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_request`
--

DROP TABLE IF EXISTS `friend_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL COMMENT '친구를 요청한 사용자 id',
  `target_member_id` int NOT NULL COMMENT '친구 요청을 받은 사용자 id',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '친구 요청 시간',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `FK_friend_request_member_id_member_id_idx` (`member_id`),
  KEY `FK_friend_request_target_member_id_member_id_idx` (`target_member_id`),
  CONSTRAINT `FK_friend_request_member_id_member_id` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FK_friend_request_target_member_id_member_id` FOREIGN KEY (`target_member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_request`
--

LOCK TABLES `friend_request` WRITE;
/*!40000 ALTER TABLE `friend_request` DISABLE KEYS */;
INSERT INTO `friend_request` VALUES (23,4,5,'2022-02-16 17:54:31');
/*!40000 ALTER TABLE `friend_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '사용자 id',
  `uid` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '카카오 회원번호',
  `name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '사용자 이름',
  `email` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '이메일',
  `phone` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '전화번호',
  `profile_img` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '프로필사진',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '계정 활성화여부 (0: 비활성화, 1: 활성화)',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입 시간',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '마지막 수정 시간',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (2,'2113132677','김선민','smkim0903@naver.com',NULL,'http://k.kakaocdn.net/dn/bKe22n/btq1nIraGPi/V7khORTYUdgn5Wwd2cDv1k/img_640x640.jpg',1,'2022-02-16 11:47:33','2022-02-16 11:47:33'),(3,'2113150895','허재석','1gj2wo3tjr@naver.com',NULL,'http://k.kakaocdn.net/dn/cfxpzD/btq7C1j8mcj/d7YuVb1uKvnIQog1KuFWf0/img_640x640.jpg',1,'2022-02-16 11:49:13','2022-02-16 16:13:44'),(4,'2099064704','이명주','myungju25@naver.com',NULL,'http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg',1,'2022-02-16 12:04:49','2022-02-16 16:27:04'),(5,'2103923724','송예진','festa11@daum.net',NULL,'http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg',1,'2022-02-16 13:35:40','2022-02-16 13:35:40'),(6,'2113021480','김혜지','hengzizng@naver.com',NULL,'http://k.kakaocdn.net/dn/cvP9b9/btrqOf4JHOJ/FDWMjDWwFiFQvyKrKku021/img_640x640.jpg',1,'2022-02-16 13:35:43','2022-02-16 13:35:43'),(7,'2095916454','KMS','kimms4142@naver.com',NULL,'http://k.kakaocdn.net/dn/mgTZs/btqEGUmJYjQ/oyppExAIwdK8KzgjzEfKZK/img_640x640.jpg',1,'2022-02-16 13:36:13','2022-02-16 13:36:13'),(8,'2122349260','bomin','ht2641@naver.com',NULL,'http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg',1,'2022-02-16 14:31:08','2022-02-16 14:31:08'),(9,'ll2_3l5jVLDYNjjnELI6fhmDu4yYeaSVDYVgHta0V6w','송예진','rkrud232@naver.com','010-9506-7564','https://ssl.pstatic.net/static/pwe/address/img_profile.png',1,'2022-02-16 20:34:51','2022-02-16 20:34:51');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_chat`
--

DROP TABLE IF EXISTS `private_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_chat` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '채팅 id',
  `sender_id` int NOT NULL COMMENT '발신 사용자 id',
  `receiver_id` int NOT NULL COMMENT '수신 사용자 id',
  `message` text COLLATE utf8_bin NOT NULL COMMENT '메시지',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '메시지 확인 여부 (0: 읽지 않음, 1: 읽음)',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '전송 시간',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `FK_private_chat_sender_id_member_id_idx` (`sender_id`),
  KEY `FK_private_chat_receiver_id_member_id_idx` (`receiver_id`),
  CONSTRAINT `FK_private_chat_receiver_id_member_id` FOREIGN KEY (`receiver_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FK_private_chat_sender_id_member_id` FOREIGN KEY (`sender_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_chat`
--

LOCK TABLES `private_chat` WRITE;
/*!40000 ALTER TABLE `private_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `private_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_participant`
--

DROP TABLE IF EXISTS `room_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_participant` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '쇼핑룸 내 참여자별 고유값',
  `member_id` int NOT NULL,
  `shopping_room_id` int NOT NULL COMMENT '쇼핑룸 id',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `FK_room_participant_room_id_shopping_room_id_idx` (`shopping_room_id`),
  KEY `fk_room_participant_member2_idx` (`member_id`),
  CONSTRAINT `fk_room_participant_member2` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FK_room_participant_room_id_shopping_room_id` FOREIGN KEY (`shopping_room_id`) REFERENCES `shopping_room` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_participant`
--

LOCK TABLES `room_participant` WRITE;
/*!40000 ALTER TABLE `room_participant` DISABLE KEYS */;
INSERT INTO `room_participant` VALUES (1,5,1,'2022-02-16 13:40:09'),(2,7,2,'2022-02-16 13:40:19'),(3,6,3,'2022-02-16 13:40:33'),(4,4,4,'2022-02-16 13:42:03'),(5,4,5,'2022-02-16 13:45:50'),(6,7,6,'2022-02-16 13:52:00'),(7,7,7,'2022-02-16 13:52:52'),(8,7,8,'2022-02-16 13:53:51'),(9,7,5,'2022-02-16 13:59:33'),(10,6,9,'2022-02-16 14:45:47'),(11,3,10,'2022-02-16 16:15:37'),(12,6,11,'2022-02-16 16:42:36'),(13,6,12,'2022-02-16 16:42:36'),(14,6,13,'2022-02-16 16:48:45'),(15,4,13,'2022-02-16 16:50:24'),(16,5,14,'2022-02-16 17:07:17'),(17,5,15,'2022-02-16 17:25:25'),(18,4,16,'2022-02-16 17:25:55'),(19,4,17,'2022-02-16 17:38:22'),(20,5,17,'2022-02-16 17:38:33'),(21,7,17,'2022-02-16 17:38:40'),(22,5,18,'2022-02-16 18:00:13'),(23,2,19,'2022-02-16 18:02:45'),(24,4,20,'2022-02-16 18:12:23'),(25,4,21,'2022-02-16 18:14:54'),(26,3,22,'2022-02-16 18:16:00'),(27,4,23,'2022-02-16 18:17:25'),(28,7,24,'2022-02-16 18:27:17'),(29,3,25,'2022-02-16 18:32:12'),(30,5,26,'2022-02-16 18:38:32'),(31,5,27,'2022-02-16 19:56:58'),(32,7,28,'2022-02-16 20:19:15'),(33,4,29,'2022-02-16 20:19:53'),(34,7,30,'2022-02-16 20:24:11'),(35,2,31,'2022-02-16 20:28:49'),(36,4,31,'2022-02-16 20:28:58'),(37,2,32,'2022-02-16 20:34:56'),(38,4,32,'2022-02-16 20:35:01'),(39,9,33,'2022-02-16 20:35:47'),(40,9,34,'2022-02-16 20:54:53'),(41,9,35,'2022-02-16 20:59:43'),(42,5,35,'2022-02-16 20:59:57'),(43,9,36,'2022-02-16 21:10:36'),(44,5,36,'2022-02-16 21:10:59'),(45,9,37,'2022-02-16 21:13:20'),(46,5,37,'2022-02-16 21:14:26'),(47,9,38,'2022-02-16 21:18:23'),(48,4,39,'2022-02-16 21:19:23'),(49,9,40,'2022-02-16 21:25:26'),(50,5,40,'2022-02-16 21:27:16'),(51,9,41,'2022-02-16 21:38:36'),(52,9,42,'2022-02-16 21:42:34'),(53,5,43,'2022-02-16 21:49:35'),(54,9,43,'2022-02-16 21:53:19'),(55,9,44,'2022-02-16 22:07:43'),(56,4,45,'2022-02-16 22:10:10'),(57,5,44,'2022-02-16 22:13:41'),(58,7,46,'2022-02-16 22:33:00'),(59,5,47,'2022-02-16 22:34:15'),(60,4,48,'2022-02-16 22:37:48'),(61,6,48,'2022-02-16 22:38:46'),(62,7,48,'2022-02-16 22:38:55'),(63,9,49,'2022-02-16 22:49:06'),(64,7,50,'2022-02-16 22:50:12'),(65,4,51,'2022-02-16 22:52:46'),(66,2,51,'2022-02-16 22:57:22'),(67,6,51,'2022-02-16 22:57:23'),(68,7,51,'2022-02-16 22:57:26'),(69,5,52,'2022-02-16 23:01:31'),(70,5,53,'2022-02-16 23:02:25'),(71,7,54,'2022-02-16 23:10:06');
/*!40000 ALTER TABLE `room_participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_mall`
--

DROP TABLE IF EXISTS `shopping_mall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_mall` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '쇼핑몰 id',
  `name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '쇼핑몰 이름',
  `url` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '쇼핑몰 사이트 주소',
  `logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '쇼핑몰 사이트 로고',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '마지막 수정 시간',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_mall`
--

LOCK TABLES `shopping_mall` WRITE;
/*!40000 ALTER TABLE `shopping_mall` DISABLE KEYS */;
INSERT INTO `shopping_mall` VALUES (1,'탑텐','https://topten.topten10mall.com/',NULL,'2022-02-12 09:00:48','2022-02-12 09:00:48'),(2,'무신사','https://www.musinsa.com/app/',NULL,'2022-02-12 09:00:48','2022-02-12 09:00:48'),(3,'29CM','https://www.29cm.co.kr/home/',NULL,'2022-02-12 09:00:48','2022-02-12 09:00:48'),(4,'뉴발란스','https://www.nbkorea.com/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(5,'자라','https://www.zara.com/kr/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(6,'COS','https://www.cosstores.com/kr_krw/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(7,'노스페이스','https://www.thenorthfacekorea.co.kr/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(8,'8Seconds','https://www.ssfshop.com/8Seconds/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(9,'wvproject','https://www.wvproject.co.kr/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(10,'h&m','https://www2.hm.com/ko_kr/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(11,'스파오','https://spao.elandmall.com/main/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(12,'미쏘','https://mixxo.elandmall.com/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(13,'지오다노','https://www.giordano.co.kr/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(14,'아더에러','https://adererror.com/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(15,'커버낫','https://covernat.net/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(16,'w컨셉','https://www.wconcept.co.kr/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(17,'코오롱몰','https://www.kolonmall.com/',NULL,'2022-02-15 15:14:37','2022-02-15 15:14:37'),(18,'스투시','https://www.stussy.co.kr/',NULL,'2022-02-15 15:16:58','2022-02-15 15:16:58'),(19,'젝시미스','https://xexymix.com/',NULL,'2022-02-15 15:19:14','2022-02-15 15:19:14'),(20,'썸제이','https://www.ssumj.com/index.html',NULL,'2022-02-15 15:19:14','2022-02-15 15:19:14'),(21,'베니토','https://www.benito.co.kr/index.html',NULL,'2022-02-15 15:19:14','2022-02-15 15:19:14'),(22,'메이비베이비','http://maybe-baby.co.kr/index.html',NULL,'2022-02-15 15:19:14','2022-02-15 15:19:14'),(23,'육육걸즈','https://www.66girls.co.kr/',NULL,'2022-02-15 15:19:14','2022-02-15 15:19:14'),(24,'나이키','https://www.nike.com/kr/ko_kr/',NULL,'2022-02-15 15:53:55','2022-02-15 15:53:55'),(25,'아디다스','https://www.adidas.co.kr/',NULL,'2022-02-15 15:53:55','2022-02-15 15:53:55'),(26,'하프클럽','http://www.halfclub.com',NULL,'2022-02-15 15:53:55','2022-02-15 15:53:55'),(27,'이랜드몰','http://www.elandmall.com',NULL,'2022-02-15 15:53:55','2022-02-15 15:53:55');
/*!40000 ALTER TABLE `shopping_mall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_room`
--

DROP TABLE IF EXISTS `shopping_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_room` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '쇼핑룸 id',
  `host_id` int NOT NULL COMMENT '쇼핑룸 생성자 id',
  `is_custom_shopping_mall` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'shopping_mall 테이블의 쇼핑몰 사용여부 (0: shopping_mall_name, shopping_mall_name 에 직접 입력, 1: shopping_mall 테이블에서 선택)',
  `shopping_mall_id` int DEFAULT NULL COMMENT '쇼핑몰 목록에서 선택했을 때 쇼핑몰 사이트 id',
  `shopping_mall_name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '쇼핑몰 목록에 없는 사이트일 때 사이트 이름',
  `shopping_mall_url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '쇼핑몰 목록에 없는 사이트일 때 사이트 주소',
  `participant_count` int NOT NULL COMMENT '쇼핑룸 최대 인원수',
  `is_private` tinyint(1) NOT NULL DEFAULT '0' COMMENT '쇼핑룸 비공개 여부 (0: 공개, 1: 비공개)',
  `password` varchar(8) COLLATE utf8_bin DEFAULT NULL COMMENT '비공개 쇼핑룸일 때의 비밀번호',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '쇼핑룸 활성화 여부 (0: 중지, 1: 활성화)',
  `session_id` varchar(200) COLLATE utf8_bin NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `FK_shopping_room_host_id_member_id_idx` (`host_id`),
  KEY `FK_shopping_room_mall_id_shopping_mall_id_idx` (`shopping_mall_id`),
  CONSTRAINT `FK_shopping_room_host_id_member_id` FOREIGN KEY (`host_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FK_shopping_room_mall_id_shopping_mall_id` FOREIGN KEY (`shopping_mall_id`) REFERENCES `shopping_mall` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_room`
--

LOCK TABLES `shopping_room` WRITE;
/*!40000 ALTER TABLE `shopping_room` DISABLE KEYS */;
INSERT INTO `shopping_room` VALUES (1,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_JavEjhfp7I','2022-02-16 13:40:09','2022-02-16 13:40:39'),(2,7,0,1,'탑텐','https://topten.topten10mall.com/',2,0,NULL,0,'ses_WNKG3k2qOo','2022-02-16 13:40:19','2022-02-16 13:40:21'),(3,6,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_Yg3gZpP7b0','2022-02-16 13:40:33','2022-02-16 13:43:12'),(4,4,0,5,'자라','https://www.zara.com/kr/',1,0,NULL,0,'ses_Eww3F0SSWu','2022-02-16 13:42:03','2022-02-16 13:42:09'),(5,4,0,2,'무신사','https://www.musinsa.com/app/',5,0,NULL,0,'ses_EKO43601oK','2022-02-16 13:45:50','2022-02-16 14:04:12'),(6,7,0,2,'무신사','https://www.musinsa.com/app/',5,1,'1234',0,'ses_TEIuEphhUJ','2022-02-16 13:52:00','2022-02-16 13:52:04'),(7,7,0,7,'노스페이스','https://www.thenorthfacekorea.co.kr/',3,0,NULL,0,'ses_AZ0zHO5F12','2022-02-16 13:52:52','2022-02-16 13:53:02'),(8,7,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_ND22bmOlLF','2022-02-16 13:53:51','2022-02-16 13:59:28'),(9,6,0,2,'무신사','https://www.musinsa.com/app/',3,0,NULL,0,'ses_Ks6faOGJSX','2022-02-16 14:45:47','2022-02-16 14:58:44'),(10,3,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_WIHjnd8Acn','2022-02-16 16:15:37','2022-02-16 16:15:43'),(11,6,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_HnByOhQ1ix','2022-02-16 16:42:36','2022-02-16 16:48:35'),(12,6,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_FOLxUVQK8a','2022-02-16 16:42:36','2022-02-16 16:48:40'),(13,6,0,2,'무신사','https://www.musinsa.com/app/',3,0,NULL,0,'ses_WwFEUxATPB','2022-02-16 16:48:45','2022-02-16 16:51:19'),(14,5,0,2,'무신사','https://www.musinsa.com/app/',6,1,'1234',0,'ses_Y5HvKPebjp','2022-02-16 17:07:17','2022-02-16 17:07:33'),(15,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_KMzlbiGvx5','2022-02-16 17:25:25','2022-02-16 17:29:57'),(16,4,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_L72kpUzNIs','2022-02-16 17:25:55','2022-02-16 17:38:16'),(17,4,0,2,'무신사','https://www.musinsa.com/app/',3,0,NULL,0,'ses_YBSfqZnhBy','2022-02-16 17:38:22','2022-02-16 17:39:59'),(18,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_CkK8sIbL0G','2022-02-16 18:00:13','2022-02-16 18:35:57'),(19,2,0,2,'무신사','https://www.musinsa.com/app/',3,0,NULL,0,'ses_XJz4xbW0M0','2022-02-16 18:02:45','2022-02-16 18:04:57'),(20,4,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_I1IrqXLzZA','2022-02-16 18:12:23','2022-02-16 18:14:47'),(21,4,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_ByBwIFNsQr','2022-02-16 18:14:54','2022-02-16 18:15:20'),(22,3,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_BO1eFPOOIJ','2022-02-16 18:16:00','2022-02-16 18:17:18'),(23,4,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_EGhzKDdXy8','2022-02-16 18:17:25','2022-02-16 18:17:25'),(24,7,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_XFWamUpnCQ','2022-02-16 18:27:17','2022-02-16 18:27:17'),(25,3,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_XKWTJkM5uw','2022-02-16 18:32:12','2022-02-16 18:32:12'),(26,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_ZPvOVfyPbU','2022-02-16 18:38:32','2022-02-16 19:33:24'),(27,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_Cnxq1Oaznn','2022-02-16 19:56:58','2022-02-16 20:02:56'),(28,7,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_YxCaaAoIdm','2022-02-16 20:19:15','2022-02-16 20:24:02'),(29,4,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_GWFBjT1skR','2022-02-16 20:19:53','2022-02-16 20:19:53'),(30,7,0,1,'탑텐','https://topten.topten10mall.com/',1,0,NULL,0,'ses_PeAkkbq0gb','2022-02-16 20:24:11','2022-02-16 20:24:27'),(31,2,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_PfKEjNA5OS','2022-02-16 20:28:49','2022-02-16 20:34:49'),(32,2,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_JIh1mEltvr','2022-02-16 20:34:56','2022-02-16 22:22:18'),(33,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_HmmLBhE6Vg','2022-02-16 20:35:47','2022-02-16 20:54:33'),(34,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_Efid7kK7gW','2022-02-16 20:54:53','2022-02-16 20:59:28'),(35,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_Zsru355LgU','2022-02-16 20:59:43','2022-02-16 21:10:12'),(36,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_Ogwonwi6ZZ','2022-02-16 21:10:36','2022-02-16 21:13:01'),(37,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_UKnD32xSx1','2022-02-16 21:13:20','2022-02-16 21:18:18'),(38,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_I6eF2ZXDa5','2022-02-16 21:18:23','2022-02-16 21:21:36'),(39,4,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_IPKADtotjr','2022-02-16 21:19:23','2022-02-16 21:42:16'),(40,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_F3oDX035ny','2022-02-16 21:25:26','2022-02-16 21:38:20'),(41,9,0,12,'미쏘','https://mixxo.elandmall.com/',2,0,NULL,0,'ses_WMuzGKBpPR','2022-02-16 21:38:36','2022-02-16 21:42:02'),(42,9,0,12,'미쏘','https://mixxo.elandmall.com/',2,0,NULL,0,'ses_S1nKQk0wNP','2022-02-16 21:42:34','2022-02-16 21:45:48'),(43,5,0,2,'무신사','https://www.musinsa.com/app/',3,0,NULL,0,'ses_CkRJZRS50k','2022-02-16 21:49:35','2022-02-16 22:29:13'),(44,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_VNNZtc96UA','2022-02-16 22:07:43','2022-02-16 22:20:20'),(45,4,0,2,'무신사','https://www.musinsa.com/app/',1,0,NULL,0,'ses_DBuQJGhu5s','2022-02-16 22:10:10','2022-02-16 22:10:10'),(46,7,0,1,'탑텐','https://topten.topten10mall.com/',6,0,NULL,0,'ses_V847BfOm5r','2022-02-16 22:33:00','2022-02-16 22:33:09'),(47,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_UKN21C2ra6','2022-02-16 22:34:15','2022-02-16 22:43:34'),(48,4,0,2,'무신사','https://www.musinsa.com/app/',3,0,NULL,0,'ses_PwCHfLwFR6','2022-02-16 22:37:48','2022-02-16 22:42:12'),(49,9,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_KeM1BM4gEl','2022-02-16 22:49:06','2022-02-16 22:49:06'),(50,7,0,2,'무신사','https://www.musinsa.com/app/',6,0,NULL,0,'ses_Vj0pR3aI90','2022-02-16 22:50:12','2022-02-16 22:50:16'),(51,4,0,2,'무신사','https://www.musinsa.com/app/',6,0,NULL,0,'ses_EsCy6dlbCT','2022-02-16 22:52:46','2022-02-16 22:58:40'),(52,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_Vx1K5D0vPY','2022-02-16 23:01:31','2022-02-16 23:02:55'),(53,5,0,2,'무신사','https://www.musinsa.com/app/',2,0,NULL,0,'ses_MLQiVRI819','2022-02-16 23:02:25','2022-02-16 23:02:25'),(54,7,0,1,'탑텐','https://topten.topten10mall.com/',6,0,NULL,0,'ses_U9i66wCaKz','2022-02-16 23:10:06','2022-02-16 23:10:11');
/*!40000 ALTER TABLE `shopping_room` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-16 23:37:34
