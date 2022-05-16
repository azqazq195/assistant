package com.moseoh.assistant.repository;

import java.util.Optional;

import javax.transaction.Transactional;

import com.moseoh.assistant.entity.RefreshToken;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long> {
    Optional<RefreshToken> findByUserKey(Long userKey);
}
