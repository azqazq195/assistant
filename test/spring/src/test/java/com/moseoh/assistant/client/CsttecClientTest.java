package com.moseoh.assistant.client;

import com.moseoh.assistant.client.dto.LoginResponseDto;
import com.moseoh.assistant.controller.auth.dto.SignInRequestDto;
import com.moseoh.assistant.controller.auth.dto.SignInResponseDto;
import com.moseoh.assistant.entity.User;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class CsttecClientTest {

    @Autowired
    CsttecClient csttecClient;

    @Disabled
    @Test
    void login() {
        SignInRequestDto signInRequestDto = new SignInRequestDto(
                "seongha.moon@csttec.com",
                "seongha.moon@csttec.com",
                "0.0.0.0"
        );

        LoginResponseDto loginResponseDto = csttecClient.login(signInRequestDto.toLoginRequestDto());
        SignInResponseDto signInResponseDto = loginResponseDto.toSignInResponseDto();
        assertEquals(signInResponseDto.getId(),45);
        assertEquals(signInResponseDto.getEmail(),"seongha.moon@csttec.com");
        assertEquals(signInResponseDto.getName(),"문성하");
    }
}