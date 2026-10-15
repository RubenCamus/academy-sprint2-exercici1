
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuaris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `naixement` DATE NULL,
  `sexe` ENUM('home', 'done', 'altres') NULL,
  `pais` VARCHAR(45) NULL,
  `codi_postal` INT NULL,
  `tipus_usuari` ENUM('free', 'premium') NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pagaments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagaments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NULL,
  `ordre_id` INT NULL,
  `total` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `ordre_id_UNIQUE` (`ordre_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subscripcions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subscripcions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_inici` DATE NULL,
  `data_renovacio` DATE NULL,
  `metode_targeta` ENUM('targeta', 'paypal') NULL,
  `usuari` INT NULL,
  `pagaments` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `usuari_UNIQUE` (`usuari` ASC),
  INDEX `fk_suscripcions_pagaments_idx` (`pagaments` ASC),
  CONSTRAINT `fk_suscripcions_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suscripcions_pagaments`
    FOREIGN KEY (`pagaments`)
    REFERENCES `mydb`.`pagaments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`targetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`targetes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NULL,
  `mes` INT NULL,
  `any` INT NULL,
  `codi_seguretat` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paypal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom_usuari` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NULL,
  `songs` INT NULL,
  `data_creacio` DATE NULL,
  `tipus` ENUM('activa', 'esborrada') NULL,
  `usuari` INT NULL,
  `playlist_borrada` TINYINT(1) NULL,
  `data_borrada` DATE NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_playlist_usuaris_idx` (`usuari` ASC),
  CONSTRAINT `fk_playlist_usuaris`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist_compartida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist_compartida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuari` INT NULL,
  `song` INT NULL,
  `data_afegit` DATE NULL,
  `id_playlist` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_playlistCompartida_playlist_idx` (`id_playlist` ASC),
  CONSTRAINT `fk_playlistCompartida_playlist`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `mydb`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist_compartida_usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist_compartida_usuaris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist_compartida_id` INT NOT NULL,
  `usuaris_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_playlist_compartida_usuaris_playlist_compartida1_idx` (`playlist_compartida_id` ASC),
  INDEX `fk_playlist_compartida_usuaris_usuaris1_idx` (`usuaris_id` ASC),
  CONSTRAINT `fk_playlist_compartida_usuaris_playlist_compartida1`
    FOREIGN KEY (`playlist_compartida_id`)
    REFERENCES `mydb`.`playlist_compartida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_compartida_usuaris_usuaris1`
    FOREIGN KEY (`usuaris_id`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artista` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `imatge` BLOB NULL,
  `semblants` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_artista_artista1_idx` (`semblants` ASC),
  CONSTRAINT `fk_artista_artista1`
    FOREIGN KEY (`semblants`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `songs` INT NULL,
  `artista` INT NULL,
  `any_publicacio` SMALLINT NULL,
  `imatge` BLOB NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_album_artista_idx` (`artista` ASC),
  CONSTRAINT `fk_album_artista`
    FOREIGN KEY (`artista`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `duracio` INT NULL,
  `reproduccions` INT NULL,
  `album` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_song_album_idx` (`album` ASC),
  CONSTRAINT `fk_song_album`
    FOREIGN KEY (`album`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`favorits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`favorits` (
  `albums` INT NULL,
  `songs` INT NULL,
  `usuari` INT NULL,
  INDEX `fk_favorits_album_idx` (`albums` ASC),
  INDEX `fk_favorits_song_idx` (`songs` ASC),
  INDEX `fk_favorits_usuari_idx` (`usuari` ASC),
  CONSTRAINT `fk_favorits_album`
    FOREIGN KEY (`albums`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorits_song`
    FOREIGN KEY (`songs`)
    REFERENCES `mydb`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorits_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seguidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seguidors` (
  `usuari` INT NULL,
  `artista` INT NULL,
  INDEX `fk_seguidors_usuari_idx` (`usuari` ASC),
  INDEX `fk_seguidors_artista_idx` (`artista` ASC),
  CONSTRAINT `fk_seguidors_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seguidors_artista`
    FOREIGN KEY (`artista`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`metode_pagament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`metode_pagament` (
  `targeta` INT NULL,
  `paypal` INT NULL,
  `subscripcio` INT NULL,
  INDEX `fk_targeta_idx` (`targeta` ASC),
  INDEX `fk_paypal_idx` (`paypal` ASC),
  INDEX `fk_subscripcio_idx` (`subscripcio` ASC),
  CONSTRAINT `fk_targeta`
    FOREIGN KEY (`targeta`)
    REFERENCES `mydb`.`targetes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paypal`
    FOREIGN KEY (`paypal`)
    REFERENCES `mydb`.`paypal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscripcio`
    FOREIGN KEY (`subscripcio`)
    REFERENCES `mydb`.`subscripcions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;