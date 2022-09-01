package com.moseoh.assistant.auth.entity.repository;

import com.moseoh.assistant.auth.entity.Token;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface JwtRepository extends JpaRepository<Token, Long> {
}
