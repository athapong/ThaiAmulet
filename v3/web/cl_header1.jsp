<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" session="true" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
</head>
<body>
<table width="1070px" border="0">
    <tr>
         <td class="header_l">
             <% if (session.getAttribute("UserSession") == null) {%>
                <div class="logo" style="position: relative; top:-60px;"><img src="./resources/images/logo_l.png" onclick="window.open('index', '_self')"></div>
                  <div class="menu_small" style="position: relative; top: -90px; font-size: 1.25em; left:320px;">
                      <a href="./loginpage" class="small_text">เข้าสู่ระบบ</a>&nbsp;&nbsp;
                      <a href="./preregistpage" class="small_text">สมัครสมาชิก</a>&nbsp;&nbsp;
                  </div>
             <%} else {
                 UserBean userBean = (UserBean) session.getAttribute("UserSession");
             %>
                    <div class="logo" style="position: relative; top:-35px;"><img src="./resources/images/logo_l.png" onclick="window.open('index', '_self')"></div>
                    <div class="menu_small" style="position: relative; top: -70px; font-size: 1.25em; left:420px;">
                        <span id="logout" onclick="logout(this)" style="cursor:pointer">ออกจากระบบ</span><br/>
                        <span class="large_text"><%=userBean.getUsername()%></span>
                    </div>
             <%}%>
              <div class="gradSearchBtn" onclick="window.open('amuletpage', '_self')">ค้นหาพระเครื่อง</div>
          <div class="menu" style="position:relative; top:25px;">
              <table style="width:960px;">
                  <tr class="border_dotted" style="border: none;">
                      <%
                        if (request.getParameter("page") != null && request.getParameter("page").equals("index")) {
                      %>
                        <td class="menu_page_selected">หน้าแรก&nbsp;</td>
                      <%} else {%>
                          <td class="menu_page_unselected" onclick="window.open('index','_self')">หน้าแรก&nbsp;</td>
                      <%}%>

                      <%
                          if (request.getParameter("page") != null && request.getParameter("page").equals("register")) {
                      %>
                        <td class="menu_page_selected">&nbsp;สมัครสมาชิกใหม่&nbsp;</td>
                      <%} else {%>
                        <td class="menu_page_unselected" onclick="window.open('preregistpage','_self')">&nbsp;สมัครสมาชิกใหม่&nbsp;</td>
                      <%}%>

                      <%
                          if (request.getParameter("page") != null && request.getParameter("page").equals("policy")) {
                      %>
                        <td class="menu_page_selected">&nbsp;นโยบายของ web&nbsp;</td>
                      <%} else {%>
                        <td class="menu_page_unselected" onclick="window.open('policypage','_self')">&nbsp;นโยบายของ web&nbsp;</td>
                      <%}%>
                      <%
                          if (request.getParameter("page") != null && request.getParameter("page").equals("knowhow")) {
                      %>
                        <td class="menu_page_selected">&nbsp;ห้องสมุดพระเครื่อง&nbsp;</td>
                      <%} else {%>
                        <td class="menu_page_unselected" onclick="window.open('mgtkmservlet','_self')">&nbsp;ห้องสมุดพระเครื่อง&nbsp;</td>
                      <%}%>
                      <%
                          if (request.getParameter("page") != null && request.getParameter("page").equals("rule")) {
                      %>
                            <td class="menu_page_selected">&nbsp;กฎกติกามารยาท&nbsp;</td>
                      <%} else {%>
                            <td class="menu_page_unselected" onclick="window.open('rulepage','_self')">&nbsp;กฎกติกามารยาท&nbsp;</td>
                      <%}%>
                      <%
                          if (request.getParameter("page") != null && request.getParameter("page").equals("contactus")) {
                      %>
                            <td class="menu_page_selected">&nbsp;ติดต่อเรา&nbsp;</td>
                      <%} else {%>
                            <td class="menu_page_unselected" onclick="window.open('contuspage','_self')">&nbsp;ติดต่อเรา&nbsp;</td>
                      <%}%>
                  </tr>
              </table>
          </div>

      </td>
      <td width="56px" style="vertical-align: top"><div><img src="./resources/images/top_r.png"></div></td>
    </tr>
</table>
</body>
</html>