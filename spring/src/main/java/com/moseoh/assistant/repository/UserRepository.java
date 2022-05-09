package com.moseoh.assistant.repository;

import java.util.List;

import com.moseoh.assistant.entity.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    public User findUserById(long id);

    public List<User> findAll();

    public User findByEmail(String email);

    public User findUserByEmailAndPassword(String email, String password);

    public boolean existsByEmail(String email);
}
