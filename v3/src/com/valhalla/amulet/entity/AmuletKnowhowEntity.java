package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "AMULET_KNOWHOW", schema = "", catalog = "athapong_amulet")
public class AmuletKnowhowEntity {
    private int khId;
    private String pic1;
    private String pic2;
    private String pic3;
    private String pic4;
    private String pic5;
    private String subjectName;
    private String regionCode;
    private String province;
    private String matType1;
    private String matType2;
    private String content;
    private byte publishFl;
    private int viewCnt;

    @Id
    @Column(name = "KH_ID", nullable = false, insertable = true, updatable = true)
    @GeneratedValue
    public int getKhId() {
        return khId;
    }

    public void setKhId(int khId) {
        this.khId = khId;
    }

    @Basic
    @Column(name = "PIC_1", nullable = true, insertable = true, updatable = true, length = 250)
    public String getPic1() {
        return pic1;
    }

    public void setPic1(String pic1) {
        this.pic1 = pic1;
    }

    @Basic
    @Column(name = "PIC_2", nullable = true, insertable = true, updatable = true, length = 250)
    public String getPic2() {
        return pic2;
    }

    public void setPic2(String pic2) {
        this.pic2 = pic2;
    }

    @Basic
    @Column(name = "PIC_3", nullable = true, insertable = true, updatable = true, length = 250)
    public String getPic3() {
        return pic3;
    }

    public void setPic3(String pic3) {
        this.pic3 = pic3;
    }

    @Basic
    @Column(name = "PIC_4", nullable = true, insertable = true, updatable = true, length = 250)
    public String getPic4() {
        return pic4;
    }

    public void setPic4(String pic4) {
        this.pic4 = pic4;
    }

    @Basic
    @Column(name = "PIC_5", nullable = true, insertable = true, updatable = true, length = 250)
    public String getPic5() {
        return pic5;
    }

    public void setPic5(String pic5) {
        this.pic5 = pic5;
    }

    @Basic
    @Column(name = "SUBJECT_NAME", nullable = false, insertable = true, updatable = true, length = 250)
    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    @Basic
    @Column(name = "REGION_CODE", nullable = false, insertable = true, updatable = true, length = 2)
    public String getRegionCode() {
        return regionCode;
    }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode;
    }

    @Basic
    @Column(name = "PROVINCE", nullable = true, insertable = true, updatable = true, length = 100)
    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Basic
    @Column(name = "MAT_TYPE_1", nullable = false, insertable = true, updatable = true, length = 50)
    public String getMatType1() {
        return matType1;
    }

    public void setMatType1(String matType1) {
        this.matType1 = matType1;
    }

    @Basic
    @Column(name = "MAT_TYPE_2", nullable = false, insertable = true, updatable = true, length = 250)
    public String getMatType2() {
        return matType2;
    }

    public void setMatType2(String matType2) {
        this.matType2 = matType2;
    }

    @Basic
    @Column(name = "CONTENT", nullable = false, insertable = true, updatable = true, length = 65535)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Basic
    @Column(name = "PUBLISH_FL", nullable = false, insertable = true, updatable = true)
    public byte getPublishFl() {
        return publishFl;
    }

    public void setPublishFl(byte publishFl) {
        this.publishFl = publishFl;
    }

    @Basic
    @Column(name = "VIEW_CNT", nullable = false, insertable = true, updatable = true)
    public int getViewCnt() {
        return viewCnt;
    }

    public void setViewCnt(int viewCnt) {
        this.viewCnt = viewCnt;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AmuletKnowhowEntity that = (AmuletKnowhowEntity) o;

        if (khId != that.khId) return false;
        if (publishFl != that.publishFl) return false;
        if (viewCnt != that.viewCnt) return false;
        if (content != null ? !content.equals(that.content) : that.content != null) return false;
        if (matType1 != null ? !matType1.equals(that.matType1) : that.matType1 != null) return false;
        if (matType2 != null ? !matType2.equals(that.matType2) : that.matType2 != null) return false;
        if (pic1 != null ? !pic1.equals(that.pic1) : that.pic1 != null) return false;
        if (pic2 != null ? !pic2.equals(that.pic2) : that.pic2 != null) return false;
        if (pic3 != null ? !pic3.equals(that.pic3) : that.pic3 != null) return false;
        if (pic4 != null ? !pic4.equals(that.pic4) : that.pic4 != null) return false;
        if (pic5 != null ? !pic5.equals(that.pic5) : that.pic5 != null) return false;
        if (province != null ? !province.equals(that.province) : that.province != null) return false;
        if (regionCode != null ? !regionCode.equals(that.regionCode) : that.regionCode != null) return false;
        if (subjectName != null ? !subjectName.equals(that.subjectName) : that.subjectName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = khId;
        result = 31 * result + (pic1 != null ? pic1.hashCode() : 0);
        result = 31 * result + (pic2 != null ? pic2.hashCode() : 0);
        result = 31 * result + (pic3 != null ? pic3.hashCode() : 0);
        result = 31 * result + (pic4 != null ? pic4.hashCode() : 0);
        result = 31 * result + (pic5 != null ? pic5.hashCode() : 0);
        result = 31 * result + (subjectName != null ? subjectName.hashCode() : 0);
        result = 31 * result + (regionCode != null ? regionCode.hashCode() : 0);
        result = 31 * result + (province != null ? province.hashCode() : 0);
        result = 31 * result + (matType1 != null ? matType1.hashCode() : 0);
        result = 31 * result + (matType2 != null ? matType2.hashCode() : 0);
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (int) publishFl;
        result = 31 * result + viewCnt;
        return result;
    }
}
