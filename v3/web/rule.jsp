<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <title>กฏกติกามารยาท</title>
</head>

<body>
<table style="border-spacing: 0px; width: 704px;">
    <table width="100%" border="0">
        <!-- begin search criteria -->
        <tr style="border-color: #dcac4e">
            <td colspan="2" style="text-align: center;">
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
    </table>
</table>
</body>
</html>