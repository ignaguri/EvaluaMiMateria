-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema appEncuestadora
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema appEncuestadora
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `appEncuestadora` DEFAULT CHARACTER SET latin1 ;
USE `appEncuestadora` ;

-- -----------------------------------------------------
-- Table `appEncuestadora`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`Rol` (
  `id_rol` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appEncuestadora`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`Usuario` (
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  `legajo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL COMMENT '	',
  `apellido` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_rol`),
  CONSTRAINT `fk_Usuario_Rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `appEncuestadora`.`Rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_Rol1_idx` ON `appEncuestadora`.`Usuario` (`id_rol` ASC);


-- -----------------------------------------------------
-- Table `appEncuestadora`.`Alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`Alumno` (
  `id_alumno` INT NOT NULL,
  `Legajo` VARCHAR(45) NULL,
  PRIMARY KEY (`id_alumno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appEncuestadora`.`Encuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`Encuesta` (
  `id_encuesta` INT NOT NULL,
  `nombre` INT NULL,
  PRIMARY KEY (`id_encuesta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appEncuestadora`.`AlumnoXEncuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`AlumnoXEncuesta` (
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  `id_encuesta` INT NOT NULL,
  `fechainscripcion` DATETIME NULL,
  `criteriospropuestos` VARCHAR(45) NULL,
  PRIMARY KEY (`id_usuario`, `id_rol`, `id_encuesta`),
  CONSTRAINT `fk_AlumnoXEncuesta_Usuario1`
    FOREIGN KEY (`id_usuario` , `id_rol`)
    REFERENCES `appEncuestadora`.`Usuario` (`id_usuario` , `id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AlumnoXEncuesta_Encuesta1`
    FOREIGN KEY (`id_encuesta`)
    REFERENCES `appEncuestadora`.`Encuesta` (`id_encuesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_AlumnoXEncuesta_Usuario1_idx` ON `appEncuestadora`.`AlumnoXEncuesta` (`id_usuario` ASC, `id_rol` ASC);

CREATE INDEX `fk_AlumnoXEncuesta_Encuesta1_idx` ON `appEncuestadora`.`AlumnoXEncuesta` (`id_encuesta` ASC);


-- -----------------------------------------------------
-- Table `appEncuestadora`.`UsuarioXEncuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`UsuarioXEncuesta` (
  `id_encuesta` INT NOT NULL,
  `id_rol` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fechaencuesta` DATETIME NULL,
  `criteriopropuesto` VARCHAR(45) NULL,
  `votoxcriterioxsemana` INT NULL,
  PRIMARY KEY (`id_rol`, `id_usuario`, `id_encuesta`),
  CONSTRAINT `fk_UsuarioXEncuesta_Encuesta1`
    FOREIGN KEY (`id_encuesta`)
    REFERENCES `appEncuestadora`.`Encuesta` (`id_encuesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UsuarioXEncuesta_Usuario1`
    FOREIGN KEY (`id_usuario` , `id_rol`)
    REFERENCES `appEncuestadora`.`Usuario` (`id_usuario` , `id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_UsuarioXEncuesta_Encuesta1_idx` ON `appEncuestadora`.`UsuarioXEncuesta` (`id_encuesta` ASC);

CREATE INDEX `fk_UsuarioXEncuesta_Usuario1_idx` ON `appEncuestadora`.`UsuarioXEncuesta` (`id_usuario` ASC, `id_rol` ASC);


-- -----------------------------------------------------
-- Table `appEncuestadora`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`Curso` (
  `id_curso` INT NOT NULL,
  `turno` VARCHAR(45) NULL,
  PRIMARY KEY (`id_curso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appEncuestadora`.`Materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`Materia` (
  `id_materia` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_materia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appEncuestadora`.`EncuestaXMateriaXCursoXUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`EncuestaXMateriaXCursoXUsuario` (
  `id_materia` INT NOT NULL,
  `id_curso` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  `fechaCreacion` DATETIME NOT NULL,
  `cantidadCriterios` INT NOT NULL,
  `cantidadVotos` INT NOT NULL,
  `fechaFinEtapa2` DATETIME NOT NULL,
  `fechaFinEtapa1` DATETIME NULL,
  `criteriosAVotar` VARCHAR(45) NULL,
  `preguntasDefinidas` VARCHAR(45) NULL,
  PRIMARY KEY (`id_materia`, `id_curso`, `id_usuario`, `id_rol`, `fechaCreacion`),
  CONSTRAINT `fk_EncuestaXMateriaXCursoXUsuario_Materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `appEncuestadora`.`Materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXMateriaXCursoXUsuario_Curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `appEncuestadora`.`Curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXMateriaXCursoXUsuario_Usuario1`
    FOREIGN KEY (`id_usuario` , `id_rol`)
    REFERENCES `appEncuestadora`.`Usuario` (`id_usuario` , `id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_EncuestaXMateriaXCursoXUsuario_Materia1_idx` ON `appEncuestadora`.`EncuestaXMateriaXCursoXUsuario` (`id_materia` ASC);

CREATE INDEX `fk_EncuestaXMateriaXCursoXUsuario_Curso1_idx` ON `appEncuestadora`.`EncuestaXMateriaXCursoXUsuario` (`id_curso` ASC);

CREATE INDEX `fk_EncuestaXMateriaXCursoXUsuario_Usuario1_idx` ON `appEncuestadora`.`EncuestaXMateriaXCursoXUsuario` (`id_usuario` ASC, `id_rol` ASC);


-- -----------------------------------------------------
-- Table `appEncuestadora`.`EncuestaXSemana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appEncuestadora`.`EncuestaXSemana` (
  `id_encuesta` INT NOT NULL,
  `id_materia` INT NOT NULL,
  `id_curso` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  `fechaInicio` DATETIME NULL,
  `fechaFin` DATETIME NULL,
  `totalVotosPreguntas` INT NULL,
  PRIMARY KEY (`id_encuesta`, `id_materia`, `id_curso`, `id_usuario`, `id_rol`),
  CONSTRAINT `fk_EncuestaXSemana_Encuesta1`
    FOREIGN KEY (`id_encuesta`)
    REFERENCES `appEncuestadora`.`Encuesta` (`id_encuesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXSemana_Materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `appEncuestadora`.`Materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXSemana_Curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `appEncuestadora`.`Curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncuestaXSemana_Usuario1`
    FOREIGN KEY (`id_usuario` , `id_rol`)
    REFERENCES `appEncuestadora`.`Usuario` (`id_usuario` , `id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_EncuestaXSemana_Encuesta1_idx` ON `appEncuestadora`.`EncuestaXSemana` (`id_encuesta` ASC);

CREATE INDEX `fk_EncuestaXSemana_Materia1_idx` ON `appEncuestadora`.`EncuestaXSemana` (`id_materia` ASC);

CREATE INDEX `fk_EncuestaXSemana_Curso1_idx` ON `appEncuestadora`.`EncuestaXSemana` (`id_curso` ASC);

CREATE INDEX `fk_EncuestaXSemana_Usuario1_idx` ON `appEncuestadora`.`EncuestaXSemana` (`id_usuario` ASC, `id_rol` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
