package com.moseoh.assistant.repository;

import java.util.List;

import javax.transaction.Transactional;

import com.moseoh.assistant.entity.MTable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface TableRepository extends JpaRepository<MTable, Long> {
    public List<MTable> findDistinctNameByDatabaseNameAndUserIdIn(String databaseName, List<Long> userIds);

    public MTable findByNameAndDatabaseNameAndUserId(String name, String databaseName, Long userId);

    public void deleteAllByUserIdAndDatabaseName(Long userId, String databaseName);
}
