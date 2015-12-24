package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.MaterialEntity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class MaterialDAO
{
    private static MaterialDAO dao;
    public static MaterialDAO getInstance() {
        if (dao == null) dao = new MaterialDAO();
        return dao;
    }

    public List<MaterialEntity> getMaterialEntities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MaterialEntity");
        List<MaterialEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }
    public MaterialEntity getMaterialEntity(String material_id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM MaterialEntity WHERE materialCode="+material_id);
        List<MaterialEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return new MaterialEntity();
    }
}
