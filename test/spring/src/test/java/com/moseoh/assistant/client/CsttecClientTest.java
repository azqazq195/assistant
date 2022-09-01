package com.moseoh.assistant.client;

import com.moseoh.assistant.csttec.application.CsttecClient;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CsttecClientTest {

    @Autowired
    CsttecClient csttecClient;

    @Disabled
    @Test
    void login() {
//        SignInRequest signInRequest = new SignInRequest(
//                "seongha.moon@csttec.com",
//                "seongha.moon@csttec.com",
//                "0.0.0.0"
//        );
//
//        LoginResponseDto loginResponseDto = csttecClient.login(signInRequest.toLoginRequestDto());
//        SignInResponse signInResponse = loginResponseDto.toSignInResponseDto();
//        assertEquals(signInResponse.getId(),45);
//        assertEquals(signInResponse.getEmail(),"seongha.moon@csttec.com");
//        assertEquals(signInResponse.getName(),"문성하");
    }
}