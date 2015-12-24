package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "MAT_TYPE_2", schema = "", catalog = "athapong_amulet")
public class MatType2Entity {
    private int matType2Code;
    private String matType2Desc;

    @Id
    @Column(name = "MAT_TYPE_2_CODE", nullable = false, insertable = true, updatable = true)
    public int getMatType2Code() {
        return matType2Code;
    }

    public void setMatType2Code(int matType2Code) {
        this.matType2Code = matType2Code;
    }

    @Basic
    @Column(name = "MAT_TYPE_2_DESC", nullable = true, insertable = true, updatable = true, length = 45)
    public String getMatType2Desc() {
        return matType2Desc;
    }

    public void setMatType2Desc(String matType2Desc) {
        this.matType2Desc = matType2Desc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MatType2Entity that = (MatType2Entity) o;

        if (matType2Code != that.matType2Code) return false;
        if (matType2Desc != null ? !matType2Desc.equals(that.matType2Desc) : that.matType2Desc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = matType2Code;
        result = 31 * result + (matType2Desc != null ? matType2Desc.hashCode() : 0);
        return result;
    }
}
