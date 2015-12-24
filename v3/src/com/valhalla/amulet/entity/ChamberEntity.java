package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "CHAMBER", schema = "", catalog = "athapong_amulet")
public class ChamberEntity {
    private int chamberCode;
    private String chamberDesc;

    @Id
    @Column(name = "CHAMBER_CODE", nullable = false, insertable = true, updatable = true)
    public int getChamberCode() {
        return chamberCode;
    }

    public void setChamberCode(int chamberCode) {
        this.chamberCode = chamberCode;
    }

    @Basic
    @Column(name = "CHAMBER_DESC", nullable = false, insertable = true, updatable = true, length = 25)
    public String getChamberDesc() {
        return chamberDesc;
    }

    public void setChamberDesc(String chamberDesc) {
        this.chamberDesc = chamberDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ChamberEntity that = (ChamberEntity) o;

        if (chamberCode != that.chamberCode) return false;
        if (chamberDesc != null ? !chamberDesc.equals(that.chamberDesc) : that.chamberDesc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = chamberCode;
        result = 31 * result + (chamberDesc != null ? chamberDesc.hashCode() : 0);
        return result;
    }
}
