CREATE DATABASE  IF NOT EXISTS `mysite` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mysite`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: mysite
-- ------------------------------------------------------
-- Server version	5.6.16

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add profile',7,'add_profile'),(20,'Can change profile',7,'change_profile'),(21,'Can delete profile',7,'delete_profile'),(22,'Can add meal',8,'add_meal'),(23,'Can change meal',8,'change_meal'),(24,'Can delete meal',8,'delete_meal'),(25,'Can add recipe',9,'add_recipe'),(26,'Can change recipe',9,'change_recipe'),(27,'Can delete recipe',9,'delete_recipe'),(28,'Can add meal recipe',10,'add_mealrecipe'),(29,'Can change meal recipe',10,'change_mealrecipe'),(30,'Can delete meal recipe',10,'delete_mealrecipe'),(31,'Can add ingredient',11,'add_ingredient'),(32,'Can change ingredient',11,'change_ingredient'),(33,'Can delete ingredient',11,'delete_ingredient'),(34,'Can add recipe ingredient',12,'add_recipeingredient'),(35,'Can change recipe ingredient',12,'change_recipeingredient'),(36,'Can delete recipe ingredient',12,'delete_recipeingredient'),(37,'Can add poll',13,'add_poll'),(38,'Can change poll',13,'change_poll'),(39,'Can delete poll',13,'delete_poll'),(40,'Can add choice',14,'add_choice'),(41,'Can change choice',14,'change_choice'),(42,'Can delete choice',14,'delete_choice');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$QPqfcGdIf7eu$7MHLtO4nOPB0XoN1Rv7tiERGAqku6XrYlvsHH2VvZrw=','2014-06-14 22:43:40.655507',1,'ssjkunjin','','','mconatse@gmail.com',1,1,'2014-04-19 02:34:41.203427'),(2,'pbkdf2_sha256$12000$H1h4E48kipNk$WjWUSXLrJDq1nvLG+2JyntGe6ANJBsbHHhv4U+pYGUk=','2014-06-28 15:18:45.156500',1,'sarah','','','smiles8223@hotmail.com',1,1,'2014-04-19 02:35:54.572623');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'profile','menu','profile'),(8,'meal','menu','meal'),(9,'recipe','menu','recipe'),(10,'meal recipe','menu','mealrecipe'),(11,'ingredient','menu','ingredient'),(12,'recipe ingredient','menu','recipeingredient'),(13,'poll','polls','poll'),(14,'choice','polls','choice');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4tt9pu4htkg0bfqt1giy0w78h7p6xw00','NjcwNDg4MjZlMGJmODI4MjJjMzJmN2I1YjcxYWViMDkyZDc4MTQ3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-05-03 03:10:03.024788'),('6brc3gg2sh0g5yktnw4yqzwyj2lsmrch','NjcwNDg4MjZlMGJmODI4MjJjMzJmN2I1YjcxYWViMDkyZDc4MTQ3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-05-22 13:30:46.255904'),('7q3mgjw60qxjaz3s4c2ur5eyda85rg6b','OGE0ZjVlM2QzM2QyOThkMGNjYjM5NDgyYWRhYTY3YzliNzkzOGIxNjp7Il9hdXRoX3VzZXJfaWQiOjEsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-06-28 22:43:40.734511'),('8olz5kzox559b7jproyx6ngrxpgat63y','ODZkNmE0NmQ0OTU0MjgyMTk4MDMxNWJmMmY0OWMzZDM4YzRjMTIwYzp7Il9hdXRoX3VzZXJfaWQiOjIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-07-07 17:29:59.518884'),('gntcxcqa1510s3mwp74h4dedm9mnxzvn','NjcwNDg4MjZlMGJmODI4MjJjMzJmN2I1YjcxYWViMDkyZDc4MTQ3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-07-12 14:50:22.000085'),('u28j4k44kyt1u45ny3k0dv1ay691fnjy','OGE0ZjVlM2QzM2QyOThkMGNjYjM5NDgyYWRhYTY3YzliNzkzOGIxNjp7Il9hdXRoX3VzZXJfaWQiOjEsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-05-31 12:30:04.815310'),('uy18fj4gqcew1rigef0cc2x4vq59eyc1','ODZkNmE0NmQ0OTU0MjgyMTk4MDMxNWJmMmY0OWMzZDM4YzRjMTIwYzp7Il9hdXRoX3VzZXJfaWQiOjIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-07-12 15:18:45.177502'),('vvmxu8ch1rbx27cvr4sht1zf4ntxp4ax','NjcwNDg4MjZlMGJmODI4MjJjMzJmN2I1YjcxYWViMDkyZDc4MTQ3Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-07-12 13:07:26.615874');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_ingredient`
--

