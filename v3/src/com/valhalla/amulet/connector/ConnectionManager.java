package com.valhalla.amulet.connector;

/**
 * Created by athapong on 2/28/2015 AD.
 */
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class ConnectionManager {

    private static SessionFactory sessionFactory;
    private static ServiceRegistry serviceRegistry;
    private static Session session = null;
    private final static Logger logger = LogManager.getLogger(ConnectionManager.class);
    private static void configureSessionFactory() {
        Configuration configuration = new Configuration();
        configuration.configure();
        serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()). buildServiceRegistry();
        sessionFactory = configuration.buildSessionFactory(serviceRegistry);
        logger.info(">> Finish configureSessionFactory(), sessionFactory="+sessionFactory.toString());
    }

    public static Session getSession() {
        if (sessionFactory == null) {
            configureSessionFactory();
        }
        try {
            logger.info(">> ConnectionManager.getSession()");
            session = sessionFactory.getCurrentSession();
        } catch (HibernateException he) {
            logger.info(">> ConnectionManager.getSession():"+ he.getMessage());
            session = sessionFactory.openSession();
            logger.warn(">> ConnectionManager - openSession()");
        }
        return session;
    }

    public static void close() {
        try {
            if (session != null && session.isOpen()) {
                session.close();
                session = null;
                logger.info(">> ConnectionManager - closeSession()");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.warn(">> ConnectionManager - exception:"+ex.getMessage());
        }

    }

}
