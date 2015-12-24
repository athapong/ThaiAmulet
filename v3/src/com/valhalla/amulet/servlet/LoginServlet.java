/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;


import com.valhalla.amulet.bean.*;
import com.valhalla.amulet.*;
import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.constants.AmuletConstants;
import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {

    int COOKIE_AGE = 2592000;
    public static String COOKIE_NAME = "REMEMBER_COOKIE_AMULET";

    UserBean loginCookie(HttpServletRequest request, HttpServletResponse response) throws IOException{
        // check user in Coookie start
        UserBean user = (UserBean) request.getSession().getAttribute("UserSession");
        HttpSession session = request.getSession(true);
        if (user == null) {
            String uuid = getCookieValue(request, COOKIE_NAME);
            if (uuid != null) {
                user = UserDAO.getInstance().loginCookie(uuid);
                if (user != null) {
                    addCookie(response, COOKIE_NAME, uuid, COOKIE_AGE); // Extends age.
                    return user;
                } else {
                    removeCookie(response, COOKIE_NAME);
                    return null;
                }
            }
        }
        return user;
        // check user in Coookie end
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        try {
            UserBean user = null;
            if (request.getParameter("usernameTxt") == null || request.getParameter("usernameTxt").equals("")) {
                user = loginCookie(request, response);
            }

            if (user == null) {
                user = new UserBean();
                user.setUserName(request.getParameter("usernameTxt"));
                user.setPassword(request.getParameter("passwordTxt"));
                boolean remember = "true".equals(request.getParameter("remember"));
                user = UserDAO.getInstance().login(user);

                // remember me begin
                if (remember) {
                    String uuid = UUID.randomUUID().toString();
                    UserDAO.getInstance().setRememberMe(user, uuid);
                    addCookie(response, COOKIE_NAME, uuid, COOKIE_AGE);
                } else {
                    UserDAO.getInstance().setRememberMe(user, "");
                    removeCookie(response, COOKIE_NAME);
                }
                // remember me end
            }

            if (user.isValid()) {
                // get member info
                HashMap members = getMemberInfo(user.getMemberId()).get(0);
                boolean pmtFlag = members.get("PMT_STATUS") == null ? false : ((BigInteger) members.get("PMT_STATUS")).intValue() == 1 ? true : false;
                user.setPmtFlag(pmtFlag);
                if (user.isAdmin()) {
                    session.setAttribute("admin_session",user);
                    session.setAttribute("UserSession", user);
                    if (user.getRole().equals(AmuletConstants.ADMIN_TYPE)) {
                        response.sendRedirect("admindexpage"); //logged-in page
                    } else if (user.getRole().equals(AmuletConstants.EXCV_TYPE)) {
                        response.sendRedirect("exindex"); //logged-in page
                    }
                } else {
                    session.setAttribute("UserSession", user);
                    response.sendRedirect("index"); //logged-in page
                }
            } else {
                response.sendRedirect("logon_failed"); //error page
            }
        } catch (Throwable theException) {
            System.out.println(theException);
        }
    }

    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setPath("/");
        cookie.setMaxAge(maxAge);
        response.addCookie(cookie);
    }

    public static void removeCookie(HttpServletResponse response, String name) {
        addCookie(response, name, null, 0);
    }

    public List<HashMap> getMemberInfo(String member_id) throws ServletException, IOException {
        String query = "SELECT MEMBER_ID, FNAME, LNAME, USER_NAME, USER.ROLE_CODE, ROLE_NAME, EMAIL, ID_CARD, ID4SCAN, PHONE_NO2, SEX, BIRTH_DATE, ID_CARD_PIC, ID_HOME_PIC, PASSWORD, PMT_DATE, DATE_ADD(PMT_DATE, INTERVAL 1 YEAR) >= curdate()  AS PMT_STATUS FROM USER, MEMBER, ROLE" +
                " WHERE USER.USER_ID = MEMBER.MEMBER_ID and USER.ROLE_CODE = ROLE.ROLE_CODE and MEMBER.MEMBER_ID="+member_id;
        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<HashMap> entities = sqlQuery.list();
        return entities;
    }
}