package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.AmuletMasterEntity;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import java.util.List;

public class AmuletMasterDAO
{
    private static AmuletMasterDAO dao;
    public static AmuletMasterDAO getInstance() {
        if (dao == null) dao = new AmuletMasterDAO();
        return dao;
    }

    public AmuletMasterEntity getAmuletEntity(int amuletId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM AmuletMasterEntity WHERE amuletCode = " + amuletId);
        List<AmuletMasterEntity> list = query.list();
        ConnectionManager.close();
        if (list.size() > 0) return list.get(0);
        else return null;
    }

    public List<AmuletMasterEntity> getAmuletEntities(int provinceId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Query query = session.createQuery("FROM AmuletMasterEntity");
        List<AmuletMasterEntity> list = query.list();
        ConnectionManager.close();
        return list;
    }



    public int saveAmuletMaster(AmuletMasterEntity entity)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        session.save(entity);
        session.getTransaction().commit();
        session.flush();
        session.close();
        return entity.getAmuletCode();
    }
    public boolean updateAmuletMaster(AmuletMasterEntity entity)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        session.update(entity);
        session.getTransaction().commit();
        session.flush();
        session.close();
        return true;
    }

    public void deleteAmulet(int amuletId) {
        Session session = ConnectionManager.getSession();
        Transaction tx = session.beginTransaction();

        Criteria criteria = session.createCriteria(AmuletMasterEntity.class);
        criteria.add(Restrictions.eq("amuletCode", amuletId));
        List<AmuletMasterEntity> amuletMasterEntityList = criteria.list();
        try {
            session.delete(amuletMasterEntityList.get(0));
        } catch(Exception ex) {
            // do nothing
        }
        tx.commit();
        session.close();
    }
}
