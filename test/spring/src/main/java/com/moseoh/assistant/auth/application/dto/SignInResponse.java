package com.moseoh.assistant.auth.application.dto;

import com.moseoh.assistant.auth.entity.Token;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SignInResponse {
    private String grantType;
    private String accessToken;
    private String refreshToken;
    private Long accessTokenExpireDate;

    public static SignInResponse of(Token token) {
        if (token == null) {
            return null;
        }

        return new SignInResponse(
                token.getGrantType(),
                token.getAccessToken(),
                token.getRefreshToken(),
                token.getAccessTokenExpireDate()
        );
    }
}
