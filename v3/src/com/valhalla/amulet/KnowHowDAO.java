package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.AmuletKnowhowEntity;
import com.valhalla.amulet.entity.MemberEntity;
import com.valhalla.amulet.entity.UserEntity;
import org.hibernate.*;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import java.util.List;

public class KnowHowDAO
{
    private static KnowHowDAO userDAO;
    public static KnowHowDAO getInstance() {
        if (userDAO == null) userDAO = new KnowHowDAO();
        return userDAO;
    }


    public boolean addOrUpdateKnowHow(AmuletKnowhowEntity entity)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        session.saveOrUpdate(entity);
        session.getTransaction().commit();
        session.flush();
        session.close();
        ConnectionManager.close();
        return true;
    }

    public boolean updateExistingMember(UserEntity user, MemberEntity memberEntity)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        user.setUserId(memberEntity.getMemberId());
        session.update(user);
        session.flush();
        session.update(memberEntity);
        session.getTransaction().commit();
        session.close();
        ConnectionManager.close();
        return true;
    }

    public void deleteKnowHow(int knowhowId) {
        Session session = ConnectionManager.getSession();
        Transaction tx = session.beginTransaction();

        AmuletKnowhowEntity entity = new AmuletKnowhowEntity();
        entity.setKhId(knowhowId);


        Criteria criteria = session.createCriteria(AmuletKnowhowEntity.class);
        criteria.add(Restrictions.eq("khId", knowhowId));
        List<AmuletKnowhowEntity> khResult = criteria.list();
        session.delete(khResult.get(0));
        tx.commit();
        session.close();
        ConnectionManager.close();
    }

    public boolean checkMemberExist(String mobileNo) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(MemberEntity.class);
        criteria.add(Restrictions.eq("phoneNo2", mobileNo));
        List<MemberEntity> memberEntities = criteria.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.close();
        ConnectionManager.close();
        if (memberEntities != null && memberEntities.size() > 0) {
            return true;
        }
        return false;
    }

    public AmuletKnowhowEntity getKnowhowInfo(String knowhowId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(AmuletKnowhowEntity.class);
        criteria.add(Restrictions.eq("khId", Integer.parseInt(knowhowId)));
        List<AmuletKnowhowEntity> entities = criteria.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.close();
        ConnectionManager.close();
        if (entities != null && entities.size() > 0) {
            return entities.get(0);
        }
        return null;
    }

    public void increaseViewCount(String khId) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        String hql = "UPDATE AmuletKnowhowEntity set viewCnt = viewCnt + 1  WHERE khId = :khId";
        Query query = session.createQuery(hql);
        query.setParameter("khId", Integer.valueOf(khId));
        query.executeUpdate();
        session.getTransaction().commit();
        ConnectionManager.close();
    }

    public List<AmuletKnowhowEntity> getKnowHowList() {

        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(AmuletKnowhowEntity.class);
        criteria.setFetchSize(4);
        criteria.setMaxResults(4);

        Order order;
        order = Order.asc("khId");
        criteria.addOrder(order);

        List<AmuletKnowhowEntity> knowhowEntities = criteria.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.close();
        ConnectionManager.close();
        if (knowhowEntities != null && knowhowEntities.size() > 0) {
            return knowhowEntities;
        }
        return null;
    }
}
