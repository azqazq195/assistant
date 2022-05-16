CREATE TABLE IF NOT EXISTS `csttec`.`cdept` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_dept_id` INT NULL,
  `cname` VARCHAR(60) NULL,
  `ccode` VARCHAR(15) NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_cteam_cteam1_idx` (`parent_dept_id` ASC),
  CONSTRAINT `fk_cteam_parent_dept_id`
    FOREIGN KEY (`parent_dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;