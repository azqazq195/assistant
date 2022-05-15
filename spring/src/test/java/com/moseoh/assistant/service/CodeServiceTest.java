package com.moseoh.assistant.service;

import java.util.Collections;

import javax.transaction.Transactional;

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
    private UserRepository userRepository;

    @Test
    @Transactional
    void getTables() {
        userRepository.save(User
                .builder()
                .username("svn")
                .email("email")
                .password("password")
                .roles(Collections.singletonList("ROLE_USER"))
                .build());
        codeService.updateSvnTables();
    }

}
