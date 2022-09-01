package com.moseoh.assistant.auth.application;

import com.moseoh.assistant.auth.entity.Token;
import com.moseoh.assistant.auth.entity.User;
import com.moseoh.assistant.auth.entity.repository.JwtRepository;
import com.moseoh.assistant.config.exception.ApiException;
import com.moseoh.assistant.response.ErrorCode;
import io.jsonwebtoken.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.Base64;
import java.util.Date;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class JwtService {
    @Value("${config.token.secretKey}")
    private String secretKey;
    @Value("${config.token.grant-type}")
    private String grantType;
    @Value("${config.token.access-token-valid-time}")
    private Long accessTokenValidTime;
    @Value("${config.token.refresh-token-valid-time}")
    private Long refreshTokenValidTime;

    private final JwtRepository jwtRepository;
    private final UserService userService;

    @PostConstruct
    protected void init() {
        secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
    }

    public Token createToken(Long userPk, List<String> roles) {
        Date now = new Date();
        return Token.builder()
                .grantType(grantType)
                .accessToken(createAccessToken(userPk, roles, now))
                .refreshToken(createRefreshToken(now))
                .accessTokenExpireDate(now.getTime() + accessTokenValidTime)
                .build();
    }

    private String createAccessToken(Long userPk, List<String> roles, Date date) {
        Claims claims = Jwts.claims().setSubject(String.valueOf(userPk));
        claims.put("roles", roles);
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(date)
                .setExpiration(new Date(date.getTime() + accessTokenValidTime))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    public String createRefreshToken(Date now) {
        return Jwts.builder()
                .setHeaderParam(Header.TYPE, Header.JWT_TYPE)
                .setExpiration(new Date(now.getTime() + refreshTokenValidTime))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    public Authentication getAuthentication(String token) {
        User user = userService.findById(Long.parseLong(this.getUserPk(token)));
        return new UsernamePasswordAuthenticationToken(user, "", user.getAuthorities());
    }

    private String getUserPk(String token) {
        return Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody().getSubject();
    }

    public String resolveToken(HttpServletRequest request) {
        return request.getHeader("Authorization");
    }

    public boolean validationToken(String token) {
        try {
            Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token);
            return true;
        } catch (SecurityException | MalformedJwtException e) {
            log.error("잘못된 Jwt 서명입니다.");
        } catch (ExpiredJwtException e) {
            log.error("만료된 토큰입니다.");
        } catch (UnsupportedJwtException e) {
            log.error("지원하지 않는 토큰입니다.");
        } catch (IllegalArgumentException e) {
            log.error("잘못된 토큰입니다.");
        }
        return false;
    }

    public Token findById(Long id) {
        return jwtRepository.findById(id).orElseThrow(
                () -> new ApiException(ErrorCode.TOKEN_NOT_FOUND)
        );
    }

    public Token save(Token token) {
        return jwtRepository.save(token);
    }
}
