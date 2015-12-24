package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "MAT_TYPE_1", schema = "", catalog = "athapong_amulet")
public class MatType1Entity {
    private int matType1Code;
    private String matType1Desc;

    @Id
    @Column(name = "MAT_TYPE_1_CODE", nullable = false, insertable = true, updatable = true)
    public int getMatType1Code() {
        return matType1Code;
    }

    public void setMatType1Code(int matType1Code) {
        this.matType1Code = matType1Code;
    }

    @Basic
    @Column(name = "MAT_TYPE1_DESC", nullable = true, insertable = true, updatable = true, length = 45)
    public String getMatType1Desc() {
        return matType1Desc;
    }

    public void setMatType1Desc(String matType1Desc) {
        this.matType1Desc = matType1Desc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MatType1Entity that = (MatType1Entity) o;

        if (matType1Code != that.matType1Code) return false;
        if (matType1Desc != null ? !matType1Desc.equals(that.matType1Desc) : that.matType1Desc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = matType1Code;
        result = 31 * result + (matType1Desc != null ? matType1Desc.hashCode() : 0);
        return result;
    }
}
