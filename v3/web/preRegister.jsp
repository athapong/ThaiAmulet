<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="resources/checkid.js"></script>
    <title>สมัครสมาชิกใหม่</title>
</head>

<body>
    <table style="vertical-align: top; width: 100%;">
        <tr>
            <td class="menu_left_header" style="text-align: center;">สมัครสมาชิก</td>
        </tr>
        <tr>
            <td class="menu_dot">&nbsp;</td>
        </tr>
        <%
            ServletContext context = session.getServletContext();
            String realContextPath = context.getRealPath(request.getContextPath());
            String agreement = realContextPath+"/resources/config/agreement.conf";
            BufferedReader reader = new BufferedReader(new FileReader(agreement));
            StringBuilder sb = new StringBuilder();
            String line;
            while((line = reader.readLine())!= null){
                sb.append(line+"\n");
            }
        %>
        <tr>
            <td style="vertical-align: top;">
                <textarea class="textarea1" rows="18" readonly><%out.print(sb.toString());%></textarea>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr style="text-align: center">
            <td><input type="button" id="accept" class="button" value="     ยอมรับเงื่อนไข     " onclick="window.open('registpage','_self')">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" class="button" value="     ยกเลิก     " onclick="window.open('index','_self')">
            </td>
        </tr>
    </table>
</body>
</html>