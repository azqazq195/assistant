package com.moseoh.assistant.auth.application;

import com.moseoh.assistant.auth.application.dto.SignInRequest;
import com.moseoh.assistant.auth.application.dto.SignInResponse;
import com.moseoh.assistant.auth.entity.User;
import com.moseoh.assistant.csttec.application.CsttecClient;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AuthService {

    private final JwtService jwtService;
    private final CsttecClient csttecClient;
    private final UserService userService;

    public SignInResponse signIn(SignInRequest signInRequest) {
        User user = userService.save(csttecClient.login(signInRequest.toLoginRequestDto()).toUser());
        return jwtService.createToken(user.getId(), user.getRoles()).toSignInResponseDto();
    }
}
