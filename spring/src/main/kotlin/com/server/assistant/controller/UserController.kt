package com.server.assistant.controller

import com.server.assistant.DTO.CreateUserDTO
import com.server.assistant.service.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

/**
 * UserController
 * 주소
 * GitHub : http://github.com/azqazq195
 * Created by azqazq195@gmail.com on 2021-10-31
 */
@RestController
class UserController {

    @Autowired
    private lateinit var userService: UserService

    @GetMapping("/users", produces = ["application/json"])
    fun getUsers(): ResponseEntity<Any> {
        return ResponseEntity.ok().body(userService.getUsers())
    }

    @PostMapping("/user")
    fun createUser(@RequestBody createUserDTO: CreateUserDTO): ResponseEntity<Any> {
        userService.createUser(createUserDTO)
        return ResponseEntity.ok().body(true)
    }
}