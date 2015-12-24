<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.entity.AmuletMasterEntity" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<html>
<head>
    <meta equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/message.js"></script>
    <title>Exclusive::ติดต่อเรา</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>
<body>
<div class="loader"></div>
<%--<form id="ex_add_amulet_form" action="ExDoAddAmuletServlet" method="post" enctype="multipart/form-data" acceptcharset="UTF-8">--%>
<form id="contact_us_form" action="#">
    <%
        if (!AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
            request.getRequestDispatcher("unauthorized").forward(request, response);
        }

//        AmuletMasterEntity amuletEntity = null;
//        if (request.getSession().getAttribute("amulet_entity") != null) {
//            amuletEntity = (AmuletMasterEntity) request.getSession().getAttribute("amulet_entity");
//        }
    %>
    <table width="100%" border="0">
        <jsp:include page="./exclusive/ex_menu.jsp?tab=8"/>


        <tr>
            <td class="content_txt" style="padding-left: 10%;"><jsp:include page="./contact_us.jsp"/></td>
        </tr>
        <tr>
            <td colspan="3"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
</html>