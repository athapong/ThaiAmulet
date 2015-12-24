package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "RATING", schema = "", catalog = "athapong_amulet")
public class RatingEntity {
    private int ratingCode;
    private String ratingDesc;

    @Id
    @Column(name = "RATING_CODE", nullable = false, insertable = true, updatable = true)
    public int getRatingCode() {
        return ratingCode;
    }

    public void setRatingCode(int ratingCode) {
        this.ratingCode = ratingCode;
    }

    @Basic
    @Column(name = "RATING_DESC", nullable = false, insertable = true, updatable = true, length = 10)
    public String getRatingDesc() {
        return ratingDesc;
    }

    public void setRatingDesc(String ratingDesc) {
        this.ratingDesc = ratingDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RatingEntity that = (RatingEntity) o;

        if (ratingCode != that.ratingCode) return false;
        if (ratingDesc != null ? !ratingDesc.equals(that.ratingDesc) : that.ratingDesc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = ratingCode;
        result = 31 * result + (ratingDesc != null ? ratingDesc.hashCode() : 0);
        return result;
    }
}
