<%@ page import="com.valhalla.amulet.servlet.LoginServlet" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <script src="resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="resources/message.js"></script>
    <title>คู่มือพระ.com :: หน้าหลัก</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>
<body>
<%
    if (request.getSession().getAttribute("UserSession") == null && LoginServlet.getCookieValue(request, LoginServlet.COOKIE_NAME) != null) {
        response.sendRedirect("/loginservlet");
    }
%>
<div class="loader"></div>
<form name="indexForm">
    <table>
        <tr>
            <td colspan="2"><jsp:include page="/cl_header.jsp?page=index"/></td>
        </tr>
        <tr>
            <td style="width:200px; padding-right: 23px; vertical-align: top;"><jsp:include page="/cl_menuleft.jsp"/></td>
            <td class="content_txt"><jsp:include page="/index.jsp"/></td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include page="/footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
</html>