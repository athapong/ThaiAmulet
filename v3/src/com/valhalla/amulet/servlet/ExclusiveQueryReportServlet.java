/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.mysql.jdbc.StringUtils;
import com.valhalla.amulet.bean.ExQueryReportBean;
import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.utils.AmuletUtils;
import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

/**
 * Servlet implementation class ExclusiveQueryReportServlet
 */
public class ExclusiveQueryReportServlet extends HttpServlet {

    public void init( ){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String whereCond = " WHERE ";
        String totalResultSql = "SELECT USER_NAME, COUNT(USER_NAME) TOTAL_ROWS FROM " +
                " SEARCH_STATISTIC JOIN MEMBER ON MEMBER.MEMBER_ID = SEARCH_STATISTIC.MEMBER_ID " +
                " JOIN USER ON USER.USER_ID = MEMBER.MEMBER_ID ";
        String groupBy = " GROUP BY USER_NAME LIMIT 0,8";
        if (!StringUtils.isNullOrEmpty(request.getParameter("fname"))) {
            whereCond += " FNAME like '%"+ request.getParameter("fname") +"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("lname"))) {
            whereCond += " LNAME like '%"+ request.getParameter("lname")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("username"))) {
            whereCond += " USER_NAME like '%"+ request.getParameter("username")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("email"))) {
            whereCond += " EMAIL like '%"+ request.getParameter("email")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("idCardNo"))) {
            whereCond += " ID_CARD like '%"+ request.getParameter("idCardNo")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("id4scan"))) {
            whereCond += " ID4SCAN like '%"+ request.getParameter("id4scan")+"%' AND";
        }
        try {
            if (!StringUtils.isNullOrEmpty(request.getParameter("dateStart"))) {
                whereCond += " SEARCH_DATE >= FROM_UNIXTIME("+ AmuletUtils.strToTimestampMin(request.getParameter("dateStart")) + "/1000) AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("dateEnd"))) {
                whereCond += " SEARCH_DATE <= FROM_UNIXTIME("+ AmuletUtils.strToTimestampMax(request.getParameter("dateEnd")) + "/1000)";
            }
        } catch(Exception ex) {
            // do nothing
        }


        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "AND");
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, " WHERE ");
        totalResultSql = totalResultSql.concat(whereCond).concat(groupBy);
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page").equals("0") ? "1" : request.getParameter("page");
        }
        List<Object[]> entities = searchQueryReport(request, response, currentPage);
        if (entities.size() > 0) {
            request.getSession().setAttribute("query_report_result", entities);
        } else {
            if (Integer.valueOf(currentPage) > 1) {
                currentPage = String.valueOf(Integer.parseInt(currentPage) - 1);
                entities = searchQueryReport(request, response, currentPage);
                if (entities.size() == 0) {
                    request.getSession().removeAttribute("query_report_result");
                } else {
                    request.getSession().setAttribute("query_report_result", entities);
                }
            } else {
                request.getSession().removeAttribute("query_report_result");
            }
        }


        // get total result
        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(totalResultSql);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        entities = sqlQuery.list();

        List<HashMap> totalRows = (List) entities;
        int rows = 0;
        if (totalRows.size() > 0) rows = Integer.valueOf(totalRows.get(0).get("TOTAL_ROWS").toString());
        savePageSession(request, AmuletUtils.calTotalPage(rows), currentPage);
        session.close();
        response.sendRedirect("qryrptpage");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startFrom = "0";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            startFrom = String.valueOf((Integer.parseInt(request.getParameter("page")) * 8) - 8);
        }
        String query = "SELECT FNAME, LNAME, USER_NAME, EMAIL, ID_CARD, ID4SCAN, COUNT(USER_NAME) SEARCH_CNT FROM " +
                " SEARCH_STATISTIC JOIN MEMBER ON MEMBER.MEMBER_ID = SEARCH_STATISTIC.MEMBER_ID " +
                " JOIN USER ON USER.USER_ID = MEMBER.MEMBER_ID GROUP BY USER_NAME limit "+ startFrom +",8";

        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        if (entities.size() > 0) {
            request.getSession().setAttribute("query_report_result", entities);
        } else {
            request.getSession().removeAttribute("query_report_result");
        }
        session.flush();


        // get total result
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page");
        }
        String totalResultSql = "SELECT COUNT(USER_NAME) TOTAL_ROWS FROM " +
                " SEARCH_STATISTIC JOIN MEMBER ON MEMBER.MEMBER_ID = SEARCH_STATISTIC.MEMBER_ID " +
                " JOIN USER ON USER.USER_ID = MEMBER.MEMBER_ID GROUP BY USER_NAME";

        sqlQuery = session.createSQLQuery(totalResultSql);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        entities = sqlQuery.list();

        List<HashMap> totalRows = (List) entities;
        int rows = totalRows.size();
        savePageSession(request, AmuletUtils.calTotalPage(rows), currentPage);

        session.close();
        response.sendRedirect("qryrptpage");
    }

    private void savePageSession(HttpServletRequest request, int pageCount, String currentPage) {
        ExQueryReportBean formBean = new ExQueryReportBean();
        formBean.setFname(AmuletUtils.nullToEmptyStr(request.getParameter("fname")));
        formBean.setLname(AmuletUtils.nullToEmptyStr(request.getParameter("lname")));
        formBean.setUserName(AmuletUtils.nullToEmptyStr(request.getParameter("username")));
        formBean.setEmail(AmuletUtils.nullToEmptyStr(request.getParameter("email")));
        formBean.setIdCardNo(AmuletUtils.nullToEmptyStr(request.getParameter("idCardNo")));
        formBean.setId4Scan(AmuletUtils.nullToEmptyStr(request.getParameter("id4scan")));
        formBean.setDateStart(AmuletUtils.nullToEmptyStr(request.getParameter("dateStart")));
        formBean.setDateEnd(AmuletUtils.nullToEmptyStr(request.getParameter("dateEnd")));
        formBean.setPageCount(new Integer(pageCount));
        formBean.setCurrentPage(new Integer(currentPage));
        request.getSession().setAttribute("ex_query_report_form_bean", formBean);
    }

    private List<Object[]> searchQueryReport(HttpServletRequest request, HttpServletResponse response, String currentPage) {
        String query = "SELECT FNAME, LNAME, USER_NAME, EMAIL, ID_CARD, ID4SCAN, COUNT(USER_NAME) SEARCH_CNT FROM " +
                        " SEARCH_STATISTIC JOIN MEMBER ON MEMBER.MEMBER_ID = SEARCH_STATISTIC.MEMBER_ID " +
                        " JOIN USER ON USER.USER_ID = MEMBER.MEMBER_ID ";
        String groupBy = " GROUP BY USER_NAME";
        String whereCond = " WHERE ";
        if (!StringUtils.isNullOrEmpty(request.getParameter("fname"))) {
            whereCond += " FNAME like '%"+ request.getParameter("fname") +"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("lname"))) {
            whereCond += " LNAME like '%"+ request.getParameter("lname")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("username"))) {
            whereCond += " USER_NAME like '%"+ request.getParameter("username")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("email"))) {
            whereCond += " EMAIL like '%"+ request.getParameter("email")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("idCardNo"))) {
            whereCond += " ID_CARD like '%"+ request.getParameter("idCardNo")+"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("id4scan"))) {
            whereCond += " ID4SCAN like '%"+ request.getParameter("id4scan")+"%'";
        }
        try {
            if (!StringUtils.isNullOrEmpty(request.getParameter("dateStart"))) {
                whereCond += " SEARCH_DATE >= FROM_UNIXTIME("+ AmuletUtils.strToTimestampMin(request.getParameter("dateStart")) + "/1000) AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("dateEnd"))) {
                whereCond += " SEARCH_DATE <= FROM_UNIXTIME("+ AmuletUtils.strToTimestampMax(request.getParameter("dateEnd")) + "/1000)";
            }
        } catch(Exception ex) {
            // do nothing
        }
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "AND");
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, " WHERE ");
        query = query.concat(whereCond).concat(groupBy);
        String startFrom = "0";
        startFrom = String.valueOf((Integer.parseInt(currentPage) * 8) - 8);
        query += " limit "+ startFrom +",8";

        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        session.flush();
        return entities;
    }
}