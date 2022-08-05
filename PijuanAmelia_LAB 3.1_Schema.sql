CREATE SCHEMA `sakila`;

CREATE TABLE `sakila`.`actor` (
  `actor_id` SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `film_id` SMALLINT NOT NULL,
  `last_update` TIMESTAMP
);

CREATE TABLE `sakila`.`address` (
  `address_id` SMALLINT PRIMARY KEY AUTO_INCREMENT,
  `address` VARCHAR(50),
  `address2` VARCHAR(50),
  `district` VARCHAR(20),
  `city` VARCHAR(50) NOT NULL,
  `postal_code` VARCHAR(10),
  `country` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(20),
  `last_update` TIMESTAMP
);

CREATE TABLE `sakila`.`customer` (
  `customer_id` SMALLINT PRIMARY KEY NOT NULL,
  `store_id` TINYINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `address_id` SMALLINT NOT NULL,
  `active` BOOLEAN NOT NULL,
  `create_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `sakila`.`film` (
  `film_id` SMALLINT PRIMARY KEY NOT NULL,
  `title` VARCHAR(128) NOT NULL,
  `description` TEXT NOT NULL,
  `release_year` YEAR NOT NULL,
  `language` VARCHAR(25) NOT NULL,
  `category` VARCHAR(25) NOT NULL,
  `rental_duration` TINYINT NOT NULL,
  `rental_rate` DECIMAL(4,2) NOT NULL,
  `length` SMALLINT NOT NULL,
  `replacement_cost` DECIMAL(5,2) NOT NULL,
  `rating` ENUM DEFAULT (G),
  `special_features` SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT null,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `sakila`.`rental` (
  `rental_id` INT PRIMARY KEY NOT NULL,
  `rental_date` DATETIME NOT NULL,
  `inventory_id` MEDIUMINT NOT NULL,
  `customer_id` SMALLINT NOT NULL,
  `return_date` DATETIME NOT NULL,
  `staff_id` TINYINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `sakila`.`staff` (
  `staff_id` TINYINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address_id` SMALLINT NOT NULL,
  `picture` BLOB DEFAULT null,
  `email` VARCHAR(50) DEFAULT null,
  `store_id` TINYINT NOT NULL,
  `active` BOOLEAN NOT NULL DEFAULT True,
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(40) DEFAULT null,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `sakila`.`store` (
  `store_id` TINYINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `staff_id` TINYINT NOT NULL AUTO_INCREMENT,
  `manager_staff_id` TINYINT NOT NULL,
  `address_id` SMALLINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

CREATE TABLE `sakila`.`payment` (
  `payment_id` SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_id` SMALLINT NOT NULL,
  `staff_id` TINYINT NOT NULL,
  `rental_id` INT DEFAULT null,
  `amount` DECIMAL(5,2) NOT NULL,
  `payment_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP
);

CREATE TABLE `sakila`.`inventory` (
  `inventory_id` MEDIUMINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `film_id` SMALLINT NOT NULL,
  `store_id` TINYINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL
);

ALTER TABLE `sakila`.`film` ADD FOREIGN KEY (`film_id`) REFERENCES `sakila`.`inventory` (`film_id`);

ALTER TABLE `sakila`.`customer` ADD FOREIGN KEY (`customer_id`) REFERENCES `sakila`.`payment` (`customer_id`);

ALTER TABLE `sakila`.`store` ADD FOREIGN KEY (`store_id`) REFERENCES `sakila`.`customer` (`store_id`);

ALTER TABLE `sakila`.`address` ADD FOREIGN KEY (`address_id`) REFERENCES `sakila`.`customer` (`address_id`);

ALTER TABLE `sakila`.`store` ADD FOREIGN KEY (`address_id`) REFERENCES `sakila`.`address` (`address_id`);

ALTER TABLE `sakila`.`payment` ADD FOREIGN KEY (`staff_id`) REFERENCES `sakila`.`store` (`staff_id`);

ALTER TABLE `sakila`.`rental` ADD FOREIGN KEY (`rental_id`) REFERENCES `sakila`.`payment` (`rental_id`);

ALTER TABLE `sakila`.`inventory` ADD FOREIGN KEY (`inventory_id`) REFERENCES `sakila`.`rental` (`inventory_id`);

ALTER TABLE `sakila`.`customer` ADD FOREIGN KEY (`customer_id`) REFERENCES `sakila`.`rental` (`customer_id`);

ALTER TABLE `sakila`.`staff` ADD FOREIGN KEY (`staff_id`) REFERENCES `sakila`.`rental` (`staff_id`);

ALTER TABLE `sakila`.`address` ADD FOREIGN KEY (`address_id`) REFERENCES `sakila`.`staff` (`address_id`);

ALTER TABLE `sakila`.`store` ADD FOREIGN KEY (`store_id`) REFERENCES `sakila`.`staff` (`store_id`);

ALTER TABLE `sakila`.`payment` ADD FOREIGN KEY (`staff_id`) REFERENCES `sakila`.`rental` (`staff_id`);

ALTER TABLE `sakila`.`film` ADD FOREIGN KEY (`film_id`) REFERENCES `sakila`.`actor` (`film_id`);

ALTER TABLE `sakila`.`store` ADD FOREIGN KEY (`store_id`) REFERENCES `sakila`.`inventory` (`store_id`);

ALTER TABLE `sakila`.`staff` ADD FOREIGN KEY (`staff_id`) REFERENCES `sakila`.`store` (`staff_id`);
