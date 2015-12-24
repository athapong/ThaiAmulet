/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.mysql.jdbc.StringUtils;
import com.valhalla.amulet.UserDAO;
import com.valhalla.amulet.bean.AdminManageUserBean;
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
public class CustomerInquiryServlet extends HttpServlet {


    public void init( ){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // if delete user member id is present
        if (!StringUtils.isNullOrEmpty(request.getParameter("deleteMember"))) {
            int member_id = Integer.valueOf(request.getParameter("deleteMember"));
            UserDAO.getInstance().deleteMember(member_id);
            request.getSession().setAttribute("deleteMember","success");
        }

        String whereCond = " WHERE USER.USER_ID = MEMBER.MEMBER_ID and USER.ROLE_CODE = ROLE.ROLE_CODE and";
        String totalResultSql = "SELECT COUNT(MEMBER_ID) TOTAL_ROWS FROM USER, MEMBER, ROLE ";
        if (!StringUtils.isNullOrEmpty(request.getParameter("firstname"))) {
            whereCond += " fname like '%"+ request.getParameter("firstname") +"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("lastname"))) {
            whereCond += " lname like '%"+ request.getParameter("lastname")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("username"))) {
            whereCond += " user_name like '%"+ request.getParameter("username")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("email"))) {
            whereCond += " email like '%"+ request.getParameter("email")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("idcardno"))) {
            whereCond += " id_card like '%"+ request.getParameter("idcardno")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("phoneno"))) {
            whereCond += " phone_no2 like '%"+ request.getParameter("phoneno")+"%'";
        }
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "and");
        totalResultSql = totalResultSql + whereCond;
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page").equals("0") ? "1" : request.getParameter("page");
        }
        List<Object[]> entities = searchMember(request, response, currentPage);
        if (entities.size() > 0) {
            request.getSession().setAttribute("cust_inq_result", entities);
        } else {
            if (Integer.valueOf(currentPage) > 1) {
                currentPage = String.valueOf(Integer.parseInt(currentPage) - 1);
                entities = searchMember(request, response, currentPage);
                if (entities.size() == 0) {
                    request.getSession().removeAttribute("cust_inq_result");
                } else {
                    request.getSession().setAttribute("cust_inq_result", entities);
                }
            } else {
                request.getSession().removeAttribute("cust_inq_result");
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
        dispatch(request, response, "/mgtuserpage");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startFrom = "0";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            startFrom = String.valueOf((Integer.parseInt(request.getParameter("page")) * 8) - 8);
        }
        String query = "SELECT MEMBER_ID, FNAME, LNAME, USER_NAME, USER.ROLE_CODE, ROLE_NAME, EMAIL, ID_CARD, PHONE_NO2 FROM USER, MEMBER, ROLE" +
                " WHERE USER.USER_ID = MEMBER.MEMBER_ID and USER.ROLE_CODE = ROLE.ROLE_CODE limit "+ startFrom +",8";

        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        if (entities.size() > 0) {
            request.getSession().setAttribute("cust_inq_result", entities);
        } else {
            request.getSession().removeAttribute("cust_inq_result");
        }
        session.flush();


        // get total result
        String currentPage = "1";
        if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
            currentPage = request.getParameter("page");
        }
        String totalResultSql = "SELECT COUNT(MEMBER_ID) TOTAL_ROWS FROM MEMBER";
        sqlQuery = session.createSQLQuery(totalResultSql);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        entities = sqlQuery.list();

        List<HashMap> totalRows = (List) entities;
        int rows = Integer.valueOf(totalRows.get(0).get("TOTAL_ROWS").toString());
        savePageSession(request, AmuletUtils.calTotalPage(rows), currentPage);

        session.close();
        response.sendRedirect("mgtuserpage");
    }

    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    private void savePageSession(HttpServletRequest request, int pageCount, String currentPage) {
        AdminManageUserBean formBean = new AdminManageUserBean();
        formBean.setFname(AmuletUtils.nullToEmptyStr(request.getParameter("firstname")));
        formBean.setLname(AmuletUtils.nullToEmptyStr(request.getParameter("lastname")));
        formBean.setUsername(AmuletUtils.nullToEmptyStr(request.getParameter("username")));
        formBean.setEmail(AmuletUtils.nullToEmptyStr(request.getParameter("email")));
        formBean.setIdCardNo(AmuletUtils.nullToEmptyStr(request.getParameter("idcardno")));
        formBean.setMobileNo(AmuletUtils.nullToEmptyStr(request.getParameter("phoneno")));
        formBean.setPageCount(new Integer(pageCount));
        formBean.setCurrentPage(new Integer(currentPage));
        request.getSession().setAttribute("admin_manage_user_form_bean", formBean);
    }

    private List<Object[]> searchMember(HttpServletRequest request, HttpServletResponse response, String currentPage) {

        String query = "SELECT MEMBER_ID, FNAME, LNAME, USER_NAME, USER.ROLE_CODE, ROLE_NAME, EMAIL, ID_CARD, PHONE_NO2 FROM USER, MEMBER, ROLE";
        String whereCond = " WHERE USER.USER_ID = MEMBER.MEMBER_ID and USER.ROLE_CODE = ROLE.ROLE_CODE and";
        if (!StringUtils.isNullOrEmpty(request.getParameter("firstname"))) {
            whereCond += " fname like '%"+ request.getParameter("firstname") +"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("lastname"))) {
            whereCond += " lname like '%"+ request.getParameter("lastname")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("username"))) {
            whereCond += " user_name like '%"+ request.getParameter("username")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("email"))) {
            whereCond += " email like '%"+ request.getParameter("email")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("idcardno"))) {
            whereCond += " id_card like '%"+ request.getParameter("idcardno")+"%' and";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("phoneno"))) {
            whereCond += " PHONE_NO2 like '%"+ request.getParameter("phoneno")+"%'";
        }
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "and");
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