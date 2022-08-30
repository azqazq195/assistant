package com.moseoh.assistant.controller.auth;

import com.moseoh.assistant.controller.auth.dto.SignInRequestDto;
import com.moseoh.assistant.controller.auth.dto.SignInResponseDto;
import com.moseoh.assistant.response.SuccessCode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.AuthService;

@RequiredArgsConstructor
@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/sign-in")
    public ResponseEntity<Response<SignInResponseDto>> signIn(
            @RequestBody SignInRequestDto signInRequestDto
            ) {
        return ResponseEntity.ok().body(
          new Response<>(
                  SuccessCode.SIGN_IN,
                  authService.signIn(signInRequestDto)
          )
        );
    }
}
