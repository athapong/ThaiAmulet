package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.RegionEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class RegionDAO
{
    private static RegionDAO dao;
    public static RegionDAO getInstance() {
        if (dao == null) dao = new RegionDAO();
        return dao;
    }

    public List<RegionEntity> getRegionEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM RegionEntity");
        List<RegionEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public RegionEntity getRegionEntity(String regionId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM RegionEntity where geoId ="+ Integer.parseInt(regionId));

        List<RegionEntity> list = query.list();
        ConnectionManager.close();

        if (list.size() > 0)
            return list.get(0);
        else
            return new RegionEntity();
    }
}
