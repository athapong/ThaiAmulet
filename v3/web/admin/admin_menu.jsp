<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%
    if (!AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession"))) {
            request.getRequestDispatcher("unauthorized").forward(request, response);
    }
    // if session is valid
    //UserBean bean = null;
    if (request.getSession().getAttribute("admin_session") == null) {
        response.sendRedirect("admin");
    }
//    else {
//        bean = (UserBean) request.getSession().getAttribute("admin_session");
//    }
    String tab = request.getParameter("tab");
%>
<tr>
    <td class="menu_left_header" style="text-align: left;"><img src="./resources/images/logo.png"/></td>
    <td nowrap class="normal_text2" style="vertical-align: top; text-align:right;">
        <span id="logout" onclick="logout(this)" style="cursor:pointer">ออกจากระบบ</span><br/>
        <span class="large_text">Administrator</span>
    </td>
</tr>
<tr>
    <td colspan="2">
        <div class="menu" style="padding-left:0px;">
            <table style="padding-left:0px; width:100%;" cellspacing="0px">
                <tr class="border_dotted" style="border: none;">
                    <% if (tab.equals("1")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">หน้าแรก</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('admindexpage','_self')">หน้าแรก</td>
                    <% } %>
                    <% if (tab.equals("2")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">รายการข้อมูลผู้ใช้</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('custinqservlet?go=#','_self')">รายการข้อมูลผู้ใช้</td>
                    <% } %>
                    <% if (tab.equals("3")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">รายการข่าวสาร web</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('newsinqservlet','_self')">รายการข่าวสาร web</td>
                    <% } %>
                    <% if (tab.equals("4")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">รายการพระเครื่อง</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('amuletinqservlet','_self')">รายการพระเครื่อง</td>
                    <% } %>
                    <td class="menu_page_unselected" style="text-align: center; padding-right:0px;">&nbsp;</td>
                </tr>
            </table>
        </div>

    </td>
</tr>
<%--2--%>
<% if (tab.equals("1")) {%>
<tr style="text-align: center;">
    <td colspan="2">&nbsp;</td>
</tr>
<% } %>
<tr>
    <td class="menu_left" colspan="2">&nbsp;</td>
</tr>