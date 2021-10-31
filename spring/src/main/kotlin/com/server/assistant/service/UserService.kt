package com.server.assistant.service

import com.server.assistant.DTO.CreateUserDTO
import com.server.assistant.DTO.ReadUserDTO
import com.server.assistant.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

/**
 * UserService
 * 주소
 * GitHub : http://github.com/azqazq195
 * Created by azqazq195@gmail.com on 2021-10-31
 */

@Component
class UserService {
    @Autowired
    lateinit var userRepository: UserRepository

    fun getUsers(): List<ReadUserDTO> {
        val users = userRepository.findAllBy()
        return users.map { it.toReadUserDto() }
    }

    @Transactional
    fun createUser(createUserDTO: CreateUserDTO): CreateUserDTO {
        val user = userRepository.save(createUserDTO.toEntity())
        return user.toCreateUserDto()
    }
}