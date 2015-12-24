<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>Exclusive::เมนู</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>
<body>
<div class="loader"></div>
<%

    if (!AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
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
<form id="menu_form" name="exindex">
    <table width="100%" border="0">
        <jsp:include page="./exclusive/ex_menu.jsp?tab=1"/>
        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <tr style="text-align: center;">
            <td class="menu_left" style="text-align: right; width:50%">
                <a href="qryrptservlet?go=#"><img src="./resources/images/ex_use_info.png"/>&nbsp;&nbsp;&nbsp;</a>
                <a href="expolicypage"><img src="./resources/images/ex_policy.png"/>&nbsp;</a>
            </td>
            <td class="menu_left" style="text-align: left; width:50%">
                <a href="inqamuletpage"><img src="./resources/images/ex_amulet_master.png"/>&nbsp;&nbsp;&nbsp;</a>
                <a href="newsinqservlet"><img src="./resources/images/ex_news.png"/></a>
            </td>
        </tr>
        <tr style="text-align: center;">
            <td class="menu_left" style="text-align: right; width:50%;">
                <a href="exrulepage"><img src="./resources/images/ex_rule.png"/>&nbsp;&nbsp;&nbsp;</a>
                <a href="mgtkmservlet"><img src="./resources/images/ex_knowhow.png"/>&nbsp;</a>
            </td>
            <td class="menu_left" style="text-align: left; width:50%;">
                <a href="excontactuspage"><img src="./resources/images/ex_contactus.png"/>&nbsp;</a>
            </td>
            <td class="menu_left" style="text-align: left;">&nbsp;</td>
        </tr>
        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
</html>