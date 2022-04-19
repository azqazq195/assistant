package com.moseoh.assistant.service;

import java.util.List;

import javax.transaction.Transactional;

import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Transactional
    public User getUser(long id) {
        User user = userRepository.findUserById(id);
        if (user == null) {
            throw new RuntimeException("not exists user id: " + id);
        }
        return user;
    }

    @Transactional
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @Transactional
    public User createUser(User user) {
        return userRepository.save(user);
    }

    @Transactional
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
}
