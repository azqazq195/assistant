package com.moseoh.assistant.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import com.moseoh.assistant.dto.SignUpRequestDto;
import com.moseoh.assistant.dto.UserDto;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.repository.UserRepository;
import com.moseoh.assistant.utils.Validation;
import com.moseoh.assistant.utils.exception.ServiceException;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

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

    @Transactional
    public UserDto signUp(SignUpRequestDto signUpRequestDto) {
        validation(signUpRequestDto);

        return userRepository.save(User.builder()
                .email(signUpRequestDto.getEmail())
                .name(signUpRequestDto.getName())
                .password(passwordEncoder.encode(signUpRequestDto.getPassword()))
                .build())
                .toUserDto();
    }

    public User loginUser(String email, String password) {
        User user = userRepository.findUserByEmail(email);
        if (user == null) {
            // 이 이메일은 존재하지 않는 유저
        }

        if (user.getPassword().equals(password)) {
            // 로그인
        } else {
            // 비밀번호 다름
        }
        return user;
    }

    @Transactional
    private void validation(SignUpRequestDto signUpRequestDto) {
        if (!Validation.checkEmail(signUpRequestDto.getEmail())) {
            throw new ServiceException(ErrorCode.NOT_VALID_EMAIL);
        }

        if (userRepository.existsByEmail(signUpRequestDto.getEmail())) {
            throw new ServiceException(ErrorCode.EXISTS_EMALL);
        }

        if (!signUpRequestDto.getPasswordCheck().equals(signUpRequestDto.getPassword())) {
            throw new ServiceException(ErrorCode.NOT_MATCHED_PASSWORD);
        }
    }
}
