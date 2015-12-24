package com.valhalla.amulet;

import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.SearchStatisticEntity;
import org.hibernate.Session;

import java.sql.Timestamp;
import java.util.Calendar;

public class SearchStatisticDAO
{
    private static SearchStatisticDAO statDAO;
    public static SearchStatisticDAO getInstance() {
        if (statDAO == null) statDAO = new SearchStatisticDAO();
        return statDAO;
    }

    public void insertSearchStat(int memberId)  {
        SearchStatisticEntity stat = new SearchStatisticEntity();
        stat.setMemberId(memberId);

        Timestamp timestamp = new Timestamp(Calendar.getInstance().getTimeInMillis());
        stat.setSearchDate(timestamp);
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        session.save(stat);
        session.getTransaction().commit();
        session.close();
        ConnectionManager.close();
    }
}
