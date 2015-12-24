package com.valhalla.amulet.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "NEWS", schema = "", catalog = "athapong_amulet")
public class NewsEntity {
    private int newsCode;
    private Date newsDate;
    private String newsCat;
    private String newsSubj;
    private String newsDesc;
    private int viewCount;
    private String newsPic;
    private Time newsTime;

    @Id
    @Column(name = "NEWS_CODE", nullable = false, insertable = true, updatable = true)
    @GeneratedValue
    public int getNewsCode() {
        return newsCode;
    }

    public void setNewsCode(int newsCode) {
        this.newsCode = newsCode;
    }

    @Basic
    @Column(name = "NEWS_DATE", nullable = true, insertable = true, updatable = true)
    public Date getNewsDate() {
        return newsDate;
    }

    public void setNewsDate(Date newsDate) {
        this.newsDate = newsDate;
    }

    @Basic
    @Column(name = "NEWS_CAT", nullable = true, insertable = true, updatable = true, length = 3)
    public String getNewsCat() {
        return newsCat;
    }

    public void setNewsCat(String newsCat) {
        this.newsCat = newsCat;
    }

    @Basic
    @Column(name = "NEWS_SUBJ", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getNewsSubj() {
        return newsSubj;
    }

    public void setNewsSubj(String newsSubj) {
        this.newsSubj = newsSubj;
    }

    @Basic
    @Column(name = "NEWS_DESC", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getNewsDesc() {
        return newsDesc;
    }

    public void setNewsDesc(String newsDesc) {
        this.newsDesc = newsDesc;
    }

    @Basic
    @Column(name = "VIEW_COUNT", nullable = false, insertable = true, updatable = true)
    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    @Basic
    @Column(name = "NEWS_PIC", nullable = true, insertable = true, updatable = true, length = 255)
    public String getNewsPic() {
        return newsPic;
    }

    public void setNewsPic(String newsPic) {
        this.newsPic = newsPic;
    }

    @Basic
    @Column(name = "NEWS_TIME", nullable = true, insertable = true, updatable = true)
    public Time getNewsTime() {
        return newsTime;
    }

    public void setNewsTime(Time newsTime) {
        this.newsTime = newsTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        NewsEntity that = (NewsEntity) o;

        if (newsCode != that.newsCode) return false;
        if (viewCount != that.viewCount) return false;
        if (newsCat != null ? !newsCat.equals(that.newsCat) : that.newsCat != null) return false;
        if (newsDate != null ? !newsDate.equals(that.newsDate) : that.newsDate != null) return false;
        if (newsDesc != null ? !newsDesc.equals(that.newsDesc) : that.newsDesc != null) return false;
        if (newsPic != null ? !newsPic.equals(that.newsPic) : that.newsPic != null) return false;
        if (newsSubj != null ? !newsSubj.equals(that.newsSubj) : that.newsSubj != null) return false;
        if (newsTime != null ? !newsTime.equals(that.newsTime) : that.newsTime != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = newsCode;
        result = 31 * result + (newsDate != null ? newsDate.hashCode() : 0);
        result = 31 * result + (newsCat != null ? newsCat.hashCode() : 0);
        result = 31 * result + (newsSubj != null ? newsSubj.hashCode() : 0);
        result = 31 * result + (newsDesc != null ? newsDesc.hashCode() : 0);
        result = 31 * result + viewCount;
        result = 31 * result + (newsPic != null ? newsPic.hashCode() : 0);
        result = 31 * result + (newsTime != null ? newsTime.hashCode() : 0);
        return result;
    }
}
