package com.moseoh.assistant.controller;

import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.UserService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Api(tags = { "1. User" })
@RequiredArgsConstructor
@RestController
@RequestMapping("/v1/user")
@ApiImplicitParams({
                @ApiImplicitParam(name = "X-AUTH-TOKEN", value = "AccessToken", required = true, dataType = "String", paramType = "header")
})
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

}
