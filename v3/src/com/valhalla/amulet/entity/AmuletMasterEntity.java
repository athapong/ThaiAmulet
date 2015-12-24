package com.valhalla.amulet.entity;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.math.BigDecimal;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@javax.persistence.Table(name = "AMULET_MASTER", schema = "", catalog = "athapong_amulet")
public class AmuletMasterEntity {
    private int amuletCode;

    @Id
    @javax.persistence.Column(name = "AMULET_CODE", nullable = false, insertable = true, updatable = true)
    @GeneratedValue
    public int getAmuletCode() {
        return amuletCode;
    }

    public void setAmuletCode(int amuletCode) {
        this.amuletCode = amuletCode;
    }

    private String amuletName;

    @Basic
    @javax.persistence.Column(name = "AMULET_NAME", nullable = true, insertable = true, updatable = true, length = 100)
    public String getAmuletName() {
        return amuletName;
    }

    public void setAmuletName(String amuletName) {
        this.amuletName = amuletName;
    }

    private BigDecimal sWidth;

    @Basic
    @javax.persistence.Column(name = "S_WIDTH", nullable = true, insertable = true, updatable = true, precision = 2)
    public BigDecimal getsWidth() {
        return sWidth;
    }

    public void setsWidth(BigDecimal sWidth) {
        this.sWidth = sWidth;
    }

    private BigDecimal sLong;

    @Basic
    @javax.persistence.Column(name = "S_LONG", nullable = true, insertable = true, updatable = true, precision = 2)
    public BigDecimal getsLong() {
        return sLong;
    }

    public void setsLong(BigDecimal sLong) {
        this.sLong = sLong;
    }

    private BigDecimal sTall;

    @Basic
    @javax.persistence.Column(name = "S_TALL", nullable = true, insertable = true, updatable = true, precision = 2)
    public BigDecimal getsTall() {
        return sTall;
    }

    public void setsTall(BigDecimal sTall) {
        this.sTall = sTall;
    }

    private String material;

    @Basic
    @javax.persistence.Column(name = "MATERIAL", nullable = true, insertable = true, updatable = true, length = 25)
    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    private String yearFrom;

    @Basic
    @javax.persistence.Column(name = "YEAR_FROM", nullable = true, insertable = true, updatable = true, length = 4)
    public String getYearFrom() {
        return yearFrom;
    }

    public void setYearFrom(String yearFrom) {
        this.yearFrom = yearFrom;
    }

    private String yearTo;

    @Basic
    @javax.persistence.Column(name = "YEAR_TO", nullable = true, insertable = true, updatable = true, length = 4)
    public String getYearTo() {
        return yearTo;
    }

    public void setYearTo(String yearTo) {
        this.yearTo = yearTo;
    }

    private String form1;

    @Basic
    @javax.persistence.Column(name = "FORM_1", nullable = true, insertable = true, updatable = true, length = 3)
    public String getForm1() {
        return form1;
    }

    public void setForm1(String form1) {
        this.form1 = form1;
    }

    private String form2;

    @Basic
    @javax.persistence.Column(name = "FORM_2", nullable = true, insertable = true, updatable = true, length = 3)
    public String getForm2() {
        return form2;
    }

    public void setForm2(String form2) {
        this.form2 = form2;
    }

    private String amuletCharacter;

    @Basic
    @javax.persistence.Column(name = "AMULET_CHARACTER", nullable = true, insertable = true, updatable = true, length = 25)
    public String getAmuletCharacter() {
        return amuletCharacter;
    }

    public void setAmuletCharacter(String amuletCharacter) {
        this.amuletCharacter = amuletCharacter;
    }

    private String color;

    @Basic
    @javax.persistence.Column(name = "COLOR", nullable = true, insertable = true, updatable = true, length = 25)
    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    private String vernerable;

    @Basic
    @javax.persistence.Column(name = "VERNERABLE", nullable = true, insertable = true, updatable = true, length = 45)
    public String getVernerable() {
        return vernerable;
    }

    public void setVernerable(String vernerable) {
        this.vernerable = vernerable;
    }

    private String temple;

    @Basic
    @javax.persistence.Column(name = "TEMPLE", nullable = true, insertable = true, updatable = true, length = 45)
    public String getTemple() {
        return temple;
    }

    public void setTemple(String temple) {
        this.temple = temple;
    }

    private String regionCode;

