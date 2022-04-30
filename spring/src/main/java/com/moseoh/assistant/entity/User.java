package com.moseoh.assistant.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.moseoh.assistant.dto.UserDto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Entity(name = "user")
public class User extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private String email;
    private String password;

    public UserDto toUserDto() {
        return new UserDto(
                name,
                email,
                getCreatedDate(),
                getModifiDate());
    }
}
