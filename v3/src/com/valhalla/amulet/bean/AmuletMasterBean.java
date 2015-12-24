package com.valhalla.amulet.bean;

import com.valhalla.amulet.utils.AmuletUtils;

import java.math.BigDecimal;
public class AmuletMasterBean {
    private int amuletCode;
    private String amuletName;
    private BigDecimal sWidth;
    private BigDecimal sLong;
    private BigDecimal sTall;
    private String material;
    private String yearFrom;
    private String yearTo;
    private String form1;
    private String form2;
    private String amuletCharacter;
    private String color;
    private String vernerable;
    private String temple;
    private String regionCode;
    private String provinceCode;
    private String amphurCode;
    private String districtCode;
    private String chamber;
    private String matType1;
    private String matType2;
    private String locketFl;
    private BigDecimal meditationL;
    private BigDecimal priceFrom;
    private BigDecimal priceTo;

    private String defectDes1;

    private String matDes1;
    private String matDes2;
    private String matDes3;
    private String matDes4;
    private String rating;
    private String note;
    private String amuletPic;

    public AmuletMasterBean() {
        amuletCode = 0;
        amuletName = "";
        sWidth = AmuletUtils.strToBigDecimal("");
        sLong = AmuletUtils.strToBigDecimal("");
        sTall = AmuletUtils.strToBigDecimal("");
        material = "0";
        yearFrom = "";
        yearTo = "";
        form1 = "0";
        form2 = "0";
        amuletCharacter = "0";
        color = "0";
        vernerable = "";
        temple = "";
        regionCode = "0";
        provinceCode = "0";
        amphurCode = "0";
        districtCode = "0";
        chamber = "0";
        matType1 = "0";
        matType2 = "0";
        locketFl = "0";
        meditationL = AmuletUtils.strToBigDecimal("");
        priceFrom = AmuletUtils.strToBigDecimal("");
        priceTo = AmuletUtils.strToBigDecimal("");

        defectDes1 = "";

        matDes1 = "0";
        matDes2 = "0";
        matDes3 = "0";
        matDes4 = "0";
        rating = "0";
        note = "";
        amuletPic = "";
    }

    public int getAMULET_CODE() {
        return amuletCode;
    }

    public void setAMULET_CODE(int amuletCode) {
        this.amuletCode = amuletCode;
    }

    public String getAMULET_NAME() {
        return amuletName;
    }

    public void setAMULET_NAME(String amuletName) {
        this.amuletName = amuletName;
    }

    public BigDecimal getS_WIDTH() {
        return sWidth;
    }

    public void setS_WIDTH(BigDecimal sWidth) {
        this.sWidth = sWidth;
    }

    public BigDecimal getS_LONG() {
        return sLong;
    }

    public void setS_LONG(BigDecimal sLong) {
        this.sLong = sLong;
    }

    public BigDecimal getS_TALL() {
        return sTall;
    }

    public void setS_TALL(BigDecimal sTall) {
        this.sTall = sTall;
    }

    public String getMATERIAL() {
        return material;
    }

    public void setMATERIAL(String material) {
        this.material = material;
    }

    public String getYEAR_FROM() {
        return yearFrom;
    }

    public void setYEAR_FROM(String yearFrom) {
        this.yearFrom = yearFrom;
    }

    public String getYEAR_TO() {
        return yearTo;
    }

    public void setYEAR_TO(String yearTo) {
        this.yearTo = yearTo;
    }

    public String getFORM_1() {
        return form1;
    }

    public void setFORM_1(String form1) {
        this.form1 = form1;
    }

    public String getFORM_2() {
        return form2;
    }

    public void setFORM_2(String form2) {
        this.form2 = form2;
    }

    public String getAMULET_CHARACTER() {
        return amuletCharacter;
    }

    public void setAMULET_CHARACTER(String amuletCharacter) {
        this.amuletCharacter = amuletCharacter;
    }

    public String getCOLOR() {
        return color;
    }

    public void setCOLOR(String color) {
        this.color = color;
    }

    public String getVERNERABLE() {
        return vernerable;
    }

    public void setVERNERABLE(String vernerable) {
        this.vernerable = vernerable;
    }

    public String getTEMPLE() {
        return temple;
    }

    public void setTEMPLE(String temple) {
        this.temple = temple;
    }

    public String getREGION_CODE() {
        return regionCode;
    }

    public void setREGION_CODE(String regionCode) {
        this.regionCode = regionCode;
    }

    public String getPROVINCE_CODE() {
        return provinceCode;
    }

    public void setPROVINCE_CODE(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getAMPHUR_CODE() {
        return amphurCode;
    }

    public void setAMPHUR_CODE(String amphurCode) {
        this.amphurCode = amphurCode;
    }

    public String getDISTRICT_CODE() {
        return districtCode;
    }

    public void setDISTRICT_CODE(String districtCode) {
        this.districtCode = districtCode;
    }

    public String getCHAMBER() {
        return chamber;
    }

    public void setCHAMBER(String chamber) {
        this.chamber = chamber;
    }

    public String getMAT_TYPE_1() {
        return matType1;
    }

    public void setMAT_TYPE_1(String matType1) {
        this.matType1 = matType1;
    }

    public String getMAT_TYPE_2() {
        return matType2;
    }

    public void setMAT_TYPE_2(String matType2) {
        this.matType2 = matType2;
    }

    public String getLOCKET_FL() {
        return locketFl;
    }

    public void setLOCKET_FL(String locketFl) {
        this.locketFl = locketFl;
    }

    public BigDecimal getMEDITATION_L() {
        return meditationL;
    }

    public void setMEDITATION_L(BigDecimal meditationL) {
        this.meditationL = meditationL;
    }

    public BigDecimal getPRICE_FROM() {
        return priceFrom;
    }

    public void setPRICE_FROM(BigDecimal priceFrom) {
        this.priceFrom = priceFrom;
    }

    public BigDecimal getPRICE_TO() {
        return priceTo;
    }

    public void setPRICE_TO(BigDecimal priceTo) {
        this.priceTo = priceTo;
    }



    public String getDEFECT_DES_1() {
        return defectDes1;
    }

    public void setDEFECT_DES_1(String defectDes1) {
        this.defectDes1 = defectDes1;
    }



    public String getMAT_DES_1() {
        return matDes1;
    }

    public void setMAT_DES_1(String matDes1) {
        this.matDes1 = matDes1;
    }

    public String getMAT_DES_2() {
        return matDes2;
    }

    public void setMAT_DES_2(String matDes2) {
        this.matDes2 = matDes2;
    }

    public String getMAT_DES_3() {
        return matDes3;
    }

    public void setMAT_DES_3(String matDes3) {
        this.matDes3 = matDes3;
    }

    public String getMAT_DES_4() {
        return matDes4;
    }

    public void setMAT_DES_4(String matDes4) {
        this.matDes4 = matDes4;
    }

    public String getRATING() {
        return rating;
    }

    public void setRATING(String rating) {
        this.rating = rating;
    }

    public String getNOTE() {
        return note;
    }

    public void setNOTE(String note) {
        this.note = note;
    }
    public String getAMULET_PIC() {
        return amuletPic;
    }

    public void setAMULET_PIC(String amuletPic) {
        this.amuletPic = amuletPic;
    }
}

