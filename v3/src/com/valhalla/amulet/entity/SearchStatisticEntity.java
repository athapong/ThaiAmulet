package com.valhalla.amulet.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "SEARCH_STATISTIC", schema = "", catalog = "athapong_amulet")
public class SearchStatisticEntity {
    private Integer memberId;
    private Timestamp searchDate;
    private int statNo;

    @Basic
    @Column(name = "MEMBER_ID", nullable = true, insertable = true, updatable = true)
    @GeneratedValue
    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    @Basic
    @Column(name = "SEARCH_DATE", nullable = true, insertable = true, updatable = true)
    public Timestamp getSearchDate() {
        return searchDate;
    }

    public void setSearchDate(Timestamp searchDate) {
        this.searchDate = searchDate;
    }

    @Id
    @Column(name = "STAT_NO", nullable = false, insertable = true, updatable = true)
    public int getStatNo() {
        return statNo;
    }

    public void setStatNo(int statNo) {
        this.statNo = statNo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SearchStatisticEntity that = (SearchStatisticEntity) o;

        if (statNo != that.statNo) return false;
        if (memberId != null ? !memberId.equals(that.memberId) : that.memberId != null) return false;
        if (searchDate != null ? !searchDate.equals(that.searchDate) : that.searchDate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = memberId != null ? memberId.hashCode() : 0;
        result = 31 * result + (searchDate != null ? searchDate.hashCode() : 0);
        result = 31 * result + statNo;
        return result;
    }
}
