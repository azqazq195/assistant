package com.moseoh.assistant.repository;

import com.moseoh.assistant.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
@Transactional
public interface UserRepository extends JpaRepository<User, Long> {
    User findUserById(long id);

    List<User> findAll();

    User findByEmail(String email);

    User findUserByEmailAndPassword(String email, String password);

    boolean existsByEmail(String email);
}
