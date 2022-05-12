package com.moseoh.assistant.utils.config;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtAuthenticationFilter extends GenericFilterBean {
    private final JwtProvider jwtProvider;

    public JwtAuthenticationFilter(JwtProvider jwtProvider) {
        this.jwtProvider = jwtProvider;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String token = jwtProvider.resolveToken((HttpServletRequest) request);

        HttpServletRequest r = ((HttpServletRequest) request);
        String method = r.getMethod();
        String requestUri = r.getRequestURI().toString();
        // r.getReader().mark(1024);
        // String body =
        // r.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        // r.getReader().reset();
        log.info("request: [" + method + "] - " + requestUri);
        // log.info("body: " + body);

        if (token != null && jwtProvider.validationToken(token)) {
            Authentication authentication = jwtProvider.getAuthentication(token);
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        chain.doFilter(request, response);
    }

}
