package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.MatType1Entity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class MatType1DAO
{
    private static MatType1DAO matType1DAO;
    public static MatType1DAO getInstance() {
        if (matType1DAO == null) matType1DAO = new MatType1DAO();
        return matType1DAO;
    }

    public List<MatType1Entity> getMatType1Entities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MatType1Entity");
        List<MatType1Entity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public MatType1Entity getMatType1Entity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MatType1Entity WHERE matType1Code="+id);
        List<MatType1Entity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else
            return new MatType1Entity();
    }
}
