package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "MAT_DESC", schema = "", catalog = "athapong_amulet")
public class MatDescEntity {
    private int matDescCode;
    private String matDescDesc;

    @Id
    @Column(name = "MAT_DESC_CODE", nullable = false, insertable = true, updatable = true)
    public int getMatDescCode() {
        return matDescCode;
    }

    public void setMatDescCode(int matDescCode) {
        this.matDescCode = matDescCode;
    }

    @Basic
    @Column(name = "MAT_DESC_DESC", nullable = false, insertable = true, updatable = true, length = 50)
    public String getMatDescDesc() {
        return matDescDesc;
    }

    public void setMatDescDesc(String matDescDesc) {
        this.matDescDesc = matDescDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MatDescEntity that = (MatDescEntity) o;

        if (matDescCode != that.matDescCode) return false;
        if (matDescDesc != null ? !matDescDesc.equals(that.matDescDesc) : that.matDescDesc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = matDescCode;
        result = 31 * result + (matDescDesc != null ? matDescDesc.hashCode() : 0);
        return result;
    }
}
