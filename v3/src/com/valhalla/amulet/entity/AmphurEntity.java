package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "AMPHUR", schema = "", catalog = "athapong_amulet")
public class AmphurEntity {
    private int amphurId;
    private String amphurCode;
    private String amphurName;
    private int geoId;
    private int provinceId;

    @Id
    @Column(name = "AMPHUR_ID", nullable = false, insertable = true, updatable = true)
    public int getAmphurId() {
        return amphurId;
    }

    public void setAmphurId(int amphurId) {
        this.amphurId = amphurId;
    }

    @Basic
    @Column(name = "AMPHUR_CODE", nullable = false, insertable = true, updatable = true, length = 4)
    public String getAmphurCode() {
        return amphurCode;
    }

    public void setAmphurCode(String amphurCode) {
        this.amphurCode = amphurCode;
    }

    @Basic
    @Column(name = "AMPHUR_NAME", nullable = false, insertable = true, updatable = true, length = 150)
    public String getAmphurName() {
        return amphurName;
    }

    public void setAmphurName(String amphurName) {
        this.amphurName = amphurName;
    }

    @Basic
    @Column(name = "GEO_ID", nullable = false, insertable = true, updatable = true)
    public int getGeoId() {
        return geoId;
    }

    public void setGeoId(int geoId) {
        this.geoId = geoId;
    }

    @Basic
    @Column(name = "PROVINCE_ID", nullable = false, insertable = true, updatable = true)
    public int getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AmphurEntity that = (AmphurEntity) o;

        if (amphurId != that.amphurId) return false;
        if (geoId != that.geoId) return false;
        if (provinceId != that.provinceId) return false;
        if (amphurCode != null ? !amphurCode.equals(that.amphurCode) : that.amphurCode != null) return false;
        if (amphurName != null ? !amphurName.equals(that.amphurName) : that.amphurName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = amphurId;
        result = 31 * result + (amphurCode != null ? amphurCode.hashCode() : 0);
        result = 31 * result + (amphurName != null ? amphurName.hashCode() : 0);
        result = 31 * result + geoId;
        result = 31 * result + provinceId;
        return result;
    }
}
