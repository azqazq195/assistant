package com.moseoh.assistant.controller;

import java.util.List;

import com.moseoh.assistant.entity.User;
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
    public ResponseEntity<Object> getUsers() {
        List<User> users = userService.getUsers();
        if (users.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok().body(users);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Object> getUser(@PathVariable long id) {
        return ResponseEntity.ok().body(userService.getUser(id));
    }

    @PostMapping
    public ResponseEntity<Object> createUser(@RequestBody User user) {
        return ResponseEntity.ok().body(userService.createUser(user));
    }

}
