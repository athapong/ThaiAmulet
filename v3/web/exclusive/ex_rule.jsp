<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>กฎกติกามารยาท</title>
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
<form name="rule_form">
    <table width="100%" border="0">
        <jsp:include page="./exclusive/ex_menu.jsp?tab=6"/>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="3">กฎกติกามารยาท</td>
        </tr>
        <tr class="menu_dot">
            <td colspan="3" class="menu_dot">&nbsp;</td>
        </tr>
        <!-- begin search criteria -->
        <tr style="border-color: #dcac4e">
            <td colspan="3" style="text-align: center;">
                <img src="resources/images/policy_background.png"/>
            </td>
        </tr>
        <!-- end search criteria -->
        <!-- policy config from file -->
        <%
            ServletContext context = session.getServletContext();
            String realContextPath = context.getRealPath(request.getContextPath());
            String policy = realContextPath+"/resources/config/rule.conf";
            String policyTxt = AmuletUtils.getContent(policy);
        %>
        <tr>
            <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                <tr style="height: 10px;" class="content_txt">
                    <td colspan="2"><%=policyTxt%></td>
                </tr>
            </table>
        </tr>

        <tr>
            <td colspan="3"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    </form>
</body>
</html>