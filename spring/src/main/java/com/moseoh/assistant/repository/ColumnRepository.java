package com.moseoh.assistant.repository;

import com.moseoh.assistant.entity.MColumn;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
@Transactional
public interface ColumnRepository extends JpaRepository<MColumn, Long> {
    MColumn findByNameAndMtableId(String name, Long mtableId);

    MColumn findByName(String name);

    List<MColumn> findByMtableId(Long mtableId);
}
