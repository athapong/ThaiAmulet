package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.Form1Entity;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

public class Form1DAO
{
    private static Form1DAO dao;
    public static Form1DAO getInstance() {
        if (dao == null) dao = new Form1DAO();
        return dao;
    }

    public List<Form1Entity> getForm1Entities() {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM Form1Entity");
        List<Form1Entity> list = query.list();
        ConnectionManager.close();
        return list;
    }

    public Form1Entity getForm1Entity(String form1_id) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM Form1Entity WHERE form1Code ="+ form1_id);
        List<Form1Entity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0)
            return list.get(0);
        else return new Form1Entity();
    }
}
