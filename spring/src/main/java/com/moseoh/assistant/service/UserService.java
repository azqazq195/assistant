package com.moseoh.assistant.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import com.moseoh.assistant.dto.UserDto;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.repository.UserRepository;
import com.moseoh.assistant.utils.exception.ServiceException;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional
    public User getUser(Long id) {
        User user = userRepository.findUserById(id);
        if (user == null) {
            throw new ServiceException(ErrorCode.USER_NOT_FOUND);
        }
        return user;
    }

    @Transactional
    public UserDto getUserDto(long id) {
        User user = userRepository.findUserById(id);
        if (user == null) {
            throw new ServiceException(ErrorCode.USER_NOT_FOUND);
        }
        return user.toUserDto();
    }

    @Transactional
    public List<UserDto> getUserList() {
        List<UserDto> userList = new ArrayList<>();
        for (User user : userRepository.findAll()) {
            userList.add(user.toUserDto());
        }

        return userList;
    }

    public User getRequestedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = userRepository.findById(((User) authentication.getPrincipal()).getId()).orElse(null);
        if (user == null)
            throw new ServiceException(ErrorCode.USER_NOT_FOUND);
        return user;
    }

    public User getSvnUser() {
        return userRepository.findById(1L).get();
    }

}
