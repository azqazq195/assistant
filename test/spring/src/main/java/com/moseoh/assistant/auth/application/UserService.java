package com.moseoh.assistant.auth.application;

import com.moseoh.assistant.auth.entity.User;
import com.moseoh.assistant.auth.entity.repository.UserRepository;
import com.moseoh.assistant.auth.exception.UserNotFoundException;
import com.moseoh.assistant.config.exception.ApiException;
import com.moseoh.assistant.response.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@RequiredArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;

    public User findById(Long id) {
        return userRepository.findById(id).orElseThrow(UserNotFoundException::new);
    }

    public User requestedUser() {
        return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    @Transactional
    public User save(User user) {
        return userRepository.save(user);
    }
}
