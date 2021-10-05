import 'package:sql_to_mapper/helpers/convertor_test.dart';

void main() {
  String sql = """CREATE TABLE IF NOT EXISTS `center`.`caction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `session_id` INT NOT NULL,
  `ctype` VARCHAR(45) NULL,
  `curl` VARCHAR(100) NULL,
  `corganization` VARCHAR(100) NULL,
  `cname` VARCHAR(45) NULL,
  `ctitle` VARCHAR(45) NULL,
  `cemail` VARCHAR(45) NULL,
  `cphone` VARCHAR(45) NULL,
  `csite_name` VARCHAR(45) NULL,
  `crequests` TEXT NULL,
  `cresponses` TEXT NULL,
  `chandled` TINYINT(1) NULL,
  `cdate_handled` TIMESTAMP NULL,
  `ctax_file_path` VARCHAR(100) NULL,
  `cstandard_qty` INT NULL,
  `cviewer_qty` INT NULL,
  `cadvanced_qty` INT NULL,
  `cpayment_type` TINYINT NULL,
  `cprivacy_agreed` TINYINT(1) NULL,
  `cpr_agreed` TINYINT(1) NULL,
  `cdate` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_caction_csession1_idx` (`session_id` ASC),
  CONSTRAINT `fk_caction_csession1`
    FOREIGN KEY (`session_id`)
    REFERENCES `center`.`csession` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB""";

  print(sql);

  Table table = Table(sql);
  Convertor convertor = Convertor(table);

  print("tableName: ${table.tableName}");
  for (int i = 0; i < table.columns.length; i++) {
    print("${table.columns[i].name}: ${table.columns[i].type}");
  }

  print("\n${convertor.mapperInsert()}");
}
