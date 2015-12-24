/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.mysql.jdbc.StringUtils;
import com.valhalla.amulet.KnowHowDAO;
import com.valhalla.amulet.bean.AdminManageKnowHowBean;
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
public class ExclusiveKnowHowInquiryServlet extends HttpServlet {


    public void init( ){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // if drop down list changes
        if (request.getParameter("isdropdownchange") != null && request.getParameter("isdropdownchange").equals("Y")) {
            AdminManageKnowHowBean formBean = null;
            if (request.getSession().getAttribute("ex_manage_knowhow_form_bean") != null) {
                formBean = (AdminManageKnowHowBean) request.getSession().getAttribute("ex_manage_knowhow_form_bean");
            } else {
                formBean = new AdminManageKnowHowBean();
            }
            formBean.setRegion(AmuletUtils.nullToEmptyStr(request.getParameter("region")));
            formBean.setProvince(AmuletUtils.nullToEmptyStr(request.getParameter("province")));
            formBean.setMatType1(AmuletUtils.nullToEmptyStr(request.getParameter("matType1")));
            formBean.setMatType2(AmuletUtils.nullToEmptyStr(request.getParameter("matType2")));
            request.getSession().setAttribute("ex_manage_knowhow_form_bean", formBean);
        } else {
            // if delete know how id is present
            if (!StringUtils.isNullOrEmpty(request.getParameter("deleteknowhow"))) {
                int knowhow_id = Integer.valueOf(request.getParameter("deleteknowhow"));
                KnowHowDAO.getInstance().deleteKnowHow(knowhow_id);
                request.getSession().setAttribute("deleteknowhow","success");
            }

            String whereCond = " WHERE ";
            String totalResultSql = "SELECT COUNT(KH_ID) TOTAL_ROWS FROM AMULET_KNOWHOW ";
            if (!StringUtils.isNullOrEmpty(request.getParameter("subject"))) {
                whereCond += " SUBJECT_NAME like '%"+ request.getParameter("subject") +"%' and";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("region"))) {
                whereCond += " REGION_CODE like '%"+ request.getParameter("region")+"%' and";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("province"))) {
                whereCond += " PROVINCE like '%"+ request.getParameter("province")+"%' and";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("matType1"))) {
                whereCond += " MAT_TYPE_1 like '%"+ request.getParameter("matType1")+"%' and";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("matType2"))) {
                whereCond += " MAT_TYPE_2 like '%"+ request.getParameter("matType2")+"%' and";
            }

            whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "and");
            totalResultSql = totalResultSql + whereCond;
            totalResultSql = org.apache.commons.lang.StringUtils.removeEnd(totalResultSql, " WHERE ");
            String currentPage = "1";
            if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
                currentPage = request.getParameter("page").equals("0") ? "1" : request.getParameter("page");
            }
            List<Object[]> entities = searchKnowHow(request, response, currentPage);
            if (entities.size() > 0) {
                request.getSession().setAttribute("knowhow_inq_result", entities);
            } else {
                if (Integer.valueOf(currentPage) > 1) {
                    currentPage = String.valueOf(Integer.parseInt(currentPage) - 1);
                    entities = searchKnowHow(request, response, currentPage);
                    if (entities.size() == 0) {
                        request.getSession().removeAttribute("knowhow_inq_result");
                    } else {
                        request.getSession().setAttribute("knowhow_inq_result", entities);
                    }
                } else {
                    request.getSession().removeAttribute("knowhow_inq_result");
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
        }

        if (request.getSession().getAttribute("admin_session") == null) {
            dispatch(request, response, "/lstkmpage");
        } else {
            if (AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
                dispatch(request, response, "/mgtkmpage");
            } else {
                dispatch(request, response, "/lstkmpage");
            }
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startFrom = "0";

        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            startFrom = String.valueOf((Integer.parseInt(request.getParameter("page")) * 8) - 8);
        }
        String query = "SELECT * FROM AMULET_KNOWHOW limit "+ startFrom +",8";

        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        if (entities.size() > 0) {
            request.getSession().setAttribute("knowhow_inq_result", entities);
        } else {
            request.getSession().removeAttribute("knowhow_inq_result");
        }
        session.flush();


        // get total result
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page");
        }
        String totalResultSql = "SELECT COUNT(KH_ID) TOTAL_ROWS FROM AMULET_KNOWHOW";
        sqlQuery = session.createSQLQuery(totalResultSql);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        entities = sqlQuery.list();

        List<HashMap> totalRows = (List) entities;
        int rows = Integer.valueOf(totalRows.get(0).get("TOTAL_ROWS").toString());
        savePageSession(request, AmuletUtils.calTotalPage(rows), currentPage);

        session.close();
        if (request.getSession().getAttribute("admin_session") == null) {
            dispatch(request, response, "/lstkmpage");
        } else {
            if (AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
                dispatch(request, response, "/mgtkmpage");
            } else {
                dispatch(request, response, "/lstkmpage");
            }
        }
    }

    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    private void savePageSession(HttpServletRequest request, int pageCount, String currentPage) {
        AdminManageKnowHowBean formBean = new AdminManageKnowHowBean();
        formBean.setSubject(AmuletUtils.nullToEmptyStr(request.getParameter("subject")));
        formBean.setRegion(AmuletUtils.nullToEmptyStr(request.getParameter("region")));
        formBean.setProvince(AmuletUtils.nullToEmptyStr(request.getParameter("province")));
        formBean.setMatType1(AmuletUtils.nullToEmptyStr(request.getParameter("matType1")));
        formBean.setMatType2(AmuletUtils.nullToEmptyStr(request.getParameter("matType2")));
        formBean.setPageCount(new Integer(pageCount));
        formBean.setCurrentPage(new Integer(currentPage));
        request.getSession().setAttribute("ex_manage_knowhow_form_bean", formBean);
    }

    private List<Object[]> searchKnowHow(HttpServletRequest request, HttpServletResponse response, String currentPage) {

        String query = "SELECT * FROM AMULET_KNOWHOW";
        String whereCond = " WHERE ";
        if (!StringUtils.isNullOrEmpty(request.getParameter("subject"))) {
            whereCond += " SUBJECT_NAME like '%"+ request.getParameter("subject") +"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("region"))) {
            whereCond += " REGION_CODE like '%"+ request.getParameter("region")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("province"))) {
            whereCond += " PROVINCE like '%"+ request.getParameter("province")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("matType1"))) {
            whereCond += " MAT_TYPE_1 like '%"+ request.getParameter("matType1")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("matType2"))) {
            whereCond += " MAT_TYPE_2 like '%"+ request.getParameter("matType2")+"%' and";
        }

        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "and");
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, " WHERE ");
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