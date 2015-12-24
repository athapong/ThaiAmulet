package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.NewsEntity;
import org.hibernate.*;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import java.util.List;


public class NewsDAO
{
    private static NewsDAO newsDAO;
    public static NewsDAO getInstance() {
        try {
            if (newsDAO == null)
                newsDAO = new NewsDAO();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return newsDAO;
    }

    public boolean addNews(NewsEntity newsEntity)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        session.saveOrUpdate(newsEntity);
        session.flush();
        session.save(newsEntity);
        session.getTransaction().commit();
        session.close();
        ConnectionManager.close();
        return true;
    }


    public void deleteNews(int newsCode) {
        Session session = ConnectionManager.getSession();
        Transaction tx = session.beginTransaction();

        NewsEntity newsEntity = new NewsEntity();
        newsEntity.setNewsCode(newsCode);

        Criteria criteria = session.createCriteria(NewsEntity.class);
        criteria.add(Restrictions.eq("newsCode", newsCode));
        List<NewsEntity> newsResult = criteria.list();
        session.delete(newsResult.get(0));
        tx.commit();
        session.close();
        ConnectionManager.close();
    }

    public NewsEntity getNewsInfo(String newsCode) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(NewsEntity.class);
        criteria.add(Restrictions.eq("newsCode", Integer.parseInt(newsCode)));
        List<NewsEntity> newsEntities = criteria.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.close();
        ConnectionManager.close();
        if (newsEntities != null && newsEntities.size() > 0) {
            return newsEntities.get(0);
        }
        return null;
    }

    public void increaseViewCount(String newsCode) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        String hql = "UPDATE NewsEntity set viewCount = viewCount + 1  WHERE newsCode = :newsCode";
        Query query = session.createQuery(hql);
        query.setParameter("newsCode", Integer.valueOf(newsCode));
        query.executeUpdate();
        session.getTransaction().commit();
        ConnectionManager.close();
    }

    public List<NewsEntity> getNewsList() {

        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(NewsEntity.class);
        criteria.setFetchSize(4);
        criteria.setMaxResults(4);

        Order order;
        order = Order.asc("newsCode");
        criteria.addOrder(order);

        List<NewsEntity> newsEntities = criteria.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.close();
        ConnectionManager.close();
        if (newsEntities != null && newsEntities.size() > 0) {
            return newsEntities;
        }
        return null;
    }
}
