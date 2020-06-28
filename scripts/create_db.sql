-- MySQL Script generated by MySQL Workbench
-- Wed May 27 17:00:35 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema recordingcenter
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema recordingcenter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `recordingcenter` DEFAULT CHARACTER SET utf8 ;
USE `recordingcenter` ;

-- -----------------------------------------------------
-- Table `recordingcenter`.`Музыкальная_группа`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Музыкальная_группа` (
  `Номер_группы` INT NOT NULL AUTO_INCREMENT,
  `Название` VARCHAR(45) NOT NULL,
  `Стиль_музыки` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Номер_группы`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Музыкант`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Музыкант` (
  `Номер_паспорта` INT NOT NULL,
  `ФИО` VARCHAR(100) NOT NULL,
  `Позиция` VARCHAR(10) NOT NULL,
  `Номер_группы` INT NOT NULL,
  PRIMARY KEY (`Номер_паспорта`),
  INDEX `Номер_группы_idx` (`Номер_группы` ASC),
  CONSTRAINT `Номер_группы`
    FOREIGN KEY (`Номер_группы`)
    REFERENCES `recordingcenter`.`Музыкальная_группа` (`Номер_группы`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Альбом`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Альбом` (
  `Номер_альбома` INT NOT NULL AUTO_INCREMENT,
  `Название` VARCHAR(45) NOT NULL,
  `Количество_треков` INT NOT NULL,
  `Длина` TIME NOT NULL,
  PRIMARY KEY (`Номер_альбома`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Сотрудник`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Сотрудник` (
  `Номер_паспорта` INT NOT NULL,
  `Должность` VARCHAR(20) NOT NULL,
  `ФИО` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Номер_паспорта`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Музыкальный_инструмент`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Музыкальный_инструмент` (
  `Номер_инструмента` INT NOT NULL AUTO_INCREMENT,
  `Тип_инструмента` VARCHAR(20) NOT NULL,
  `Страна_производства` VARCHAR(20) NOT NULL,
  `Номер_музыканта` INT NOT NULL,
  PRIMARY KEY (`Номер_инструмента`),
  INDEX `Номер_музыканта_idx` (`Номер_музыканта` ASC) ,
  CONSTRAINT `Номер_музыканта`
    FOREIGN KEY (`Номер_музыканта`)
    REFERENCES `recordingcenter`.`Музыкант` (`Номер_паспорта`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Оборудование`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Оборудование` (
  `Инвентарный_номер` INT NOT NULL AUTO_INCREMENT,
  `Тип_оборудования` VARCHAR(45) NOT NULL,
  `Номер_сотрудника` INT NOT NULL,
  PRIMARY KEY (`Инвентарный_номер`),
  INDEX `Номер_сотрудника_idx` (`Номер_сотрудника` ASC) ,
  CONSTRAINT `Номер_сотрудника`
    FOREIGN KEY (`Номер_сотрудника`)
    REFERENCES `recordingcenter`.`Сотрудник` (`Номер_паспорта`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Запись_альбома`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Запись_альбома` (
  `Номер_сессии` INT NOT NULL,
  `Номер_альбома` INT NOT NULL,
  `Номер_группы` INT NOT NULL,
  `Номер_сотрудника` INT NOT NULL,
  `Дата_записи` DATE NOT NULL,
  PRIMARY KEY (`Номер_сессии`),
  INDEX `Номер_альбома_idx` (`Номер_альбома` ASC) ,
  INDEX `Номер_группы_idx` (`Номер_группы` ASC) ,
  INDEX `Номер_сотрудника_idx` (`Номер_сотрудника` ASC) ,
  CONSTRAINT `Номер_альбома_idx`
    FOREIGN KEY (`Номер_альбома`)
    REFERENCES `recordingcenter`.`Альбом` (`Номер_альбома`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Номер_группы_idx`
    FOREIGN KEY (`Номер_группы`)
    REFERENCES `recordingcenter`.`Музыкальная_группа` (`Номер_группы`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Номер_сотрудника_idx`
    FOREIGN KEY (`Номер_сотрудника`)
    REFERENCES `recordingcenter`.`Сотрудник` (`Номер_паспорта`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Участие_в_записи`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Участие_в_записи` (
  `Номер_музыканта` INT NOT NULL,
  `Номер_альбома` INT NOT NULL,
  INDEX `Номер_альбома_idx` (`Номер_альбома` ASC),
  INDEX `Номер_музыканта_idx` (`Номер_музыканта` ASC),
  CONSTRAINT `н_музыканта_idx`
    FOREIGN KEY (`Номер_музыканта`)
    REFERENCES `recordingcenter`.`Музыкант` (`Номер_паспорта`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `н_альбома_idx`
    FOREIGN KEY (`Номер_альбома`)
    REFERENCES `recordingcenter`.`Альбом` (`Номер_альбома`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recordingcenter`.`Запись_соло_исполнителя`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recordingcenter`.`Запись_соло_исполнителя` (
  `Номер_сессии` INT NOT NULL,
  `Номер_музыканта` INT NOT NULL,
  `Номер_сотрудника` INT NOT NULL,
  `Номер_инструмента` INT NOT NULL,
  PRIMARY KEY (`Номер_сессии`),
  INDEX `Номер_музыканта_idx` (`Номер_музыканта` ASC),
  INDEX `Номер_сотрудника_idx` (`Номер_сотрудника` ASC),
  INDEX `Номер_инструмента_idx` (`Номер_инструмента` ASC),
  CONSTRAINT `н_музыканта`
    FOREIGN KEY (`Номер_музыканта`)
    REFERENCES `recordingcenter`.`Музыкант` (`Номер_паспорта`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `н_сотрудника`
    FOREIGN KEY (`Номер_сотрудника`)
    REFERENCES `recordingcenter`.`Сотрудник` (`Номер_паспорта`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `н_инструмента`
    FOREIGN KEY (`Номер_инструмента`)
    REFERENCES `recordingcenter`.`Музыкальный_инструмент` (`Номер_инструмента`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
