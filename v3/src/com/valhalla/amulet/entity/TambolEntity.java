package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "TAMBOL", schema = "", catalog = "athapong_amulet")
public class TambolEntity {
    private int districtId;
    private String districtCode;
    private String districtName;
    private int amphurId;
    private int provinceId;
    private int geoId;

    @Id
    @Column(name = "DISTRICT_ID", nullable = false, insertable = true, updatable = true)
    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    @Basic
    @Column(name = "DISTRICT_CODE", nullable = false, insertable = true, updatable = true, length = 6)
    public String getDistrictCode() {
        return districtCode;
    }

    public void setDistrictCode(String districtCode) {
        this.districtCode = districtCode;
    }

    @Basic
    @Column(name = "DISTRICT_NAME", nullable = false, insertable = true, updatable = true, length = 150)
    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    @Basic
    @Column(name = "AMPHUR_ID", nullable = false, insertable = true, updatable = true)
    public int getAmphurId() {
        return amphurId;
    }

    public void setAmphurId(int amphurId) {
        this.amphurId = amphurId;
    }

    @Basic
    @Column(name = "PROVINCE_ID", nullable = false, insertable = true, updatable = true)
    public int getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
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

        TambolEntity that = (TambolEntity) o;

        if (amphurId != that.amphurId) return false;
        if (districtId != that.districtId) return false;
        if (geoId != that.geoId) return false;
        if (provinceId != that.provinceId) return false;
        if (districtCode != null ? !districtCode.equals(that.districtCode) : that.districtCode != null) return false;
        if (districtName != null ? !districtName.equals(that.districtName) : that.districtName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = districtId;
        result = 31 * result + (districtCode != null ? districtCode.hashCode() : 0);
        result = 31 * result + (districtName != null ? districtName.hashCode() : 0);
        result = 31 * result + amphurId;
        result = 31 * result + provinceId;
        result = 31 * result + geoId;
        return result;
    }
}
