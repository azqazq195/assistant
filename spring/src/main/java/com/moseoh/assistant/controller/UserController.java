package com.moseoh.assistant.controller;

import javax.transaction.Transactional;

import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/list")
    public ResponseEntity<Response> getUsers() {
        return Response.toResponseEntity(userService.getUserList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Response> getUser(@PathVariable long id) {
        return Response.toResponseEntity(userService.getUser(id));
    }

    @PostMapping
    public ResponseEntity<Response> createUser(@RequestBody User user) {
        return Response.toResponseEntity(userService.createUser(user));
    }

}
