package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.TambolEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class TambolDAO
{
    private static TambolDAO dao;
    public static TambolDAO getInstance() {
        if (dao == null) dao = new TambolDAO();
        return dao;
    }

    public List<TambolEntity> getTambolEntities(int provinceId, int amphurId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM TambolEntity WHERE provinceId = " + provinceId + " AND amphurId = " + amphurId);

        List<TambolEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public TambolEntity getTambolEntity(String provinceId, String amphurId, String tambolId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM TambolEntity WHERE provinceId = " + provinceId + " AND amphurId = " + amphurId + " AND districtId = " + tambolId);

        List<TambolEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return new TambolEntity();
    }
}
