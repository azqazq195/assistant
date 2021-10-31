package com.server.assistant.service

import com.server.assistant.dto.CreateUserDTO
import com.server.assistant.dto.LoginUserDTO
import com.server.assistant.dto.ReadUserDTO
import com.server.assistant.repository.UserRepository
import com.server.assistant.response.LoginResponse
import com.server.assistant.response.Result
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.util.*

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

    fun getUser(id: Long): ReadUserDTO {
        val user = userRepository.findUserById(id)
        return user.toReadUserDto()
    }

    @Transactional
    fun createUser(createUserDTO: CreateUserDTO): CreateUserDTO {
        val user = userRepository.save(createUserDTO.toEntity())
        return user.toCreateUserDto()
    }

    fun login(loginUserDTO: LoginUserDTO): LoginResponse {
        userRepository.findUserByEmail(loginUserDTO.email)
            ?: return LoginResponse(null, "존재하지 않는 아이디 입니다.", Result.FAILURE.name.lowercase())
        val user = userRepository.findUserByEmailAndPassword(loginUserDTO.email, loginUserDTO.password)
            ?: return LoginResponse(null,"비밀번호가 일치하지 않습니다.", Result.FAILURE.name.lowercase())
        return LoginResponse(user.id, "로그인 성공.", Result.SUCCESS.name.lowercase())
    }
}