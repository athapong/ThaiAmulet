<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigInteger" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>ผู้ดูแลระบบ::จัดการข้อมูลผู้ใช้</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>
<body>
<div class="loader"></div>

<form id="preview_user_form">
<%
    if (!AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession"))) {
        request.getRequestDispatcher("unauthorized").forward(request, response);
    }
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
    List<HashMap> userList = (List) request.getSession().getAttribute("preview_user_result");
    HashMap userInfo = userList.get(0);
%>
    <table width="100%" border="0">
        <jsp:include page="./admin/admin_menu.jsp?tab=2"/>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="2">ข้อมูลสมาชิก</td>
        </tr>
        <tr class="menu_dot">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>
        <tr style="border-color: #dcac4e">
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr style="border: 0px;">
                        <td style="width:100%;text-align: left;" class="text_header" colspan="6">ID No.&nbsp;<%=userInfo.get("MEMBER_ID")%></td>
                        <td style="text-align: right;" onclick="window.open('updateuserpage','_self')"><span class="button" style="width:10%;">&nbsp;&nbsp;&nbsp;แก้ไข&nbsp;&nbsp;&nbsp;</span></td>
                    </tr>
                    <tr style="border: 0px;">
                        <td style="width:100%;text-align: left; border-top: 1px dotted #dcac4e;" class="text_header" colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">1. ข้อมูลส่วนตัว</td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">2. username และ password</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อ นามสกุล</td>
                        <td class="content_txt_middle" style="width:30%;">
                            <%=(String)userInfo.get("FNAME")%>&nbsp;<%=(String)userInfo.get("LNAME")%>
                        </td>
                        <td class="caption" style="width: 10%;">username</td>
                        <td class="content_txt_middle" style="width:30%;">
                            <%=(String)userInfo.get("USER_NAME")%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption">เพศ</td>
                        <td class="content_txt_middle">
                            <%=((Character) userInfo.get("SEX") == 'F') ? "หญิง" : "ชาย"%>
                        </td>
                        <td class="caption">password</td>
                        <td class="content_txt_middle">******</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">วัน เดือน ปีเกิด</td>
                        <td class="content_txt_middle">
                            <% if (!new SimpleDateFormat("dd/MM/yyyy").format(userInfo.get("BIRTH_DATE")).equals("01/01/1900")) {%>
                                <%=new SimpleDateFormat("dd/MM/yyyy").format(userInfo.get("BIRTH_DATE"))%>
                            <% } %>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เลขบัตรประชาชน</td>
                        <td class="content_txt_middle">
                        <%=userInfo.get("ID_CARD")%>
                        </td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">3. ชำระค่าสมาชิกรายปี</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">รูปสำเนาบัตรประชาชน</td>
                        <td class="content_txt_middle">
                            <% if (userInfo.get("ID_CARD_PIC") != null) {%>
                            <a href="./<%=userInfo.get("ID_CARD_PIC")%>" download>ดาวน์โหลด</a>
                            <% } else {%>
                            <a href="#")%>ดาวน์โหลด</a>
                            <% } %>
                        </td>
                        <td class="caption">สถานะ</td>
                        <td class="content_txt_middle" title="ชำระเมื่อวันที่ <%=userInfo.get("PMT_DATE") == null ? "-" : userInfo.get("PMT_DATE")%>"><%=userInfo.get("PMT_STATUS") == null ? "ยังไม่ชำระ" : ((BigInteger) userInfo.get("PMT_STATUS")).intValue() == 1 ? "ชำระแล้ว" : "ยังไม่ชำระ"%></td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">รูปสำเนาทะเบียนบ้าน</td>
                        <td class="content_txt_middle">
                            <% if (userInfo.get("ID_HOME_PIC") != null) {%>
                            <a href="./<%=userInfo.get("ID_HOME_PIC")%>" download>ดาวน์โหลด</a>
                            <% } else {%>
                            <a href="#")%>ดาวน์โหลด</a>
                            <% } %>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เลขอีมี่ (EMEI)/facebook account</td>
                        <td class="content_txt_middle">
                            <%=AmuletUtils.nullToEmptyStr((String) userInfo.get("ID4SCAN"))%>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เบอร์โทรศัพท์มือถือ</td>
                        <td class="content_txt_middle">
                            <%=AmuletUtils.nullToEmptyStr((String) userInfo.get("PHONE_NO2"))%>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">อีเมล์</td>
                        <td class="content_txt_middle">
                            <%=userInfo.get("EMAIL")%>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="roleCode" value="<%=userInfo.get("ROLE_CODE")%>"/>
</form>
</body>
</html>