DROP TABLE IF EXISTS `menu_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_ingredient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `private` tinyint(1) NOT NULL,
  `name` varchar(60) NOT NULL,
  `category` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_ingredient_5948a8a3` (`profile_id`),
  CONSTRAINT `profile_id_refs_id_1035b2d5` FOREIGN KEY (`profile_id`) REFERENCES `menu_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_ingredient`
--

LOCK TABLES `menu_ingredient` WRITE;
/*!40000 ALTER TABLE `menu_ingredient` DISABLE KEYS */;
INSERT INTO `menu_ingredient` VALUES (1,1,0,'Sugar','spc'),(2,1,1,'Salt','spc'),(3,1,0,'Chicken','met'),(4,2,1,'Broccoli','veg'),(5,2,1,'whole grain Bagel','grn'),(6,2,1,'fat free cream cheese','dry'),(7,2,1,'orange','frt'),(8,2,1,'6 inch tortilla','grn'),(9,2,1,'smoked turkey','met'),(10,2,1,'lettuce','veg'),(11,2,1,'tomato','veg'),(12,2,1,'onion','veg'),(13,2,1,'salsa','cnd'),(14,2,1,'cuke','veg'),(15,2,1,'cherry tomatoes','veg'),(16,2,1,'rice vinegar','cnd'),(17,2,1,'apple','frt'),(18,2,1,'flank steak','met'),(19,2,1,'baked potato','veg'),(20,2,1,'sour cream','dry'),(21,2,1,'green beans','veg'),(22,2,1,'canteloupe','frt'),(23,2,1,'fat free ranch dressing','cnd'),(24,2,1,'skim milk','dry'),(25,2,1,'vegetable soup','mis'),(26,2,1,'yogurt','dry'),(27,2,1,'berries','frt'),(28,2,1,'chicken breast','met'),(29,2,1,'red baby potatoes','veg'),(30,2,1,'parsley','spc'),(31,2,1,'butter','cnd'),(32,2,1,'olive oil','cnd'),(33,2,1,'pear','frt'),(34,2,1,'banana','frt'),(35,2,1,'graham craker','grn'),(36,2,1,'spring mix greens','veg'),(37,2,1,'fat free french dressing','cnd'),(38,2,1,'crispy breadsticks','grn'),(39,2,1,'Salmon','met'),(40,2,1,'radish','veg'),(41,2,1,'lemon juice','cnd'),(42,2,1,'vinegar','cnd'),(43,2,1,'dill weed','spc'),(44,2,1,'black pepper','spc'),(45,2,1,'whole grain roll','grn'),(46,2,1,'wheat crackers','grn'),(47,2,1,'low fat cheddar cheese','dry'),(48,2,1,'whole grain cereal','grn'),(49,2,1,'bell pepper','veg'),(50,2,1,'green onion','veg'),(51,2,1,'tilapia','met'),(52,2,1,'brown rice','grn'),(53,2,1,'yellow squash','veg'),(54,2,1,'zucchini','veg'),(55,2,1,'grapes','frt'),(56,2,1,'peanuts','grn'),(57,2,1,'grapefruit','frt'),(58,2,1,'spinach','veg'),(59,2,1,'water chestnuts','mis'),(60,2,1,'mandarin oranges','frt'),(61,2,1,'whole grain crackers','grn'),(62,2,1,'pork','met'),(63,2,1,'wild rice','grn'),(64,2,1,'asparagus','veg'),(65,2,1,'whipped topping','dry'),(66,2,1,'egg','dry'),(67,2,1,'whole grain bread','grn'),(68,2,1,'orange juice','frt'),(69,2,1,'roast beef','met'),(70,2,1,'dijon mustard','cnd'),(71,2,1,'red onion','veg'),(72,2,1,'baby carrots','veg'),(73,2,1,'shrimp','met'),(74,2,1,'garlic','spc'),(75,2,1,'ginger','spc'),(76,2,1,'sugar snap peas','veg'),(77,2,1,'red bell pepper','veg'),(78,2,1,'canned corn (no salt)','veg'),(79,2,1,'egg substitute','dry'),(80,2,1,'whole wheat flour tortilla','grn'),(81,2,1,'whole grain pita','grn'),(82,2,1,'turkey','met'),(83,2,1,'avacado','veg'),(84,2,1,'tuna','met'),(85,2,1,'mayo','cnd'),(86,2,1,'pickle','cnd'),(87,2,1,'celery','veg'),(88,2,1,'fruit','frt'),(89,2,1,'vegetable','veg'),(90,2,1,'pineapple','frt'),(91,2,1,'pineapple chunks','frt'),(92,2,1,'ham','met'),(93,2,1,'whole grain pasta','grn'),(94,2,1,'cauliflower','veg'),(95,2,1,'parmesan cheese','dry'),(96,2,1,'vanilla yogurt','dry'),(97,2,1,'chicken tenderloins','met');
/*!40000 ALTER TABLE `menu_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_meal`
--

DROP TABLE IF EXISTS `menu_meal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_meal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(3) NOT NULL,
  `date` date NOT NULL,
  `profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_meal_5948a8a3` (`profile_id`),
  CONSTRAINT `profile_id_refs_id_a3afd2bd` FOREIGN KEY (`profile_id`) REFERENCES `menu_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_meal`
--

LOCK TABLES `menu_meal` WRITE;
/*!40000 ALTER TABLE `menu_meal` DISABLE KEYS */;
INSERT INTO `menu_meal` VALUES (1,'bft','2014-04-18',2),(2,'lch','2014-04-19',2),(3,'dnr','2014-04-18',2),(4,'lch','2014-05-29',1),(5,'dnr','2014-05-30',1),(6,'sck','2014-05-30',1),(7,'bft','2014-07-02',2),(8,'lch','2014-07-02',2),(9,'dnr','2014-07-02',2),(10,'sck','2014-07-02',2),(11,'bft','2014-07-03',2),(12,'lch','2014-07-03',2),(13,'dnr','2014-07-03',2),(14,'sck','2014-07-03',2),(15,'bft','2014-07-04',2),(16,'lch','2014-07-04',2),(17,'dnr','2014-07-04',2),(18,'sck','2014-07-04',2),(19,'bft','2014-07-05',2),(20,'lch','2014-07-05',2),(21,'dnr','2014-07-05',2),(22,'sck','2014-07-05',2),(23,'bft','2014-07-06',2),(24,'lch','2014-07-06',2),(25,'dnr','2014-07-06',2),(26,'sck','2014-07-06',2),(27,'bft','2014-07-07',2),(28,'lch','2014-07-07',2),(29,'dnr','2014-07-07',2),(30,'sck','2014-07-07',2),(31,'bft','2014-07-08',2),(32,'lch','2014-07-08',2),(33,'dnr','2014-07-08',2),(34,'sck','2014-07-08',2);
/*!40000 ALTER TABLE `menu_meal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_mealrecipe`
--

DROP TABLE IF EXISTS `menu_mealrecipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_mealrecipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meal_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_mealrecipe_7ebabbcb` (`meal_id`),
  KEY `menu_mealrecipe_fba12377` (`recipe_id`),
  CONSTRAINT `meal_id_refs_id_cba69a47` FOREIGN KEY (`meal_id`) REFERENCES `menu_meal` (`id`),
  CONSTRAINT `recipe_id_refs_id_e7f5bf55` FOREIGN KEY (`recipe_id`) REFERENCES `menu_recipe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_mealrecipe`
--

LOCK TABLES `menu_mealrecipe` WRITE;
/*!40000 ALTER TABLE `menu_mealrecipe` DISABLE KEYS */;
INSERT INTO `menu_mealrecipe` VALUES (1,1,1),(2,1,2),(3,2,1),(4,3,2),(5,4,1),(6,5,3),(7,6,2),(8,7,4),(9,7,5),(10,8,6),(11,8,7),(12,8,8),(13,9,9),(14,10,10),(15,11,4),(16,11,8),(17,11,11),(18,12,12),(19,12,13),(20,13,14),(21,14,15),(22,15,16),(23,16,17),(24,16,8),(25,16,18),(26,17,19),(27,17,20),(28,18,21),(29,19,22),(30,19,5),(31,20,23),(32,20,15),(33,21,24),(34,22,25),(35,23,22),(36,23,26),(37,24,27),(38,24,28),(39,24,29),(40,25,30),(41,26,31),(42,27,32),(43,28,33),(44,28,34),(45,28,35),(46,29,36),(47,30,8),(48,31,37),(49,31,5),(50,32,38),(51,32,8),(52,33,39),(53,34,26);
/*!40000 ALTER TABLE `menu_mealrecipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_profile`
--

DROP TABLE IF EXISTS `menu_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_c40e82dd` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_profile`
--

LOCK TABLES `menu_profile` WRITE;
/*!40000 ALTER TABLE `menu_profile` DISABLE KEYS */;
INSERT INTO `menu_profile` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `menu_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_recipe`
--

