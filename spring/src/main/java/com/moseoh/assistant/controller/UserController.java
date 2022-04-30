package com.moseoh.assistant.controller;

import com.moseoh.assistant.dto.SignUpRequestDto;
import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.UserService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Api(tags = { "1. User" })
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/v1/user")
public class UserController {

    private final UserService userService;

    @ApiOperation(value = "모든 회원 조회", notes = "모든 회원 목록을 조회합니다.")
    @GetMapping("/list")
    public ResponseEntity<Response> getUsers() {
        return Response.toResponseEntity(userService.getUserList());
    }

    @ApiOperation(value = "회원 조회", notes = "회원을 조회합니다.")
    @GetMapping("/{id}")
    public ResponseEntity<Response> getUser(
            @ApiParam(value = "회원 pk", required = true) @PathVariable long id) {
        return Response.toResponseEntity(userService.getUserDto(id));
    }

    @ApiOperation(value = "회원 가입", notes = "회원 가입을 합니다.")
    @PostMapping("/signup")
    public ResponseEntity<Response> signUp(
            @ApiParam(value = "회원가입 정보", required = true) @RequestBody SignUpRequestDto signUpRequestDto) {
        log.info(signUpRequestDto.toString());
        return Response.toResponseEntity(userService.signUp(signUpRequestDto));
    }

    // @PostMapping("/signin")
    // public ResponseEntity<Response> signIn(@RequestBody SignInDto signInDto) {
    // return Response.toResponseEntity(userService.createUser(signInDto));
    // }

}
