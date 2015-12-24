package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.ChamberEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class ChamberDAO
{
    private static ChamberDAO chamberDAO;
    public static ChamberDAO getInstance() {
        if (chamberDAO == null) chamberDAO = new ChamberDAO();
        return chamberDAO;
    }

    public List<ChamberEntity> getChamberEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM ChamberEntity");
        List<ChamberEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public ChamberEntity getChamberEntity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM ChamberEntity WHERE chamberCode="+id);
        List<ChamberEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return new ChamberEntity();
    }
}
