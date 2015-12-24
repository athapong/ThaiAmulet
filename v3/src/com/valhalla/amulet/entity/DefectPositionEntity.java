package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "DEFECT_POSITION", schema = "", catalog = "athapong_amulet")
public class DefectPositionEntity {
    private int defectPosCode;
    private String defectPostDesc;

    @Id
    @Column(name = "DEFECT_POS_CODE", nullable = false, insertable = true, updatable = true)
    public int getDefectPosCode() {
        return defectPosCode;
    }

    public void setDefectPosCode(int defectPosCode) {
        this.defectPosCode = defectPosCode;
    }

    @Basic
    @Column(name = "DEFECT_POST_DESC", nullable = false, insertable = true, updatable = true, length = 50)
    public String getDefectPostDesc() {
        return defectPostDesc;
    }

    public void setDefectPostDesc(String defectPostDesc) {
        this.defectPostDesc = defectPostDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DefectPositionEntity that = (DefectPositionEntity) o;

        if (defectPosCode != that.defectPosCode) return false;
        if (defectPostDesc != null ? !defectPostDesc.equals(that.defectPostDesc) : that.defectPostDesc != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = defectPosCode;
        result = 31 * result + (defectPostDesc != null ? defectPostDesc.hashCode() : 0);
        return result;
    }
}
