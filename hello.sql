SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;


CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` text NOT NULL,
  `tokenVersion` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_4ba6d0c734d53f8e1b2e24b6c5` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

INSERT INTO `admins` (`id`, `username`, `password`, `tokenVersion`) VALUES
	(1,'berkasse','$2b$05$dI8zHNHCIEajpd3CgocojOFEMmtQBW9xYZ4TXRM6basp/vVNKg2JS',1),
	(4,'brahim','$2b$05$m3wZj5x8VZR0INkMimI/YuonAOBJ5dMQTAyt.9chQ6T6d6BpZTHpG',1);

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `attribute_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL DEFAULT 0,
  `elementId` int(11) DEFAULT NULL,
  `attributeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_d5b348dfc104b610723ce16981d` (`attributeId`),
  KEY `FK_04cca6d7fa0b649ddec9d2c5191` (`elementId`),
  CONSTRAINT `FK_04cca6d7fa0b649ddec9d2c5191` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_d5b348dfc104b610723ce16981d` FOREIGN KEY (`attributeId`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;

INSERT INTO `attribute_elements` (`id`, `price`, `elementId`, `attributeId`) VALUES
	(51,'0',48,17),
	(52,'0',50,17),
	(53,'0',49,17);

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `min` int(11) NOT NULL DEFAULT 0,
  `max` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

INSERT INTO `attributes` (`id`, `title`, `min`, `max`) VALUES
	(17,'Sauce',1,1);

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `index` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `status`, `index`) VALUES
	(39,'Poke Bowl',NULL,NULL,1,'0'),
	(40,'Make your own',NULL,NULL,1,5),
	(41,'Toast',NULL,NULL,1,4),
	(42,'Smoothie Bowl',NULL,NULL,1,2),
	(44,'Buddah Bowl',NULL,NULL,1,1),
	(45,'Proteine Bowl',NULL,NULL,1,6),
	(46,'Smoothie',NULL,NULL,1,3);

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;

INSERT INTO `elements` (`id`, `title`, `image`, `status`) VALUES
	(20,'Soja Salee',NULL,1),
	(21,'Sauce Sucree',NULL,1),
	(22,'Pomme Fruit',NULL,1),
	(23,'Avocado ',NULL,1),
	(24,'Ponzu',NULL,1),
	(25,'Spicy Mayo',NULL,1),
	(26,'Sweet Chilli',NULL,1),
	(27,'Yaourt',NULL,1),
	(28,'Riz Rasmati','/uploads/elements/1625095108232-rz.png',1),
	(29,'Qunioa ','/uploads/elements/1626389948270-1625095158709-grg.png',1),
	(30,'Carrote','/uploads/elements/1625095206517-crt.png',1),
	(31,'Poivron','/uploads/elements/1625095228421-fl.png',1),
	(32,'Concombre','/uploads/elements/1625095247153-cc.png',1),
	(33,'Chou Rouge','/uploads/elements/1625095272597-cr.png',1),
	(34,'Tomate Cerise','/uploads/elements/1625095292202-tm.png',1),
	(35,'Radis','/uploads/elements/1625095311204-rvrv.png',1),
	(36,'Edamame','/uploads/elements/1625095420352-lb.png',1),
	(37,'Wakame','/uploads/elements/1625095452953-bvg.png',1),
	(38,'Avocat','/uploads/elements/1625095470183-av.png',1),
	(39,'Mangue','/uploads/elements/1625095488450-mng.png',1),
	(40,'Ananas','/uploads/elements/1625095498295-an.png',1),
	(41,'Noix de cajou',NULL,1),
	(42,'Saumon','/uploads/elements/1625095632057-sm.jpg',1),
	(43,'Thon','/uploads/elements/1625095653535-th.png',1),
	(44,'Tofu','/uploads/elements/1625095685771-fr.png',1),
	(45,'Poulet teryaki','/uploads/elements/1625095719813-sm.jpg',1),
	(46,'Gambas','/uploads/elements/1625095766586-th.png',1),
	(47,'Duo','/uploads/elements/1625095797987-bn.png',1),
	(48,'Soja salees',NULL,1),
	(49,'Soja sucree',NULL,1),
	(50,'Pomme fruit',NULL,1);

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `main` tinyint(4) NOT NULL DEFAULT 0,
  `productId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_7af50639264735c79e918af6089` (`productId`),
  CONSTRAINT `FK_7af50639264735c79e918af6089` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

