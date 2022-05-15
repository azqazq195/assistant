package com.moseoh.assistant.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "mtable")
@Table(uniqueConstraints = @UniqueConstraint(columnNames = { "databaseName", "name", "user_id" }))
public class MTable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private String databaseName;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "mtable_id")
    private List<MColumn> mcolumns;

    @OneToOne
    @JoinColumn(name = "user_id")
    @JsonIgnore
    private User user;

    public void addMColumn(MColumn mColumn) {
        if (mcolumns == null) {
            mcolumns = new ArrayList<>();
        }
        mColumn.setMtable(this);
        mcolumns.add(mColumn);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("table: ");
        sb.append(name);
        for (MColumn column : mcolumns) {
            sb.append("\n");
            sb.append(column.toString());
        }
        return sb.toString();
    }
}
