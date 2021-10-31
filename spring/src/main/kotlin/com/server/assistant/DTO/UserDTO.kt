package com.server.assistant.DTO

import com.server.assistant.entity.User

/**
 * UserDTO
 * 주소
 * GitHub : http://github.com/azqazq195
 * Created by azqazq195@gmail.com on 2021-10-31
 */
data class ReadUserDTO(
    val id: Long? = null,
    val name: String,
    val email: String
)

data class CreateUserDTO(
    val name: String,
    val email: String,
    val password: String
) {
    fun toEntity(): User {
        return User(
            name = name,
            email = email,
            password = password
        )
    }
}
