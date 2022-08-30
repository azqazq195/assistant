package com.moseoh.assistant.client;

import com.moseoh.assistant.client.dto.LoginResponseDto;
import com.moseoh.assistant.controller.auth.dto.SignInRequestDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CsttecClientTest {

    @Autowired
    CsttecClient csttecClient;

    @Test
    void login() {
        SignInRequestDto signInRequestDto = new SignInRequestDto(
                "seongha.moon@csttec.com",
                "seongha.moon@csttec.com",
                "0.0.0.0"
        );

        LoginResponseDto loginResponseDto = csttecClient.login(signInRequestDto.toLoginRequestDto());
        System.out.println(loginResponseDto);
        System.out.println(loginResponseDto.toUser());
    }
}