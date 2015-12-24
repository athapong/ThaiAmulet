package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.Form2Entity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class Form2DAO
{
    private static Form2DAO dao;
    public static Form2DAO getInstance() {
        if (dao == null) dao = new Form2DAO();
        return dao;
    }

    public List<Form2Entity> getForm2Entities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM Form2Entity");
        List<Form2Entity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public Form2Entity getForm2Entity(String form2_id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM Form2Entity WHERE form2Code ="+ form2_id);
        List<Form2Entity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return new Form2Entity();
    }
}
