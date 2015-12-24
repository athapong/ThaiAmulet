/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.mysql.jdbc.StringUtils;
import com.valhalla.amulet.NewsDAO;
import com.valhalla.amulet.bean.AdminManageNewsBean;
import com.valhalla.amulet.bean.UserBean;
import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.utils.AmuletUtils;
import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

/**
 * Servlet implementation class CustomerInquiryServlet
 */
public class NewsInquiryServlet extends HttpServlet {


    public void init( ){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // if delete news id is present
        if (!StringUtils.isNullOrEmpty(request.getParameter("deleteNews"))) {
            int news_id = Integer.valueOf(request.getParameter("deleteNews"));
            NewsDAO.getInstance().deleteNews(news_id);
            request.getSession().setAttribute("deleteNews","success");
        }

        String totalResultSql = "SELECT COUNT(NEWS_CODE) TOTAL_ROWS FROM NEWS ";
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page");
        }
        List<Object[]> entities = searchNews(request, response, currentPage);
        if (entities.size() > 0) {
            request.getSession().setAttribute("news_inq_result", entities);
        } else {
            if (Integer.valueOf(currentPage) > 1) {
                currentPage = String.valueOf(Integer.parseInt(currentPage) - 1);
                entities = searchNews(request, response, currentPage);
                if (entities.size() == 0) {
                    request.getSession().removeAttribute("news_inq_result");
                } else {
                    request.getSession().setAttribute("news_inq_result", entities);
                }
            } else {
                request.getSession().removeAttribute("news_inq_result");
            }
        }


        // get total result
        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(totalResultSql);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        entities = sqlQuery.list();

        List<HashMap> totalRows = (List) entities;
        int rows = Integer.valueOf(totalRows.get(0).get("TOTAL_ROWS").toString());
        savePageSession(request, AmuletUtils.calTotalPage(rows), currentPage);
        session.close();
        UserBean bean = null;
        if (request.getSession().getAttribute("admin_session") == null) {
            dispatch(request, response, "/newspage");
        } else {
            dispatch(request, response, "/mgtnewspage");
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startFrom = "0";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            startFrom = String.valueOf((Integer.parseInt(request.getParameter("page")) * 8) - 8);
        }
        String query = "SELECT NEWS_CODE, NEWS_DATE, NEWS_CAT, NEWS_SUBJ, NEWS_DESC, VIEW_COUNT, NEWS_PIC FROM NEWS limit "+ startFrom +",8";

        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        if (entities.size() > 0) {
            request.getSession().setAttribute("news_inq_result", entities);
        } else {
            request.getSession().removeAttribute("news_inq_result");
        }
        session.flush();


        // get total result
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page");
        }
        String totalResultSql = "SELECT COUNT(NEWS_CODE) TOTAL_ROWS FROM NEWS";
        sqlQuery = session.createSQLQuery(totalResultSql);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        entities = sqlQuery.list();

        List<HashMap> totalRows = (List) entities;
        int rows = Integer.valueOf(totalRows.get(0).get("TOTAL_ROWS").toString());
        savePageSession(request, AmuletUtils.calTotalPage(rows), currentPage);

        session.close();
        UserBean bean = null;

        // clear selected news in session
        request.getSession().removeAttribute("news_entity");

        // forward to proper page
        if (request.getSession().getAttribute("admin_session") == null) {
            dispatch(request, response, "/newspage");
        } else {
            dispatch(request, response, "/mgtnewspage");
        }

    }

    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    private void savePageSession(HttpServletRequest request, int pageCount, String currentPage) {
        AdminManageNewsBean formBean = new AdminManageNewsBean();
        formBean.setPageCount(new Integer(pageCount));
        formBean.setCurrentPage(new Integer(currentPage));
        request.getSession().setAttribute("admin_manage_news_form_bean", formBean);
    }

    private List<Object[]> searchNews(HttpServletRequest request, HttpServletResponse response, String currentPage) {

        String query = "SELECT NEWS_CODE, NEWS_DATE, NEWS_CAT, NEWS_SUBJ, NEWS_DESC, VIEW_COUNT FROM NEWS ";
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