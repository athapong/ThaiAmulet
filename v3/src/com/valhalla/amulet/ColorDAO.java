package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.ColorEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class ColorDAO
{
    private static ColorDAO dao;
    public static ColorDAO getInstance() {
        if (dao == null) dao = new ColorDAO();
        return dao;
    }

    public List<ColorEntity> getColorEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM ColorEntity");
        List<ColorEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }
    public ColorEntity getColorEntity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM ColorEntity where colorCode="+id);
        List<ColorEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else
            return new ColorEntity();
    }
}
