package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "DEFECT_DESC", schema = "", catalog = "athapong_amulet")
public class DefectDescEntity {
    private int defectDescCode;
    private String defectDescDesc;

    @Id
    @Column(name = "DEFECT_DESC_CODE", nullable = false, insertable = true, updatable = true)
    public int getDefectDescCode() {
        return defectDescCode;
    }

    public void setDefectDescCode(int defectDescCode) {
        this.defectDescCode = defectDescCode;
    }

    @Basic
    @Column(name = "DEFECT_DESC_DESC", nullable = false, insertable = true, updatable = true, length = 50)
    public String getDefectDescDesc() {
        return defectDescDesc;
    }

    public void setDefectDescDesc(String defectDescDesc) {
        this.defectDescDesc = defectDescDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DefectDescEntity that = (DefectDescEntity) o;

        if (defectDescCode != that.defectDescCode) return false;
        if (defectDescDesc != null ? !defectDescDesc.equals(that.defectDescDesc) : that.defectDescDesc != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = defectDescCode;
        result = 31 * result + (defectDescDesc != null ? defectDescDesc.hashCode() : 0);
        return result;
    }
}
