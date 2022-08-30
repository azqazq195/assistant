package com.moseoh.assistant.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "tb_user")
public class User {
    @Id
    @GeneratedValue
    private int id;
    private int userId;
    private String userEmail;
    private String userName;
    private String sessionId;
    private String siteName;
    private String metaServerUrl;
    private String fileServerUrl;
    private String userPictureUrl;
}
