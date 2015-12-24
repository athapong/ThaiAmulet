<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.constants.AmuletConstants" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <title>ผู้ดูแลระบบ::จัดการข้อมูลผู้ใช้</title>
    <script>
    </script>
</head>
<body>
<form id="admin_add_user_success_form" action="" method="post">
    <%
        // if session is valid
        if (request.getSession().getAttribute("admin_session") == null) {
            request.getRequestDispatcher("admin").forward(request,response);
        }
        UserBean bean = null;
        if (request.getSession().getAttribute("admin_session") == null) {
            response.sendRedirect("admin");
        } else {
            bean = (UserBean) request.getSession().getAttribute("admin_session");
        }
    %>
    <table width="100%" border="0">
        <% if (bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {%>
        <jsp:include page="/admmenupage?tab=0"/>
        <% } else if (bean.getRole().equals(AmuletConstants.EXCV_TYPE)) {%>
        <jsp:include page="/ex_menu_top?tab=0"/>
        <% } else {%>
        <jsp:include page="/index"/>
        <% } %>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="2">ไม่มีบริการ</td>
        </tr>
        <tr class="menu_dot">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" colspan="4" style="text-align:center;"><i class="fa fa-times-circle-o fa-6x" style="color:#ff1d25;"></i></td>
                    </tr>
                    <tr>
                        <td class="caption" colspan="4" style="text-align:center;"><span style="font-size: 3em; color: #ff1d25;">ไม่พบหน้าจอที่ต้องการ</span></td>
                    </tr>
                    <tr>
                        <td style="width:30%;text-align: center; font-size: large; color: #f2f2f2;" class="text_header" colspan="4">กรุณาลองใหม่อีกครั้ง</td>
                    </tr>
                    <tr>
                        <td style="width:30%;text-align: center; font-size: x-large" class="text_header" colspan="4">
                            <span class="button" style="width: 10%; display: block; text-align: center; position: absolute; left:45%;" onclick="history.go(-1)">กลับ</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="/footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
</html>