package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "LOCKET", schema = "", catalog = "athapong_amulet")
public class LocketEntity {
    private int locketCode;
    private String locketDesc;

    @Id
    @Column(name = "LOCKET_CODE", nullable = false, insertable = true, updatable = true)
    public int getLocketCode() {
        return locketCode;
    }

    public void setLocketCode(int locketCode) {
        this.locketCode = locketCode;
    }

    @Basic
    @Column(name = "LOCKET_DESC", nullable = false, insertable = true, updatable = true, length = 25)
    public String getLocketDesc() {
        return locketDesc;
    }

    public void setLocketDesc(String locketDesc) {
        this.locketDesc = locketDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LocketEntity that = (LocketEntity) o;

        if (locketCode != that.locketCode) return false;
        if (locketDesc != null ? !locketDesc.equals(that.locketDesc) : that.locketDesc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = locketCode;
        result = 31 * result + (locketDesc != null ? locketDesc.hashCode() : 0);
        return result;
    }
}
