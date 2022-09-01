package com.moseoh.assistant.auth.controller;

import com.moseoh.assistant.auth.application.dto.SignInRequest;
import com.moseoh.assistant.auth.application.dto.SignInResponse;
import com.moseoh.assistant.response.SuccessCode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.auth.application.AuthService;

@RequiredArgsConstructor
@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/sign-in")
    public ResponseEntity<Response<SignInResponse>> signIn(
            @RequestBody SignInRequest signInRequest
            ) {
        return ResponseEntity.ok().body(
          new Response<>(
                  SuccessCode.SIGN_IN,
                  authService.signIn(signInRequest)
          )
        );
    }
}
