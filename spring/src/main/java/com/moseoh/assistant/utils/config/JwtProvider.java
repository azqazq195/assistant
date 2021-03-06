package com.moseoh.assistant.utils.config;

import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import com.moseoh.assistant.dto.TokenDto;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.service.UserService;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.UnsupportedJwtException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class JwtProvider {
    @Value("spring.jwt.secret")
    private String secretKey;
    private final String ROLES = "roles";
    private final Long accessTokenValidMillisecond = 60 * 60 * 1000L;
    private final Long refreshTokenValidMillisecond = 24 * 60 * 60 * 1000L;
    private final UserService userService;

    @PostConstruct
    protected void init() {
        this.secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
    }

    public TokenDto createTokenDto(Long userId, List<String> roles) {
        Date now = new Date();

        return new TokenDto(
                "bearer",
                createAccessToken(userId, roles, now),
                createRefreshToken(now),
                new Date(now.getTime() + accessTokenValidMillisecond));
    }

    public String createAccessToken(Long userId, List<String> roles, Date now) {
        Claims claims = Jwts.claims().setSubject(String.valueOf(userId));
        claims.put(ROLES, roles);

        return Jwts.builder()
                .setHeaderParam(Header.TYPE, Header.JWT_TYPE)
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(new Date(now.getTime() + accessTokenValidMillisecond))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    public String createRefreshToken(Date now) {
        return Jwts.builder()
                .setHeaderParam(Header.TYPE, Header.JWT_TYPE)
                .setExpiration(new Date(now.getTime() + refreshTokenValidMillisecond))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    public Authentication getAuthentication(String token) {
        Claims claims = parseClaims(token);
        User user = userService.getUser(Long.parseLong(claims.getSubject()));
        // UserDetails userDetails =
        // userDetailsService.loadUserByUsername(claims.getSubject());
        return new UsernamePasswordAuthenticationToken(user, "", user.getAuthorities());
    }

    private Claims parseClaims(String token) {
        return Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody();
    }

    public String resolveToken(HttpServletRequest request) {
        return request.getHeader("X-AUTH-TOKEN");
    }

    // jwt ??? ????????? ??? ???????????? ??????
    public boolean validationToken(String token) {
        try {
            Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token);
            return true;
        } catch (SecurityException | MalformedJwtException e) {
            log.error("????????? Jwt ???????????????.");
        } catch (ExpiredJwtException e) {
            log.error("????????? ???????????????.");
        } catch (UnsupportedJwtException e) {
            log.error("???????????? ?????? ???????????????.");
        } catch (IllegalArgumentException e) {
            log.error("????????? ???????????????.");
        }
        return false;
    }
}