INSERT INTO `images` (`id`, `path`, `main`, `productId`) VALUES
	(20,'/uploads/1625096596464-HF.png',1,19),
	(22,'/uploads/1625592742215-HF.png',1,21),
	(24,'/uploads/1625592893009-HF.png',1,NULL),
	(25,'/uploads/1626044359729-10707609.jpeg',1,NULL),
	(26,'/uploads/1626044374466-10707609.jpeg',1,NULL),
	(27,'/uploads/1626044707340-10707609.jpeg',1,NULL),
	(28,'/uploads/1626044721214-10707609.jpeg',1,NULL),
	(29,'/uploads/1626105020377-1625592742215-HF.png',1,NULL),
	(30,'/uploads/1626105077962-1625592742215-HF.png',1,23),
	(31,'/uploads/1626397709188-217377965_543782033476525_8724175102318223737_n.png',1,24),
	(33,'/uploads/1626397817623-217377965_543782033476525_8724175102318223737_n.png',1,26),
	(34,'/uploads/1626397872013-217377965_543782033476525_8724175102318223737_n.png',1,27),
	(35,'/uploads/1626398126759-217377965_543782033476525_8724175102318223737_n.png',1,28);

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `price` double NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `have_attribute` tinyint(4) NOT NULL DEFAULT 0,
  `attribute_picutres` tinyint(4) NOT NULL DEFAULT 0,
  `index` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_ff56834e735fa78a15d0cf21926` (`categoryId`),
  CONSTRAINT `FK_ff56834e735fa78a15d0cf21926` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

INSERT INTO `products` (`id`, `title`, `description`, `categoryId`, `price`, `status`, `have_attribute`, `attribute_picutres`, `index`) VALUES
	(19,'Composer To Poke','make your own bowl',40,'0',1,1,1,2),
	(21,'Bowl Test','saumon marine riz basmati parfume - avocat - chou rouge edamame, mangue. pickles d\'oignon, graines de sesame. graines de chia . sauce: pomme fruit',40,'0',1,1,1,1),
	(23,'Bowl With Text !','make your own bowl',40,10,1,1,'0','0'),
	(24,'SAUMON','Saumon marine, riz basmati parfume , avocat, chou rouge edamame, mangue, pickles d\'oignon, graines de sesame, graines de chia . sauce: pomme fruit',39,85,1,1,'0','0'),
	(26,'VEGAN','Tofu marine quinoa parfume, concombre, edamame radis, carotte, noix de cajou, wakame, graines de sesame, graines de chia, sauce avocado',39,75,1,'0','0','0'),
	(27,'DUO','saumon et thon rouge marine quinoa parfume, carotte, edamame avocat, chou rouge, wakame, graines de sesame, graines de chia, sauce ponzu',39,87,1,'0','0','0'),
	(28,'POULET TERAYKI','Poulet marine riz basmati parfume, carotte, edamame avocat, poivron pickles d\'oignon, graines de sesame, graines de chia, sauce poireau',39,80,1,'0','0','0');

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `products_attributes_attributes` (
  `productsId` int(11) NOT NULL,
  `attributesId` int(11) NOT NULL,
  PRIMARY KEY (`productsId`,`attributesId`),
  KEY `IDX_fce36fa54495d98046d94f9925` (`productsId`),
  KEY `IDX_a3801a7c702341aab095b82dfc` (`attributesId`),
  CONSTRAINT `FK_a3801a7c702341aab095b82dfc1` FOREIGN KEY (`attributesId`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_fce36fa54495d98046d94f99253` FOREIGN KEY (`productsId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `products_attributes_attributes` (`productsId`, `attributesId`) VALUES
	(24,17);

-- ------------------------------------------------ 



CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updated_at` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `tokenVersion` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_97672ac88f789774dd47f7c8be` (`email`),
  UNIQUE KEY `IDX_a000cca60bcf04454e72769949` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;



-- ------------------------------------------------ 

