<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="com.valhalla.amulet.constants.AmuletConstants" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.min.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.min.css">
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <script src="./resources/checkid.js"></script>
    <script src="./resources/message.js"></script>
    <title>ผู้ดูแลระบบ::จัดการข้อมูลผู้ใช้</title>
</head>
<script type="text/javascript">

    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
    $(function() {
        $("input#usernameTxt").on({
            keydown: function(e) {
                if (e.which === 32)
                    return false;
            },
            change: function() {
                // Regex-remove all spaces in the final value
                this.value = this.value.replace(/\s/g, "");
            }
        });
    });
</script>
<body>
<div class="loader"></div>
<form id="admin_add_user_form" action="adduserservlet" method="post">
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
    %>
    <table width="100%" border="0">
        <jsp:include page="./admin/admin_menu.jsp?tab=2"/>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="2">เพิ่มข้อมูลสมาชิก</td>
        </tr>
        <tr class="menu_dot">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr style="border: 0px;">
                        <td style="width:100%;text-align: left;" class="text_header" colspan="4">&nbsp;
                            <span class="button" style="width:10%; float: right; text-align: center;" onclick="window.open('mgtuserpage','_self')" tabindex="11">ยกเลิก</span>
                            <span style="float:right;">&nbsp;</span>
                            <span class="button" style="width:10%; float: right; text-align: center;" onclick="$('#submit_btn').click()" tabindex="10">บันทึก</span>
                            <input type="submit" id="submit_btn" hidden="hidden"/>
                        </td>
                    </tr>
                    <tr style="border: 0px;">
                        <td style="width:100%;text-align: left; border-top: 1px dotted #dcac4e;" class="text_header" colspan="7">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อ นามสกุล<span class="required">*</span></td>
                        <td class="content_txt_middle" style="width:40%;">
                            <input type="text" style="width:150px;" class="input_box" id="firstname" name="firstname" maxlength="250" required tabindex=1/>
                            &nbsp;
                            <input type="text" style="width:150px;" class="input_box" id="lastname" name="lastname" maxlength="250" required tabindex=2/>
                        </td>
                        <td class="caption" style="width: 15%;">username<span class="required">*</span></td>
                        <td class="content_txt_middle" style="width:30%;">
                            <input type="text" style="width:150px;" class="input_box" id="usernameTxt" name="usernameTxt" maxlength="25" required tabindex="7"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เลขบัตรประชาชน<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="number" style="width:150px;" class="input_box" id="idCardNo" name="idCardNo" maxlength="13" required tabindex=3/>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="caption_remark">ชื่อ username ความยาวไม่เกิน 25 ตัวอักษร และไม่เว้นวรรค หรือตัวอักขระพิเศษ</td>

                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">ประเภทผู้ใช้งาน<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <select name="roleCode" style="border-radius: 4px; border: 1px solid #dcac4e; width:150px; height:25px; font-family: fontawesomeregular; font-size:0.9em;" tabindex=4>
                                <option value="<%=AmuletConstants.USER_TYPE%>" selected>End-User</option>
                                <option value="<%=AmuletConstants.ADMIN_TYPE%>">Admin</option>
                                <option value="<%=AmuletConstants.EXCV_TYPE%>">Executive</option>
                            </select>
                        </td>
                        <td class="caption">password<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="password" style="width:150px;" class="input_box" id="passwordTxt" name="passwordTxt" maxlength="250" equalTo="#confirm_password" required tabindex=8/>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เบอร์โทรศัพท์มือถือ<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="number" style="width:150px;" class="input_box" id="phoneNo2" name="phoneNo2" maxlength="250" required tabindex=5/>
                            &nbsp;<span class="caption_remark" style="font-size:1em;">สำหรับใช้ในการติดต่อ</span>
                        </td>
                        <td class="caption">ยืนยัน password<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="password" style="width:150px;" class="input_box" id="confirm_password" name="confirm_password" equalTo="#passwordTxt" maxlength="250" required tabindex=9/>
                        </td>
                    </tr>

                    <tr>
                        <td class="caption" style="width: 20%;">อีเมล<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="email" style="width:150px;" class="input_box" id="email" name="email" maxlength="250" required tabindex=6/>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
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
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
<script>
    $("#admin_add_user_form").validate({
        lang: 'th'
    });
</script>
</html>