package com.valhalla.amulet.bean;

public class AmuletMasterInquiryBean {
    private String amuletCode = "";
    private String amuletName = "";

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

    public String getAmuletCode() {
        return amuletCode;
    }

    public void setAmuletCode(String amuletCode) {
        this.amuletCode = amuletCode;
    }

    public String getAmuletName() {
        return amuletName;
    }

    public void setAmuletName(String amuletName) {
        this.amuletName = amuletName;
    }
}
