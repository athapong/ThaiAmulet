/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet implementation class LogoutServlet
 */
public class LogoutServlet extends HttpServlet {


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        LoginServlet.removeCookie(response, LoginServlet.COOKIE_NAME);
        if (session.getAttribute("admin_session") != null) {
            session.removeAttribute("admin_session");
            session.removeAttribute("UserSession");
            response.sendRedirect("admin");
        } else if (session.getAttribute("UserSession") != null) {
            session.removeAttribute("UserSession");
            response.sendRedirect("index");
        }
    }
}