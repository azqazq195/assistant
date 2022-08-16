package com.moseoh.assistant.service;

import com.moseoh.assistant.config.JwtProvider;
import com.moseoh.assistant.dto.*;
import com.moseoh.assistant.entity.RefreshToken;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.repository.RefreshTokenRepository;
import com.moseoh.assistant.repository.UserRepository;
import com.moseoh.assistant.utils.Validation;
import com.moseoh.assistant.utils.exception.ServiceException;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository userRepository;
    private final JwtProvider jwtProvider;
    private final RefreshTokenRepository refreshTokenRepository;

    @Transactional
    public UserDto signUp(SignUpRequestDto signUpRequestDto) {
        validation(signUpRequestDto);
        return userRepository.save(signUpRequestDto.toEntity()).toUserDto();
    }

    @Transactional
    public TokenDto signIn(SignInRequestDto signInRequestDto) {
        User user = userRepository.findByEmail(signInRequestDto.getEmail());

        if (user == null) {
            throw new ServiceException(ErrorCode.USER_NOT_FOUND);
        }
        if (!signInRequestDto.getPassword().equals(user.getPassword())) {
            throw new ServiceException(ErrorCode.NOT_MATCHED_PASSWORD);
        }

        TokenDto tokenDto = jwtProvider.createTokenDto(user.getId(), user.getRoles());
        Optional<RefreshToken> refreshToken = refreshTokenRepository.findByUserKey(user.getId());
        if (refreshToken.isPresent()) {
            refreshTokenRepository.save(RefreshToken.builder()
                    .id(refreshToken.get().getId())
                    .userKey(user.getId())
                    .token(tokenDto.getRefreshToken())
                    .build());
        } else {
            refreshTokenRepository.save(RefreshToken.builder()
                    .userKey(user.getId())
                    .token(tokenDto.getRefreshToken())
                    .build());
        }

        return tokenDto;
    }

    @Transactional
    void validation(SignUpRequestDto signUpRequestDto) {

        if (!Validation.checkEmail(signUpRequestDto.getEmail())) {
            throw new ServiceException(ErrorCode.NOT_VALID_EMAIL);
        }

        if (userRepository.existsByEmail(signUpRequestDto.getEmail())) {
            throw new ServiceException(ErrorCode.EXISTS_EMAIL);
        }

        if (!signUpRequestDto.getPasswordCheck().equals(signUpRequestDto.getPassword())) {
            throw new ServiceException(ErrorCode.NOT_MATCHED_PASSWORD);
        }
    }

    @Transactional
    public TokenDto refreshToken(RefreshTokenRequestDto refreshTokenRequestDto) {
        if (!jwtProvider.validationToken(refreshTokenRequestDto.getRefreshToken()))
            throw new ServiceException(ErrorCode.INVALID_TOKEN);

        String accessToken = refreshTokenRequestDto.getAccessToken();
        Authentication authentication = jwtProvider.getAuthentication(accessToken);
        User user = userRepository.findById(((User) authentication.getPrincipal()).getId()).orElse(null);
        if (user == null)
            throw new ServiceException(ErrorCode.USER_NOT_FOUND);

        RefreshToken refreshToken = refreshTokenRepository.findByUserKey(user.getId()).orElse(null);
        if (refreshToken == null)
            throw new ServiceException(ErrorCode.REFRESH_TOKEN_NOT_FOUND);

        if (!refreshToken.getToken().equals(refreshTokenRequestDto.getRefreshToken()))
            throw new ServiceException(ErrorCode.MISMATCH_REFRESH_TOKEN);

        TokenDto newCreatedToken = jwtProvider.createTokenDto(user.getId(), user.getRoles());
        RefreshToken updatedRefreshToken = refreshToken.updateToken(newCreatedToken.getRefreshToken());
        refreshTokenRepository.save(updatedRefreshToken);

        return newCreatedToken;
    }
}
