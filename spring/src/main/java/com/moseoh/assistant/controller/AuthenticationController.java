package com.moseoh.assistant.controller;

import com.moseoh.assistant.dto.RefreshTokenRequestDto;
import com.moseoh.assistant.dto.SignInRequestDto;
import com.moseoh.assistant.dto.SignUpRequestDto;
import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.AuthenticationService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Api(tags = { "0. Authentication" })
@RequiredArgsConstructor
@RestController
@RequestMapping("/v1/authentication")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @ApiOperation(value = "회원 가입", notes = "회원 가입을 합니다.")
    @PostMapping("/signup")
    public ResponseEntity<Response> signUp(
            @ApiParam(value = "회원가입 정보", required = true) @RequestBody SignUpRequestDto signUpRequestDto) {
        log.info(signUpRequestDto.toString());
        signUpRequestDto.checkEmpty();
        return Response.toResponseEntity(authenticationService.signUp(signUpRequestDto));
    }

    @ApiOperation(value = "로그인", notes = "로그인을 합니다.")
    @PostMapping("/signin")
    public ResponseEntity<Response> signIn(
            @ApiParam(value = "로그인 정보", required = true) @RequestBody SignInRequestDto signInRequestDto) {
        log.info(signInRequestDto.toString());
        signInRequestDto.checkEmpty();
        return Response.toResponseEntity(authenticationService.signIn(signInRequestDto));
    }

    @ApiOperation(value = "리프레시 토큰 재발급", notes = "엑세스 토큰 만료시 회원 검증 후 리프레시 토큰을 검증해서 액세스 토큰과 리프레시 토큰을 재발급합니다.")
    @PostMapping("/refreshToken")
    public ResponseEntity<Response> refreshToken(@RequestBody RefreshTokenRequestDto refreshTokenRequestDto) {
        log.info(refreshTokenRequestDto.toString());
        return Response.toResponseEntity(authenticationService.refreshToken(refreshTokenRequestDto));
    }

}
