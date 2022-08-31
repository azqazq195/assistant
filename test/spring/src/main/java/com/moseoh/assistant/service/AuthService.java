package com.moseoh.assistant.service;

import com.moseoh.assistant.client.CsttecClient;
import com.moseoh.assistant.controller.auth.dto.SignInRequestDto;
import com.moseoh.assistant.controller.auth.dto.SignInResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AuthService {

    private final CsttecClient csttecClient;

    public SignInResponseDto signIn(SignInRequestDto signInRequestDto) {
        return csttecClient.login(signInRequestDto.toLoginRequestDto()).toSignInResponseDto();
    }
}
