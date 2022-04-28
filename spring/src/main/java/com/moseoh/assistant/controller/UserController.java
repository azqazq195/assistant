package com.moseoh.assistant.controller;

import com.moseoh.assistant.dto.SignUpRequestDto;
import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.UserService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("user")
public class UserController {

    private final UserService userService;

    @GetMapping("/list")
    public ResponseEntity<Response> getUsers() {
        return Response.toResponseEntity(userService.getUserList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Response> getUser(@PathVariable long id) {
        return Response.toResponseEntity(userService.getUserDto(id));
    }

    @PostMapping("/signup")
    public ResponseEntity<Response> signUp(@RequestBody SignUpRequestDto signUpRequestDto) {
        log.info(signUpRequestDto.toString());
        return Response.toResponseEntity(userService.signUp(signUpRequestDto));
    }

    // @PostMapping("/signin")
    // public ResponseEntity<Response> signIn(@RequestBody SignInDto signInDto) {
    // return Response.toResponseEntity(userService.createUser(signInDto));
    // }

}
