package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "MATERIAL", schema = "", catalog = "athapong_amulet")
public class MaterialEntity {
    private int materialCode;
    private String materialDesc;

    @Id
    @Column(name = "MATERIAL_CODE", nullable = false, insertable = true, updatable = true)
    public int getMaterialCode() {
        return materialCode;
    }

    public void setMaterialCode(int materialCode) {
        this.materialCode = materialCode;
    }

    @Basic
    @Column(name = "MATERIAL_DESC", nullable = true, insertable = true, updatable = true, length = 45)
    public String getMaterialDesc() {
        return materialDesc;
    }

    public void setMaterialDesc(String materialDesc) {
        this.materialDesc = materialDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MaterialEntity that = (MaterialEntity) o;

        if (materialCode != that.materialCode) return false;
        if (materialDesc != null ? !materialDesc.equals(that.materialDesc) : that.materialDesc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = materialCode;
        result = 31 * result + (materialDesc != null ? materialDesc.hashCode() : 0);
        return result;
    }
}
