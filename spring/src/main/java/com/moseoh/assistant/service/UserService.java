package com.moseoh.assistant.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.repository.UserRepository;
import com.moseoh.assistant.utils.ServiceException;
import com.moseoh.assistant.utils.Validation;
import com.moseoh.assistant.utils.ServiceException.ErrorCode;

// import org.slf4j.Logger;
// import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserService {

    @Autowired
    private UserRepository userRepository;
    // private Logger logger = LoggerFactory.getLogger(UserService.class);

    @Transactional
    public User getUser(long id) {
        User user = userRepository.findUserById(id);
        if (user == null) {
            throw new ServiceException(ErrorCode.USER_NOT_FOUND);
        }
        return user;
    }

    @Transactional
    public List<User> getUserList() {
        return userRepository.findAll();
    }

    @Transactional
    public User createUser(User user) {
        validation(user);

        user.setCreatedDate(new Date());
        user.setModifiedDate(new Date());

        return userRepository.save(user);
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
    private void validation(User user) {
        if (!Validation.checkEmail(user.getEmail())) {
            throw new ServiceException(ErrorCode.NOT_VALID_EMAIL);
        }

        if (userRepository.existsByEmail(user.getEmail())) {
            throw new ServiceException(ErrorCode.EXISTS_EMALL);
        }

        if (!user.getPasswordCheck().equals(user.getPassword())) {
            throw new ServiceException(ErrorCode.NOT_MATCHED_PASSWORD);
        }
    }
}
