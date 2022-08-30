DROP SCHEMA IF EXISTS `flashcards`;
CREATE SCHEMA `flashcards`;

USE `flashcards`;

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(1000) NOT NULL,
  `name` varchar(1000) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sets` (
  `set_name` varchar(500) NOT NULL,
  `owner` int NOT NULL,
  `set_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(2000) DEFAULT NULL,
  `card_number` int DEFAULT NULL,
  `accuracy` double DEFAULT NULL,
  `private` tinyint DEFAULT NULL,
  PRIMARY KEY (`set_id`),
  KEY `user_id_idx` (`owner`),
  CONSTRAINT `user_id` FOREIGN KEY (`owner`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cards` (
  `set_id` int NOT NULL,
  `term` varchar(1000) DEFAULT NULL,
  `def` varchar(2000) DEFAULT NULL,
  `tries` int DEFAULT NULL,
  `sucesses` varchar(45) DEFAULT NULL,
  `cardID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cardID`),
  KEY `set_id_idx` (`set_id`),
  CONSTRAINT `set_id` FOREIGN KEY (`set_id`) REFERENCES `sets` (`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
