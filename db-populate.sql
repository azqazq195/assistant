-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema csttec
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `csttec` ;

-- -----------------------------------------------------
-- Schema csttec
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `csttec` DEFAULT CHARACTER SET utf8 ;
USE `csttec` ;

-- -----------------------------------------------------
-- Table `csttec`.`cdept`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdept` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdept` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_dept_id` INT NULL,
  `cname` VARCHAR(60) NULL,
  `ccode` VARCHAR(15) NULL,
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


-- -----------------------------------------------------
-- Table `csttec`.`ccomment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccomment` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccomment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `file_id` INT NULL,
  `file_version` SMALLINT NULL,
  `object_id` INT NULL,
  `cmessage` TEXT NOT NULL,
  `user_id` INT NOT NULL,
  `cshared` TINYINT(1) NULL,
  `cdate_created` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ccomment_cobject2_idx` (`object_id` ASC),
  INDEX `fk_ccomment_cuser1_idx` (`user_id` ASC),
  INDEX `fk_ccomment_cfile1_idx` (`file_id` ASC, `file_version` ASC),
  CONSTRAINT `fk_ccomment_object_id`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ccomment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccomment_cfile1`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfolder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfolder` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfolder` (
  `id` INT NOT NULL,
  `cname` VARCHAR(100) NULL,
  `parent_folder_id` INT NULL,
  `cfolder_type` TINYINT NULL,
  `cinherit_privilege` TINYINT(1) NULL DEFAULT 1,
  `cdescription` VARCHAR(750) NULL,
  `cvisible_on_board` TINYINT(1) NULL DEFAULT 0,
  `cdeliverables_type` VARCHAR(40) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cfolder_parent_folder_id_idx` (`parent_folder_id` ASC),
  CONSTRAINT `fk_cfolder_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cfolder_parent_folder_id`
    FOREIGN KEY (`parent_folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cimport_operation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cimport_operation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cimport_operation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(100) NULL,
  `cdate_imported` TIMESTAMP NULL,
  `chostname` VARCHAR(45) NULL,
  `clocal_dir_path` VARCHAR(200) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cimport_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cimport_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfile` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cversion` SMALLINT NOT NULL DEFAULT 1,
  `cdate_created` TIMESTAMP NULL,
  `cdate_updated` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cdate_released` TIMESTAMP NULL,
  `cdate_expired` TIMESTAMP NULL,
  `cdate_deleted` TIMESTAMP NULL,
  `cfile_name` VARCHAR(150) NOT NULL,
  `cserver_name` VARCHAR(10) NULL,
  `cvol_file_path` VARCHAR(300) NULL,
  `cfile_size` BIGINT UNSIGNED NULL,
  `user_id` INT NOT NULL,
  `deleter_id` INT NULL,
  `dept_id` INT NOT NULL,
  `cdescription` VARCHAR(500) NULL,
  `comment_id` INT NULL,
  `cshown` TINYINT(1) NULL DEFAULT 1,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  `folder_id` INT NULL,
  `cfile_status` INT NULL DEFAULT 0,
  `chas_thumbnail` TINYINT(1) NULL DEFAULT 0,
  `cdoc_type` VARCHAR(45) NULL,
  `ccad_type` VARCHAR(15) NULL,
  `ccad_name` VARCHAR(45) NULL,
  `cpart_no` VARCHAR(50) NULL,
  `crev` VARCHAR(15) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `csecondary` TINYINT(1) NULL DEFAULT 0,
  `c3d` TINYINT(1) NULL DEFAULT 0,
  `uproject` VARCHAR(45) NULL,
  `umodule` VARCHAR(45) NULL,
  `ucategory` VARCHAR(45) NULL,
  `upart_no` VARCHAR(20) NULL,
  `upart_name` VARCHAR(45) NULL,
  `uset_qty` VARCHAR(15) NULL,
  `utotal_qty` VARCHAR(15) NULL,
  `uauthor` VARCHAR(15) NULL,
  `umaterial` VARCHAR(45) NULL,
  `uheat_treatment` VARCHAR(45) NULL,
  `ufinish_treatment` VARCHAR(45) NULL,
  `usurface_treatment` VARCHAR(45) NULL,
  `umaker` VARCHAR(45) NULL,
  `ucustomer` VARCHAR(45) NULL,
  `ucomment` VARCHAR(45) NULL,
  `uspec` VARCHAR(45) NULL,
  `uderived_type` VARCHAR(45) NULL,
  `umaterial_code` VARCHAR(45) NULL,
  `usupplier` VARCHAR(45) NULL,
  `import_id` INT NULL,
  `csheet_no` VARCHAR(10) NULL,
  `cchange_no` VARCHAR(45) NULL,
  `crights` VARCHAR(10) NULL,
  `ccon_actv` VARCHAR(10) NULL,
  `csecurity_class` VARCHAR(10) NULL,
  `csheet_assy` VARCHAR(10) NULL,
  `ccode_no` VARCHAR(20) NULL,
  `cpage_count` SMALLINT NULL,
  PRIMARY KEY (`id`, `cversion`),
  INDEX `fk_cfile_cuser1_idx` (`user_id` ASC),
  INDEX `fk_cfile_ccomment1_idx` (`comment_id` ASC),
  INDEX `fk_cfile_folder_idx` (`folder_id` ASC),
  INDEX `fk_cfile_import_idx` (`import_id` ASC),
  INDEX `fk_cfile_cuser1_idx1` (`deleter_id` ASC),
  INDEX `cfile_date_modified_idx` (`cdate_modified` DESC),
  INDEX `fk_cfile_dept_idx` (`dept_id` ASC),
  CONSTRAINT `fk_cfile_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cfile_comment_id`
    FOREIGN KEY (`comment_id`)
    REFERENCES `csttec`.`ccomment` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cfile_folder_id`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cfile_import_id`
    FOREIGN KEY (`import_id`)
    REFERENCES `csttec`.`cimport_operation` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cfile_deleter_id`
    FOREIGN KEY (`deleter_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cfile_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cuser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cuser` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cuser` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cemail` VARCHAR(40) NOT NULL,
  `cpassword` VARCHAR(32) NULL,
  `cname` VARCHAR(30) NULL,
  `ctitle` VARCHAR(15) NULL,
  `cemployee_no` VARCHAR(15) NULL,
  `ccell_phone` VARCHAR(15) NULL,
  `cphone` VARCHAR(15) NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cdate_logged_in` TIMESTAMP NULL,
  `cdate_pw_expired` TIMESTAMP NULL,
  `dept_id` INT NULL,
  `image_file_id` INT NULL,
  `clicense_type` TINYINT NULL,
  `cstatus` TINYINT NULL DEFAULT 1 COMMENT '상태는 활성(0), 비활성(1), 삭제(2)로 관리한다. \'삭제\' 상태를 두는 이유는 세션 등과 연계하여 이력을 관리하기 위한 목적이다. \'삭제\' 상태가 존재하기 때문에 사용자를 조회/등록/삭제하는 로직에서는 이를 감안한 로직이 포함되어야 한다.',
  `cmail_template` BLOB NULL,
  `cfailed_login_count` INT NULL DEFAULT 0,
  `cuser_address_id` INT NULL,
  `manager_id` INT NULL,
  `cprivate` TINYINT(1) NULL,
  `cadmin` TINYINT(1) NULL DEFAULT 0,
  `cpwd_user_locked` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_cuser_cteam1_idx` (`dept_id` ASC),
  INDEX `fk_cuser_cfile1_idx` (`image_file_id` ASC),
  INDEX `fk_cuser_manager_idx` (`manager_id` ASC),
  CONSTRAINT `fk_cuser_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuser_image_file_id`
    FOREIGN KEY (`image_file_id`)
    REFERENCES `csttec`.`cfile` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuser_manager_id`
    FOREIGN KEY (`manager_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_type` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `thread_id` INT NULL,
  `thread_current` TINYINT(1) NULL DEFAULT 1,
  `user_id` INT NOT NULL,
  `cname` VARCHAR(15) NULL,
  `cdescription` VARCHAR(200) NULL,
  `cstereotype` VARCHAR(20) NULL,
  `cinstruction` TEXT NULL,
  `cnumbering_pattern` VARCHAR(100) NULL,
  `cno_editable` TINYINT(1) NULL DEFAULT 0,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  `clicense` VARCHAR(20) NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cuse_download_limit` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_type_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cwork_type_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_role` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(15) NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_template` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_template` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_id` INT NULL,
  `cseq` INT NOT NULL,
  `cname` VARCHAR(15) NOT NULL,
  `cdesc` VARCHAR(200) NULL,
  `work_type_id` INT NOT NULL DEFAULT 0,
  `work_role_id` INT NULL,
  `camount` DOUBLE NULL DEFAULT 0,
  `cduration` DOUBLE NULL DEFAULT 1,
  `ctemplate` TINYINT(1) NULL DEFAULT 0,
  `user_id` INT NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cdate_start` TIMESTAMP NULL,
  `cdate_end` TIMESTAMP NULL,
  `cconstraint_type` TINYINT NULL,
  `cdate_constrainted` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_work_template_work_template1_idx` (`parent_id` ASC),
  INDEX `fk_work_template_cwork_type1_idx` (`work_type_id` ASC),
  INDEX `fk_work_template_cwork_role1_idx` (`work_role_id` ASC),
  INDEX `fk_cwork_template_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_work_template_parent_id`
    FOREIGN KEY (`parent_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_work_template_work_type_id`
    FOREIGN KEY (`work_type_id`)
    REFERENCES `csttec`.`cwork_type` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_work_template_work_role_id`
    FOREIGN KEY (`work_role_id`)
    REFERENCES `csttec`.`cwork_role` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_template_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_type_stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_type_stage` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_type_stage` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_type_id` INT NOT NULL,
  `cname` VARCHAR(10) NULL,
  `cseq` TINYINT NULL,
  `ccolor` VARCHAR(8) NULL,
  `cdefault_when_revised` TINYINT(1) NULL,
  `cboard` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_type_stage_work_type_idx` (`work_type_id` ASC),
  CONSTRAINT `fk_cwork_type_stage_work_type`
    FOREIGN KEY (`work_type_id`)
    REFERENCES `csttec`.`cwork_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owning_work_id` INT NULL,
  `stage_work_id` INT NULL,
  `work_type_id` INT NULL,
  `work_role_id` INT NULL,
  `work_template_id` INT NULL,
  `work_type_stage_id` INT NULL,
  `sender_id` INT NULL,
  `resp_user_id` INT NULL,
  `cno` VARCHAR(100) NULL,
  `crevision` VARCHAR(5) NULL,
  `cname` VARCHAR(100) NULL,
  `cdesc` VARCHAR(200) NULL,
  `cseq` INT NULL DEFAULT 0,
  `crequest_note` TEXT NULL,
  `cnote` TEXT NULL,
  `cdate_due` TIMESTAMP NULL,
  `cdate_requested` TIMESTAMP NULL,
  `cdate_started` TIMESTAMP NULL,
  `cdate_ended` TIMESTAMP NULL,
  `cdate_plan_to_start` TIMESTAMP NULL,
  `cdate_plan_to_end` TIMESTAMP NULL,
  `cwork_class` INT NULL,
  `cstage` TINYINT NULL,
  `cstatus` TINYINT NULL,
  `clate` TINYINT(1) NULL DEFAULT 0,
  `cduration` DOUBLE NULL,
  `cduration_plan` DOUBLE NULL,
  `camount` DOUBLE NULL DEFAULT 0,
  `camount_plan` DOUBLE NULL DEFAULT 0,
  `cwork_unit` VARCHAR(10) NULL,
  `cprogress` DOUBLE NULL DEFAULT 0,
  `cprogress_criteria` TINYINT NULL,
  `cproject_work` TINYINT(1) NULL DEFAULT 0,
  `clink_expire_days` INT NULL,
  `cnotifier_process_visible` TINYINT(1) NULL DEFAULT 0,
  `cconstraint_type` TINYINT NULL,
  `cdate_constrainted` TIMESTAMP NULL,
  `cverdict` TINYINT NULL DEFAULT 0,
  `cverdict_comment` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_idx` (`id` ASC),
  INDEX `fk_cwork_cwork_type_idx` (`work_type_id` ASC),
  INDEX `fk_cwork_sender_idx` (`sender_id` ASC),
  INDEX `fk_cwork_resp_user_idx` (`resp_user_id` ASC),
  INDEX `fk_cwork_owning_work_idx` (`owning_work_id` ASC),
  INDEX `fk_cwork_work_template1_idx` (`work_template_id` ASC),
  INDEX `fk_cwork_cwork_role1_idx` (`work_role_id` ASC),
  INDEX `fk_cwork_cwork1_idx` (`stage_work_id` ASC),
  INDEX `fk_cwork_work_type_stage_idx` (`work_type_stage_id` ASC),
  CONSTRAINT `fk_cwork_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_work_type_id`
    FOREIGN KEY (`work_type_id`)
    REFERENCES `csttec`.`cwork_type` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_sender_id`
    FOREIGN KEY (`sender_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_resp_user_id`
    FOREIGN KEY (`resp_user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_owning_work_id`
    FOREIGN KEY (`owning_work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_work_template_id`
    FOREIGN KEY (`work_template_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_work_role_id`
    FOREIGN KEY (`work_role_id`)
    REFERENCES `csttec`.`cwork_role` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_stage_work_id`
    FOREIGN KEY (`stage_work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_work_type_stage`
    FOREIGN KEY (`work_type_stage_id`)
    REFERENCES `csttec`.`cwork_type_stage` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproject_template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject_template` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject_template` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `root_work_id` INT NOT NULL,
  `template_project_id` INT NULL,
  `cno_pattern` VARCHAR(50) NULL,
  `cuser_no_allowed` TINYINT(1) NULL,
  `cname` VARCHAR(20) NOT NULL,
  `cdesc` VARCHAR(200) NULL,
  `cdefault` TINYINT(1) NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_cproject_template_root_work_idx` (`root_work_id` ASC),
  INDEX `fk_cproject_template_project_idx` (`template_project_id` ASC),
  CONSTRAINT `fk_cproject_template_root_work_id`
    FOREIGN KEY (`root_work_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_template_project_id`
    FOREIGN KEY (`template_project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproject_template_grade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject_template_grade` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject_template_grade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_template_id` INT NOT NULL,
  `cseq` TINYINT NULL,
  `cname` VARCHAR(10) NULL,
  `cdescription` VARCHAR(500) NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cproject_template_grade_user_idx` (`user_id` ASC),
  INDEX `fk_cproject_template_grade_project_idx` (`project_template_id` ASC),
  CONSTRAINT `fk_cproject_template_grade_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_template_grade_project`
    FOREIGN KEY (`project_template_id`)
    REFERENCES `csttec`.`cproject_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject` (
  `id` INT NOT NULL,
  `root_work_id` INT NULL,
  `project_template_id` INT NULL,
  `grade_id` INT NULL,
  `cproject_stage` VARCHAR(15) NULL,
  `cno` VARCHAR(20) NULL,
  `cno_stored` VARCHAR(20) NULL,
  `cdescription` TEXT NULL,
  `cstatus` TINYINT NULL,
  `cshow_on_list` TINYINT(1) NULL DEFAULT 1,
  `cscheduled` TINYINT(1) NULL,
  `cmodel` VARCHAR(45) NULL,
  `cinternal` TINYINT(1) NULL,
  `creq_dept` VARCHAR(40) NULL,
  `creq_ws` VARCHAR(20) NULL,
  `creq_user_name` VARCHAR(10) NULL,
  `creq_user_contact` VARCHAR(20) NULL,
  `creq_doc_no` VARCHAR(30) NULL,
  `cfinished_doc_no` VARCHAR(30) NULL,
  `cdate_requested` TIMESTAMP NULL,
  `cdate_finished` TIMESTAMP NULL,
  `cmember_only` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cno_UNIQUE` (`cno` ASC),
  INDEX `fk_cproject_cwork1_idx` (`root_work_id` ASC),
  INDEX `fk_cproject_template_idx` (`project_template_id` ASC),
  INDEX `fk_cproject_grade_idx` (`grade_id` ASC),
  CONSTRAINT `fk_cproject_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_root_work_id`
    FOREIGN KEY (`root_work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_template`
    FOREIGN KEY (`project_template_id`)
    REFERENCES `csttec`.`cproject_template` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_grade`
    FOREIGN KEY (`grade_id`)
    REFERENCES `csttec`.`cproject_template_grade` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cobject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cobject` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cobject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NULL,
  `to_project_id` INT NULL,
  `thread_id` INT NULL,
  `thread_current` TINYINT(1) NULL,
  `cversion` VARCHAR(10) NULL,
  `cdisplay_name` VARCHAR(150) NULL,
  `dept_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cuser_name` VARCHAR(60) NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cdate_released` TIMESTAMP NULL,
  `cdate_applied` TIMESTAMP NULL,
  `ctype_name` VARCHAR(45) NULL,
  `ctimestamp` MEDIUMTEXT NULL,
  `cchange_note` TEXT NULL,
  `clicense` VARCHAR(20) NULL,
  `import_id` INT NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  `cstatus` TINYINT NULL DEFAULT 0,
  `copenness` TINYINT NOT NULL DEFAULT 0 COMMENT '공개등급',
  PRIMARY KEY (`id`),
  INDEX `fk_cobject_cteam1_idx` (`dept_id` ASC),
  INDEX `fk_cobject_cuser1_idx` (`user_id` ASC),
  INDEX `fk_cobject_project_idx` (`project_id` ASC),
  INDEX `fk_cobject_import_idx` (`import_id` ASC),
  INDEX `cobject_date_modified_idx` (`cdate_modified` DESC),
  INDEX `thread_idx` (`thread_id` ASC),
  INDEX `fk_cobject_to_project_idx` (`to_project_id` ASC),
  CONSTRAINT `fk_cobject_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobject_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobject_project_id`
    FOREIGN KEY (`project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobject_import_id`
    FOREIGN KEY (`import_id`)
    REFERENCES `csttec`.`cimport_operation` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_to_project_id`
    FOREIGN KEY (`to_project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cclassification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cclassification` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cclassification` (
  `id` INT NOT NULL,
  `ccode` VARCHAR(7) NULL,
  `ccontain_items` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cclassification_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`citem_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`citem_type` ;

CREATE TABLE IF NOT EXISTS `csttec`.`citem_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ccode` VARCHAR(6) NOT NULL,
  `cname` VARCHAR(90) NOT NULL,
  `cnumbering_pattern` VARCHAR(100) NULL,
  `cauto_assign` TINYINT(1) NULL DEFAULT 0,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  `cinclude_all_rev_files` TINYINT(1) NULL DEFAULT 0,
  `classification_id` INT NULL,
  `cstereotype` VARCHAR(20) NULL,
  `ccategory` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_citem_type_cclassification1_idx` (`classification_id` ASC),
  CONSTRAINT `fk_citem_type_classification`
    FOREIGN KEY (`classification_id`)
    REFERENCES `csttec`.`cclassification` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`citem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`citem` ;

CREATE TABLE IF NOT EXISTS `csttec`.`citem` (
  `id` INT NOT NULL,
  `item_type_id` INT NOT NULL,
  `folder_id` INT NULL,
  `cno` VARCHAR(45) NULL,
  `cno_stored` VARCHAR(45) NULL,
  `cname` VARCHAR(100) NULL,
  `cunit` VARCHAR(5) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cno_UNIQUE` (`cno` ASC),
  INDEX `fk_citem_cobject1_idx` (`id` ASC),
  INDEX `fk_citem_cfolder1_idx` (`folder_id` ASC),
  INDEX `fk_citem_citem_type1_idx` (`item_type_id` ASC),
  CONSTRAINT `fk_citem_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_citem_folder_id`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_citem_item_type_id`
    FOREIGN KEY (`item_type_id`)
    REFERENCES `csttec`.`citem_type` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`citem_revision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`citem_revision` ;

CREATE TABLE IF NOT EXISTS `csttec`.`citem_revision` (
  `id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `crevision` VARCHAR(15) NULL,
  `cname` VARCHAR(100) NULL,
  `cdescription` VARCHAR(750) NULL,
  `cmaterial_type` VARCHAR(5) NULL,
  `cmaterial` VARCHAR(45) NULL,
  `cspec` VARCHAR(100) NULL,
  `cmass` DOUBLE NULL DEFAULT 0,
  `cweight_unit` VARCHAR(5) NULL,
  `ccurrency` VARCHAR(5) NULL,
  `cprice` DOUBLE NULL DEFAULT 0,
  `cheat_treatment` VARCHAR(15) NULL,
  `cpost_treatment` VARCHAR(15) NULL,
  `csurface_treatment` VARCHAR(15) NULL,
  `cmaker` VARCHAR(60) NULL,
  `cmodel_code` VARCHAR(40) NULL COMMENT '모델코드',
  `cmodel_name` VARCHAR(100) NULL COMMENT '모델명',
  `cbrand` VARCHAR(40) NULL COMMENT '브랜드',
  `cmodel_type` VARCHAR(20) NULL,
  `cresource_type` VARCHAR(30) NULL,
  `cpage_count` INT NULL DEFAULT 1,
  `cpart_no` VARCHAR(100) NULL,
  `cstock_no` VARCHAR(20) NULL,
  `cplant` VARCHAR(20) NULL COMMENT '공장',
  `ccategory` VARCHAR(100) NULL COMMENT '구분/작업방식/자원유형',
  `clocation` VARCHAR(40) NULL COMMENT '위치/공정번호',
  `reference_revision_id` INT NULL,
  `cdate_target` TIMESTAMP NULL COMMENT '출시예정일',
  `cdate_in` TIMESTAMP NULL COMMENT '적용일(시작)',
  `cdate_out` TIMESTAMP NULL COMMENT '적용일(완료)',
  `cmixed_production` TINYINT(1) NULL DEFAULT 0 COMMENT '혼류생산',
  `cshow_on_pfmea` TINYINT(1) NULL,
  `ctime_required` DOUBLE NULL COMMENT '소요시간, 초(sec)로 입력되며 화면에는 계산하여 표기됨',
  `ctime_unit` TINYINT NULL COMMENT '소요시간(단위)',
  `cworker_required` DOUBLE NULL COMMENT '소요인원',
  `cmachine_required` VARCHAR(100) NULL COMMENT '소요설비',
  `cstatus` TINYINT NULL DEFAULT 0,
  `cuse` TINYINT(1) NULL DEFAULT 1 COMMENT '사용',
  `clatest` TINYINT(1) NULL DEFAULT 1,
  `cexclude_bom` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_citem_revision_cobject1_idx` (`id` ASC),
  INDEX `fk_citem_revision_citem1_idx` (`item_id` ASC),
  INDEX `fk_citem_revision_citem_revision1_idx` (`reference_revision_id` ASC),
  INDEX `fk_citem_revision_occurrence` (`id` ASC, `item_id` ASC),
  CONSTRAINT `fk_citem_revision_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_citem_revision_item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `csttec`.`citem` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_citem_revision_reference_revision_id`
    FOREIGN KEY (`reference_revision_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cprocess`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cprocess` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cprocess` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cstep` VARCHAR(30) NULL,
  `cstep_seq` TINYINT NULL,
  `cuser_name` VARCHAR(60) NULL,
  `user_id` INT NOT NULL,
  `cdate_sent` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cdate_due` TIMESTAMP NULL,
  `cdate_released` TIMESTAMP NULL,
  `cstatus` TINYINT NULL,
  `crejected` TINYINT(1) NULL DEFAULT 0,
  `ccurrent` TINYINT(1) NULL DEFAULT 1,
  `ctasks_requested` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_cprocess_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cprocess_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctask`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctask` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctask` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `process_id` INT NOT NULL,
  `cseq` TINYINT NULL,
  `ctask_type` TINYINT NULL,
  `cdate_received` TIMESTAMP NULL,
  `cstatus` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ctask_cprocess1_idx` (`process_id` ASC),
  CONSTRAINT `fk_ctask_process_id`
    FOREIGN KEY (`process_id`)
    REFERENCES `csttec`.`cprocess` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cprocess_template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cprocess_template` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cprocess_template` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(45) NOT NULL,
  `cdescription` VARCHAR(750) NULL,
  `user_id` INT NOT NULL,
  `work_type_id` INT NULL,
  `work_type_stage_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cprocess_template_cuser1_idx` (`user_id` ASC),
  INDEX `fk_cprocess_template_work_type_idx` (`work_type_id` ASC),
  INDEX `fk_cprocess_template_work_type_stage_idx` (`work_type_stage_id` ASC),
  CONSTRAINT `fk_cprocess_template_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cprocess_template_work_type`
    FOREIGN KEY (`work_type_id`)
    REFERENCES `csttec`.`cwork_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cprocess_template_work_type_stage`
    FOREIGN KEY (`work_type_stage_id`)
    REFERENCES `csttec`.`cwork_type_stage` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_type_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_type_task` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_type_task` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_type_id` INT NOT NULL,
  `work_type_stage_id` INT NULL,
  `cseq` INT NOT NULL,
  `ctask_type` TINYINT NOT NULL,
  INDEX `fk_cwork_type_task_work_type_idx` (`work_type_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_type_task_stage_idx` (`work_type_stage_id` ASC),
  CONSTRAINT `fk_cwork_type_task_work_type`
    FOREIGN KEY (`work_type_id`)
    REFERENCES `csttec`.`cwork_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_type_task_stage`
    FOREIGN KEY (`work_type_stage_id`)
    REFERENCES `csttec`.`cwork_type_stage` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctask_template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctask_template` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctask_template` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `process_id` INT NOT NULL,
  `cseq` INT NULL,
  `ctask_type` TINYINT NULL,
  `work_type_task_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cprocess_task_template_cprocess_template1_idx` (`process_id` ASC),
  INDEX `fk_ctask_template_cwork_type_task1_idx` (`work_type_task_id` ASC),
  CONSTRAINT `fk_ctask_template_process_id`
    FOREIGN KEY (`process_id`)
    REFERENCES `csttec`.`cprocess_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctask_template_work_type_task`
    FOREIGN KEY (`work_type_task_id`)
    REFERENCES `csttec`.`cwork_type_task` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_type_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_type_user` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_type_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_type_task_id` INT NOT NULL,
  `work_role_id` INT NULL,
  `user_id` INT NULL,
  `dept_id` INT NULL,
  `cmandatory` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_type_user_work_type_task_idx` (`work_type_task_id` ASC),
  INDEX `fk_cwork_type_user_work_role_idx` (`work_role_id` ASC),
  INDEX `fk_cwork_type_user_user_idx` (`user_id` ASC),
  INDEX `fk_cwork_type_user_dept_idx` (`dept_id` ASC),
  CONSTRAINT `fk_cwork_type_user_work_type_task`
    FOREIGN KEY (`work_type_task_id`)
    REFERENCES `csttec`.`cwork_type_task` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_type_user_work_role`
    FOREIGN KEY (`work_role_id`)
    REFERENCES `csttec`.`cwork_role` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_type_user_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_type_user_dept`
    FOREIGN KEY (`dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctask_user_template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctask_user_template` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctask_user_template` (
  `task_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `work_type_user_id` INT NULL,
  PRIMARY KEY (`task_id`, `user_id`),
  INDEX `fk_cuser_has_cprocess_task_template_cprocess_task_template1_idx` (`task_id` ASC),
  INDEX `fk_cuser_has_cprocess_task_template_cuser1_idx` (`user_id` ASC),
  INDEX `fk_ctask_user_template_work_type_user_idx` (`work_type_user_id` ASC),
  CONSTRAINT `fk_ctask_user_template_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctask_user_template_task_id`
    FOREIGN KEY (`task_id`)
    REFERENCES `csttec`.`ctask_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctask_user_template_work_type_user`
    FOREIGN KEY (`work_type_user_id`)
    REFERENCES `csttec`.`cwork_type_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctask_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctask_user` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctask_user` (
  `task_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `work_type_user_id` INT NULL,
  `cdate_opened` TIMESTAMP NULL,
  `cdate_ended` TIMESTAMP NULL,
  `ccomment` VARCHAR(750) NULL,
  `cdecision` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`task_id`, `user_id`),
  INDEX `fk_ctask_has_cuser_cuser1_idx` (`user_id` ASC),
  INDEX `fk_ctask_has_cuser_ctask1_idx` (`task_id` ASC),
  INDEX `fk_ctask_user_work_type_user_idx` (`work_type_user_id` ASC),
  CONSTRAINT `fk_ctask_user_task_id`
    FOREIGN KEY (`task_id`)
    REFERENCES `csttec`.`ctask` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctask_user_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctask_user_work_type_user`
    FOREIGN KEY (`work_type_user_id`)
    REFERENCES `csttec`.`cwork_type_user` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`clov`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`clov` ;

CREATE TABLE IF NOT EXISTS `csttec`.`clov` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clov_name` VARCHAR(20) NULL,
  `cvalue_type` TINYINT NULL COMMENT '값 유형 (0: String, 1: INT, 2: Double)',
  `cvalue_length` TINYINT NULL,
  `cauto_sort` TINYINT(1) NULL,
  `callow_user_value` TINYINT(1) NULL,
  `clov_level` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`clov_entry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`clov_entry` ;

CREATE TABLE IF NOT EXISTS `csttec`.`clov_entry` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lov_id` INT NOT NULL,
  `cvalue` VARCHAR(20) NOT NULL,
  `cseq` INT NULL,
  `cdescription` VARCHAR(100) NULL,
  `cdefault` TINYINT(1) NULL,
  `parent_entry_id` INT NULL,
  INDEX `fk_clov_value_clov1_idx` (`lov_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_clov_entry_parent_entry_id_idx` (`parent_entry_id` ASC),
  CONSTRAINT `fk_clov_entry_lov`
    FOREIGN KEY (`lov_id`)
    REFERENCES `csttec`.`clov` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_clov_entry_parent_entry_id`
    FOREIGN KEY (`parent_entry_id`)
    REFERENCES `csttec`.`clov_entry` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfile_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfile_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfile_relation` (
  `primary_id` INT NOT NULL,
  `primary_version` SMALLINT NOT NULL,
  `secondary_id` INT NOT NULL,
  `secondary_version` SMALLINT NOT NULL,
  `crelation_type` VARCHAR(30) NULL,
  `csecondary_file_name` VARCHAR(100) NULL,
  PRIMARY KEY (`primary_id`, `primary_version`, `secondary_id`, `secondary_version`),
  INDEX `fk_cfile_relation_secondary_idx` (`secondary_id` ASC, `secondary_version` ASC),
  CONSTRAINT `fk_cfile_relation_primary`
    FOREIGN KEY (`primary_id` , `primary_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cfile_relation_secondary`
    FOREIGN KEY (`secondary_id` , `secondary_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cpreference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cpreference` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cpreference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(50) NULL COMMENT '환경변수 정보를 ',
  `cvalue` VARCHAR(100) NULL,
  `cvalue_blob` BLOB NULL,
  `dept_id` INT NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cpreference_dept_id` (`dept_id` ASC),
  INDEX `fk_cpreference_user_id` (`user_id` ASC),
  CONSTRAINT `fk_cpreference_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cpreference_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cdeliverable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdeliverable` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdeliverable` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(40) NULL,
  `cdescription` VARCHAR(500) NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  `ctype` TINYINT NULL,
  `user_id` INT NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cdeliverable_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cdeliverable_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_deliverable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_deliverable` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_deliverable` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NOT NULL,
  `deliverable_id` INT NOT NULL,
  `cdate` TIMESTAMP NULL,
  `cverdict` TINYINT NULL,
  `ccomment` VARCHAR(500) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_deliverable_work_idx` (`work_id` ASC),
  INDEX `fk_cwork_deliverable_deliverable_idx` (`deliverable_id` ASC),
  INDEX `fk_cwork_deliverable_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cwork_deliverable_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_deliverable_deliverable`
    FOREIGN KEY (`deliverable_id`)
    REFERENCES `csttec`.`cdeliverable` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_deliverable_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cdoc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdoc` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdoc` (
  `id` INT NOT NULL,
  `folder_id` INT NOT NULL,
  `cno` VARCHAR(45) NULL,
  `ctype` VARCHAR(45) NULL,
  `cprefix` VARCHAR(5) NULL,
  `ccontents` MEDIUMTEXT NULL,
  INDEX `fk_cdoc_object_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cdoc_folder_idx` (`folder_id` ASC),
  CONSTRAINT `fk_cdoc_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cdoc_folder`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cobject_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cobject_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cobject_relation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `primary_id` INT NOT NULL,
  `primary_thread_id` INT NULL,
  `secondary_id` INT NOT NULL,
  `secondary_thread_id` INT NULL,
  `work_deliverable_id` INT NULL,
  `project_id` INT NULL,
  `doc_id` INT NULL,
  `crelation_type` VARCHAR(20) NULL,
  `user_id` INT NOT NULL,
  `cdescription` VARCHAR(200) NULL,
  `csymbol` VARCHAR(30) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cobject_relation_secondary_idx` (`secondary_id` ASC),
  INDEX `fk_cobject_relation_primary_idx` (`primary_id` ASC),
  INDEX `fk_cobject_relation_user_idx` (`user_id` ASC),
  INDEX `fk_cobject_relation_project_idx` (`project_id` ASC),
  INDEX `fk_cobject_relation_deliverable_idx` (`work_deliverable_id` ASC),
  INDEX `fk_cobject_relation_doc_idx` (`doc_id` ASC),
  CONSTRAINT `fk_cobject_relation_primary_id`
    FOREIGN KEY (`primary_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_relation_secondary_id`
    FOREIGN KEY (`secondary_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_relation_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_relation_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_relation_deliverable`
    FOREIGN KEY (`work_deliverable_id`)
    REFERENCES `csttec`.`cwork_deliverable` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_relation_doc`
    FOREIGN KEY (`doc_id`)
    REFERENCES `csttec`.`cdoc` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coccurrence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coccurrence` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coccurrence` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_item_id` INT NOT NULL,
  `parent_revision_id` INT NOT NULL,
  `child_item_id` INT NOT NULL,
  `child_revision_id` INT NOT NULL,
  `work_in_id` INT NULL,
  `work_out_id` INT NULL,
  `cquantity` DOUBLE NULL DEFAULT 1,
  `cseq` VARCHAR(20) NULL,
  `cexclude_bom` TINYINT(1) NULL,
  `corigin_x` DOUBLE NULL,
  `corigin_y` DOUBLE NULL,
  `corigin_z` DOUBLE NULL,
  `crotation_x` DOUBLE NULL,
  `crotation_y` DOUBLE NULL,
  `crotation_z` DOUBLE NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_in` TIMESTAMP NULL,
  `cdate_out` TIMESTAMP NULL,
  `user_id` INT NOT NULL,
  `cuser_name` VARCHAR(60) NULL,
  `cvariant_condition` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_coccurrence_parent_idx` (`parent_revision_id` ASC, `parent_item_id` ASC),
  INDEX `fk_coccurrence_user_idx` (`user_id` ASC),
  INDEX `fk_coccurrence_child_idx` (`child_item_id` ASC, `child_revision_id` ASC),
  INDEX `fk_coccurrence_work_in_idx` (`work_in_id` ASC),
  INDEX `fk_coccurrence_work_out_idx` (`work_out_id` ASC),
  CONSTRAINT `fk_coccurrence_parent`
    FOREIGN KEY (`parent_revision_id` , `parent_item_id`)
    REFERENCES `csttec`.`citem_revision` (`id` , `item_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coccurrence_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coccurrence_child`
    FOREIGN KEY (`child_item_id` , `child_revision_id`)
    REFERENCES `csttec`.`citem_revision` (`item_id` , `id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coccurrence_work_in`
    FOREIGN KEY (`work_in_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coccurrence_work_out`
    FOREIGN KEY (`work_out_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cuser_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cuser_log` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cuser_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `cdate_from` TIMESTAMP NULL,
  `cdate_to` TIMESTAMP NULL,
  `dept_id` INT NULL,
  `cemail` VARCHAR(40) NULL,
  `cname` VARCHAR(30) NULL,
  `cdisplay_name` VARCHAR(100) NULL,
  `cfull_name` VARCHAR(150) NULL,
  `ctitle` VARCHAR(15) NULL,
  `clicense_type` TINYINT NULL,
  `cstatus` TINYINT NULL,
  `cdept_name` VARCHAR(60) NULL,
  `cdept_full_name` VARCHAR(300) NULL,
  INDEX `fk_cuser_log_user_idx` (`user_id` ASC),
  INDEX `fk_cuser_log_dept_idx` (`dept_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cuser_log_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cuser_log_dept`
    FOREIGN KEY (`dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cuser_ext_ip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cuser_ext_ip` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cuser_ext_ip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `cext_ip` VARCHAR(16) NULL,
  `cdate_registered` TIMESTAMP NULL,
  `cdate_latest_accessed` TIMESTAMP NULL,
  `clogin_count` INT NULL,
  `cdownload_count` INT NULL,
  `cstatus` TINYINT NULL,
  `cnote` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cuser_ext_ip_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cuser_ext_ip_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`csession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`csession` ;

CREATE TABLE IF NOT EXISTS `csttec`.`csession` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `user_log_id` INT NOT NULL,
  `user_ext_ip_id` INT NULL,
  `cdate_logged_in` TIMESTAMP NULL,
  `cdate_logged_out` TIMESTAMP NULL,
  `cdate_last_accessed` TIMESTAMP NULL,
  `chostname` VARCHAR(30) NULL,
  `cip` VARCHAR(30) NULL,
  `cmac_address` VARCHAR(20) NULL,
  `cos_user_name` VARCHAR(20) NULL,
  `csession_id` VARCHAR(100) NULL,
  `cadmin_mode` TINYINT(1) NULL,
  `cbypass_user_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_csession_user_idx` (`user_id` ASC),
  INDEX `fk_csession_user_log_idx` (`user_log_id` ASC),
  INDEX `fk_csession_user_ext_ip_idx` (`user_ext_ip_id` ASC),
  CONSTRAINT `fk_csession_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_csession_user_log`
    FOREIGN KEY (`user_log_id`)
    REFERENCES `csttec`.`cuser_log` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_csession_cuser_ext_ip`
    FOREIGN KEY (`user_ext_ip_id`)
    REFERENCES `csttec`.`cuser_ext_ip` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`caction_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`caction_log` ;

CREATE TABLE IF NOT EXISTS `csttec`.`caction_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `session_id` INT NULL,
  `object_id` INT NULL,
  `cobject_name` VARCHAR(150) NULL COMMENT 'Object 삭제 시 Display Name을 가져와서 업데이트 처리',
  `cobject_type` VARCHAR(30) NULL,
  `caction_type` VARCHAR(30) NULL,
  `cdescription` VARCHAR(1000) NULL,
  `cdate_started` TIMESTAMP NULL,
  `cdate_ended` TIMESTAMP NULL,
  `cresult` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_caction_log_csession1_idx` (`session_id` ASC),
  CONSTRAINT `fk_caction_log_session`
    FOREIGN KEY (`session_id`)
    REFERENCES `csttec`.`csession` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cobject_file_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cobject_file_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cobject_file_relation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NOT NULL,
  `file_id` INT NOT NULL,
  `file_version` SMALLINT NOT NULL,
  `work_deliverable_id` INT NULL,
  `crelation_type` VARCHAR(30) NULL,
  `csymbol` VARCHAR(15) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cobject_has_cfile_file_idx` (`file_id` ASC, `file_version` ASC),
  INDEX `fk_cobject_has_cfile_object_idx` (`object_id` ASC),
  INDEX `fk_cobject_file_relation_deliverable_idx` (`work_deliverable_id` ASC),
  CONSTRAINT `fk_cobject_file_relation_object_id`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_file_relation_file_id`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cobject_file_relation_deliverable`
    FOREIGN KEY (`work_deliverable_id`)
    REFERENCES `csttec`.`cwork_deliverable` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cclassification_system`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cclassification_system` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cclassification_system` (
  `id` INT NOT NULL,
  `cuse_item_props` TINYINT(1) NULL,
  `cuse_code` TINYINT(1) NULL,
  `ccode` VARCHAR(6) NULL,
  `cuse_numbering` TINYINT(1) NULL,
  `cnumbering_pattern` VARCHAR(50) NULL,
  `cuse_standard_names` TINYINT(1) NULL,
  `callow_user_name` TINYINT(1) NULL,
  `cfor_material` TINYINT(1) NULL,
  `cfor_manufacturing` TINYINT(1) NULL,
  `citem_category` TINYINT NULL,
  `citem_stereotype` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cclassification_system_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cstandard_names`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cstandard_names` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cstandard_names` (
  `classification_id` INT NOT NULL,
  `cstandard_name` VARCHAR(45) NOT NULL,
  `cseq` TINYINT NULL,
  PRIMARY KEY (`classification_id`, `cstandard_name`),
  CONSTRAINT `fk_cstandard_names_classification_id`
    FOREIGN KEY (`classification_id`)
    REFERENCES `csttec`.`cclassification` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cprivilege`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cprivilege` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cprivilege` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `folder_id` INT NOT NULL,
  `dept_id` INT NULL,
  `user_id` INT NULL,
  `cread` TINYINT(1) NULL,
  `cwrite` TINYINT(1) NULL,
  `cmanage` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cprivilege_cteam1_idx` (`dept_id` ASC),
  INDEX `fk_cprivilege_cuser1_idx` (`user_id` ASC),
  CONSTRAINT `fk_cprivilege_folder_id`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cprivilege_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cprivilege_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfolder_favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfolder_favorite` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfolder_favorite` (
  `user_id` INT NOT NULL,
  `folder_id` INT NOT NULL,
  INDEX `fk_cfolder_favorite_cuser1_idx` (`user_id` ASC),
  INDEX `fk_cfolder_favorite_cfolder1_idx` (`folder_id` ASC),
  CONSTRAINT `fk_cfolder_favorite_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cfolder_favorite_folder_id`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`citem_box`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`citem_box` ;

CREATE TABLE IF NOT EXISTS `csttec`.`citem_box` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `cseq` TINYINT NOT NULL,
  `cname` VARCHAR(60) NOT NULL,
  `ccategory` TINYINT NOT NULL DEFAULT 0 COMMENT 'Engineering: 0, Manufacturing: 1',
  PRIMARY KEY (`id`),
  INDEX `fk_citem_favorite_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_citem_box_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`citem_box_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`citem_box_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`citem_box_relation` (
  `item_box_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  PRIMARY KEY (`item_box_id`, `item_id`),
  INDEX `fk_citem_box_item_idx` (`item_id` ASC),
  INDEX `fk_citem_box_box_idx` (`item_box_id` ASC),
  CONSTRAINT `fk_citem_box_relation_box_id`
    FOREIGN KEY (`item_box_id`)
    REFERENCES `csttec`.`citem_box` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_citem_box_reation_item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `csttec`.`citem` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cpreference_entry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cpreference_entry` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cpreference_entry` (
  `preference_id` INT NOT NULL,
  `cseq` INT NULL,
  `cvalue` VARCHAR(100) NULL,
  INDEX `fk_cpreference_entry_cpreference1_idx` (`preference_id` ASC),
  CONSTRAINT `fk_cpreference_entry_id`
    FOREIGN KEY (`preference_id`)
    REFERENCES `csttec`.`cpreference` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfolder_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfolder_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfolder_relation` (
  `primary_id` INT NOT NULL,
  `secondary_id` INT NOT NULL,
  INDEX `fk_cfolder_relation_cfolder2_idx` (`secondary_id` ASC),
  CONSTRAINT `fk_cfolder_relation_primary_id`
    FOREIGN KEY (`primary_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cfolder_relation_secondary_id`
    FOREIGN KEY (`secondary_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccompany`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccompany` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccompany` (
  `id` INT NOT NULL,
  `cname` VARCHAR(45) NULL,
  `cdescription` TEXT NULL,
  `ctype` VARCHAR(10) NULL,
  `ctax_no` VARCHAR(20) NULL,
  `chome_page` VARCHAR(100) NULL,
  `csite_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ccompany_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccustomer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccustomer` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccustomer` (
  `id` INT NOT NULL,
  `company_id` INT NOT NULL,
  `cname` VARCHAR(45) NULL,
  `cdate_birthday` TIMESTAMP NULL,
  `cdept_name` VARCHAR(45) NULL,
  `ctitle` VARCHAR(45) NULL,
  `cemail` VARCHAR(50) NULL,
  `ccell_phone` VARCHAR(45) NULL,
  `coffice_phone` VARCHAR(45) NULL,
  `cdescription` TEXT NULL,
  `cmarketting_agreed` TINYINT(1) NULL,
  INDEX `fk_ccustomer_company_idx` (`company_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ccustomer_company_id`
    FOREIGN KEY (`company_id`)
    REFERENCES `csttec`.`ccompany` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccustomer_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccontact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccontact` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccontact` (
  `id` INT NOT NULL,
  `cname` VARCHAR(45) NULL,
  `ccompany` VARCHAR(45) NULL,
  `cdepartment` VARCHAR(45) NULL,
  `ctitle` VARCHAR(45) NULL,
  `cdate_birthday` TIMESTAMP NULL,
  `cemail` VARCHAR(50) NULL,
  `ccell_phone` VARCHAR(45) NULL,
  `coffice_phone` VARCHAR(45) NULL,
  `cdescription` TEXT NULL,
  `cmember_editable` TINYINT(1) NULL,
  `cmarketting_agreed` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ccontact_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `csttec`.`cmail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cmail` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cmail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ctitle` VARCHAR(300) NULL,
  `ccontents` BLOB NULL,
  `cas_distribute` TINYINT(1) NULL,
  `user_id` INT NOT NULL,
  `user_log_id` INT NULL,
  `ctype` TINYINT NULL COMMENT 'User/CRM',
  `customer_id` INT NULL,
  `crecipient_mail` VARCHAR(100) NULL COMMENT '수신자 메일',
  `caccessed_ip` VARCHAR(40) NULL,
  `cdate_sent` TIMESTAMP NULL COMMENT '발송 시간',
  `cdate_scheduled` TIMESTAMP NULL COMMENT '발송할 시간',
  `cdate_accessed` TIMESTAMP NULL COMMENT '열람 시간',
  PRIMARY KEY (`id`),
  INDEX `fk_cmail_user_idx` (`user_id` ASC),
  INDEX `fk_cmail_user_log_idx` (`user_log_id` ASC),
  INDEX `fk_cmail_customer_idx` (`customer_id` ASC),
  CONSTRAINT `fk_cmail_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cmail_user_log_id`
    FOREIGN KEY (`user_log_id`)
    REFERENCES `csttec`.`cuser_log` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cmail_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `csttec`.`ccontact` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cmail_file_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cmail_file_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cmail_file_relation` (
  `mail_id` INT NOT NULL,
  `file_id` INT NOT NULL,
  `file_version` SMALLINT NOT NULL,
  PRIMARY KEY (`mail_id`, `file_id`, `file_version`),
  INDEX `fk_cmail_has_cfile_cfile1_idx` (`file_id` ASC, `file_version` ASC),
  INDEX `fk_cmail_has_cfile_cmail1_idx` (`mail_id` ASC),
  CONSTRAINT `fk_cmail_has_cfile_cmail1`
    FOREIGN KEY (`mail_id`)
    REFERENCES `csttec`.`cmail` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmail_file_relation_file`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cmail_recipient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cmail_recipient` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cmail_recipient` (
  `mail_id` INT NOT NULL,
  `crecipient_type` TINYINT NULL,
  `user_log_id` INT NOT NULL,
  `cexception` VARCHAR(1000) NULL,
  `cdate_opened` TIMESTAMP NULL,
  INDEX `fk_cmail_recipient_cmail1_idx` (`mail_id` ASC),
  INDEX `fk_cmail_recipient_user_log_idx` (`user_log_id` ASC),
  CONSTRAINT `fk_cmail_recipient_mail`
    FOREIGN KEY (`mail_id`)
    REFERENCES `csttec`.`cmail` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmail_recipient_user_log_id`
    FOREIGN KEY (`user_log_id`)
    REFERENCES `csttec`.`cuser_log` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cviewer_session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cviewer_session` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cviewer_session` (
  `viewer_session_id` VARCHAR(100) NOT NULL,
  `cticket` VARCHAR(100) NOT NULL,
  `session_id` VARCHAR(100) NOT NULL,
  `chost` VARCHAR(45) NOT NULL,
  `cport` INT NOT NULL,
  `cdate_last_accessed` TIMESTAMP NOT NULL,
  PRIMARY KEY (`viewer_session_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cusage_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cusage_log` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cusage_log` (
  `object_id` INT NULL,
  `file_id` INT NULL,
  `file_version` SMALLINT NULL,
  `session_id` INT NULL,
  `user_log_id` INT NULL,
  `caccess_type` VARCHAR(10) NULL,
  `caccess_route` VARCHAR(10) NULL,
  `caccess_ip` VARCHAR(40) NULL,
  `cdate` TIMESTAMP NULL,
  `ctraffic_size` BIGINT NULL,
  `viewer_session_id` VARCHAR(100) NULL,
  INDEX `fk_cusage_log_session_idx` (`session_id` ASC),
  INDEX `fk_cusage_log_user_log_idx` (`user_log_id` ASC),
  INDEX `fk_cusage_log_file_idx` (`file_id` ASC, `file_version` ASC),
  INDEX `fk_cusage_log_object_idx` (`object_id` ASC),
  INDEX `fk_cusage_log_viewer_session_idx` (`viewer_session_id` ASC),
  CONSTRAINT `fk_cusage_log_file`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cusage_log_session`
    FOREIGN KEY (`session_id`)
    REFERENCES `csttec`.`csession` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cusage_log_user_log`
    FOREIGN KEY (`user_log_id`)
    REFERENCES `csttec`.`cuser_log` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cusage_log_viewer_session`
    FOREIGN KEY (`viewer_session_id`)
    REFERENCES `csttec`.`cviewer_session` (`viewer_session_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfile_checkout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfile_checkout` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfile_checkout` (
  `file_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cdate_checkout` TIMESTAMP NULL,
  INDEX `fk_cfile_checkout_cuser1_idx` (`user_id` ASC),
  INDEX `fk_cfile_checkout_cfile1_idx` (`file_id` ASC),
  PRIMARY KEY (`file_id`),
  CONSTRAINT `fk_cfile_checkout_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cfile_checkout_file`
    FOREIGN KEY (`file_id`)
    REFERENCES `csttec`.`cfile` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproject_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject_category` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject_category` (
  `id` INT NOT NULL,
  `ccontain_projects` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cproject_category_cfolder1`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cnumbering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cnumbering` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cnumbering` (
  `cpattern` VARCHAR(50) NOT NULL,
  `cmax_code` VARCHAR(50) NULL,
  `ctype_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpattern`, `ctype_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cobject_checkout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cobject_checkout` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cobject_checkout` (
  `object_id` INT NOT NULL,
  `thread_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cdate_checkout` TIMESTAMP NULL,
  INDEX `fk_cobject_checkout_object_idx` (`object_id` ASC),
  INDEX `fk_cobject_checkout_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cobject_checkout_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_checkout_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`csaved_query`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`csaved_query` ;

CREATE TABLE IF NOT EXISTS `csttec`.`csaved_query` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `ctype_name` VARCHAR(45) NULL,
  `cname` VARCHAR(20) NULL,
  `ccriteria` VARCHAR(2000) NULL,
  INDEX `fk_csaved_query_cuser1_idx` (`user_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_csaved_query_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cboard_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cboard_article` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cboard_article` (
  `id` INT NOT NULL,
  `folder_id` INT NOT NULL,
  `ccontents` TEXT NULL,
  `cnotice` TINYINT(1) NULL,
  `cshow_on_top` TINYINT(1) NULL DEFAULT 0,
  `ctemp_save` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_cboard_article_cfolder1_idx` (`folder_id` ASC),
  INDEX `fk_cboard_article_cobject1_idx` (`id` ASC),
  CONSTRAINT `fk_cboard_article_folder_id`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cboard_article_object_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cprocess_object_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cprocess_object_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cprocess_object_relation` (
  `process_id` INT NOT NULL,
  `object_id` INT NOT NULL,
  `cprimary` TINYINT(1) NULL DEFAULT 1,
  INDEX `fk_process_object_relation_process_idx` (`process_id` ASC),
  INDEX `fk_process_object_relation_object_idx` (`object_id` ASC),
  CONSTRAINT `fk_process_object_relation_process`
    FOREIGN KEY (`process_id`)
    REFERENCES `csttec`.`cprocess` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_process_object_relation_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cuser_license`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cuser_license` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cuser_license` (
  `user_id` INT NOT NULL,
  `clicense` VARCHAR(20) NOT NULL,
  INDEX `fk_cuser_license_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cuser_license_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cprocess_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cprocess_log` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cprocess_log` (
  `object_id` INT NOT NULL,
  `cstep_seq` TINYINT NULL,
  `cstep` VARCHAR(30) NULL,
  `ctask_seq` TINYINT NULL,
  `ctask_type` TINYINT NULL,
  `cuser_name` VARCHAR(60) NULL,
  `cdate` TIMESTAMP NULL,
  `caction` VARCHAR(10) NULL,
  `cnote` VARCHAR(750) NULL,
  INDEX `fk_cprocess_log_object_idx` (`object_id` ASC),
  CONSTRAINT `fk_cprocess_log_object_id`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproject_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject_member` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject_member` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NOT NULL,
  `work_role_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cproject_member_cproject1_idx` (`project_id` ASC),
  INDEX `fk_cproject_member_cwork_role1_idx` (`work_role_id` ASC),
  INDEX `fk_cproject_member_cuser1_idx` (`user_id` ASC),
  CONSTRAINT `fk_cproject_member_cproject1`
    FOREIGN KEY (`project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_member_cwork_role1`
    FOREIGN KEY (`work_role_id`)
    REFERENCES `csttec`.`cwork_role` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_member_cuser1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`csystem_usage_stat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`csystem_usage_stat` ;

CREATE TABLE IF NOT EXISTS `csttec`.`csystem_usage_stat` (
  `cdate` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `cstorage_file` DOUBLE NULL,
  `cstorage_file_active` DOUBLE NULL,
  `cnetwork_file_write` DOUBLE NULL,
  `cnetwork_file_read` DOUBLE NULL,
  `cnetwork_traffic` DOUBLE NULL,
  `cadvanced_count` INT NULL,
  `cstandard_count` INT NULL,
  `cwebhard_count` INT NULL,
  `cviewer_count` INT NULL,
  `cproject_count` INT NULL,
  `cchange_count` INT NULL,
  PRIMARY KEY (`cdate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cboard_article_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cboard_article_comment` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cboard_article_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `board_article_id` INT NOT NULL,
  `ccomment` TEXT NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cboard_article_comment_cuser1_idx` (`user_id` ASC),
  INDEX `fk_cboard_article_comment_cboard_article1_idx` (`board_article_id` ASC),
  CONSTRAINT `fk_cboard_article_comment_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cboard_article_comment_article_id`
    FOREIGN KEY (`board_article_id`)
    REFERENCES `csttec`.`cboard_article` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccalendar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccalendar` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccalendar` (
  `id` INT NOT NULL,
  `owner_id` INT NULL,
  `cname` VARCHAR(45) NULL,
  `cdescription` VARCHAR(300) NULL,
  `ccountry_applied` TINYINT(1) NULL,
  `ccountry` VARCHAR(2) NULL,
  `ctype` VARCHAR(45) NULL,
  INDEX `fk_ccalendar_object_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_ccalendar_owner_idx` (`owner_id` ASC),
  CONSTRAINT `fk_ccalendar_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccalendar_user`
    FOREIGN KEY (`owner_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctodo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctodo` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctodo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NULL,
  `calendar_id` INT NULL,
  `requestor_id` INT NOT NULL,
  `user_id` INT NULL,
  `cseq` INT NULL,
  `ctodo` VARCHAR(500) NULL,
  `cresult` VARCHAR(500) NULL,
  `capplied` TINYINT(1) NULL,
  `cdone` TINYINT(1) NULL,
  `cfixed` TINYINT(1) NULL DEFAULT 0,
  `cdate_due` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ctodo_object_idx` (`object_id` ASC),
  INDEX `fk_ctodo_user_idx` (`user_id` ASC),
  INDEX `fk_ctodo_calendar_idx` (`calendar_id` ASC),
  INDEX `fk_ctodo_requestor_idx` (`requestor_id` ASC),
  CONSTRAINT `fk_ctodo_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctodo_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctodo_calendar`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `csttec`.`ccalendar` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctodo_requestor`
    FOREIGN KEY (`requestor_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_time`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_time` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_time` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NULL,
  `todo_id` INT NULL,
  `user_id` INT NOT NULL,
  `cdate_started` TIMESTAMP NULL,
  `cdate_finished` TIMESTAMP NULL,
  `ctime_consumed` MEDIUMTEXT NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  `cstatus` TINYINT NULL DEFAULT 0 COMMENT '상태(미설정/채택/불채택)',
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_time_work_idx` (`work_id` ASC),
  INDEX `fk_cwork_time_user_idx` (`user_id` ASC),
  INDEX `fk_cwork_time_todo_idx` (`todo_id` ASC),
  CONSTRAINT `fk_cwork_time_work_id`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_time_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_time_todo`
    FOREIGN KEY (`todo_id`)
    REFERENCES `csttec`.`ctodo` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cbom_column`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cbom_column` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cbom_column` (
  `user_id` INT NOT NULL,
  `cbom_type` TINYINT NULL,
  `cdisplay_type` VARCHAR(20) NOT NULL,
  `cseq` TINYINT NOT NULL,
  `cname` VARCHAR(45) NULL,
  `calign` VARCHAR(6) NULL,
  `cwidth` INT NULL,
  `cvisible` TINYINT(1) NULL,
  `cfrozen` TINYINT(1) NULL,
  INDEX `fk_cbom_column_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cbom_column_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfile_viewable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfile_viewable` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfile_viewable` (
  `file_id` INT NOT NULL,
  `file_version` SMALLINT NOT NULL,
  `cvol_file_name` VARCHAR(120) NULL,
  `cpage` SMALLINT NULL,
  `cdate_created` TIMESTAMP NULL,
  `crotation` INT NULL,
  `ccolor_inverted` TINYINT(1) NULL,
  `cfile_type` VARCHAR(5) NULL,
  `cwidth` SMALLINT NULL,
  `cheight` SMALLINT NULL,
  INDEX `fk_cfile_viewable_file_idx` (`file_id` ASC, `file_version` ASC),
  CONSTRAINT `fk_cfile_viewable_file`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cdept_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdept_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdept_relation` (
  `primary_id` INT NOT NULL,
  `secondary_id` INT NOT NULL,
  INDEX `fk_cdept_relation_primary_idx` (`primary_id` ASC),
  INDEX `fk_cdept_relation_secondary_idx` (`secondary_id` ASC),
  CONSTRAINT `fk_cdept_relation_primary`
    FOREIGN KEY (`primary_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cdept_relation_secondary`
    FOREIGN KEY (`secondary_id`)
    REFERENCES `csttec`.`cdept` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfolder_hidden`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfolder_hidden` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfolder_hidden` (
  `folder_id` INT NOT NULL,
  `user_id` INT NULL,
  `ccriteria` VARCHAR(45) NULL,
  INDEX `fk_folder_hidden_folder_idx` (`folder_id` ASC),
  INDEX `fk_folder_hidden_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_folder_hidden_folder`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_folder_hidden_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cexchange`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cexchange` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cexchange` (
  `code` VARCHAR(3) NOT NULL,
  `cunit` VARCHAR(10) NULL,
  `cname` VARCHAR(45) NULL,
  `crate` DECIMAL(8,4) NULL,
  `cbase` DECIMAL(6,2) NULL,
  `cttb` DECIMAL(6,2) NULL,
  `ctts` DECIMAL(6,2) NULL,
  `cdate` TIMESTAMP NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_sheet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_sheet` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_sheet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `thread_id` INT NULL,
  `work_id` INT NOT NULL,
  `cseq` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_sheet_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_cwork_sheet_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_mjs_sheet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_mjs_sheet` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_mjs_sheet` (
  `id` INT NOT NULL,
  `cmaterial` VARCHAR(20) NULL,
  `coperation_no` VARCHAR(40) NULL,
  `coperation_desc` VARCHAR(50) NULL,
  `ctask_center` VARCHAR(15) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_mjs_sheet_work_sheet`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork_sheet` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_sro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_sro` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_sro` (
  `id` INT NOT NULL,
  `cpart_no` VARCHAR(45) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `ceffectivity` VARCHAR(20) NULL,
  `coutsourcing_type` VARCHAR(20) NULL,
  `ceng_docs` VARCHAR(300) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_csro_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_mjs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_mjs` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_mjs` (
  `id` INT NOT NULL,
  `cop_type` CHAR(1) NULL,
  `cpart_no` VARCHAR(45) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `cdoc` VARCHAR(300) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_mjs_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_ecr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_ecr` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_ecr` (
  `id` INT NOT NULL,
  `cdate` TIMESTAMP NULL,
  `ccustomer` VARCHAR(40) NULL,
  `cprogram` VARCHAR(20) NULL,
  `cmodel` VARCHAR(15) NULL,
  `cec_control_no` VARCHAR(40) NULL,
  `cpart_no` VARCHAR(40) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `cpart_types` VARCHAR(10) NULL,
  `cissued_by` VARCHAR(45) NULL,
  `cissued_by_others` VARCHAR(45) NULL,
  `ceffectivity` VARCHAR(50) NULL,
  `cspecial_process` VARCHAR(200) NULL,
  `cmake` TINYINT(1) NULL,
  `cbuy` TINYINT(1) NULL,
  `cfai_req` TINYINT(1) NULL,
  `cbom_change` TINYINT(1) NULL,
  `cop_sheet_change` TINYINT(1) NULL,
  `csro_req` TINYINT NULL,
  `ctooling_change` TINYINT(1) NULL,
  `cmaterial_change` TINYINT(1) NULL,
  `cstock_change` TINYINT(1) NULL,
  `cspecial_process_req` TINYINT(1) NULL,
  `cecv_req` TINYINT(1) NULL,
  `coutsourcing_req` TINYINT(1) NULL,
  `ctool_lead_time` VARCHAR(10) NULL,
  `cmaterial_lead_time` VARCHAR(10) NULL,
  `cmaterial_new_qty` VARCHAR(10) NULL,
  `cmaterial_change_qty` VARCHAR(10) NULL,
  `cstock_inprocess_qty` VARCHAR(50) NULL,
  `cstock_stock_qty` VARCHAR(50) NULL,
  `cstock_uai_qty` VARCHAR(50) NULL,
  `cstock_rework_qty` VARCHAR(50) NULL,
  `cstock_scrap_qty` VARCHAR(50) NULL,
  `cstock_remark` VARCHAR(100) NULL,
  `ccost_change` TINYINT(1) NULL,
  `ccost_rc` DECIMAL(10) NULL,
  `ccost_nrc` DECIMAL(10) NULL,
  `ccost_nre` DECIMAL(10) NULL,
  `ccost_nrc_remark` VARCHAR(400) NULL,
  `ccost_nre_remark` VARCHAR(400) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_ecr_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_ecv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_ecv` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_ecv` (
  `id` INT NOT NULL,
  `ccustomer` VARCHAR(40) NULL,
  `cpart_no` VARCHAR(45) NULL,
  `ceffectivity` VARCHAR(50) NULL,
  `cec_control_no` VARCHAR(80) NULL,
  `cecr_no` VARCHAR(40) NULL,
  `cchange_desc` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_ecv_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_pecv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_pecv` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_pecv` (
  `id` INT NOT NULL,
  `cpart_no` VARCHAR(40) NULL,
  `ccustomer` VARCHAR(40) NULL,
  `ceffectivity_designated` TINYINT(1) NULL,
  `ceffectivity` VARCHAR(40) NULL,
  `cchange_elements` VARCHAR(200) NULL,
  `cchange_element_others` VARCHAR(50) NULL,
  `cchange_desc` VARCHAR(500) NULL,
  `crefair_req` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_pecv_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_crr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_crr` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_crr` (
  `id` INT NOT NULL,
  `ccustomer` VARCHAR(40) NULL,
  `cmodel` VARCHAR(15) NULL,
  `cpart_no` VARCHAR(40) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `citem_count` VARCHAR(40) NULL,
  `cunit_per_month` VARCHAR(100) NULL,
  `cbriefing_req` VARCHAR(15) NULL,
  `citem_fair_req` VARCHAR(15) NULL,
  `cdate_first_delivery` TIMESTAMP NULL,
  `cdate_contract_start` TIMESTAMP NULL,
  `cdate_contract_end` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_crr_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cuser_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cuser_role` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cuser_role` (
  `user_id` INT NOT NULL,
  `work_role_id` INT NOT NULL,
  INDEX `fk_cuser_role_user_idx` (`user_id` ASC),
  INDEX `fk_cuser_role_work_role_idx` (`work_role_id` ASC),
  PRIMARY KEY (`user_id`, `work_role_id`),
  CONSTRAINT `fk_cuser_role_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cuser_role_work_role`
    FOREIGN KEY (`work_role_id`)
    REFERENCES `csttec`.`cwork_role` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_type_todo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_type_todo` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_type_todo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_type_id` INT NOT NULL,
  `cseq` INT NOT NULL,
  `ctodo` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_type_todo_work_type_idx` (`work_type_id` ASC),
  CONSTRAINT `fk_cwork_type_todo_work_type`
    FOREIGN KEY (`work_type_id`)
    REFERENCES `csttec`.`cwork_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_change_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_change_item` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_change_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NOT NULL,
  `cseq` INT NULL,
  `cdescription` VARCHAR(1000) NULL,
  `cdoc_type` VARCHAR(20) NULL,
  `cpart_no` VARCHAR(40) NULL,
  `crevision` VARCHAR(10) NULL,
  `cremark` VARCHAR(1000) NULL,
  `chz_change_itemcol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chz_change_item_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_chz_change_item_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_tool_change`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_tool_change` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_tool_change` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NOT NULL,
  `cseq` INT NULL,
  `ccode` VARCHAR(10) NULL,
  `cno` VARCHAR(40) NULL,
  `cchange_type` VARCHAR(10) NULL,
  `cremark` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chz_tool_change_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_chz_tool_change_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cattr_def`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cattr_def` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cattr_def` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(45) NULL,
  `ctype` VARCHAR(20) NULL,
  `csize` INT NULL,
  `cdesc` VARCHAR(200) NULL,
  `cshared` TINYINT(1) NULL,
  `clinked_attr_name` VARCHAR(45) NULL,
  `cuse_range_limit` TINYINT(1) NULL,
  `crange_min` VARCHAR(50) NULL,
  `crange_max` VARCHAR(50) NULL,
  `cuse_lov` TINYINT(1) NULL,
  `lov_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cattr_def_clov1_idx` (`lov_id` ASC),
  CONSTRAINT `fk_cattr_def_clov1`
    FOREIGN KEY (`lov_id`)
    REFERENCES `csttec`.`clov` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cclass_attr_def`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cclass_attr_def` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cclass_attr_def` (
  `folder_id` INT NOT NULL,
  `cseq` INT NOT NULL,
  `attr_def_id` INT NOT NULL,
  `cmandatory` TINYINT(1) NULL,
  INDEX `fk_cclass_attr_def_cfolder1_idx` (`folder_id` ASC),
  INDEX `fk_cclass_attr_def_cattr1_idx` (`attr_def_id` ASC),
  CONSTRAINT `fk_cclass_attr_def_cfolder1`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cclass_attr_def_cattr1`
    FOREIGN KEY (`attr_def_id`)
    REFERENCES `csttec`.`cattr_def` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`citem_attr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`citem_attr` ;

CREATE TABLE IF NOT EXISTS `csttec`.`citem_attr` (
  `item_revision_id` INT NOT NULL,
  `attr_def_id` INT NOT NULL,
  `cvalue` VARCHAR(50) NULL,
  INDEX `fk_citem_attr_citem_revision1_idx` (`item_revision_id` ASC),
  INDEX `fk_citem_attr_cattr_def1_idx` (`attr_def_id` ASC),
  CONSTRAINT `fk_citem_attr_citem_revision1`
    FOREIGN KEY (`item_revision_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_citem_attr_cattr_def1`
    FOREIGN KEY (`attr_def_id`)
    REFERENCES `csttec`.`cattr_def` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cschedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cschedule` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cschedule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NULL,
  `calendar_id` INT NULL,
  `cname` VARCHAR(120) NULL,
  `cdescription` VARCHAR(1000) NULL,
  `cdate_from` TIMESTAMP NULL,
  `cdate_to` TIMESTAMP NULL,
  `clocation` VARCHAR(200) NULL,
  `choliday` TINYINT(1) NULL,
  `reference_id` INT NULL,
  `cnational_holiday` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cschedule_object_idx` (`object_id` ASC),
  INDEX `fk_cschedule_calendar_idx` (`calendar_id` ASC),
  CONSTRAINT `fk_cschedule_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cschedule_calendar`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `csttec`.`ccalendar` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cuser_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cuser_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cuser_relation` (
  `object_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `crelation_type` VARCHAR(45) NULL,
  INDEX `fk_cuser_relation_user_idx` (`user_id` ASC),
  INDEX `fk_cuser_relation_object_idx` (`object_id` ASC),
  CONSTRAINT `fk_cuser_relation_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cuser_relation_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cschedule_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cschedule_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cschedule_relation` (
  `schedule_id` INT NOT NULL,
  `calendar_id` INT NULL,
  INDEX `fk_cschedule_relation_schedule_idx` (`schedule_id` ASC),
  INDEX `fk_cschedule_relation_calendar_idx` (`calendar_id` ASC),
  CONSTRAINT `fk_cschedule_relation_schedule`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `csttec`.`cschedule` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cschedule_relation_calendar`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `csttec`.`ccalendar` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccalendar_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccalendar_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccalendar_relation` (
  `calendar_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `ccolor` VARCHAR(7) NULL,
  `cdisplayed` TINYINT(1) NULL DEFAULT 1,
  `ccurrent` TINYINT(1) NULL,
  INDEX `fk_ccalendar_relation_calendar_idx` (`calendar_id` ASC),
  INDEX `fk_ccalendar_relation_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_ccalendar_relation_calendar`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `csttec`.`ccalendar` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccalendar_relation_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_crm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_crm` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_crm` (
  `id` INT NOT NULL,
  `cpurpose` VARCHAR(200) NULL,
  `clocation` VARCHAR(200) NULL,
  INDEX `fk_chz_crm_work_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_crm_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cplace`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cplace` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cplace` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NOT NULL,
  `cname` VARCHAR(45) NOT NULL,
  `caddress` VARCHAR(300) NULL,
  `czip_code` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cplace_object_idx` (`object_id` ASC),
  CONSTRAINT `fk_cplace_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cplace_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cplace_contact` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cplace_contact` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NOT NULL,
  `place_id` INT NULL,
  `cvalue` VARCHAR(45) NULL,
  `ctype` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cplace_contact_place_idx` (`place_id` ASC),
  INDEX `fk_cplace_contact_object_idx` (`object_id` ASC),
  CONSTRAINT `fk_cplace_contact_place`
    FOREIGN KEY (`place_id`)
    REFERENCES `csttec`.`cplace` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cplace_contact_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`crepeat_option`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`crepeat_option` ;

CREATE TABLE IF NOT EXISTS `csttec`.`crepeat_option` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `schedule_id` INT NULL,
  `work_id` INT NULL,
  `todo_id` INT NULL,
  `ctype` VARCHAR(45) NULL,
  `cperiod` INT NULL,
  `cmonth` INT NULL,
  `cweek` INT NULL,
  `cday_of_month` INT NULL,
  `cday_of_week` INT NULL,
  `cdate_start` TIMESTAMP NULL,
  `cdate_end` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_crepeat_option_schedule_idx` (`schedule_id` ASC),
  INDEX `fk_crepeat_option_work_idx` (`work_id` ASC),
  INDEX `fk_crepeat_option_todo_idx` (`todo_id` ASC),
  CONSTRAINT `fk_crepeat_option_schedule`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `csttec`.`cschedule` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_crepeat_option_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_crepeat_option_todo`
    FOREIGN KEY (`todo_id`)
    REFERENCES `csttec`.`ctodo` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_trs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_trs` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_trs` (
  `id` INT NOT NULL,
  `cpart_no` VARCHAR(45) NULL,
  `ctool_type` VARCHAR(5) NULL,
  `ctool_type_suffix` VARCHAR(5) NULL,
  `ctool_no` VARCHAR(50) NULL,
  `ctool_no_suffix` VARCHAR(5) NULL,
  `ctool_rev` VARCHAR(5) NULL,
  `ctool_class` VARCHAR(10) NULL,
  `ctool_location` VARCHAR(45) NULL,
  `ctool_description` VARCHAR(100) NULL,
  `cserial_no` VARCHAR(45) NULL,
  `ctrs_type` VARCHAR(30) NULL,
  `cpayment_type` VARCHAR(150) NULL,
  `cwork_scope` VARCHAR(10) NULL,
  `crev_req` TINYINT(1) NULL,
  `ctryout_req` TINYINT(1) NULL,
  `cpi_req` VARCHAR(45) NULL,
  `ctask_group` VARCHAR(2) NULL,
  `cquantity` VARCHAR(10) NULL,
  `cusage` TEXT NULL,
  `cconcept` TEXT NULL,
  `cremark` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_trs_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccompany_staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccompany_staff` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccompany_staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `cname` VARCHAR(45) NULL,
  `ctitle` VARCHAR(45) NULL,
  `ccell_phone` VARCHAR(45) NULL,
  `coffice_phone` VARCHAR(45) NULL,
  `cemail` VARCHAR(50) NULL,
  `crepresentative` TINYINT(1) NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_ccompany_staff_company_idx` (`company_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_ccompany_staff_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_ccompany_staff_company_id`
    FOREIGN KEY (`company_id`)
    REFERENCES `csttec`.`ccompany` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccompany_staff_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwarehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwarehouse` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwarehouse` (
  `id` INT NOT NULL,
  `cdescription` VARCHAR(300) NULL,
  INDEX `fk_cwarehouse_object_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cwarehouse_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cmaterial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cmaterial` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cmaterial` (
  `id` INT NOT NULL,
  `folder_id` INT NOT NULL,
  `cno` VARCHAR(50) NULL,
  `cname` VARCHAR(100) NULL,
  `cspec` VARCHAR(100) NULL,
  `cspec_detail` VARCHAR(100) NULL,
  `cmaker` VARCHAR(50) NULL,
  `cunit` VARCHAR(20) NULL,
  `cprice` DECIMAL(10,2) NULL,
  INDEX `fk_cmaterial_object_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cmaterial_folder_idx` (`folder_id` ASC),
  CONSTRAINT `fk_cmaterial_object_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cmaterial_folder_id`
    FOREIGN KEY (`folder_id`)
    REFERENCES `csttec`.`cfolder` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cmaterial_supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cmaterial_supplier` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cmaterial_supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `material_id` INT NOT NULL,
  `company_id` INT NOT NULL,
  `cprimary` TINYINT(1) NULL,
  `cprice` DECIMAL(10,2) NULL,
  `clot_size` INT NULL,
  `cdelivery` INT NULL,
  INDEX `fk_cmaterial_supplier_cmaterial1_idx` (`material_id` ASC),
  INDEX `fk_cmaterial_supplier_ccompany1_idx` (`company_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cmaterial_supplier_cmaterial1`
    FOREIGN KEY (`material_id`)
    REFERENCES `csttec`.`cmaterial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmaterial_supplier_ccompany1`
    FOREIGN KEY (`company_id`)
    REFERENCES `csttec`.`ccompany` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cmaterial_warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cmaterial_warehouse` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cmaterial_warehouse` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `material_id` INT NOT NULL,
  `warehouse_id` INT NOT NULL,
  `cstorage_location` VARCHAR(45) NULL,
  `cstored_amount` INT NULL,
  `cstock_upper_limit` INT NULL,
  `cstock_lower_limit` INT NULL,
  INDEX `fk_cmaterial_warehouse_material_idx` (`material_id` ASC),
  INDEX `fk_cmaterial_warehouse_warehouse_idx` (`warehouse_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cmaterial_warehouse_material`
    FOREIGN KEY (`material_id`)
    REFERENCES `csttec`.`cmaterial` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cmaterial_warehouse_warehouse`
    FOREIGN KEY (`warehouse_id`)
    REFERENCES `csttec`.`cwarehouse` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccost_center`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccost_center` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccost_center` (
  `id` INT NOT NULL,
  `cyear_from` SMALLINT NOT NULL,
  `cyear_to` SMALLINT NULL,
  `parent_id` INT NULL,
  `cname` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ccost_center_object_idx` (`id` ASC),
  INDEX `fk_ccost_center_parent_idx` (`parent_id` ASC),
  CONSTRAINT `fk_ccost_center_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccost_center_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `csttec`.`ccost_center` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctransaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctransaction` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctransaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `booker_id` INT NOT NULL,
  `cnote` VARCHAR(300) NULL,
  `cdate_booked` TIMESTAMP NULL,
  `cdate_occurred` TIMESTAMP NULL,
  `ctype` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ctransaction_user_idx` (`user_id` ASC),
  INDEX `fk_ctransaction_booker_idx` (`booker_id` ASC),
  CONSTRAINT `fk_ctransaction_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctransaction_booker`
    FOREIGN KEY (`booker_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cbook_entry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cbook_entry` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cbook_entry` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `transaction_id` INT NOT NULL,
  `material_id` INT NULL,
  `company_id` INT NULL,
  `warehouse_id` INT NULL,
  `cost_center_id` INT NULL,
  `work_id` INT NULL,
  `centry_side` TINYINT NULL,
  `caccount` VARCHAR(10) NULL,
  `cprice` DECIMAL(10,2) NULL,
  `camount` DECIMAL(15,2) NULL,
  `cqty` INT NULL,
  `cremainder` INT NULL,
  `cdriving` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cbook_entry_material_idx` (`material_id` ASC),
  INDEX `fk_cbook_entry_company_idx` (`company_id` ASC),
  INDEX `fk_cbook_entry_warehouse_idx` (`warehouse_id` ASC),
  INDEX `fk_cbook_entry_cost_center_idx` (`cost_center_id` ASC),
  INDEX `fk_cbook_entry_transaction_idx` (`transaction_id` ASC),
  INDEX `fk_cbook_entry_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_cbook_entry_material`
    FOREIGN KEY (`material_id`)
    REFERENCES `csttec`.`cmaterial` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbook_entry_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `csttec`.`ccompany` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbook_entry_warehouse`
    FOREIGN KEY (`warehouse_id`)
    REFERENCES `csttec`.`cwarehouse` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbook_entry_cost_center`
    FOREIGN KEY (`cost_center_id`)
    REFERENCES `csttec`.`ccost_center` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbook_entry_transaction`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `csttec`.`ctransaction` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbook_entry_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccost_center_monthly`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccost_center_monthly` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccost_center_monthly` (
  `cost_center_id` INT NOT NULL,
  `cyear` SMALLINT NOT NULL,
  `cmonth` TINYINT NOT NULL,
  `cbudget` DECIMAL(15) NULL,
  `cexpenditure` DECIMAL(15) NULL,
  `cdate_calculated` TIMESTAMP NULL,
  INDEX `fk_ccost_center_monthly_cost_center_idx` (`cost_center_id` ASC),
  PRIMARY KEY (`cost_center_id`, `cyear`, `cmonth`),
  CONSTRAINT `fk_ccost_center_monthly_cost_center`
    FOREIGN KEY (`cost_center_id`)
    REFERENCES `csttec`.`ccost_center` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccost_center_yearly`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccost_center_yearly` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccost_center_yearly` (
  `cost_center_id` INT NOT NULL,
  `cyear` SMALLINT NOT NULL,
  `cbudget` DECIMAL(15) NULL,
  `cexpenditure` DECIMAL(15) NULL,
  `cdate_calculated` TIMESTAMP NULL,
  INDEX `fk_ccost_center_yearly_cost_center_idx` (`cost_center_id` ASC),
  PRIMARY KEY (`cost_center_id`, `cyear`),
  CONSTRAINT `fk_ccost_center_yearly_cost_center`
    FOREIGN KEY (`cost_center_id`)
    REFERENCES `csttec`.`ccost_center` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cmaterial_consume`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cmaterial_consume` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cmaterial_consume` (
  `consume_id` INT NOT NULL,
  `buy_id` INT NOT NULL,
  `cqty` INT NOT NULL,
  INDEX `fk_cmaterial_consume_consume_idx` (`consume_id` ASC),
  INDEX `fk_cmaterial_consume_buy_idx` (`buy_id` ASC),
  PRIMARY KEY (`consume_id`, `buy_id`),
  CONSTRAINT `fk_cmaterial_consume_consume`
    FOREIGN KEY (`consume_id`)
    REFERENCES `csttec`.`cbook_entry` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cmaterial_consume_buy`
    FOREIGN KEY (`buy_id`)
    REFERENCES `csttec`.`cbook_entry` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_rfq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_rfq` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_rfq` (
  `id` INT NOT NULL,
  `customer_id` INT NULL,
  `company_id` INT NULL,
  `quot_user_id` INT NOT NULL,
  `crfq_type` VARCHAR(45) NULL,
  `cdate_due_quote` TIMESTAMP NULL,
  `cmodel` VARCHAR(45) NULL,
  `ccontract_period` VARCHAR(45) NULL,
  `cpayment_terms` VARCHAR(45) NULL,
  `cexport_terms` VARCHAR(45) NULL,
  `cunit_per_month` VARCHAR(100) NULL,
  `citem_count` VARCHAR(45) NULL,
  `cpart_no` VARCHAR(100) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `cpart_desc` VARCHAR(100) NULL,
  `cquote_no` VARCHAR(45) NULL,
  `cdate_quote_start` TIMESTAMP NULL,
  `cdate_quote_submit` TIMESTAMP NULL,
  `cdate_contracted` TIMESTAMP NULL,
  `cprice_per_unit` DECIMAL(15) NULL,
  `crevenue` DECIMAL(15) NULL,
  `cprofit` DECIMAL(15) NULL,
  `cprofit_rate` DECIMAL(5,2) NULL,
  `cproject_no` VARCHAR(45) NULL,
  `ccontract_progress` VARCHAR(500) NULL,
  `cnote_recognition` VARCHAR(500) NULL,
  `cnote_quotation` VARCHAR(500) NULL,
  `cnote_negotiation` VARCHAR(500) NULL,
  `cnote_contract` VARCHAR(500) NULL,
  `ccurrency` VARCHAR(3) NULL,
  `cexchange_rate` DECIMAL(6,2) NULL,
  `cdecision_negotiation` TINYINT(1) NULL,
  INDEX `fk_chz_rfq_work_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_chz_rfq_customer_idx` (`customer_id` ASC),
  INDEX `fk_chz_rfq_company_idx` (`company_id` ASC),
  INDEX `fk_chz_rfq_quot_user_idx` (`quot_user_id` ASC),
  CONSTRAINT `fk_chz_rfq_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_chz_rfq_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `csttec`.`ccontact` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_chz_rfq_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `csttec`.`ccompany` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_chz_rfq_quot_user`
    FOREIGN KEY (`quot_user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_ncp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_ncp` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_ncp` (
  `id` INT NOT NULL,
  `cpart_no` VARCHAR(45) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `cmachine_no` VARCHAR(45) NULL,
  `cnc_program_no` VARCHAR(80) NULL,
  `cnc_program_rev` VARCHAR(45) NULL,
  `creason` VARCHAR(500) NULL,
  `cremark` VARCHAR(500) NULL,
  `cvericut_result` TINYINT(1) NULL,
  `csro_no` VARCHAR(100) NULL,
  `csro_rev` VARCHAR(5) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_ncp_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_mcd_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_mcd_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_mcd_relation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NOT NULL,
  `coperation_no` VARCHAR(20) NULL,
  `cmcd_no` VARCHAR(100) NULL,
  `cmcd_rev` VARCHAR(5) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chz_mcd_relation_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_chz_mcd_relation_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_mjs_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_mjs_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_mjs_relation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NOT NULL,
  `cmjs_no` VARCHAR(100) NULL,
  `cmjs_rev_was` VARCHAR(5) NULL,
  `cmjs_rev_is` VARCHAR(5) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chz_mjs_relation_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_chz_mjs_relation_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cecn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cecn` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cecn` (
  `id` INT NOT NULL,
  `cchanged_item` VARCHAR(200) NULL,
  `ccustomer` VARCHAR(45) NULL,
  `coem_ec_no` VARCHAR(45) NULL,
  `cinstruction` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cecn_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cecn_reason`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cecn_reason` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cecn_reason` (
  `ecn_id` INT NOT NULL,
  `creason` VARCHAR(45) NULL,
  INDEX `fk_cecn_reason_ecn_idx` (`ecn_id` ASC),
  CONSTRAINT `fk_cecn_reason_ecn`
    FOREIGN KEY (`ecn_id`)
    REFERENCES `csttec`.`cecn` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_drs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_drs` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_drs` (
  `id` INT NOT NULL,
  `crev` VARCHAR(10) NULL,
  `cunit` VARCHAR(4) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_drs_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_drs_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_drs_result` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_drs_result` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hz_drs_id` INT NOT NULL,
  `cseq` SMALLINT NULL,
  `csource` VARCHAR(30) NULL,
  `cderived` VARCHAR(30) NULL,
  `caccepted` TINYINT(1) NULL,
  `cnote` VARCHAR(400) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chz_drs_result_work_idx` (`hz_drs_id` ASC),
  CONSTRAINT `fk_chz_drs_result_work`
    FOREIGN KEY (`hz_drs_id`)
    REFERENCES `csttec`.`chz_drs` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_pvs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_pvs` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_pvs` (
  `id` INT NOT NULL,
  `cpart_no` VARCHAR(40) NULL,
  `cpart_name` VARCHAR(40) NULL,
  `cpvs_code` VARCHAR(1) NULL,
  `czone` VARCHAR(5) NULL,
  `cunit` VARCHAR(5) NULL,
  `ctol_roughness` VARCHAR(5) NULL,
  `ctol_angles` VARCHAR(5) NULL,
  `ctol_len_0` VARCHAR(5) NULL,
  `ctol_len_1` VARCHAR(5) NULL,
  `ctol_len_2` VARCHAR(5) NULL,
  `ctol_len_3` VARCHAR(5) NULL,
  `ctol_len_4` VARCHAR(5) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_pvs_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_item_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_item_type` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_item_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_item` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_item` (
  `id` INT NOT NULL,
  `doc_thread_id` INT NULL,
  `work_item_type_id` INT NOT NULL,
  `cno` VARCHAR(20) NOT NULL,
  `ctitle` VARCHAR(130) NOT NULL,
  `cdescription` TEXT NULL,
  `cstatus` TINYINT NULL DEFAULT 0,
  `cpriority` TINYINT NULL,
  INDEX `fk_cwork_item_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_item_type_idx` (`work_item_type_id` ASC),
  INDEX `fk_cwork_item_doc_idx` (`doc_thread_id` ASC),
  CONSTRAINT `fk_cwork_item_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_item_type`
    FOREIGN KEY (`work_item_type_id`)
    REFERENCES `csttec`.`cwork_item_type` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_item_doc`
    FOREIGN KEY (`doc_thread_id`)
    REFERENCES `csttec`.`cobject` (`thread_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproperty_def`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproperty_def` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproperty_def` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(45) NOT NULL,
  `ctype` TINYINT NOT NULL,
  `csize` SMALLINT NULL,
  `carray` TINYINT(1) NULL,
  `cunit` VARCHAR(5) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_item_classify_rule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_item_classify_rule` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_item_classify_rule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cwork_item_type_id` INT NOT NULL,
  `property_def_id` INT NULL,
  `ctext` VARCHAR(45) NOT NULL,
  `cvalue` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_item_classify_rule_property_def_idx` (`property_def_id` ASC),
  INDEX `fk_cwork_item_classify_rule_work_item_type_idx` (`cwork_item_type_id` ASC),
  CONSTRAINT `fk_cwork_item_classify_rule_property_def`
    FOREIGN KEY (`property_def_id`)
    REFERENCES `csttec`.`cproperty_def` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_item_classify_rule_work_item_type`
    FOREIGN KEY (`cwork_item_type_id`)
    REFERENCES `csttec`.`cwork_item_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cdoc_work_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdoc_work_item` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdoc_work_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_item_thread_id` INT NOT NULL,
  `work_item_id` INT NOT NULL,
  `cfreeze` TINYINT(1) NULL,
  `doc_id` INT NOT NULL,
  INDEX `fk_clive_doc_item_work_item_idx` (`work_item_id` ASC),
  INDEX `fk_cdoc_work_item_doc_idx` (`doc_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cdoc_work_item_thread_idx` (`work_item_thread_id` ASC),
  CONSTRAINT `fk_clive_doc_item_work_item`
    FOREIGN KEY (`work_item_id`)
    REFERENCES `csttec`.`cwork_item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cdoc_work_item_doc`
    FOREIGN KEY (`doc_id`)
    REFERENCES `csttec`.`cdoc` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cdoc_work_item_object`
    FOREIGN KEY (`work_item_thread_id`)
    REFERENCES `csttec`.`cobject` (`thread_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cobject_property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cobject_property` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cobject_property` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NOT NULL,
  `property_def_id` INT NOT NULL,
  `cvalue` VARCHAR(200) NULL,
  INDEX `fk_cobject_property_object_idx` (`object_id` ASC),
  INDEX `fk_cobject_property_def_idx` (`property_def_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cobject_property_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cobject_property_def`
    FOREIGN KEY (`property_def_id`)
    REFERENCES `csttec`.`cproperty_def` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cdoc_work_item_def`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdoc_work_item_def` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdoc_work_item_def` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `doc_id` INT NOT NULL,
  `work_item_type_id` INT NOT NULL,
  `cuse` TINYINT(1) NULL,
  `cdisplay` TINYINT(1) NULL,
  `cprop_ids` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cdoc_work_item_def_doc_idx` (`doc_id` ASC),
  INDEX `fk_cdoc_work_item_def_work_item_type_idx` (`work_item_type_id` ASC),
  CONSTRAINT `fk_cdoc_work_item_def_doc`
    FOREIGN KEY (`doc_id`)
    REFERENCES `csttec`.`cdoc` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cdoc_work_item_def_work_item_type`
    FOREIGN KEY (`work_item_type_id`)
    REFERENCES `csttec`.`cwork_item_type` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_item_action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_item_action` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_item_action` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_item_id` INT NOT NULL,
  `work_id` INT NULL,
  `caction` VARCHAR(45) NULL,
  `cdate_requested` TIMESTAMP NULL,
  `ccurrent` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_item_action_work_item_idx` (`work_item_id` ASC),
  INDEX `fk_cwork_item_action_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_cwork_item_action_work_item`
    FOREIGN KEY (`work_item_id`)
    REFERENCES `csttec`.`cwork_item` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_item_action_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_item_action_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_item_action_user` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_item_action_user` (
  `work_item_action_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `ccomment` VARCHAR(700) NULL,
  `cdate_opened` TIMESTAMP NULL,
  `cdate_ended` TIMESTAMP NULL,
  INDEX `fk_cwork_item_action_user_action_idx` (`work_item_action_id` ASC),
  INDEX `fk_cwork_item_action_user_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cwork_item_action_user_action`
    FOREIGN KEY (`work_item_action_id`)
    REFERENCES `csttec`.`cwork_item_action` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_item_action_user_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`crepository_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`crepository_tag` ;

CREATE TABLE IF NOT EXISTS `csttec`.`crepository_tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NOT NULL,
  `crepository_url` VARCHAR(200) NULL,
  `crevision` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_crepository_tag_object_idx` (`object_id` ASC),
  CONSTRAINT `fk_crepository_tag_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_dependency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_dependency` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_dependency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `primary_id` INT NOT NULL,
  `secondary_id` INT NOT NULL,
  `clag_days` DOUBLE NULL,
  `ctype` TINYINT NOT NULL,
  INDEX `fk_cwork_dependency_primary_idx` (`primary_id` ASC),
  INDEX `fk_cwork_dependency_secondary_idx` (`secondary_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cwork_dependency_primary`
    FOREIGN KEY (`primary_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_dependency_secondary`
    FOREIGN KEY (`secondary_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_template_dependency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_template_dependency` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_template_dependency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `primary_id` INT NOT NULL,
  `secondary_id` INT NOT NULL,
  `clag_days` DOUBLE NULL,
  `ctype` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_template_dependency_primary_idx` (`primary_id` ASC),
  INDEX `fk_cwork_template_dependency_secondary_idx` (`secondary_id` ASC),
  CONSTRAINT `fk_cwork_template_dependency_primary`
    FOREIGN KEY (`primary_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_template_dependency_secondary`
    FOREIGN KEY (`secondary_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctest_case_step`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctest_case_step` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctest_case_step` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_item_id` INT NOT NULL,
  `cseq` TINYINT NULL,
  `cstep` VARCHAR(50) NULL,
  `cdescription` VARCHAR(500) NULL,
  `cexpected_result` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ctest_case_step_work_item_idx` (`work_item_id` ASC),
  CONSTRAINT `fk_ctest_case_step_work_item`
    FOREIGN KEY (`work_item_id`)
    REFERENCES `csttec`.`cwork_item` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctest_env`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctest_env` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctest_env` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cseq` TINYINT NULL,
  `cname` VARCHAR(45) NULL,
  `cdescription` VARCHAR(500) NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  `user_id` INT NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ctest_env_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_ctest_env_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctest_run`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctest_run` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctest_run` (
  `id` INT NOT NULL,
  `test_env_id` INT NOT NULL,
  `ctest_status` TINYINT NULL DEFAULT 0,
  `cdescription` VARCHAR(500) NULL,
  `judge_id` INT NULL,
  `cdate_judged` TIMESTAMP NULL,
  INDEX `fk_ctest_run_work_idx` (`id` ASC),
  INDEX `fk_ctest_run_env_idx` (`test_env_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_ctest_run_user_idx` (`judge_id` ASC),
  CONSTRAINT `fk_ctest_run_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctest_run_env`
    FOREIGN KEY (`test_env_id`)
    REFERENCES `csttec`.`ctest_env` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctest_run_user`
    FOREIGN KEY (`judge_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctest_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctest_result` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctest_result` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_item_id` INT NOT NULL,
  `work_id` INT NOT NULL,
  `cverdict` TINYINT NULL DEFAULT 0,
  `cdate_executed` TIMESTAMP NULL,
  `clatest` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_ctest_result_work_idx` (`work_id` ASC),
  INDEX `fk_ctest_result_work_item_idx` (`work_item_id` ASC),
  CONSTRAINT `fk_ctest_result_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`ctest_run` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctest_result_work_item`
    FOREIGN KEY (`work_item_id`)
    REFERENCES `csttec`.`cwork_item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctest_step_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctest_step_result` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctest_step_result` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `test_result_id` INT NOT NULL,
  `test_case_step_id` INT NOT NULL,
  `cactual_result` VARCHAR(500) NULL,
  `cverdict` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_ctest_step_result_step_idx` (`test_case_step_id` ASC),
  INDEX `fk_ctest_step_result_result_idx` (`test_result_id` ASC),
  CONSTRAINT `fk_ctest_result_step`
    FOREIGN KEY (`test_case_step_id`)
    REFERENCES `csttec`.`ctest_case_step` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctest_step_result`
    FOREIGN KEY (`test_result_id`)
    REFERENCES `csttec`.`ctest_result` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cdeliverable_file_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdeliverable_file_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdeliverable_file_relation` (
  `deliverable_id` INT NOT NULL,
  `file_id` INT NOT NULL,
  `file_version` SMALLINT NOT NULL,
  INDEX `fk_cdeliverable_file_relation_file_idx` (`file_id` ASC, `file_version` ASC),
  INDEX `fk_cdeliverable_file_relation_deliverable_idx` (`deliverable_id` ASC),
  CONSTRAINT `fk_cdeliverable_file_relation_file`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cdeliverable_file_relation_deliverable`
    FOREIGN KEY (`deliverable_id`)
    REFERENCES `csttec`.`cdeliverable` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproject_template_grade_work_skip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject_template_grade_work_skip` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject_template_grade_work_skip` (
  `project_template_grade_id` INT NOT NULL,
  `work_template_id` INT NOT NULL,
  INDEX `fk_cproject_template_grade_work_skip_grad_idx` (`project_template_grade_id` ASC),
  INDEX `fk_cproject_template_grade_work_skip_work_idx` (`work_template_id` ASC),
  CONSTRAINT `fk_cproject_template_grade_work_skip_grade`
    FOREIGN KEY (`project_template_grade_id`)
    REFERENCES `csttec`.`cproject_template_grade` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_template_grade_work_skip_work`
    FOREIGN KEY (`work_template_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `csttec`.`cwork_template_deliverable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_template_deliverable` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_template_deliverable` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_template_id` INT NOT NULL,
  `deliverable_id` INT NOT NULL,
  `cmandatory` TINYINT(1) NULL DEFAULT 1,
  INDEX `fk_cwork_template_deliverable_template_idx` (`work_template_id` ASC),
  INDEX `fk_cwork_template_deliverable_deliverable_idx` (`deliverable_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cwork_template_deliverable_template`
    FOREIGN KEY (`work_template_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_template_deliverable_deliverable`
    FOREIGN KEY (`deliverable_id`)
    REFERENCES `csttec`.`cdeliverable` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cissue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cissue` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cissue` (
  `id` INT NOT NULL,
  `crequest_dept` VARCHAR(45) NULL,
  `crequester` VARCHAR(45) NULL COMMENT '발견자',
  `ctype` TINYINT NULL COMMENT '이슈/문제점 유형',
  `ctype_requested` TINYINT NULL COMMENT '이슈/문제점 유형(요청)',
  `cpriority` TINYINT NULL COMMENT '중요도/긴급도',
  `cseverity` TINYINT NULL COMMENT '심각도',
  `cplace_class` TINYINT NULL COMMENT '발생처',
  `ccategory_class` TINYINT NULL,
  `cphase_class` TINYINT NULL COMMENT '발견단계',
  `ctrigger_class` TINYINT NULL COMMENT '발생유형',
  `creason_class` TINYINT NULL COMMENT '발생원인',
  `cimpact` VARCHAR(100) NULL COMMENT '변경영향도',
  `cplace` VARCHAR(100) NULL COMMENT '발생환경/발견장소',
  `csolution` TEXT NULL COMMENT '해결방안',
  `cresolution` TEXT NULL COMMENT '해결내용',
  `cqty` INT NULL COMMENT '발생수량',
  `cstatus` TINYINT NULL DEFAULT 0,
  `crecurrence_class` TINYINT NULL,
  `cestimated_days` DOUBLE NULL COMMENT '예상소요기간(일)',
  `cestimated_cost_change` DECIMAL(10) NULL,
  `cestimated_invest_change` DECIMAL(15) NULL,
  `crecurrence` TINYINT(1) NULL COMMENT '재발여부',
  `recurred_issue_id` INT NULL,
  `cdate_occurred` TIMESTAMP NULL COMMENT '발생일자/발견일자',
  `cdate_requested` TIMESTAMP NULL,
  `cdate_due` TIMESTAMP NULL COMMENT '해결목표일자',
  `cdate_resolved` TIMESTAMP NULL COMMENT '해결일자',
  `cchange_required` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_cissue_recurred_issue_idx` (`recurred_issue_id` ASC),
  CONSTRAINT `fk_cissue_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cissue_recurred_issue`
    FOREIGN KEY (`recurred_issue_id`)
    REFERENCES `csttec`.`cissue` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccriteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccriteria` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccriteria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(100) NULL,
  `cdescription` VARCHAR(500) NULL,
  `cactive` TINYINT(1) NULL,
  `user_id` INT NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ccriteria_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_ccriteria_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_template_criteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_template_criteria` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_template_criteria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_template_id` INT NOT NULL,
  `criteria_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  INDEX `fk_cwork_template_criteria_template_idx` (`work_template_id` ASC),
  INDEX `fk_cwork_template_criteria_criteria_idx` (`criteria_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_template_criteria_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cwork_template_criteria_template`
    FOREIGN KEY (`work_template_id`)
    REFERENCES `csttec`.`cwork_template` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_template_criteria_criteria`
    FOREIGN KEY (`criteria_id`)
    REFERENCES `csttec`.`ccriteria` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_template_criteria_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cwork_criteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cwork_criteria` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cwork_criteria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NOT NULL,
  `criteria_id` INT NOT NULL,
  `cdate` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `cverdict` TINYINT NULL,
  `ccomment` VARCHAR(500) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cwork_criteria_work_idx` (`work_id` ASC),
  INDEX `fk_cwork_criteria_criteria_idx` (`criteria_id` ASC),
  INDEX `fk_cwork_criteria_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cwork_criteria_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_criteria_criteria`
    FOREIGN KEY (`criteria_id`)
    REFERENCES `csttec`.`ccriteria` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cwork_criteria_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctime_sheet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctime_sheet` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctime_sheet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `cdate` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `cname` VARCHAR(100) NULL,
  `cdescription` VARCHAR(500) NULL,
  `cbillable` TINYINT(1) NULL DEFAULT 1,
  `work_id` INT NULL,
  `work_item_id` INT NULL,
  `chour` DOUBLE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ctime_sheet_work_idx` (`work_id` ASC),
  INDEX `fk_ctime_sheet_user_idx` (`user_id` ASC),
  INDEX `fk_ctime_sheet_work_item_idx` (`work_item_id` ASC),
  CONSTRAINT `fk_ctime_sheet_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctime_sheet_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctime_sheet_work_item`
    FOREIGN KEY (`work_item_id`)
    REFERENCES `csttec`.`cwork_item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctest_run_filter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctest_run_filter` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctest_run_filter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `test_run_id` INT NOT NULL,
  `property_def_id` INT NOT NULL,
  `cvalue` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ctest_run_filter_run_idx` (`test_run_id` ASC),
  INDEX `fk_ctest_run_filter_property_idx` (`property_def_id` ASC),
  CONSTRAINT `fk_ctest_run_filter_run`
    FOREIGN KEY (`test_run_id`)
    REFERENCES `csttec`.`ctest_run` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctest_run_filter_property`
    FOREIGN KEY (`property_def_id`)
    REFERENCES `csttec`.`cproperty_def` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cissue_lot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cissue_lot` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cissue_lot` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `issue_id` INT NOT NULL,
  `coperation` TINYINT NULL,
  `clot_no` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cissue_lot_cissue_idx` (`issue_id` ASC),
  CONSTRAINT `fk_cissue_lot_cissue`
    FOREIGN KEY (`issue_id`)
    REFERENCES `csttec`.`cissue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cecr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cecr` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cecr` (
  `id` INT NOT NULL,
  `crequester` VARCHAR(45) NULL COMMENT '요청자',
  `crequest_dept` VARCHAR(45) NULL COMMENT '요청부서',
  `cpriority` TINYINT NULL COMMENT '중요도',
  `cpriority_requested` TINYINT NULL COMMENT '중요도(요청)',
  `cdate_requested` TIMESTAMP NULL COMMENT '요청일자',
  `csource` VARCHAR(200) NULL COMMENT '변경 근거(출처)',
  `cdate_desired` TIMESTAMP NULL COMMENT '변경희망일',
  `cdate_targeted` TIMESTAMP NULL COMMENT '목표일정',
  `cverdict` TINYINT NULL COMMENT '판정',
  `creason_classes` VARCHAR(100) NULL COMMENT '변경사유',
  `cestimated_days` DOUBLE NULL COMMENT '예상소요기간(일)',
  `cestimated_cost_change` DECIMAL(10) NULL COMMENT '예상원가변동(원)',
  `cestimated_invest_change` DECIMAL(15) NULL COMMENT '예상투자비변동(원)',
  `board_leader_id` INT NULL,
  `ccrb_required` TINYINT(1) NULL,
  `ccrb_decision` TINYINT NULL,
  `cstatus` TINYINT NULL COMMENT '상태',
  INDEX `fk_cecr_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cecr_board_leader_idx` (`board_leader_id` ASC),
  CONSTRAINT `fk_cecr_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cecr_board_leader`
    FOREIGN KEY (`board_leader_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ctodo_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ctodo_relation` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ctodo_relation` (
  `todo_id` INT NOT NULL,
  `work_criteria_id` INT NULL,
  `work_deliverable_id` INT NULL,
  INDEX `fk_ctodo_relation_todo_idx` (`todo_id` ASC),
  INDEX `fk_ctodo_relation_criteria_idx` (`work_criteria_id` ASC),
  INDEX `fk_ctodo_relation_deliverable_idx` (`work_deliverable_id` ASC),
  CONSTRAINT `fk_ctodo_relation_todo`
    FOREIGN KEY (`todo_id`)
    REFERENCES `csttec`.`ctodo` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctodo_relation_criteria`
    FOREIGN KEY (`work_criteria_id`)
    REFERENCES `csttec`.`cwork_criteria` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ctodo_relation_deliverable`
    FOREIGN KEY (`work_deliverable_id`)
    REFERENCES `csttec`.`cwork_deliverable` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cuser_usage_stat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cuser_usage_stat` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cuser_usage_stat` (
  `user_id` INT NOT NULL,
  `cdate` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `clicense_type` TINYINT NOT NULL,
  `cproject` TINYINT(1) NULL DEFAULT 0,
  `cchange` TINYINT(1) NULL DEFAULT 0,
  `ctraffic_usage` DOUBLE NULL,
  PRIMARY KEY (`cdate`, `user_id`),
  INDEX `fk_cuser_usage_stat_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cuser_usage_stat_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ceco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ceco` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ceco` (
  `id` INT NOT NULL,
  `crequest_dept` VARCHAR(45) NULL COMMENT '요청부서',
  `crequester` VARCHAR(45) NULL COMMENT '요청자\n',
  `ccategory_class` TINYINT NULL COMMENT '변경유형',
  `cpriority` TINYINT NULL COMMENT '긴급도(우선순위), 중요도',
  `cseverity` TINYINT NULL COMMENT '심각도',
  `creason_classes` VARCHAR(100) NULL,
  `cestimated_resolution` TEXT NULL COMMENT '예상조치사항',
  `cverification` TEXT NULL COMMENT '검증/확인 검토 결과',
  `csource` VARCHAR(500) NULL COMMENT '변경 근거(출처)',
  `cestimated_days` DOUBLE NULL COMMENT '예상 소요시간(일)',
  `cestimated_cost_change` DECIMAL(10) NULL COMMENT '예상 원가 변동(원)',
  `cestimated_invest_change` DECIMAL(15) NULL COMMENT '예상 투자비 변동(원)',
  `cstatus` TINYINT NULL,
  `cstatus_on_request` TINYINT NULL COMMENT '상태(요청)',
  `cstatus_on_plan` TINYINT NULL COMMENT '상태(계획)',
  `cstatus_on_verification` TINYINT NULL COMMENT '상태(검증/확인)',
  `cverification_method` TINYINT NULL COMMENT '검증방법',
  `executor_id` INT NULL COMMENT '변경처리자',
  `board_leader_id` INT NULL COMMENT 'CCB 의장',
  `ccib_required` TINYINT(1) NULL,
  `cdate_requested` TIMESTAMP NULL COMMENT '요청일자',
  `cdate_desired` TIMESTAMP NULL COMMENT '변경희망일자',
  `cdate_targeted` TIMESTAMP NULL COMMENT '목표일자',
  `cdate_verified` TIMESTAMP NULL COMMENT '확인일',
  `cdate_loaded` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ceco_work_idx` (`id` ASC),
  INDEX `fk_ceco_assigned_executor_idx` (`executor_id` ASC),
  INDEX `fk_ceco_board_leader_idx` (`board_leader_id` ASC),
  CONSTRAINT `fk_ceco_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_assigned_executor`
    FOREIGN KEY (`executor_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_board_leader_id`
    FOREIGN KEY (`board_leader_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_tcc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_tcc` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_tcc` (
  `id` INT NOT NULL,
  `cpeening_type` TINYINT NULL,
  `cpart_no` VARCHAR(45) NULL,
  `cpart_name` VARCHAR(100) NULL,
  `capplied_part_nos` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_chz_tcc_work`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cbaseline`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cbaseline` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cbaseline` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` INT NULL,
  `project_id` INT NULL,
  `cname` VARCHAR(100) NULL,
  `ctype` TINYINT NULL,
  `cdescription` VARCHAR(400) NULL,
  `user_id` INT NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cbaseline_project_idx` (`project_id` ASC),
  INDEX `fk_cbaseline_user_idx` (`user_id` ASC),
  INDEX `fk_cbaseline_object_idx` (`object_id` ASC),
  CONSTRAINT `fk_cbaseline_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbaseline_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbaseline_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cbaseline_object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cbaseline_object` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cbaseline_object` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `baseline_id` INT NOT NULL,
  `object_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cdate_added` TIMESTAMP NULL,
  `cdate_plan_to_start` TIMESTAMP NULL,
  `cdate_plan_to_end` TIMESTAMP NULL,
  `camount_plan` DOUBLE NULL,
  `parent_id` INT NULL,
  INDEX `fk_cbaseline_object_object_idx` (`object_id` ASC),
  INDEX `fk_cbaseline_object_user_idx` (`user_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_cbaseline_object_baseline_idx` (`baseline_id` ASC),
  INDEX `fk_cbaseline_object_parent_idx` (`parent_id` ASC),
  CONSTRAINT `fk_cbaseline_object_object`
    FOREIGN KEY (`object_id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbaseline_object_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbaseline_object_baseline`
    FOREIGN KEY (`baseline_id`)
    REFERENCES `csttec`.`cbaseline` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cbaseline_object_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `csttec`.`cbaseline_object` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfile_markup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfile_markup` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfile_markup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `file_id` INT NOT NULL,
  `file_version` SMALLINT NOT NULL,
  `cpage` SMALLINT NOT NULL,
  `ctext` TEXT NULL,
  `cnote` VARCHAR(400) NULL,
  `cshared` TINYINT(1) NULL,
  `cdate_created` TIMESTAMP NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cfile_markup_file_idx` (`file_id` ASC, `file_version` ASC),
  INDEX `fk_cfile_markup_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_cfile_markup_file`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cfile_markup_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cviewer_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cviewer_token` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cviewer_token` (
  `viewer_token_id` VARCHAR(100) NOT NULL,
  `viewer_session_id` VARCHAR(100) NOT NULL,
  `file_id` INT NULL,
  `file_version` SMALLINT NULL,
  `cvol_file_path` VARCHAR(100) NULL,
  `cfull_file_path` VARCHAR(100) NULL,
  `cfile_name` VARCHAR(45) NULL,
  `cfile_server_url` VARCHAR(45) NULL,
  `cpage` INT NULL,
  `curl` VARCHAR(500) NULL,
  `ctext` VARCHAR(200) NULL,
  `cprint` TINYINT(1) NULL,
  `cfile_type` VARCHAR(45) NULL,
  `crotation` INT NULL,
  `ccolor_inverted` TINYINT(1) NULL,
  `clower_x` DECIMAL(8,2) NULL,
  `clower_y` DECIMAL(8,2) NULL,
  `cupper_x` DECIMAL(8,2) NULL,
  `cupper_y` DECIMAL(8,2) NULL,
  `cratio` DECIMAL(8,4) NULL,
  `cprevious_scale` DECIMAL(8,4) NULL,
  `cviewer_width` INT NULL,
  `cviewer_height` INT NULL,
  `cstamp_text` VARCHAR(100) NULL,
  `cstamp_sub_text` VARCHAR(300) NULL,
  PRIMARY KEY (`viewer_token_id`),
  INDEX `fk_viewer_token_session_idx` (`viewer_session_id` ASC),
  CONSTRAINT `fk_table1_cviewer_session1`
    FOREIGN KEY (`viewer_session_id`)
    REFERENCES `csttec`.`cviewer_session` (`viewer_session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ceco_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ceco_line` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ceco_line` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `eco_id` INT NOT NULL,
  `parent_rev_id` INT NOT NULL,
  `cseq` VARCHAR(20) NOT NULL,
  `cchange_type` TINYINT NOT NULL,
  `old_occ_id` INT NULL,
  `new_occ_id` INT NULL,
  `old_revision_id` INT NULL,
  `new_revision_id` INT NULL,
  `cold_qty` DOUBLE NULL,
  `cnew_qty` DOUBLE NULL,
  `cinterchangeability` TINYINT NULL,
  `cdisposal_method` TINYINT NULL,
  `cnote` VARCHAR(400) NULL,
  `applier_id` INT NULL,
  `capplicability` TINYINT NULL,
  `caffected_assembly_count` INT NULL,
  `cdate_requested` TIMESTAMP NULL,
  `cdate_applied` TIMESTAMP NULL,
  `cdate_expected` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ceco_line_eco_idx` (`eco_id` ASC),
  INDEX `fk_ceco_line_parent_rev_idx` (`parent_rev_id` ASC),
  INDEX `fk_ceco_line_old_rev_idx` (`old_revision_id` ASC),
  INDEX `fk_ceco_line_new_rev_idx` (`new_revision_id` ASC),
  INDEX `fk_ceco_line_applier_idx` (`applier_id` ASC),
  INDEX `fk_ceco_line_old_occ_idx` (`old_occ_id` ASC),
  INDEX `fk_ceco_line_new_occ_idx` (`new_occ_id` ASC),
  CONSTRAINT `fk_ceco_line_eco`
    FOREIGN KEY (`eco_id`)
    REFERENCES `csttec`.`ceco` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_line_parent_rev`
    FOREIGN KEY (`parent_rev_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_line_old_rev`
    FOREIGN KEY (`old_revision_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_line_new_rev`
    FOREIGN KEY (`new_revision_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_line_applier`
    FOREIGN KEY (`applier_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_line_old_occ`
    FOREIGN KEY (`old_occ_id`)
    REFERENCES `csttec`.`coccurrence` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_line_new_occ`
    FOREIGN KEY (`new_occ_id`)
    REFERENCES `csttec`.`coccurrence` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ceco_line_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ceco_line_comment` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ceco_line_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `eco_line_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cdate` TIMESTAMP NULL,
  `cnote` VARCHAR(400) NULL,
  `cdate_expected` TIMESTAMP NULL,
  `clatest` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ceco_line_comment_line_idx` (`eco_line_id` ASC),
  INDEX `fk_ceco_line_comment_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_ceco_line_comment_line`
    FOREIGN KEY (`eco_line_id`)
    REFERENCES `csttec`.`ceco_line` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ceco_line_comment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coption`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coption` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coption` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `cname` VARCHAR(45) NULL,
  `cdescription` VARCHAR(500) NULL,
  `cactive` TINYINT(1) NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_coption_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_coption_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coption_value`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coption_value` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coption_value` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cvalue` VARCHAR(45) NULL,
  `option_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_coption_value_option_idx` (`option_id` ASC),
  INDEX `fk_coption_value_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_coption_value_option`
    FOREIGN KEY (`option_id`)
    REFERENCES `csttec`.`coption` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coption_value_cuser1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coption_applied`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coption_applied` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coption_applied` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_revision_id` INT NOT NULL,
  `option_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_coption_applied_option_idx` (`option_id` ASC),
  INDEX `fk_coption_applied_rev_idx` (`item_revision_id` ASC),
  CONSTRAINT `fk_coption_applied_option`
    FOREIGN KEY (`option_id`)
    REFERENCES `csttec`.`coption` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coption_applied_rev`
    FOREIGN KEY (`item_revision_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coption_value_applied`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coption_value_applied` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coption_value_applied` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `option_applied_id` INT NOT NULL,
  `option_value_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_coption_value_applied_value_idx` (`option_value_id` ASC),
  INDEX `fk_coption_value_applied_option_idx` (`option_applied_id` ASC),
  CONSTRAINT `fk_coption_value_applied_value`
    FOREIGN KEY (`option_value_id`)
    REFERENCES `csttec`.`coption_value` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coption_value_applied_option`
    FOREIGN KEY (`option_applied_id`)
    REFERENCES `csttec`.`coption_applied` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coption_set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coption_set` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coption_set` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_revision_id` INT NOT NULL,
  `cname` VARCHAR(45) NULL,
  `cdescription` VARCHAR(400) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_coption_set_citem_revision1_idx` (`item_revision_id` ASC),
  CONSTRAINT `fk_coption_set_citem_revision1`
    FOREIGN KEY (`item_revision_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coption_set_value`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coption_set_value` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coption_set_value` (
  `option_set_id` INT NOT NULL,
  `option_id` INT NOT NULL,
  `option_value_id` INT NOT NULL,
  INDEX `fk_coption_set_value_set_idx` (`option_set_id` ASC),
  INDEX `fk_coption_set_value_option_idx` (`option_id` ASC),
  INDEX `fk_coption_set_value_value_idx` (`option_value_id` ASC),
  CONSTRAINT `fk_coption_set_value_set`
    FOREIGN KEY (`option_set_id`)
    REFERENCES `csttec`.`coption_set` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coption_set_value_option`
    FOREIGN KEY (`option_id`)
    REFERENCES `csttec`.`coption` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coption_set_value_value`
    FOREIGN KEY (`option_value_id`)
    REFERENCES `csttec`.`coption_value` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproject_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject_role` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject_role` (
  `project_id` INT NOT NULL,
  `work_role_id` INT NOT NULL,
  INDEX `fk_cproject_role_role_idx` (`work_role_id` ASC),
  INDEX `fk_cproject_role_project_idx` (`project_id` ASC),
  CONSTRAINT `fk_cproject_role_role`
    FOREIGN KEY (`work_role_id`)
    REFERENCES `csttec`.`cwork_role` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_role_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `csttec`.`cproject_evm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproject_evm` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproject_evm` (
  `project_id` INT NOT NULL,
  `baseline_id` INT NOT NULL,
  `cdate` TIMESTAMP NOT NULL,
  `cev_md` DOUBLE NULL,
  `cac_md` DOUBLE NULL,
  INDEX `fk_cproject_evm_project_idx` (`project_id` ASC),
  INDEX `fk_cproject_evm_baseline_idx` (`baseline_id` ASC),
  PRIMARY KEY (`cdate`, `baseline_id`, `project_id`),
  CONSTRAINT `fk_cproject_evm_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `csttec`.`cproject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cproject_evm_baseline`
    FOREIGN KEY (`baseline_id`)
    REFERENCES `csttec`.`cbaseline` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`chz_cost_change`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`chz_cost_change` ;

CREATE TABLE IF NOT EXISTS `csttec`.`chz_cost_change` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `work_id` INT NOT NULL,
  `cseq` TINYINT NULL,
  `cwage_rate` DECIMAL(6) NULL,
  `chours` DECIMAL(5,2) NULL,
  `ccost` DECIMAL(10) NULL,
  `cremark` VARCHAR(400) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chz_cost_change_work_idx` (`work_id` ASC),
  CONSTRAINT `fk_chz_cost_change_work`
    FOREIGN KEY (`work_id`)
    REFERENCES `csttec`.`cwork` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccharacteristic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccharacteristic` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccharacteristic` (
  `id` INT NOT NULL,
  `ckc_type` VARCHAR(10) NULL,
  `ckc_category` TINYINT NULL COMMENT '고객/내부',
  `cname` VARCHAR(80) NULL,
  `cmeasure_type` TINYINT NULL,
  `cspec_type` TINYINT NULL,
  `cspec_text` VARCHAR(400) NULL,
  `cspec_base` VARCHAR(10) NULL,
  `cspec_tolerance` VARCHAR(10) NULL,
  `cspec_upper_limit` VARCHAR(10) NULL,
  `cspec_lower_limit` VARCHAR(10) NULL,
  `cspec_unit` VARCHAR(40) NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `file_id` INT NULL,
  `file_version` SMALLINT NULL,
  `clibrary_spec` TINYINT(1) NULL COMMENT '라이브러리 SPEC 여부',
  `clibrary_name` VARCHAR(80) NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_ccharacteristic_file_idx` (`file_id` ASC, `file_version` ASC),
  INDEX `fk_ccharacteristic_user_idx` (`user_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ccharacteristic_file`
    FOREIGN KEY (`file_id` , `file_version`)
    REFERENCES `csttec`.`cfile` (`id` , `cversion`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccharacteristic_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `csttec`.`cuser` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccharacteristic_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cproduced_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cproduced_item` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cproduced_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bop_rev_id` INT NOT NULL,
  `product_rev_id` INT NOT NULL,
  `clot_size` DOUBLE NULL,
  `cdate_created` TIMESTAMP NULL,
  `cdate_modified` TIMESTAMP NULL,
  `cactive` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_cme_produced_item_bop_rev_idx` (`bop_rev_id` ASC),
  INDEX `fk_cme_produced_item_product_rev_idx` (`product_rev_id` ASC),
  CONSTRAINT `fk_cme_produced_item_bop_rev`
    FOREIGN KEY (`bop_rev_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cme_produced_item_product_rev`
    FOREIGN KEY (`product_rev_id`)
    REFERENCES `csttec`.`citem_revision` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cprocess_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cprocess_type` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cprocess_type` (
  `id` INT NOT NULL,
  `cname` VARCHAR(80) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cprocess_type_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`coperation_step`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`coperation_step` ;

CREATE TABLE IF NOT EXISTS `csttec`.`coperation_step` (
  `id` INT NOT NULL,
  `process_type_id` INT NULL,
  `cname` VARCHAR(100) NULL,
  `ctype` TINYINT NULL COMMENT '작업종류',
  `cinput` VARCHAR(400) NULL,
  `coutput` VARCHAR(400) NULL,
  `cshow_on_pfmea` TINYINT(1) NULL DEFAULT 1,
  INDEX `fk_coperation_step_process_type_idx` (`process_type_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coperation_step_process_type`
    FOREIGN KEY (`process_type_id`)
    REFERENCES `csttec`.`cprocess_type` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_coperation_step_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccontrol_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccontrol_plan` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccontrol_plan` (
  `id` INT NOT NULL,
  `cmeasure_method` VARCHAR(400) NULL COMMENT '측정방법',
  `csample_size` VARCHAR(45) NULL,
  `csample_frequency` VARCHAR(45) NULL,
  `ccontrol_method` VARCHAR(400) NULL COMMENT '관리방법',
  `creaction_plan` VARCHAR(400) NULL COMMENT '대응계획',
  `cresponsibility` TINYINT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ccontrol_plan_object`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`ccompany_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`ccompany_contact` ;

CREATE TABLE IF NOT EXISTS `csttec`.`ccompany_contact` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `contact_id` INT NOT NULL,
  `cprimary` TINYINT(1) NULL,
  `cdepartment` VARCHAR(50) NULL,
  `ctitle` VARCHAR(20) NULL,
  `crepresentative` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ccompany_contact_company_idx` (`company_id` ASC),
  INDEX `fk_ccompany_contact_contact_idx` (`contact_id` ASC),
  CONSTRAINT `fk_ccompany_contact_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `csttec`.`ccompany` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ccompany_contact_contact`
    FOREIGN KEY (`contact_id`)
    REFERENCES `csttec`.`ccontact` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`crequirement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`crequirement` ;

CREATE TABLE IF NOT EXISTS `csttec`.`crequirement` (
  `id` INT NOT NULL,
  `cname` VARCHAR(400) NULL,
  `ref_req_id` INT NULL COMMENT '참조 요구사항',
  `characteristic_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_crequirement_ref_req_idx` (`ref_req_id` ASC),
  INDEX `fk_crequirement_characteristic_idx` (`characteristic_id` ASC),
  CONSTRAINT `fk_crequirement_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_crequirement_ref_req`
    FOREIGN KEY (`ref_req_id`)
    REFERENCES `csttec`.`crequirement` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_crequirement_characteristic`
    FOREIGN KEY (`characteristic_id`)
    REFERENCES `csttec`.`ccharacteristic` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfailure_mode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfailure_mode` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfailure_mode` (
  `id` INT NOT NULL,
  `cname` VARCHAR(400) NULL,
  `cseverity` TINYINT NULL,
  `ref_req_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cfailure_mode_ref_req_idx` (`ref_req_id` ASC),
  CONSTRAINT `fk_cfailure_mode_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cfailure_mode_ref_req`
    FOREIGN KEY (`ref_req_id`)
    REFERENCES `csttec`.`crequirement` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfailure_effect`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfailure_effect` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfailure_effect` (
  `id` INT NOT NULL,
  `cname` VARCHAR(400) NULL,
  `cseverity` TINYINT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cfailure_effect_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`croot_cause`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`croot_cause` ;

CREATE TABLE IF NOT EXISTS `csttec`.`croot_cause` (
  `id` INT NOT NULL,
  `cname` VARCHAR(400) NULL,
  `coccurrence` TINYINT NULL,
  `cdetection` TINYINT NULL,
  `ref_req_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_croot_cause_ref_req_idx` (`ref_req_id` ASC),
  CONSTRAINT `fk_croot_cause_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_croot_cause_ref_req`
    FOREIGN KEY (`ref_req_id`)
    REFERENCES `csttec`.`crequirement` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cprevention`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cprevention` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cprevention` (
  `id` INT NOT NULL,
  `cname` VARCHAR(400) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cprevention_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cdetection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cdetection` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cdetection` (
  `id` INT NOT NULL,
  `cname` VARCHAR(400) NULL,
  `cdetection` TINYINT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cdetection_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csttec`.`cfailure_control`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `csttec`.`cfailure_control` ;

CREATE TABLE IF NOT EXISTS `csttec`.`cfailure_control` (
  `id` INT NOT NULL,
  `cname` VARCHAR(400) NULL,
  `coccurrence` TINYINT NULL,
  `cdetection` TINYINT NULL,
  `crpn` SMALLINT NULL,
  `ref_req_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cfailure_control_ref_req_idx` (`ref_req_id` ASC),
  CONSTRAINT `fk_cfailure_control_id`
    FOREIGN KEY (`id`)
    REFERENCES `csttec`.`cobject` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cfailure_control_ref_req`
    FOREIGN KEY (`ref_req_id`)
    REFERENCES `csttec`.`crequirement` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO csttec@localhost;
 DROP USER csttec@localhost;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'csttec'@'localhost' IDENTIFIED BY 'csttec!@';


-- -----------------------------------------------------
-- Data for table `csttec`.`cwork_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `csttec`;
INSERT INTO `csttec`.`cwork_role` (`id`, `cname`, `cactive`) VALUES (0, 'PM', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `csttec`.`citem_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `csttec`;
INSERT INTO `csttec`.`citem_type` (`id`, `ccode`, `cname`, `cnumbering_pattern`, `cauto_assign`, `cactive`, `cinclude_all_rev_files`, `classification_id`, `cstereotype`, `ccategory`) VALUES (0, '', '아이템', NULL, 0, 1, NULL, NULL, 'item', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `csttec`.`cpreference`
-- -----------------------------------------------------
START TRANSACTION;
USE `csttec`;
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (1, 'Security_use_ip_filtering', '0', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (2, 'Security_ip_filter_list', NULL, NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (3, 'Privilege_owner_read', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (4, 'Privilege_owner_write', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (5, 'Privilege_owner_manage', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (6, 'Privilege_dept_read', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (7, 'Privilege_dept_write', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (8, 'Privilege_dept_manage', '0', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (9, 'Privilege_others_read', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (10, 'Privilege_others_write', '0', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (11, 'Privilege_others_manage', '0', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (12, 'Privilege_write_rule_on_item', 'RuleBased', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (13, 'Privilege_write_rule_on_file', 'RuleBased', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (14, 'Privilege_write_rule_on_bom', 'RuleBased', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (16, 'Privilege_restricted_file_types_to_consumer', NULL, NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (17, 'Privilege_restricted_file_types_to_viewer', NULL, NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (18, 'Item_enable_toggle_rev_rule', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (19, 'Item_show_working_revs', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (20, 'Item_show_all_revs', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (21, 'BOM_rev_rule_for_latest', 'AsLatest', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (22, 'BOM_rev_rule_for_old', 'AsReleased', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (23, 'Privilege_read_rule', 'RuleBased', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (24, 'Privilege_read_on_change', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (25, 'File_restrict_duplicate_name', '0', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (26, 'File_restricted_file_types_duplicate_name', NULL, NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (34, 'Mail_send_to_sender', '1', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (15, 'Privilege_read_rule_on_file_history', 'World', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (27, 'File_allow_to_delete_released_file', '0', NULL, 0, NULL);
INSERT INTO `csttec`.`cpreference` (`id`, `cname`, `cvalue`, `cvalue_blob`, `dept_id`, `user_id`) VALUES (28, 'Dept_rebuild_relations', '1', NULL, 0, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `csttec`.`cfolder_relation`
-- -----------------------------------------------------
START TRANSACTION;
USE `csttec`;
INSERT INTO `csttec`.`cfolder_relation` (`primary_id`, `secondary_id`) VALUES (0, 0);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- begin attached script 'script'
grant all privileges on csttec.* to 'csttec'@'localhost';

insert into cdept(cname, cdate_created, cactive) values('조직도', now(), 1);

update cdept
set id = 0
where cname = '조직도';

insert into cdept_relation(primary_id, secondary_id) values (0, 0);

insert into cuser(cemail, cpassword, cname, cdate_created, clicense_type, cstatus, dept_id, cadmin)
values('admin', '3bee0bc10e6a0234dafa380fc4c2191c', 'System', now(), 0, 1, 0, 1);

update cuser
set id = 0
where cemail='admin';

insert into cuser_log(cemail, cname, cdisplay_name, cdate_from, clicense_type, cstatus, user_id, dept_id, cdept_name, cdept_full_name, ctitle)
values('admin', 'System', 'System', now(), 0, 1, 0, 0, '', '/', '');

update cuser_log set id = 0 where user_id = 0;

INSERT INTO cobject (cdisplay_name, dept_id, user_id, cuser_name, cdate_created, cdate_modified, cactive) 
VALUES ('데이터 홈', 0, 0, 'System', now(), now(), 1);

update cobject
set id = 0, thread_id = 0, thread_current = 1;

insert into cfolder (id, cname, cfolder_type, cdescription, cvisible_on_board)
values (0, '데이터 홈', 0, '시스템의 최상위 폴더', 1);


INSERT INTO cwork_type (thread_id, thread_current, user_id, cname, cdescription, cactive) 
VALUES (0, 1, 0, '일반', '결재가 필요한 일반적인 업무에 사용합니다.\n필요한 경우 용도에 맞게 변경하여 사용하실 수 있습니다.', 1);

INSERT INTO cwork_type (thread_id, thread_current, user_id, cname, cdescription, cstereotype, cactive) 
VALUES (1, 1, 0, '단계검토', '프로젝트 단계를 판정하는 일종의 마일스톤 업무입니다.\n시스템의 정상적 동작을 위해 필요한 정보이므로 삭제 또는 수정하지 마십시오.', 'phasegate', 1);

INSERT INTO cwork_type (thread_id, thread_current, user_id, cname, cdescription, cstereotype, cactive) 
VALUES (2, 1, 0, '마일스톤', '프로젝트의 중요 시점을 의미하며 통과기준 등을 검토하는 업무입니다.\n시스템의 정상적 동작을 위해 필요한 정보이므로 삭제 또는 수정하지 마십시오.', 'milestone', 1);

update cwork_type set id = thread_id;

update cwork_role set id = 0;

update citem_type set id = 0;

INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('MaterialType', 0, 5, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Material', 0, 10, 1, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Currency', 0, 3, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('HeatTreatment', 0, 10, 0, 1);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('PostTreatment', 0, 10, 0, 1);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('SurfaceTreatment', 0, 10, 1, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Maker', 0, 5, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Unit', 0, 5, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`, `clov_level`) VALUES ('RequestDepartment', 0, 20, 1, 1, 2);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Model', 0, 10, 1, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('DocType', 0, 45, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Project', 0, 20, 1, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('OpType', 0, 1, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('DeliverablesType', 0, 40, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Location', 0, 100, 1, 1);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('ToolType', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('ToolTaskGroup', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('ToolLocation', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Account.Expenditure', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('RfqType', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('ExportTerms', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('MachineNo', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('Customer', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('ChangeReason', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('PVSCode', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('NonBillableType', 0, 100, 0, 0);
INSERT INTO `clov` (`clov_name`, `cvalue_type`, `cvalue_length`, `cauto_sort`, `callow_user_value`) VALUES ('MeResourceType', 0, 100, 0, 0);

update clov set id = 1 where clov_name = 'MaterialType';
update clov set id = 2 where clov_name = 'Material';
update clov set id = 3 where clov_name = 'Currency';
update clov set id = 4 where clov_name = 'HeatTreatment';
update clov set id = 5 where clov_name = 'PostTreatment';
update clov set id = 6 where clov_name = 'SurfaceTreatment';
update clov set id = 7 where clov_name = 'Maker';
update clov set id = 8 where clov_name = 'Unit';
update clov set id = 9 where clov_name = 'RequestDepartment';
update clov set id = 10 where clov_name = 'Model';
update clov set id = 11 where clov_name = 'DocType';
update clov set id = 12 where clov_name = 'Project';
update clov set id = 13 where clov_name = 'OpType';
update clov set id = 14 where clov_name = 'DeliverablesType';
update clov set id = 15 where clov_name = 'Location';
update clov set id = 16 where clov_name = 'ToolType';
update clov set id = 17 where clov_name = 'ToolTaskGroup';
update clov set id = 18 where clov_name = 'ToolLocation';
update clov set id = 19 where clov_name = 'Account.Expenditure';
update clov set id = 20 where clov_name = 'RfqType';
update clov set id = 21 where clov_name = 'ExportTerms';
update clov set id = 22 where clov_name = 'MachineNo';
update clov set id = 23 where clov_name = 'Customer';
update clov set id = 24 where clov_name = 'ChangeReason';
update clov set id = 25 where clov_name = 'PVSCode';
update clov set id = 26 where clov_name = 'NonBillableType';
update clov set id = 27 where clov_name = 'MeResourceType';

INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (1, 'FERT', 2, '제품', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (1, 'HALB', 1, '반제품', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (1, 'ROH', 0, '원자재', 1, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'A6061', 0, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'A7075', 1, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'PVC', 2, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SK3', 3, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SK4', 4, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SK5', 5, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SKD11', 6, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SMC20C', 7, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SM45C', 8, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SUS304', 9, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SUS316', 10, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SUS410', 11, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (2, 'SUS430', 12, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (3, 'KRW', 0, '', 1, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (3, 'USD', 1, '', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (3, 'JPY', 2, '', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (3, 'CNY', 3, '', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (3, 'EUR', 4, '', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (4, 'HRC 40-45', 0, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (4, 'HRC 48-50', 1, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (4, 'HRC 58-60', 2, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (4, 'SUB-ZERO', 0, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (5, '고주파담금질', 1, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (5, '질화(가스)', 2, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (5, '질화(액체)', 3, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (6, 'CR', 0, '크롬도금', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (6, 'ZN', 1, '아연도금', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (6, 'NI', 2, '니켈도금', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (6, 'PK', 3, '파커라이징(검은색)', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (6, 'PAINT', 4, '페인트', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (6, 'H-CR', 5, '크롬도금(경질)', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'NSK', 0, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'OMRON', 1, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'FESTO', 2, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'SMC', 3, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'MISUMI', 4, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'KEYENCE', 5, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, '오토닉스', 6, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'MITSUBISHI', 7, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'THK', 8, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'SKF', 9, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (7, 'YASKAWA', 10, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'PC', 0, 'piece', 1, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'SET', 1, 'set', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'BOX', 2, 'box', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'BAG', 3, 'bag', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'PACK', 4, 'pack', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'G', 5, 'gram', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'KG', 6, 'kilogram', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'M', 7, 'meter', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'M2', 8, 'squaremeter', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'L', 9, 'liter', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (8, 'DAY', 10, 'day', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (26, '교육/훈련', 0, '프로젝트 비용에 포함되지 않는 교육/훈련에 해당', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (26, '휴가(연차/반차 등)', 1, '회사의 승인을 받아 휴가 사용', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (26, '휴무/휴일', 2, '회사에서 정부규정 및 노사합의를 통해 지정', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (26, '병가/산재', 3, '회사의 승인을 받아 병가 사용', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (26, '인프라 사고/정비', 4, '화재, 정비, 장애 등으로 인해 업무 수행 불가', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (26, '기타 사유', 5, '상세 사유는 비고에 기재 요망', NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (27, '설비', 0, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (27, '치공구', 1, NULL, NULL, NULL);
INSERT INTO clov_entry(`lov_id`, `cvalue`, `cseq`, `cdescription`, `cdefault`, `parent_entry_id`) VALUES (27, '부자재', 2, NULL, NULL, NULL);

INSERT INTO ctest_env(cseq, cname, cdescription, user_id) values (0, '기본', '시스템에 의해 자동으로 생성된 테스트 환경입니다.\n고객의 테스트 환경에 맞춰 적절하게 수정하여 사용하십시오.', 0);
update ctest_env set id = 0;

CREATE OR REPLACE VIEW vproject_data AS
   SELECT 
		project_id AS 'project_id',
		id AS 'object_id',
		thread_id AS 'object_thread_id'
	FROM
		cobject
	WHERE
		cactive = 1 AND thread_current = 1
		AND project_id IS NOT NULL
		AND ctype_name != 'Project'
	UNION
	SELECT
		to_project_id AS 'project_id',
		id AS 'object_id',
		thread_id AS 'object_thread_id'
	FROM
		cobject
	WHERE 
		cactive = 1 AND thread_current = 1
		AND to_project_id IS NOT NULL
	UNION
	SELECT
		primary_id AS 'project_id',
		secondary_id AS 'object_id',
		secondary_thread_id AS 'object_thread_id'
	FROM
		cobject_relation
	WHERE
		crelation_type = 'ProjectData';
-- end attached script 'script'
