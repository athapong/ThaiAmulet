
package com.valhalla.amulet.servlet;

import com.valhalla.amulet.connector.ConnectionManager;
import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class LoginServlet
 */
public class AdminPreviewUserServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String member_id = request.getParameter("memberId");
        String query = "SELECT MEMBER_ID, FNAME, LNAME, USER_NAME, USER.ROLE_CODE, ROLE_NAME, EMAIL, ID_CARD, ID4SCAN, PHONE_NO2, SEX, BIRTH_DATE, ID_CARD_PIC, ID_HOME_PIC, PASSWORD, PMT_DATE, DATE_ADD(PMT_DATE, INTERVAL 1 YEAR) >= curdate()  AS PMT_STATUS FROM USER, MEMBER, ROLE" +
                " WHERE USER.USER_ID = MEMBER.MEMBER_ID and USER.ROLE_CODE = ROLE.ROLE_CODE and MEMBER.MEMBER_ID="+member_id;


        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        if (entities.size() > 0) {
            request.getSession().setAttribute("preview_user_result", entities);
        } else {
            request.getSession().removeAttribute("preview_user_result");
        }
        session.flush();
        session.close();
        response.sendRedirect("./viewuserpage");

    }
}