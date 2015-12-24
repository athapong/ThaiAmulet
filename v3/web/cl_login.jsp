<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>คู่มือพระ.com :: เข้าสู่ระบบ</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>

<%
    if (request.getSession().getAttribute("UserSession") != null) {
        response.sendRedirect(AmuletUtils.pageFwdByRole((UserBean) request.getSession().getAttribute("UserSession")));
    }
%>
<form action="loginservlet" method="post">
    <body>
        <div class="loader"></div>
        <table>
            <tr>
                <td colspan="2"><jsp:include page="cl_header.jsp"/></td>
            </tr>
            <tr>
                <td style="width:20%; padding-right: 23px; vertical-align: top;"><jsp:include page="cl_menuleft.jsp"/></td>
                <td style="vertical-align: top;"><jsp:include page="cl_login.html"/></td>
            </tr>
            <tr>
                <td colspan="2"><jsp:include  page="/footer.jsp"/></td>
            </tr>
        </table>
    </body>
</form>
</html>