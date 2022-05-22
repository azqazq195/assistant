package com.moseoh.assistant.service;

import java.util.Collections;

import javax.transaction.Transactional;

import com.moseoh.assistant.dto.ReloadReqeustDto;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.repository.UserRepository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CodeServiceTest {

        @Autowired
        private CodeService codeService;
        @Autowired
        private UserService userService;
        @Autowired
        private UserRepository userRepository;

        @Transactional
        @Test
        void createSvnTables() {
                userRepository.save(User
                                .builder()
                                .id(1L)
                                .username("svn")
                                .email("email")
                                .password("password")
                                .roles(Collections.singletonList("ROLE_USER"))
                                .build());
                User adminUser = userRepository.getById(1L);

                codeService.createSvnTables(adminUser);
        }

        @Test
        void getTables() {
                userRepository.save(User
                                .builder()
                                .id(1L)
                                .username("svn")
                                .email("email")
                                .password("password")
                                .roles(Collections.singletonList("ROLE_USER"))
                                .build());
                userRepository.save(User
                                .builder()
                                .id(2L)
                                .username("user")
                                .email("email")
                                .password("password")
                                .roles(Collections.singletonList("ROLE_USER"))
                                .build());
                userRepository.save(User
                                .builder()
                                .id(3L)
                                .username("user")
                                .email("email")
                                .password("password")
                                .roles(Collections.singletonList("ROLE_USER"))
                                .build());

                User adminUser = userService.getSvnUser();
                User user = userService.getUser(2L);
                ReloadReqeustDto reloadReqeustDto = new ReloadReqeustDto();
                reloadReqeustDto.setDbPopulate(
                                "CREATE TABLE IF NOT EXISTS `csttec`.`cdept` (\n  `id` INT NOT NULL AUTO_INCREMENT,\n  `parent_dept_id` INT NULL,\n  `cname` VARCHAR(60) NULL,\n  `ccode` VARCHAR(15) NOT NULL,\n  `cdate_created` TIMESTAMP NULL,\n  `cdate_modified` TIMESTAMP NULL,\n  `cactive` TINYINT(1) NULL DEFAULT 1,\n  PRIMARY KEY (`id`),\n  INDEX `fk_cteam_cteam1_idx` (`parent_dept_id` ASC),\n  CONSTRAINT `fk_cteam_parent_dept_id`\n    FOREIGN KEY (`parent_dept_id`)\n    REFERENCES `csttec`.`cdept` (`id`)\n    ON DELETE RESTRICT\n    ON UPDATE NO ACTION)\nENGINE = InnoDB;");

                codeService.updateSvnTables(adminUser);
                codeService.updateUserTables(user, reloadReqeustDto);

                user = userService.getUser(3L);
                codeService.updateUserTables(user, reloadReqeustDto);

        }

}
