package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.ProvinceEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class ProvinceDAO
{
    private static ProvinceDAO dao;
    public static ProvinceDAO getInstance() {
        if (dao == null) dao = new ProvinceDAO();
        return dao;
    }

    public List<ProvinceEntity> getProvinceEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM ProvinceEntity");
        List<ProvinceEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public List<ProvinceEntity> getProvinceEntitiesByRegion(String regionId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM ProvinceEntity where geoId ="+ Integer.parseInt(regionId));
        List<ProvinceEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public ProvinceEntity getProvinceEntity(String id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM ProvinceEntity where provinceId="+id);
        List<ProvinceEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else
            return new ProvinceEntity();
    }
}
