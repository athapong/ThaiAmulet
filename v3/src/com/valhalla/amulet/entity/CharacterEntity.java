package com.valhalla.amulet.entity;

import javax.persistence.*;

/**
 * Created by athapong on 4/19/2015 AD.
 */
@Entity
@Table(name = "CHARACTER", schema = "", catalog = "athapong_amulet")
public class CharacterEntity {
    private int characterCode;
    private String characterDesc;

    @Id
    @Column(name = "CHARACTER_CODE", nullable = false, insertable = true, updatable = true)
    public int getCharacterCode() {
        return characterCode;
    }

    public void setCharacterCode(int characterCode) {
        this.characterCode = characterCode;
    }

    @Basic
    @Column(name = "CHARACTER_DESC", nullable = false, insertable = true, updatable = true, length = 25)
    public String getCharacterDesc() {
        return characterDesc;
    }

    public void setCharacterDesc(String characterDesc) {
        this.characterDesc = characterDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CharacterEntity that = (CharacterEntity) o;

        if (characterCode != that.characterCode) return false;
        if (characterDesc != null ? !characterDesc.equals(that.characterDesc) : that.characterDesc != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = characterCode;
        result = 31 * result + (characterDesc != null ? characterDesc.hashCode() : 0);
        return result;
    }
}
