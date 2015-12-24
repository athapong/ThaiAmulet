package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.RatingEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class RatingDAO
{
    private static RatingDAO dao;
    public static RatingDAO getInstance() {
        if (dao == null) dao = new RatingDAO();
        return dao;
    }

    public List<RatingEntity> getRatingEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM RatingEntity");
        List<RatingEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }
}
