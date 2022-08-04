package com.moseoh.assistant.repository;

import com.moseoh.assistant.entity.MTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
@Transactional
public interface TableRepository extends JpaRepository<MTable, Long> {
    List<MTable> findDistinctNameByDatabaseNameAndUserIdIn(String databaseName, List<Long> userIds);

    MTable findByNameAndDatabaseNameAndUserId(String name, String databaseName, Long userId);

    void deleteAllByUserIdAndDatabaseName(Long userId, String databaseName);
}
