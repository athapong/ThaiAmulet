package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.MatType2Entity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class MatType2DAO
{
    private static MatType2DAO matType2DAO;
    public static MatType2DAO getInstance() {
        if (matType2DAO == null) matType2DAO = new MatType2DAO();
        return matType2DAO;
    }

    public List<MatType2Entity> getMatType2Entities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MatType2Entity");
        List<MatType2Entity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public MatType2Entity getMatType2Entity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MatType2Entity WHERE matType2Code="+id);
        List<MatType2Entity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else
            return new MatType2Entity();
    }
}
