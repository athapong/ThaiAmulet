package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.MatDescEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class MatDescDAO
{
    private static MatDescDAO dao;
    public static MatDescDAO getInstance() {
        if (dao == null) dao = new MatDescDAO();
        return dao;
    }

    public List<MatDescEntity> getMatDescEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MatDescEntity");
        List<MatDescEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public MatDescEntity getMatDescEntity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MatDescEntity WHERE matDescCode="+ id);
        List<MatDescEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return new MatDescEntity();
    }
}
