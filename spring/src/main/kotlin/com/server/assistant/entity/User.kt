package com.server.assistant.entity

import com.server.assistant.DTO.CreateUserDTO
import com.server.assistant.DTO.ReadUserDTO
import java.time.OffsetDateTime
import java.time.OffsetTime
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

/**
 * User
 * 주소
 * GitHub : http://github.com/azqazq195
 * Created by azqazq195@gmail.com on 2021-10-31
 */

@Entity
data class User(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val name: String,
    val email: String,
    val password: String,
    val createdDate: OffsetDateTime? = null,
    var updatedDate: OffsetDateTime? = null
) {
    fun toReadUserDto(): ReadUserDTO {
        return ReadUserDTO(
            id = id,
            name = name,
            email = email
        )
    }

    fun toCreateUserDto(): CreateUserDTO {
        return CreateUserDTO(
            name = name,
            email = email,
            password = password
        )
    }
}
