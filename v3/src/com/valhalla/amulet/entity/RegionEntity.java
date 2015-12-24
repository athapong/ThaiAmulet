package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "REGION", schema = "", catalog = "athapong_amulet")
public class RegionEntity {
    private int geoId;
    private String geoName;

    @Id
    @Column(name = "GEO_ID", nullable = false, insertable = true, updatable = true)
    public int getGeoId() {
        return geoId;
    }

    public void setGeoId(int geoId) {
        this.geoId = geoId;
    }

    @Basic
    @Column(name = "GEO_NAME", nullable = false, insertable = true, updatable = true, length = 255)
    public String getGeoName() {
        return geoName;
    }

    public void setGeoName(String geoName) {
        this.geoName = geoName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RegionEntity that = (RegionEntity) o;

        if (geoId != that.geoId) return false;
        if (geoName != null ? !geoName.equals(that.geoName) : that.geoName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = geoId;
        result = 31 * result + (geoName != null ? geoName.hashCode() : 0);
        return result;
    }
}
