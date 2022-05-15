package com.moseoh.assistant.entity;

import javax.persistence.*;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "mcolumn")
@Table(uniqueConstraints = @UniqueConstraint(columnNames = { "name", "mtable_id" }))
public class MColumn {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private boolean ai;
    private boolean pk;
    private boolean fk;
    private String type;
    private boolean nullable;

    @ManyToOne
    private MTable mtable;

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("name: ");
        sb.append(name);
        sb.append(", ");
        sb.append("ai: ");
        sb.append(ai);
        sb.append(", ");
        sb.append("pk: ");
        sb.append(pk);
        sb.append(", ");
        sb.append("fk: ");
        sb.append(fk);
        sb.append(", ");
        sb.append("type: ");
        sb.append(type);
        sb.append(", ");
        sb.append("nullable: ");
        sb.append(nullable);
        return sb.toString();
    }
}
