package com.valhalla.amulet.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "USER", schema = "", catalog = "athapong_amulet")
public class UserEntity {
    private int userId;
    private String userName;
    private String password;
    private String roleCode;
    private String loginStatus;
    private Timestamp timeStamp;
    private int searchCnt;
    private String uuid;

    @Id
    @Column(name = "USER_ID", nullable = false, insertable = true, updatable = true)
    @GeneratedValue
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "USER_NAME", nullable = false, insertable = true, updatable = true, length = 50)
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    @Column(name = "PASSWORD", nullable = true, insertable = true, updatable = true, length = 32)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "ROLE_CODE", nullable = true, insertable = true, updatable = true, length = 3)
    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    @Basic
    @Column(name = "LOGIN_STATUS", nullable = true, insertable = true, updatable = true, length = 1)
    public String getLoginStatus() {
        return loginStatus;
    }

    public void setLoginStatus(String loginStatus) {
        this.loginStatus = loginStatus;
    }

    @Basic
    @Column(name = "TIME_STAMP", nullable = false, insertable = true, updatable = true)
    public Timestamp getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(Timestamp timeStamp) {
        this.timeStamp = timeStamp;
    }

    @Basic
    @Column(name = "SEARCH_CNT", nullable = false, insertable = true, updatable = true)
    public int getSearchCnt() {
        return searchCnt;
    }

    public void setSearchCnt(int searchCnt) {
        this.searchCnt = searchCnt;
    }

    @Basic
    @Column(name = "UUID", nullable = true, insertable = true, updatable = true, length = 32)
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserEntity that = (UserEntity) o;

        if (searchCnt != that.searchCnt) return false;
        if (userId != that.userId) return false;
        if (loginStatus != null ? !loginStatus.equals(that.loginStatus) : that.loginStatus != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;
        if (roleCode != null ? !roleCode.equals(that.roleCode) : that.roleCode != null) return false;
        if (timeStamp != null ? !timeStamp.equals(that.timeStamp) : that.timeStamp != null) return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;
        if (uuid != null ? !uuid.equals(that.uuid) : that.uuid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId;
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (roleCode != null ? roleCode.hashCode() : 0);
        result = 31 * result + (loginStatus != null ? loginStatus.hashCode() : 0);
        result = 31 * result + (timeStamp != null ? timeStamp.hashCode() : 0);
        result = 31 * result + searchCnt;
        result = 31 * result + (uuid != null ? uuid.hashCode() : 0);
        return result;
    }
}
