-- Adminer 4.7.6 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `todolist`;
CREATE DATABASE `todolist` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `todolist`;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `title` varchar(64) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '0 = non active, 1 = active',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='0 non active, 1 active';

INSERT INTO `categories` (`title`, `status`, `id`) VALUES
('Alimentation',	0,	1);

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `tasks` (`id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(1,	'Acheter une salade',	0,	'2022-08-21 17:13:59',	'2022-08-21 17:13:59'),
(2,	'Rouler sa bosse',	0,	'2022-08-21 17:14:18',	'2022-12-13 18:56:34'),
(4,	'Ranger son assiette',	0,	'2022-12-13 13:40:15',	'2022-12-13 13:40:15'),
(68,	'soiree',	1,	NULL,	'2023-05-15 21:01:54'),
(100,	'Préparer le titre pro',	1,	NULL,	'2023-05-16 09:26:52'),
(101,	'Avancer dans les révisions',	1,	NULL,	'2023-05-16 09:28:00');

DROP TABLE IF EXISTS `task_have_category`;
CREATE TABLE `task_have_category` (
  `category_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`task_id`,`category_id`),
  KEY `category_id` (`category_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_have_category_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`),
  CONSTRAINT `task_have_category_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `task_have_category` (`category_id`, `task_id`) VALUES
(1,	1),
(1,	2);

-- 2023-05-23 10:29:04