    @Basic
    @javax.persistence.Column(name = "REGION_CODE", nullable = true, insertable = true, updatable = true, length = 5)
    public String getRegionCode() {
        return regionCode;
    }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode;
    }

    private String provinceCode;

    @Basic
    @javax.persistence.Column(name = "PROVINCE_CODE", nullable = true, insertable = true, updatable = true, length = 5)
    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    private String amphurCode;

    @Basic
    @javax.persistence.Column(name = "AMPHUR_CODE", nullable = true, insertable = true, updatable = true, length = 5)
    public String getAmphurCode() {
        return amphurCode;
    }

    public void setAmphurCode(String amphurCode) {
        this.amphurCode = amphurCode;
    }

    private String districtCode;

    @Basic
    @javax.persistence.Column(name = "DISTRICT_CODE", nullable = true, insertable = true, updatable = true, length = 5)
    public String getDistrictCode() {
        return districtCode;
    }

    public void setDistrictCode(String districtCode) {
        this.districtCode = districtCode;
    }

    private String chamber;

    @Basic
    @javax.persistence.Column(name = "CHAMBER", nullable = true, insertable = true, updatable = true, length = 25)
    public String getChamber() {
        return chamber;
    }

    public void setChamber(String chamber) {
        this.chamber = chamber;
    }

    private String matType1;

    @Basic
    @javax.persistence.Column(name = "MAT_TYPE_1", nullable = true, insertable = true, updatable = true, length = 45)
    public String getMatType1() {
        return matType1;
    }

    public void setMatType1(String matType1) {
        this.matType1 = matType1;
    }

    private String matType2;

    @Basic
    @javax.persistence.Column(name = "MAT_TYPE_2", nullable = true, insertable = true, updatable = true, length = 45)
    public String getMatType2() {
        return matType2;
    }

    public void setMatType2(String matType2) {
        this.matType2 = matType2;
    }

    private String locketFl;

    @Basic
    @javax.persistence.Column(name = "LOCKET_FL", nullable = true, insertable = true, updatable = true, length = 45)
    public String getLocketFl() {
        return locketFl;
    }

    public void setLocketFl(String locketFl) {
        this.locketFl = locketFl;
    }

    private BigDecimal meditationL;

    @Basic
    @javax.persistence.Column(name = "MEDITATION_L", nullable = true, insertable = true, updatable = true, precision = 2)
    public BigDecimal getMeditationL() {
        return meditationL;
    }

    public void setMeditationL(BigDecimal meditationL) {
        this.meditationL = meditationL;
    }

    private BigDecimal priceFrom;

    @Basic
    @javax.persistence.Column(name = "PRICE_FROM", nullable = true, insertable = true, updatable = true, precision = 2)
    public BigDecimal getPriceFrom() {
        return priceFrom;
    }

    public void setPriceFrom(BigDecimal priceFrom) {
        this.priceFrom = priceFrom;
    }

    private BigDecimal priceTo;

    @Basic
    @javax.persistence.Column(name = "PRICE_TO", nullable = true, insertable = true, updatable = true, precision = 2)
    public BigDecimal getPriceTo() {
        return priceTo;
    }

    public void setPriceTo(BigDecimal priceTo) {
        this.priceTo = priceTo;
    }




    private String defectDes1;

    @Basic
    @javax.persistence.Column(name = "DEFECT_DES_1", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getDefectDes1() {
        return defectDes1;
    }

    public void setDefectDes1(String defectDes1) {
        this.defectDes1 = defectDes1;
    }

    private String matDes1;

    @Basic
    @javax.persistence.Column(name = "MAT_DES_1", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getMatDes1() {
        return matDes1;
    }

    public void setMatDes1(String matDes1) {
        this.matDes1 = matDes1;
    }

    private String matDes2;

    @Basic
    @javax.persistence.Column(name = "MAT_DES_2", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getMatDes2() {
        return matDes2;
    }

    public void setMatDes2(String matDes2) {
        this.matDes2 = matDes2;
    }

    private String matDes3;

    @Basic
    @javax.persistence.Column(name = "MAT_DES_3", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getMatDes3() {
        return matDes3;
    }

    public void setMatDes3(String matDes3) {
        this.matDes3 = matDes3;
    }

    private String matDes4;

    @Basic
    @javax.persistence.Column(name = "MAT_DES_4", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getMatDes4() {
        return matDes4;
    }

    public void setMatDes4(String matDes4) {
        this.matDes4 = matDes4;
    }

    private String rating;

    @Basic
    @javax.persistence.Column(name = "RATING", nullable = true, insertable = true, updatable = true, length = 3)
    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    private String note;

    @Basic
    @javax.persistence.Column(name = "NOTE", nullable = true, insertable = true, updatable = true, length = 65535)
    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    private String amuletPic;

    @Basic
    @javax.persistence.Column(name = "AMULET_PIC", nullable = true, insertable = true, updatable = true, length = 250)
    public String getAmuletPic() {
        return amuletPic;
    }

    public void setAmuletPic(String amuletPic) {
        this.amuletPic = amuletPic;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AmuletMasterEntity that = (AmuletMasterEntity) o;

        if (amuletCode != that.amuletCode) return false;
        if (amphurCode != null ? !amphurCode.equals(that.amphurCode) : that.amphurCode != null) return false;
        if (amuletCharacter != null ? !amuletCharacter.equals(that.amuletCharacter) : that.amuletCharacter != null)
            return false;
        if (amuletName != null ? !amuletName.equals(that.amuletName) : that.amuletName != null) return false;
        if (amuletPic != null ? !amuletPic.equals(that.amuletPic) : that.amuletPic != null) return false;
        if (chamber != null ? !chamber.equals(that.chamber) : that.chamber != null) return false;
        if (color != null ? !color.equals(that.color) : that.color != null) return false;
        if (defectDes1 != null ? !defectDes1.equals(that.defectDes1) : that.defectDes1 != null) return false;
        if (districtCode != null ? !districtCode.equals(that.districtCode) : that.districtCode != null) return false;
        if (form1 != null ? !form1.equals(that.form1) : that.form1 != null) return false;
        if (form2 != null ? !form2.equals(that.form2) : that.form2 != null) return false;
        if (locketFl != null ? !locketFl.equals(that.locketFl) : that.locketFl != null) return false;
        if (matDes1 != null ? !matDes1.equals(that.matDes1) : that.matDes1 != null) return false;
        if (matDes2 != null ? !matDes2.equals(that.matDes2) : that.matDes2 != null) return false;
        if (matDes3 != null ? !matDes3.equals(that.matDes3) : that.matDes3 != null) return false;
        if (matDes4 != null ? !matDes4.equals(that.matDes4) : that.matDes4 != null) return false;
        if (matType1 != null ? !matType1.equals(that.matType1) : that.matType1 != null) return false;
        if (matType2 != null ? !matType2.equals(that.matType2) : that.matType2 != null) return false;
        if (material != null ? !material.equals(that.material) : that.material != null) return false;
        if (meditationL != null ? !meditationL.equals(that.meditationL) : that.meditationL != null) return false;
        if (note != null ? !note.equals(that.note) : that.note != null) return false;
        if (priceFrom != null ? !priceFrom.equals(that.priceFrom) : that.priceFrom != null) return false;
        if (priceTo != null ? !priceTo.equals(that.priceTo) : that.priceTo != null) return false;
        if (provinceCode != null ? !provinceCode.equals(that.provinceCode) : that.provinceCode != null) return false;
        if (rating != null ? !rating.equals(that.rating) : that.rating != null) return false;
        if (regionCode != null ? !regionCode.equals(that.regionCode) : that.regionCode != null) return false;
        if (sLong != null ? !sLong.equals(that.sLong) : that.sLong != null) return false;
        if (sTall != null ? !sTall.equals(that.sTall) : that.sTall != null) return false;
        if (sWidth != null ? !sWidth.equals(that.sWidth) : that.sWidth != null) return false;
        if (temple != null ? !temple.equals(that.temple) : that.temple != null) return false;
        if (vernerable != null ? !vernerable.equals(that.vernerable) : that.vernerable != null) return false;
        if (yearFrom != null ? !yearFrom.equals(that.yearFrom) : that.yearFrom != null) return false;
        if (yearTo != null ? !yearTo.equals(that.yearTo) : that.yearTo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = amuletCode;
        result = 31 * result + (amuletName != null ? amuletName.hashCode() : 0);
        result = 31 * result + (sWidth != null ? sWidth.hashCode() : 0);
        result = 31 * result + (sLong != null ? sLong.hashCode() : 0);
        result = 31 * result + (sTall != null ? sTall.hashCode() : 0);
        result = 31 * result + (material != null ? material.hashCode() : 0);
        result = 31 * result + (yearFrom != null ? yearFrom.hashCode() : 0);
        result = 31 * result + (yearTo != null ? yearTo.hashCode() : 0);
        result = 31 * result + (form1 != null ? form1.hashCode() : 0);
        result = 31 * result + (form2 != null ? form2.hashCode() : 0);
        result = 31 * result + (amuletCharacter != null ? amuletCharacter.hashCode() : 0);
        result = 31 * result + (color != null ? color.hashCode() : 0);
        result = 31 * result + (vernerable != null ? vernerable.hashCode() : 0);
        result = 31 * result + (temple != null ? temple.hashCode() : 0);
        result = 31 * result + (regionCode != null ? regionCode.hashCode() : 0);
        result = 31 * result + (provinceCode != null ? provinceCode.hashCode() : 0);
        result = 31 * result + (amphurCode != null ? amphurCode.hashCode() : 0);
        result = 31 * result + (districtCode != null ? districtCode.hashCode() : 0);
        result = 31 * result + (chamber != null ? chamber.hashCode() : 0);
        result = 31 * result + (matType1 != null ? matType1.hashCode() : 0);
        result = 31 * result + (matType2 != null ? matType2.hashCode() : 0);
        result = 31 * result + (locketFl != null ? locketFl.hashCode() : 0);
        result = 31 * result + (meditationL != null ? meditationL.hashCode() : 0);
        result = 31 * result + (priceFrom != null ? priceFrom.hashCode() : 0);
        result = 31 * result + (priceTo != null ? priceTo.hashCode() : 0);
        result = 31 * result + (defectDes1 != null ? defectDes1.hashCode() : 0);
        result = 31 * result + (matDes1 != null ? matDes1.hashCode() : 0);
        result = 31 * result + (matDes2 != null ? matDes2.hashCode() : 0);
        result = 31 * result + (matDes3 != null ? matDes3.hashCode() : 0);
        result = 31 * result + (matDes4 != null ? matDes4.hashCode() : 0);
        result = 31 * result + (rating != null ? rating.hashCode() : 0);
        result = 31 * result + (note != null ? note.hashCode() : 0);
        result = 31 * result + (amuletPic != null ? amuletPic.hashCode() : 0);
        return result;
    }
}
