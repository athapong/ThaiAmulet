<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/checkid.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <title>ลืมรหัสผ่าน</title>
</head>

<body>
    <table style="vertical-align: top; width: 100%;">
        <tr>
            <td class="menu_left_header" style="text-align: center;" colspan="3">ลืมรหัสผ่าน</td>
        </tr>
        <tr>
            <td class="menu_dot" colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr style="text-align: center">
            <td style="width:50px;" >&nbsp;</td>
            <td style="width:250px;" class="caption" style="text-align: right;">username/email&nbsp;&nbsp;&nbsp;<input type="text" class="input_box" id="name_mail" name="name_mail" maxlength="250" required/></td>
            <td style="width:200px;">&nbsp;</td>
        </tr>

        <tr style="text-align: center">
            <td style="width:50px;" >&nbsp;</td>
            <td style="width:250px; text-align: right;">
                <input type="submit" id="accept" class="button" value="  กู้คืนรหัสผ่าน  ">
            </td>
            <td style="width:200px;">&nbsp;</td>
        </tr>
    </table>
</body>
<script>
    $("#forgotPwdForm").validate();
</script>
</html>