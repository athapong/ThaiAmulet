package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "PROVINCE", schema = "", catalog = "athapong_amulet")
public class ProvinceEntity {
    private int provinceId;
    private String provinceCode;
    private String provinceName;
    private int geoId;

    @Id
    @Column(name = "PROVINCE_ID", nullable = false, insertable = true, updatable = true)
    public int getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    @Basic
    @Column(name = "PROVINCE_CODE", nullable = false, insertable = true, updatable = true, length = 2)
    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    @Basic
    @Column(name = "PROVINCE_NAME", nullable = false, insertable = true, updatable = true, length = 150)
    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    @Basic
    @Column(name = "GEO_ID", nullable = false, insertable = true, updatable = true)
    public int getGeoId() {
        return geoId;
    }

    public void setGeoId(int geoId) {
        this.geoId = geoId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ProvinceEntity that = (ProvinceEntity) o;

        if (geoId != that.geoId) return false;
        if (provinceId != that.provinceId) return false;
        if (provinceCode != null ? !provinceCode.equals(that.provinceCode) : that.provinceCode != null) return false;
        if (provinceName != null ? !provinceName.equals(that.provinceName) : that.provinceName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = provinceId;
        result = 31 * result + (provinceCode != null ? provinceCode.hashCode() : 0);
        result = 31 * result + (provinceName != null ? provinceName.hashCode() : 0);
        result = 31 * result + geoId;
        return result;
    }
}
