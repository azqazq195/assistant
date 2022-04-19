package com.moseoh.assistant.repository;

import java.util.List;

import com.moseoh.assistant.entity.User;

import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {
    public User findUserById(long id);

    public List<User> findAll();

    public User findUserByEmail(String email);

    public User findUserByEmailAndPassword(String email, String password);
}
