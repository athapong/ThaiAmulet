/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.mysql.jdbc.StringUtils;
import com.valhalla.amulet.AmuletMasterDAO;
import com.valhalla.amulet.bean.AmuletMasterInquiryBean;
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
public class AmuletMasterInquiryServlet extends HttpServlet {


    public void init( ){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // if delete amulet id is present
        if (!StringUtils.isNullOrEmpty(request.getParameter("deleteAmulet"))) {
            int amulet_id = Integer.valueOf(request.getParameter("deleteAmulet"));
            AmuletMasterDAO.getInstance().deleteAmulet(amulet_id);
            request.getSession().setAttribute("deleteAmulet","success");
        }

        String whereCond = "";
        String totalResultSql = "SELECT COUNT(AMULET_CODE) TOTAL_ROWS FROM AMULET_MASTER ";
        if (!StringUtils.isNullOrEmpty(request.getParameter("amuletName"))) {
            whereCond += " WHERE AMULET_NAME like '%"+ request.getParameter("amuletName") +"%'";
        }

        totalResultSql = totalResultSql + whereCond;
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page").equals("0") ? "1" : request.getParameter("page");
        }
        List<Object[]> entities = searchAmuletMaster(request, response, currentPage);
        if (entities.size() > 0) {
            request.getSession().setAttribute("amulet_master_inq_result", entities);
        } else {
            if (Integer.valueOf(currentPage) > 1) {
                currentPage = String.valueOf(Integer.parseInt(currentPage) - 1);
                entities = searchAmuletMaster(request, response, currentPage);
                if (entities.size() == 0) {
                    request.getSession().removeAttribute("amulet_master_inq_result");
                } else {
                    request.getSession().setAttribute("amulet_master_inq_result", entities);
                }
            } else {
                request.getSession().removeAttribute("amulet_master_inq_result");
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
        dispatch(request, response, "/amuletsrchresultpage");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startFrom = "0";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            startFrom = String.valueOf((Integer.parseInt(request.getParameter("page")) * 8) - 8);
        }
        String query = "SELECT AMULET_CODE, AMULET_NAME FROM AMULET_MASTER " +
                " limit "+ startFrom +",8";

        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        if (entities.size() > 0) {
            request.getSession().setAttribute("amulet_master_inq_result", entities);
        } else {
            request.getSession().removeAttribute("amulet_master_inq_result");
        }
        session.flush();


        // get total result
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page");
        }
        String totalResultSql = "SELECT COUNT(AMULET_CODE) TOTAL_ROWS FROM AMULET_MASTER";
        sqlQuery = session.createSQLQuery(totalResultSql);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        entities = sqlQuery.list();

        List<HashMap> totalRows = (List) entities;
        int rows = Integer.valueOf(totalRows.get(0).get("TOTAL_ROWS").toString());
        savePageSession(request, AmuletUtils.calTotalPage(rows), currentPage);

        session.close();
        response.sendRedirect("amuletsrchresultpage");
    }

    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    private void savePageSession(HttpServletRequest request, int pageCount, String currentPage) {
        AmuletMasterInquiryBean formBean = new AmuletMasterInquiryBean();
        formBean.setAmuletCode(AmuletUtils.nullToEmptyStr(request.getParameter("amuletCode")));
        formBean.setAmuletName(AmuletUtils.nullToEmptyStr(request.getParameter("amuletName")));
        formBean.setPageCount(new Integer(pageCount));
        formBean.setCurrentPage(new Integer(currentPage));
        request.getSession().setAttribute("amulet_master_inquiry_form_bean", formBean);
    }

    private List<Object[]> searchAmuletMaster(HttpServletRequest request, HttpServletResponse response, String currentPage) {

        String query = "SELECT AMULET_CODE, AMULET_NAME FROM AMULET_MASTER";
        String whereCond = "";
        if (!StringUtils.isNullOrEmpty(request.getParameter("amuletName"))) {
            whereCond += " WHERE AMULET_NAME like '%"+ request.getParameter("amuletName") +"%'";
        }

        query = query + whereCond;
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