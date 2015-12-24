package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.AmphurEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class AmphurDAO
{
    private static AmphurDAO dao;
    public static AmphurDAO getInstance() {
        if (dao == null) dao = new AmphurDAO();
        return dao;
    }

    public List<AmphurEntity> getAmphurEntities(int provinceId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM AmphurEntity WHERE provinceId = "+ provinceId);
        List<AmphurEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public AmphurEntity getAmphurEntity(String provinceId, String amphurId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM AmphurEntity WHERE provinceId = "+ provinceId +" AND amphurId ="+ amphurId);
        List<AmphurEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return null;
    }
}
