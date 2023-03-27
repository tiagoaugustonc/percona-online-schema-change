-- Create tables

CREATE TABLE `country` (
    `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE `city` (
    `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `country_id` smallint(5) unsigned NOT NULL,
    `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_fk_country_id` (`country_id`),
    CONSTRAINT `fk_city_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
