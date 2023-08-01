-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hosp_vet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hosp_vet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hosp_vet` ;
USE `hosp_vet` ;

-- -----------------------------------------------------
-- Table `hosp_vet`.`tutores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hosp_vet`.`tutores` (
  `tutor_id` INT NOT NULL AUTO_INCREMENT,
  `tutor_nome` VARCHAR(255) NULL DEFAULT NULL,
  `tutor_cpf` VARCHAR(15) UNIQUE NULL DEFAULT NULL,
  `tutor_cel` VARCHAR(15) NULL DEFAULT NULL,
  `tutor_email` VARCHAR(50) NULL DEFAULT NULL,
  `tutor_animal` INT NULL DEFAULT NULL,
  PRIMARY KEY (`tutor_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1111
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `fk_tutor_animal` ON `hosp_vet`.`tutores` (`tutor_animal` ASC) VISIBLE;

CREATE UNIQUE INDEX `tutor_cpf_UNIQUE` ON `hosp_vet`.`tutores` (`tutor_cpf` ASC) VISIBLE;

CREATE UNIQUE INDEX `tutor_email_UNIQUE` ON `hosp_vet`.`tutores` (`tutor_email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `hosp_vet`.`animais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hosp_vet`.`animais` (
  `animal_id` INT NOT NULL AUTO_INCREMENT,
  `animal_chip_numero` VARCHAR(50) UNIQUE NULL DEFAULT NULL,
  `animal_rg` VARCHAR(50) UNIQUE NULL DEFAULT NULL,
  `animal_nome` VARCHAR(50) NULL DEFAULT NULL,
  `animal_especie` VARCHAR(50) NULL DEFAULT NULL,
  `animal_raca` VARCHAR(50) NULL DEFAULT NULL,
  `animal_sexo` VARCHAR(5) NULL DEFAULT NULL,
  `animal_porte` VARCHAR(10) NULL DEFAULT NULL,
  `animal_peso` FLOAT NULL DEFAULT NULL COMMENT '\n',
  `animal_cor` VARCHAR(15) NULL DEFAULT NULL,
  `animal_dob` DATE NULL DEFAULT NULL,
  `animal_tutor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`animal_id`),
  CONSTRAINT `animais_ibfk_1`
    FOREIGN KEY (`animal_tutor`)
    REFERENCES `hosp_vet`.`tutores` (`tutor_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 1006
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `animal_tutor` ON `hosp_vet`.`animais` (`animal_tutor` ASC) VISIBLE;

CREATE UNIQUE INDEX `animal_chip_numero_UNIQUE` ON `hosp_vet`.`animais` (`animal_chip_numero` ASC) VISIBLE;

CREATE UNIQUE INDEX `animal_rg_UNIQUE` ON `hosp_vet`.`animais` (`animal_rg` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `hosp_vet`.`animais_prontuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hosp_vet`.`animais_prontuarios` (
  `animal_id` INT NULL DEFAULT NULL,
  `animal_prontuario_vacinas` VARCHAR(255) NULL DEFAULT NULL,
  `animal_prontuario_ultima_vacina` DATE NULL DEFAULT NULL,
  `animal_prontuario_proxima_vacina` DATE NULL DEFAULT NULL,
  `animal_prontuario_castracao` VARCHAR(5) NULL DEFAULT NULL,
  `animal_prontuario_procedimentos` VARCHAR(255) NULL DEFAULT NULL,
  `animal_prontuario_doencas` VARCHAR(255) NULL DEFAULT NULL,
  CONSTRAINT `animais_prontuarios_ibfk_1`
    FOREIGN KEY (`animal_id`)
    REFERENCES `hosp_vet`.`animais` (`animal_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `animal_id` ON `hosp_vet`.`animais_prontuarios` (`animal_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `hosp_vet`.`funcionarios_enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hosp_vet`.`funcionarios_enderecos` (
  `endereco_id` INT NOT NULL AUTO_INCREMENT,
  `funcionario_id` INT NULL DEFAULT NULL,
  `funcionario_logradouro` VARCHAR(255) NULL DEFAULT NULL,
  `bairro` VARCHAR(50) NULL DEFAULT NULL,
  `cidade` VARCHAR(50) NULL DEFAULT NULL,
  `estado` VARCHAR(2) NULL DEFAULT NULL,
  `cep` VARCHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`endereco_id`),
  CONSTRAINT `funcionarios_enderecos_ibfk_1`
    FOREIGN KEY (`funcionario_id`)
    REFERENCES `hosp_vet`.`funcionarios` (`funcionario_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `funcionario_id` ON `hosp_vet`.`funcionarios_enderecos` (`funcionario_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `hosp_vet`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hosp_vet`.`funcionarios` (
  `funcionario_id` INT NOT NULL AUTO_INCREMENT,
  `funcionario_nome` VARCHAR(255) NULL DEFAULT NULL,
  `crmv` VARCHAR(10) NULL UNIQUE DEFAULT NULL,
  `funcionario_cpf` VARCHAR(15) UNIQUE NULL DEFAULT NULL,
  `funcionario_cel` VARCHAR(15) UNIQUE NULL DEFAULT NULL,
  `funcionario_cargo` VARCHAR(30) NULL DEFAULT NULL,
  `funcionario_end` INT NULL DEFAULT NULL,
  PRIMARY KEY (`funcionario_id`),
  CONSTRAINT `fk_funcionario_end`
    FOREIGN KEY (`funcionario_end`)
    REFERENCES `hosp_vet`.`funcionarios_enderecos` (`funcionario_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 164
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `unique_constraint` ON `hosp_vet`.`funcionarios` (`crmv` ASC) VISIBLE;

CREATE INDEX `fk_funcionario_end` ON `hosp_vet`.`funcionarios` (`funcionario_end` ASC) VISIBLE;

CREATE UNIQUE INDEX `funcionario_cpf_UNIQUE` ON `hosp_vet`.`funcionarios` (`funcionario_cpf` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `hosp_vet`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hosp_vet`.`consultas` (
  `consulta_id` INT NOT NULL AUTO_INCREMENT,
  `consulta_tutor` INT NULL DEFAULT NULL,
  `consulta_medico` INT NULL DEFAULT NULL,
  `consulta_animal` INT NULL DEFAULT NULL,
  `consulta_data` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`consulta_id`),
  CONSTRAINT `consultas_ibfk_1`
    FOREIGN KEY (`consulta_tutor`)
    REFERENCES `hosp_vet`.`tutores` (`tutor_id`),
  CONSTRAINT `consultas_ibfk_2`
    FOREIGN KEY (`consulta_medico`)
    REFERENCES `hosp_vet`.`funcionarios` (`funcionario_id`),
  CONSTRAINT `consultas_ibfk_3`
    FOREIGN KEY (`consulta_animal`)
    REFERENCES `hosp_vet`.`animais` (`animal_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2004
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `consulta_tutor` ON `hosp_vet`.`consultas` (`consulta_tutor` ASC) VISIBLE;

CREATE INDEX `consulta_medico` ON `hosp_vet`.`consultas` (`consulta_medico` ASC) VISIBLE;

CREATE INDEX `consulta_animal` ON `hosp_vet`.`consultas` (`consulta_animal` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