DROP TABLE IF EXISTS `menu_recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `profile_id` int(11) NOT NULL,
  `private` tinyint(1) NOT NULL,
  `rating` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `directions` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_recipe_5948a8a3` (`profile_id`),
  CONSTRAINT `profile_id_refs_id_1ce2ebea` FOREIGN KEY (`profile_id`) REFERENCES `menu_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_recipe`
--

LOCK TABLES `menu_recipe` WRITE;
/*!40000 ALTER TABLE `menu_recipe` DISABLE KEYS */;
INSERT INTO `menu_recipe` VALUES (1,'Chicken Tika Masala',2,0,4,'2014-04-19 03:18:57.691369',''),(2,'Beef and Brocolli',2,0,3,'2014-04-19 11:19:06.607097',''),(3,'Sugary Chicken',1,0,3,'2014-05-31 12:27:26.875681',''),(4,'Whole grain bagel with cream cheese',2,1,0,'2014-06-23 16:50:32.430494','Toast bagel and spread on cream cheese'),(5,'orange',2,1,0,'2014-06-23 16:50:52.262628',''),(6,'smoked turkey wrap',2,1,0,'2014-06-23 16:58:34.650075','top tortilla with turkey, lettuce, tomato, onion, and salsa. roll up'),(7,'cucumber and tomato salad',2,1,0,'2014-06-23 17:32:38.439973','combine sliced cuke and halved tomatoes with vinegar to taste'),(8,'apple',2,0,0,'2014-06-23 17:32:55.067925',''),(9,'flank steak dinner',2,1,0,'2014-06-23 17:37:53.519995','marinate in ff french dressing'),(10,'veggie with dip',2,1,0,'2014-06-23 17:39:31.787616',''),(11,'milk',2,1,0,'2014-06-23 17:40:12.692955',''),(12,'veggie soup and salad',2,1,0,'2014-06-23 17:42:37.170219','cut tomato in wedges for salad'),(13,'yogurt n berries',2,1,0,'2014-06-23 17:48:28.842333','mix both and enjoy'),(14,'chicken dinner',2,1,0,'2014-06-23 18:56:11.553601',''),(15,'pear',2,0,0,'2014-06-23 18:56:20.592118',''),(16,'yogurt n banana',2,1,0,'2014-06-23 19:03:41.743350',''),(17,'mixed green salad',2,1,0,'2014-06-23 19:05:00.066830',''),(18,'crispy breadsticks',2,0,0,'2014-06-23 19:05:19.880964',''),(19,'grilled Salmon with sliced cuke and radish',2,1,0,'2014-06-23 19:14:00.562745','1. rub salmon with lemon juice, then 1 tsp of oil. Sprinkle with black pepper if desired. Cut into 8 pieces. Place salmon, skin side down, onto aluminum foil sprayed with cooking spray.\r\n2. In a bowl, combine the remaining ingredients. mix well and refrigerate.\r\n3. Grill or broil at medium to high heat until salmon is flaky but still moist. (For best results use a food thermometer. The internal temperature should be 145 F.)\r\n4. Top each serving of salmon with the cuke radish mixture.'),(20,'berries',2,1,0,'2014-06-23 19:15:32.713016',''),(21,'cheese n crackers',2,1,0,'2014-06-23 19:16:39.681846',''),(22,'cereal',2,1,0,'2014-06-23 19:17:10.275596',''),(23,'grilled chicken salad',2,1,0,'2014-06-23 19:26:21.664133','COMBINE\r\n'),(24,'grilled tilapia dinner',2,1,0,'2014-06-23 19:30:41.747009','Sprinkle fish with lemon juice and basil'),(25,'Peanuts',2,1,0,'2014-06-23 19:31:08.595545',''),(26,'Grapefruit',2,1,0,'2014-06-23 19:31:55.889250',''),(27,'Spinach fruit salad',2,1,0,'2014-06-23 19:34:00.357369',''),(28,'whole grain crackers',2,1,0,'2014-06-23 19:34:46.529010',''),(29,'milk',2,1,0,'2014-06-23 19:34:53.048383',''),(30,'Pork dinner',2,1,0,'2014-06-23 19:36:08.051673',''),(31,'berries n fluff',2,1,0,'2014-06-23 19:36:53.382266',''),(32,'egg breakfast',2,1,0,'2014-06-23 19:38:15.890985','fry egg in nonstick pan'),(33,'roast beef sandwich',2,1,0,'2014-06-23 19:39:59.316900',''),(34,'baby carrots',2,1,0,'2014-06-23 19:40:24.388334',''),(35,'grapes',2,1,0,'2014-06-23 19:40:42.851391',''),(36,'Shrimp stir fry dinner',2,1,0,'2014-06-23 19:47:24.568367','1. Saute garlic and ginger in oil in large skillet until fragrant.\r\n2. Stir in peas, and chopped bell pepper if desired. Saute until tender crisp.\r\n3. Stir in shrimp. cook over medium heat 3 to 4 minutes until shrimp are just opaque in centers.\r\n4. Serve with steamed rice.'),(37,'Breakfast burrito',2,1,0,'2014-06-23 19:53:29.209224','1. In small skillet, add the chopped tomato, onion, and corn. Cook over medium heat until the veggies are soft and moisture is evaporated.\r\n2. Add the egg substitute and scramble with the veggies until cooked through, about 3 minutes.\r\n3. Spread the egg mixture in the center of the tortilla and top with salsa. Fold both sides of the tortilla up over the filling, then roll to close. Serve immediately.'),(38,'Turkey pita sandwich',2,1,0,'2014-06-23 19:56:02.326982','stuff in pita'),(39,'Tuna stuffed tomato dinner',2,1,0,'2014-06-23 19:59:11.297790','drain tuna\r\nmix with mayo\r\nseason with black pepper and pickle\r\ncore and partially quarter tomato and stuff with tuna');
/*!40000 ALTER TABLE `menu_recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_recipeingredient`
--

DROP TABLE IF EXISTS `menu_recipeingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_recipeingredient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `amount` decimal(5,2) NOT NULL,
  `unit` varchar(4) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_recipeingredient_fba12377` (`recipe_id`),
  KEY `menu_recipeingredient_8cbc2862` (`ingredient_id`),
  CONSTRAINT `ingredient_id_refs_id_ccd05cc2` FOREIGN KEY (`ingredient_id`) REFERENCES `menu_ingredient` (`id`),
  CONSTRAINT `recipe_id_refs_id_9fa332db` FOREIGN KEY (`recipe_id`) REFERENCES `menu_recipe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_recipeingredient`
--

LOCK TABLES `menu_recipeingredient` WRITE;
/*!40000 ALTER TABLE `menu_recipeingredient` DISABLE KEYS */;
INSERT INTO `menu_recipeingredient` VALUES (1,1,3.00,'none',3),(2,2,25.00,'gal',1),(3,3,4.00,'c',1),(4,3,3.00,'gal',3),(5,3,5.00,'lb',2),(6,4,1.00,'none',5),(7,4,3.00,'tbsp',6),(8,6,1.00,'none',8),(9,6,3.00,'oz',9),(10,6,0.25,'none',10),(11,6,0.25,'none',11),(12,6,0.25,'none',12),(13,6,2.00,'tbsp',13),(14,7,0.50,'c',14),(15,7,4.00,'none',15),(16,7,1.00,'tbsp',16),(17,9,3.00,'oz',18),(18,9,0.50,'none',19),(19,9,2.00,'tbsp',20),(20,9,0.66,'c',21),(21,9,0.25,'none',22),(22,10,1.00,'none',89),(23,10,3.00,'tbsp',23),(24,11,1.00,'c',24),(25,12,1.00,'c',25),(26,12,2.00,'c',10),(27,12,1.00,'none',11),(28,12,2.00,'tbsp',23),(29,13,1.00,'c',26),(30,13,0.75,'c',27),(31,14,2.50,'oz',3),(32,14,3.00,'none',29),(33,14,0.25,'tsp',30),(34,14,2.00,'c',4),(35,14,2.00,'tsp',31),(36,16,1.00,'c',26),(37,16,1.00,'none',34),(38,16,1.00,'none',35),(39,17,2.00,'c',36),(40,17,0.50,'none',11),(41,17,0.50,'none',14),(42,17,2.00,'tbsp',37),(43,18,2.00,'none',38),(44,19,2.00,'lb',39),(45,19,1.00,'tsp',41),(46,19,1.00,'tbsp',32),(47,19,2.00,'c',14),(48,19,0.75,'c',40),(49,19,2.00,'tbsp',42),(50,19,0.25,'tsp',43),(51,19,1.00,'none',45),(52,19,1.00,'tsp',31),(53,20,0.75,'c',27),(54,21,8.00,'none',46),(55,21,2.00,'oz',47),(56,22,1.00,'c',48),(57,22,1.00,'c',24),(58,23,2.00,'c',36),(59,23,2.50,'oz',28),(60,23,1.00,'c',15),(61,23,0.50,'none',49),(62,23,0.25,'none',50),(63,23,1.00,'tsp',32),(64,23,2.00,'tbsp',16),(65,24,3.00,'oz',51),(66,24,0.66,'c',52),(67,24,0.75,'c',53),(68,24,0.75,'c',54),(69,24,1.00,'tsp',31),(70,24,1.00,'c',55),(71,25,8.00,'none',56),(72,26,0.50,'none',57),(73,27,2.00,'c',58),(74,27,0.50,'c',49),(75,27,0.50,'c',59),(76,27,0.75,'c',60),(77,27,2.00,'tbsp',37),(78,28,8.00,'none',61),(79,29,1.00,'c',24),(80,30,3.00,'oz',62),(81,30,0.50,'c',63),(82,30,1.00,'c',64),(83,30,2.00,'tsp',31),(84,31,0.75,'c',27),(85,31,0.50,'c',65),(86,32,1.00,'none',66),(87,32,1.00,'none',67),(88,32,2.00,'tsp',31),(89,32,0.50,'c',68),(90,33,1.00,'none',45),(91,33,1.50,'oz',69),(92,33,1.00,'tsp',70),(93,33,0.25,'none',10),(94,33,0.25,'none',11),(95,33,0.25,'none',71),(96,34,0.50,'c',72),(97,35,1.00,'c',55),(98,36,2.00,'none',74),(99,36,0.13,'tsp',75),(100,36,1.00,'tbsp',32),(101,36,0.50,'lb',76),(102,36,0.50,'c',49),(103,36,12.00,'oz',73),(104,36,0.33,'c',52),(105,36,2.00,'c',36),(106,36,2.00,'tbsp',23),(107,37,0.50,'c',11),(108,37,2.00,'tsp',12),(109,37,0.25,'c',78),(110,37,0.25,'c',79),(111,37,1.00,'none',80),(112,37,2.00,'tbsp',13),(113,38,0.50,'none',81),(114,38,3.00,'oz',82),(115,38,0.17,'none',83),(116,38,0.25,'none',10),(117,38,0.25,'none',11),(118,38,0.25,'none',12),(119,39,3.00,'oz',84),(120,39,4.00,'tsp',85),(121,39,0.25,'none',86),(122,39,4.00,'none',87),(123,39,6.00,'none',46);
/*!40000 ALTER TABLE `menu_recipeingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polls_choice`
--

DROP TABLE IF EXISTS `polls_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polls_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) NOT NULL,
  `choice_text` varchar(200) NOT NULL,
  `votes` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `polls_choice_70f78e6b` (`poll_id`),
  CONSTRAINT `poll_id_refs_id_3aa09835` FOREIGN KEY (`poll_id`) REFERENCES `polls_poll` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polls_choice`
--

LOCK TABLES `polls_choice` WRITE;
/*!40000 ALTER TABLE `polls_choice` DISABLE KEYS */;
/*!40000 ALTER TABLE `polls_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polls_poll`
--

DROP TABLE IF EXISTS `polls_poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polls_poll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(200) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polls_poll`
--

LOCK TABLES `polls_poll` WRITE;
/*!40000 ALTER TABLE `polls_poll` DISABLE KEYS */;
/*!40000 ALTER TABLE `polls_poll` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-28 13:07:30
