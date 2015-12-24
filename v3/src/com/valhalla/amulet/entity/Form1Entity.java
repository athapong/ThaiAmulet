package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "FORM_1", schema = "", catalog = "athapong_amulet")
public class Form1Entity {
    private int form1Code;
    private String form1Desc;

    @Id
    @Column(name = "FORM_1_CODE", nullable = false, insertable = true, updatable = true)
    public int getForm1Code() {
        return form1Code;
    }

    public void setForm1Code(int form1Code) {
        this.form1Code = form1Code;
    }

    @Basic
    @Column(name = "FORM_1_DESC", nullable = false, insertable = true, updatable = true, length = 25)
    public String getForm1Desc() {
        return form1Desc;
    }

    public void setForm1Desc(String form1Desc) {
        this.form1Desc = form1Desc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Form1Entity that = (Form1Entity) o;

        if (form1Code != that.form1Code) return false;
        if (form1Desc != null ? !form1Desc.equals(that.form1Desc) : that.form1Desc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = form1Code;
        result = 31 * result + (form1Desc != null ? form1Desc.hashCode() : 0);
        return result;
    }
}
