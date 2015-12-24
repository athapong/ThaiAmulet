package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "FORM_2", schema = "", catalog = "athapong_amulet")
public class Form2Entity {
    private int form2Code;
    private String form2Desc;

    @Id
    @Column(name = "FORM_2_CODE", nullable = false, insertable = true, updatable = true)
    public int getForm2Code() {
        return form2Code;
    }

    public void setForm2Code(int form2Code) {
        this.form2Code = form2Code;
    }

    @Basic
    @Column(name = "FORM_2_DESC", nullable = false, insertable = true, updatable = true, length = 25)
    public String getForm2Desc() {
        return form2Desc;
    }

    public void setForm2Desc(String form2Desc) {
        this.form2Desc = form2Desc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Form2Entity that = (Form2Entity) o;

        if (form2Code != that.form2Code) return false;
        if (form2Desc != null ? !form2Desc.equals(that.form2Desc) : that.form2Desc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = form2Code;
        result = 31 * result + (form2Desc != null ? form2Desc.hashCode() : 0);
        return result;
    }
}
