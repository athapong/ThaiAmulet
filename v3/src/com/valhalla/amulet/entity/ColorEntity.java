package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "COLOR", schema = "", catalog = "athapong_amulet")
public class ColorEntity {
    private int colorCode;
    private String colorDesc;

    @Id
    @Column(name = "COLOR_CODE", nullable = false, insertable = true, updatable = true)
    public int getColorCode() {
        return colorCode;
    }

    public void setColorCode(int colorCode) {
        this.colorCode = colorCode;
    }

    @Basic
    @Column(name = "COLOR_DESC", nullable = false, insertable = true, updatable = true, length = 25)
    public String getColorDesc() {
        return colorDesc;
    }

    public void setColorDesc(String colorDesc) {
        this.colorDesc = colorDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ColorEntity that = (ColorEntity) o;

        if (colorCode != that.colorCode) return false;
        if (colorDesc != null ? !colorDesc.equals(that.colorDesc) : that.colorDesc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = colorCode;
        result = 31 * result + (colorDesc != null ? colorDesc.hashCode() : 0);
        return result;
    }
}
