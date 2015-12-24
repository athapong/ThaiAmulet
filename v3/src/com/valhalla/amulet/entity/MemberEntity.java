package com.valhalla.amulet.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "MEMBER", schema = "", catalog = "athapong_amulet")
public class MemberEntity {
    private int memberId;
    private String fname;
    private String lname;
    private String sex;
    private Date birthDate;
    private Date pmtDate;
    private String idCard;
    private String id4scan;
    private String phoneNo2;
    private String idCardPic;
    private String idHomePic;
    private String email;
    private Timestamp timeStamp;

    @Id
    @Column(name = "MEMBER_ID", nullable = false, insertable = true, updatable = false)
    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    @Basic
    @Column(name = "FNAME", nullable = true, insertable = true, updatable = true, length = 250)
    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    @Basic
    @Column(name = "LNAME", nullable = true, insertable = true, updatable = true, length = 250)
    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    @Basic
    @Column(name = "SEX", nullable = true, insertable = true, updatable = true, length = 1)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Basic
    @Column(name = "BIRTH_DATE", nullable = true, insertable = true, updatable = true)
    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    @Basic
    @Column(name = "PMT_DATE", nullable = true, insertable = true, updatable = true)
    public Date getPmtDate() {
        return pmtDate;
    }

    public void setPmtDate(Date pmtDate) {
        this.pmtDate = pmtDate;
    }


    @Basic
    @Column(name = "ID_CARD", nullable = true, insertable = true, updatable = true, length = 19)
    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    @Basic
    @Column(name = "ID4SCAN", nullable = true, insertable = true, updatable = true, length = 250)
    public String getId4scan() {
        return id4scan;
    }

    public void setId4scan(String id4scan) {
        this.id4scan = id4scan;
    }

    @Basic
    @Column(name = "PHONE_NO2", nullable = true, insertable = true, updatable = true, length = 250)
    public String getPhoneNo2() {
        return phoneNo2;
    }

    public void setPhoneNo2(String phoneNo2) {
        this.phoneNo2 = phoneNo2;
    }

    @Basic
    @Column(name = "ID_CARD_PIC", nullable = true, insertable = true, updatable = true, length = 250)
    public String getIdCardPic() {
        return idCardPic;
    }

    public void setIdCardPic(String idCardPic) {
        this.idCardPic = idCardPic;
    }

    @Basic
    @Column(name = "ID_HOME_PIC", nullable = true, insertable = true, updatable = true, length = 250)
    public String getIdHomePic() {
        return idHomePic;
    }

    public void setIdHomePic(String idHomePic) {
        this.idHomePic = idHomePic;
    }

    @Basic
    @Column(name = "EMAIL", nullable = true, insertable = true, updatable = true, length = 250)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "TIME_STAMP", nullable = false, insertable = true, updatable = true)
    public Timestamp getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(Timestamp timeStamp) {
        this.timeStamp = timeStamp;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MemberEntity that = (MemberEntity) o;

        if (memberId != that.memberId) return false;
        if (birthDate != null ? !birthDate.equals(that.birthDate) : that.birthDate != null) return false;
        if (pmtDate != null ? !pmtDate.equals(that.pmtDate) : that.pmtDate != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (fname != null ? !fname.equals(that.fname) : that.fname != null) return false;
        if (idCard != null ? !idCard.equals(that.idCard) : that.idCard != null) return false;
        if (idCardPic != null ? !idCardPic.equals(that.idCardPic) : that.idCardPic != null) return false;
        if (idHomePic != null ? !idHomePic.equals(that.idHomePic) : that.idHomePic != null) return false;
        if (lname != null ? !lname.equals(that.lname) : that.lname != null) return false;
        if (id4scan != null ? !id4scan.equals(that.id4scan) : that.id4scan != null) return false;
        if (phoneNo2 != null ? !phoneNo2.equals(that.phoneNo2) : that.phoneNo2 != null) return false;
        if (sex != null ? !sex.equals(that.sex) : that.sex != null) return false;
        if (timeStamp != null ? !timeStamp.equals(that.timeStamp) : that.timeStamp != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = memberId;
        result = 31 * result + (fname != null ? fname.hashCode() : 0);
        result = 31 * result + (lname != null ? lname.hashCode() : 0);
        result = 31 * result + (sex != null ? sex.hashCode() : 0);
        result = 31 * result + (birthDate != null ? birthDate.hashCode() : 0);
        result = 31 * result + (pmtDate != null ? pmtDate.hashCode() : 0);
        result = 31 * result + (idCard != null ? idCard.hashCode() : 0);
        result = 31 * result + (id4scan != null ? id4scan.hashCode() : 0);
        result = 31 * result + (phoneNo2 != null ? phoneNo2.hashCode() : 0);
        result = 31 * result + (idCardPic != null ? idCardPic.hashCode() : 0);
        result = 31 * result + (idHomePic != null ? idHomePic.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (timeStamp != null ? timeStamp.hashCode() : 0);
        return result;
    }
}
