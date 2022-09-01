package com.moseoh.assistant.auth.entity;

import com.moseoh.assistant.auth.application.dto.SignInResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "tb_user")
public class Token {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String grantType;
    private String accessToken;
    private String refreshToken;
    private Long accessTokenExpireDate;

    public SignInResponse toSignInResponseDto() {
        return new SignInResponse(
                grantType,
                accessToken,
                refreshToken,
                accessTokenExpireDate
        );
    }
}
