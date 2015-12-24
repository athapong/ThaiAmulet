package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.CharacterEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class CharacterDAO
{
    private static CharacterDAO dao;
    public static CharacterDAO getInstance() {
        if (dao == null) dao = new CharacterDAO();
        return dao;
    }

    public List<CharacterEntity> getCharacterEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM CharacterEntity");
        List<CharacterEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public CharacterEntity getCharacterEntity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM CharacterEntity WHERE characterCode ="+ id);
        List<CharacterEntity> list = query.list();
        ConnectionManager.close();
        return list.get(0);
    }
}
