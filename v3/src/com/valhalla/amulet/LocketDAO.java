package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.LocketEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class LocketDAO
{
    private static LocketDAO locketDAO;
    public static LocketDAO getInstance() {
        if (locketDAO == null) locketDAO = new LocketDAO();
        return locketDAO;
    }

    public List<LocketEntity> getLocketEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM LocketEntity");
        List<LocketEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public LocketEntity getLocketEntity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM LocketEntity WHERE locketCode="+id);
        List<LocketEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return new LocketEntity();
    }
}
