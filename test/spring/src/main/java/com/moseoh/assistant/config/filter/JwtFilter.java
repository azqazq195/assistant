package com.moseoh.assistant.config.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.moseoh.assistant.response.ErrorCode;
import com.moseoh.assistant.response.Response;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@RequiredArgsConstructor
public class JwtFilter extends GenericFilterBean {

    private final JwtProvider jwtProvider;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String token = jwtProvider.resolveToken(req);
        if (!StringUtils.hasText(token)) {
            log.warn("token is empty.");
            invalidTokenException(res);
            return;
        }

        if (!jwtProvider.validationToken(token)) {
            invalidTokenException(res);
        }

        Authentication authentication = jwtProvider.getAuthentication(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(request, response);
    }

    private void invalidTokenException(HttpServletResponse response) throws IOException {
        ErrorCode errorCode = ErrorCode.INVALID_TOKEN;
        ObjectMapper objectMapper = new ObjectMapper();

        response.setStatus(errorCode.getHttpStatus().value());
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(objectMapper.writeValueAsString(
                new Response<>(
                        errorCode,
                        errorCode.getMessage(),
                        null
                )
        ));
        response.getWriter().flush();
        response.getWriter().close();
    }
}