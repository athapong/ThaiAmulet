<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/checkid.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/message.js"></script>
    <title>คู่มือพระ.com :: ลืมรหัสผ่าน</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>

<%
    if ((UserBean) request.getSession().getAttribute("UserSession") != null) {
        request.getRequestDispatcher("index").forward(request, response);
    }
%>
<body>
<div class="loader"></div>
<form id="forgotPwdForm" action="./forgtpwdservlet">
    <table width="100%">
        <tr>
            <td colspan="2"><jsp:include page="cl_header.jsp?page="/></td>
        </tr>
        <tr>
            <td style="width:200px; padding-right: 80px; vertical-align: top;"><jsp:include page="cl_menuleft.jsp"/></td>
            <td style="vertical-align: top;"><jsp:include page="forgotpwd_fail.jsp"/></td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="/footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
</html>