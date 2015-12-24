package com.valhalla.amulet.bean;

public class AdminManageKnowHowBean {
    private String subject = "";
    private String region = "";
    private String province = "";
    private String matType1 = "";
    private String matType2 = "";
    private int currentPage = 0;
    private int pageCount = 0;

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



    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getMatType1() {
        return matType1;
    }

    public void setMatType1(String matType1) {
        this.matType1 = matType1;
    }

    public String getMatType2() {
        return matType2;
    }

    public void setMatType2(String matType2) {
        this.matType2 = matType2;
    }
}
