-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema telephone
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema telephone
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `telephone` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema telephone
-- -----------------------------------------------------
USE `telephone` ;

-- -----------------------------------------------------
-- Table `telephone`.`contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telephone`.`contact` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `category` ENUM('friend', 'company', 'family', 'etc') NULL DEFAULT 'friend',
  `address` VARCHAR(50) NULL DEFAULT '',
  `company` VARCHAR(50) NULL DEFAULT '',
  `birthday` DATE NULL,
  PRIMARY KEY (`cid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telephone`.`phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telephone`.`phone` (
  `cid` INT NOT NULL,
  `seq` INT NOT NULL,
  `number` VARCHAR(20) NULL DEFAULT '',
  `type` ENUM('mobile', 'home', 'company', 'fax', 'etc') NULL DEFAULT 'mobile',
  INDEX `fk_phone_contact_idx` (`cid` ASC) VISIBLE,
  PRIMARY KEY (`seq`),
  CONSTRAINT `fk_phone_contact`
    FOREIGN KEY (`cid`)
    REFERENCES `telephone`.`contact` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
