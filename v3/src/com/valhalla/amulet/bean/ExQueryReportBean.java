package com.valhalla.amulet.bean;

public class ExQueryReportBean {


    private String fname;
    private String lname;
    private String userName;
    private String email;
    private String idCardNo;
    private String id4scan;
    private String dateStart;
    private String dateEnd;
    private int currentPage;

    public ExQueryReportBean() {
        this.fname = "";
        this.lname = "";
        this.userName = "";
        this.email = "";
        this.idCardNo = "";
        this.id4scan = "";
        this.dateStart = "";
        this.dateEnd = "";
        this.currentPage = 0;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    private int pageCount;
    public String getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(String dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdCardNo() {
        return idCardNo;
    }

    public void setIdCardNo(String idCardNo) {
        this.idCardNo = idCardNo;
    }

    public String getId4Scan() {
        return id4scan;
    }

    public void setId4Scan(String id4scan) {
        this.id4scan = id4scan;
    }

    public String getDateStart() {
        return dateStart;
    }

    public void setDateStart(String dateStart) {
        this.dateStart = dateStart;
    }
}