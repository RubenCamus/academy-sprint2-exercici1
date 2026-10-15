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
  `nom` VARCHAR(45) NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `data_naixement` DATE NULL,
  `sexe` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `codi_postal` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(255) NULL,
  `descripcio` VARCHAR(45) NULL,
  `tamany` INT NULL,
  `nom_arxiu` VARCHAR(45) NULL,
  `durada` INT NULL,
  `thumbnail` BLOB NULL,
  `reproduccions` INT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `estat` ENUM('public', 'ocult', 'privat') NULL,
  `usuari` INT NULL,
  `data_publicacio` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_videos_usuari_idx` (`usuari` ASC),
  CONSTRAINT `fk_videos_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`etiqueta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`canals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`canals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(45) NULL,
  `data_creacio` DATETIME NULL,
  `usuari` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canals_usuari_idx` (`usuari` ASC),
  CONSTRAINT `fk_canals_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `data_creacio` DATETIME NULL,
  `estat` ENUM('public', 'privat') NULL,
  `usuari` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_usuari_idx` (`usuari` ASC),
  CONSTRAINT `fk_playlist_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`likes_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`likes_video` (
  `video` INT NULL,
  `tipus_like` ENUM('like', 'dislike') NULL,
  `data` DATETIME NULL,
  `usuari` INT NULL,
  INDEX `fk_video_idx` (`video` ASC),
  INDEX `fk_usuari_idx` (`usuari` ASC),
  CONSTRAINT `fk_video`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comentaris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(45) NULL,
  `data` DATETIME NULL,
  `likes` INT NULL,
  `video` INT NULL,
  `usuari` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentaris_video_idx` (`video` ASC),
  INDEX `fk_comentaris_usuari_idx` (`usuari` ASC),
  CONSTRAINT `fk_comentaris_video`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentaris_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`likes_comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`likes_comentaris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentari` INT NULL,
  `tipus_like` ENUM('like', 'dislike') NULL,
  `usuari` INT NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_likes_comentari_idx` (`comentari` ASC),
  INDEX `fk_likes_usuari_idx` (`usuari` ASC),
  UNIQUE INDEX `usuari_UNIQUE` (`usuari` ASC),
  CONSTRAINT `fk_likes_comentari`
    FOREIGN KEY (`comentari`)
    REFERENCES `mydb`.`comentaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`etiqueta_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`etiqueta_video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `video` INT NULL,
  `etiqueta` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_etiquetaVideo_video_idx` (`video` ASC),
  INDEX `fk_etiquetaVideo_etiqueta_idx` (`etiqueta` ASC),
  CONSTRAINT `fk_etiquetaVideo_video`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etiquetaVideo_etiqueta`
    FOREIGN KEY (`etiqueta`)
    REFERENCES `mydb`.`etiqueta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist_videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist` INT NULL,
  `video` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlistVideo_playlist_idx` (`playlist` ASC),
  INDEX `fk_playlistVideo_video_idx` (`video` ASC),
  CONSTRAINT `fk_playlistVideo_playlist`
    FOREIGN KEY (`playlist`)
    REFERENCES `mydb`.`playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlistVideo_video`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subscriptores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subscriptores` (
  `canal` INT NULL,
  `usuari` INT NULL,
  INDEX `fk_usuaris_idx` (`usuari` ASC),
  INDEX `fk_canals_idx` (`canal` ASC),
  CONSTRAINT `fk_usuaris`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canals`
    FOREIGN KEY (`canal`)
    REFERENCES `mydb`.`canals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;