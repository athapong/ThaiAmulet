<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>ผู้ดูแลระบบ::เมนู</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>

<body>
<div class="loader"></div>
<%
    if (!AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession"))) {
        request.getRequestDispatcher("unauthorized").forward(request, response);
    }
    // if session is valid
    UserBean bean = null;

    if (request.getSession().getAttribute("admin_session") == null) {
        response.sendRedirect("admin");
    } else {
        bean = (UserBean) request.getSession().getAttribute("admin_session");
    }
%>
<form id="menu_form">
    <table width="100%" border="0">
        <jsp:include page="./admin/admin_menu.jsp?tab=1"/>
        <tr style="text-align: center;">
            <td class="menu_left" style="text-align: center; padding-right: 5px;" colspan="2">
                <a href="custinqservlet?go=#"><img src="./resources/images/manage_user.png"/></a>
                &nbsp;&nbsp;
                <a href="newsinqservlet"><img src="./resources/images/manage_news.png"/></a>
                &nbsp;&nbsp;
                <a href="amuletinqservlet"><img src="./resources/images/ex_amulet_master.png" style="width: 228px;height:228px;"/></a>
            </td>
        </tr>
        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
</html>