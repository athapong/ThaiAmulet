<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <script src="./resources/message.js"></script>
    <title>ผู้ดูแลระบบ::เข้าสู่ระบบ</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>

<script>
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
<%
    if (request.getSession().getAttribute("UserSession") != null) {
        response.sendRedirect(AmuletUtils.pageFwdByRole((UserBean) request.getSession().getAttribute("UserSession")));
    }
%>
<form id="admin_login_form" action="loginservlet" method="post">
    <table width="100%" border="0">
        <tr>
            <td colspan="2">
                <div style="text-align: left; vertical-align: top; position: absolute;">
                    <img src="./resources/images/top_l.png"/>
                </div>
                <div style="text-align: right; vertical-align: top;">
                    <img src="./resources/images/top_r.png"/>
                </div>
            </td>
        </tr>
        <tr>
            <td class="menu_left_header" colspan="2" style="text-align: center; padding-right: 14%;"><img src="./resources/images/logo.png"/></td>
        </tr>
        <tr>
            <td class="menu_dot" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr style="text-align: center;">
            <td class="menu_left" style="text-align: right; padding-right: 5px; height: 35px; width:35%;" id="username_label">
                <label for="usernameTxt">username</label>
            </td>
            <td class="menu_left" style="text-align: left;">
                <input class="input_box" type="text" id="usernameTxt" name="usernameTxt" maxlength="25" required/>
            </td>
        </tr>
        <tr style="text-align: center;">
            <td class="menu_left" style="text-align: right; padding-right: 5px;" id="password_label">
                <label for="passwordTxt">password</label>
            </td>
            <td class="menu_left" style="text-align: left;">
                <input class="input_box" type="password" id="passwordTxt" name="passwordTxt" maxlength="25" required/>
            </td>
        </tr>
        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td class="menu_left">&nbsp;</td>
            <td class="menu_left"><input type="checkbox" class="checkbox" value="true">Remember me &nbsp;&nbsp;<a href="forgtpwdpage" class="menu_left" style="text-decoration: none;">ลืมรหัสผ่าน</a></td></td>
        </tr>
        <tr>
            <td class="menu_left">&nbsp;</td>
            <td class="menu_left"><input type="submit" id="admin_login_button" class="button" value="      เข้าสู่ระบบ      "></td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
</form>
<script>
    $("#admin_login_form").validate({
        lang: 'TH'
    });
</script>
</body>
</html>