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
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
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
    });
    $(function() {
        $( "#birthDate" ).datepicker({
            showAnim: 'slideDown',
            duration: 'fast',
            dateFormat: "dd/mm/yy",
            changeMonth: true,
            changeYear: true,
            beforeShow: function(){
                $(".ui-datepicker").css('font-size', 12)
            }
        });
    });
    $(function() {
        $( "#pmtDate" ).datepicker({
            showAnim: 'slideDown',
            duration: 'fast',
            dateFormat: "dd/mm/yy",
            changeMonth: true,
            changeYear: true,
            beforeShow: function(){
                $(".ui-datepicker").css('font-size', 12)
            }
        });
    });
    $(function() {
        $("#btnIdCardUpload").change(function (){
            var fileName = $(this).val();
            $("#btnIdCardUpload_filename").html(fileName);
        });
        $("#btnHouseCertUpload").change(function (){
            var fileName = $(this).val();
            $("#btnHouseCertUpload_filename").html(fileName);
        });
    });
    $(function() {
        $("input#username").on({
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
    $(function() {
        $("#pmt_status").change(function (){
            var pmtStatus = $(this).val();
            if (pmtStatus == '1') {
                $("#pmtDate").attr('disabled',false);
            } else {
                $("#pmtDate").val('');
                $("#pmtDate").attr('disabled',true);
            }
        });
    });

    function checkPmtDate() {
        if ($('#pmt_status').val() == '1' && $("#pmtDate").val() == '') {
            alert("กรุณาระบุวันที่รับชำระค่าสมาชิกรายปี");
            return;
        } else {
            $("#admin_update_user_form").submit();
        }
    }
</script>
<body>
<div class="loader"></div>
<form id="admin_update_user_form" action="doupdateuser" method="post" enctype="multipart/form-data" acceptcharset="UTF-8">
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
                        <td style="width:100%;text-align: left;" class="text_header" colspan="4">ID No.&nbsp;<%=userInfo.get("MEMBER_ID")%>
                            <span class="button" style="width:10%; float: right; text-align: center;" onclick="history.go(-1)">ยกเลิก</span>
                            <span style="float:right;">&nbsp;</span>
                            <span class="button" style="width:10%; float: right; text-align: center;" onclick="checkPmtDate()">บันทึก</span>
                        </td>
                    </tr>
                    <tr style="border: 0px;">
                        <td style="width:100%;text-align: left; border-top: 1px dotted #dcac4e;" class="text_header" colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">1. ข้อมูลส่วนตัว</td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">2. กำหนด username และ password</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อ นามสกุล<span class="required">*</span></td>
                        <td class="content_txt_middle" style="width:40%;">
                            <input type="text" style="width:150px;" class="input_box" id="firstname" name="firstname" maxlength="250" value="<%=(String)userInfo.get("FNAME")%>" required/>
                            &nbsp;
                            <input type="text" style="width:150px;" class="input_box" id="lastname" name="lastname" maxlength="250" value="<%=(String)userInfo.get("LNAME")%>" required/>
                        </td>
                        <td class="caption" style="width: 15%;">username<span class="required">*</span></td>
                        <td class="content_txt_middle" style="width:30%;">
                            <input type="text" style="width:150px;" class="input_box" id="username" name="username" maxlength="250" value="<%=(String)userInfo.get("USER_NAME")%>" required/>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption">เพศ<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <% if ((Character) userInfo.get("SEX") == 'M') {%>
                                <input type="radio" name="sex" value="M" checked/> &nbsp; ชาย&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sex" value="F"/> &nbsp; หญิง
                            <% } else {%>
                                <input type="radio" name="sex" value="M"/> &nbsp; ชาย&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sex" value="F" checked/> &nbsp; หญิง
                            <% } %>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="caption_remark">ชื่อ username ความยาวไม่เกิน 25 ตัวอักษร และไม่เว้นวรรค หรือตัวอักขระพิเศษ</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">วัน เดือน ปีเกิด<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <% if(!new SimpleDateFormat("dd/MM/yyyy").format(userInfo.get("BIRTH_DATE")).equals("01/01/1900")) {%>
                            <input type="text" style="width:150px;" class="input_date_box" id="birthDate" name="birthDate" maxlength="10" value="<%=new SimpleDateFormat("dd/MM/yyyy").format(userInfo.get("BIRTH_DATE"))%>" required readonly="true"/>
                            <% } else {%>
                            <input type="text" style="width:150px;" class="input_date_box" id="birthDate" name="birthDate" maxlength="10" value="" required/>
                            <% } %>
                            &nbsp;<span class="caption_remark" style="font-size:1em;">จำกัดอายุระหว่าง 20-70 ปี</span>

                        </td>
                        <td class="caption">password<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="password" style="width:150px;" class="input_box" id="password" name="password" maxlength="250" equalTo="#confirm_password" value="<%=(String)userInfo.get("PASSWORD")%>" required/>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เลขบัตรประชาชน<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="number" style="width:150px;" class="input_box" id="idCardNo" name="idCardNo" maxlength="13" value="<%=(String)userInfo.get("ID_CARD")%>" required/>
                        </td>
                        <td class="caption">ยืนยัน password<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="password" style="width:150px;" class="input_box" id="confirm_password" name="confirm_password" equalTo="#password" maxlength="250" value="<%=(String)userInfo.get("PASSWORD")%>" required/>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">รูปสำเนาบัตรประชาชน<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="file" class="button_upload" id="btnIdCardUpload" name="btnIdCardUpload" accept="image/*" style="display:none;" required>
                            <input type="button" class="button_upload" onclick="document.getElementById('btnIdCardUpload').click()" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เลือกไฟล์&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>
                            &nbsp;<span id="btnIdCardUpload_filename" class="caption_remark" style="font-size:1em;">ขนาดไม่เกิน 300 KB</span>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">รูปสำเนาทะเบียนบ้าน<span class="required">*</span>
                        </td>
                        <td class="content_txt_middle">
                            <input type="file" class="button_upload" name="btnHouseCertUpload" id="btnHouseCertUpload" accept="image/*" style="display:none;" required>
                            <input type="button" class="button_upload" onclick="document.getElementById('btnHouseCertUpload').click()" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เลือกไฟล์&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>
                            &nbsp;<span id="btnHouseCertUpload_filename" class="caption_remark" style="font-size:1em;">ขนาดไม่เกิน 300 KB</span>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เลขอีมี่ (EMEI)/facebook account<span class="required">*</span></td>
                        <td class="content_txt_middle" colspan="2">
                            <input type="text" style="width:150px;" class="input_box" id="id4scan" name="id4scan" maxlength="250" value="<%=AmuletUtils.nullToEmptyStr((String)userInfo.get("ID4SCAN"))%>" required alt="เลชอีมี (EMEI) สำหรับ Android phone หรือ facebook account สำหรับ iPhone"/>
                            &nbsp;<span class="caption_remark" style="font-size:1em;">สำหรับถ่ายภาพใช้ในโปรแกรม ค้นหาพระเครื่อง</span>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td class="content_txt_middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">เบอร์โทรศัพท์มือถือ<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="tel" style="width:150px;" class="input_box" id="phoneNo2" name="phoneNo2" maxlength="250" value="<%=(String)userInfo.get("PHONE_NO2")%>" required/>
                            &nbsp;<span class="caption_remark" style="font-size:1em;">สำหรับใช้ในการติดต่อ</span>
                        </td>
                        <td style="width:30%;text-align: left; font-size: x-large" class="text_header" colspan="2">3. ชำระค่าสมาชิกรายปี</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">อีเมล<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="email" style="width:150px;" class="input_box" id="email" name="email" equalTo="#email_confirm" maxlength="250" value="<%=(String)userInfo.get("EMAIL")%>" required/>
                        </td>
                        <td class="caption">สถานะ</td>
                        <td class="content_txt_middle">
                            <select id="pmt_status" name="pmt_status" style="width: 150px;" class="select">
                                <option value="0">ยังไม่ชำระ</option>
                                <option value="1">ชำระแล้ว</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">ยืนยันอีเมล<span class="required">*</span></td>
                        <td class="content_txt_middle">
                            <input type="email" style="width:150px;" class="input_box" id="email_confirm" equalTo="#email" name="email_confirm" maxlength="250" value="<%=(String)userInfo.get("EMAIL")%>" required/>
                        </td>
                        <td class="caption" style="width: 20%;" id="lblPmtDate">วันที่รับชำระ</td>
                        <td class="content_txt_middle" id="pickerPmtDate">
                            <% if(userInfo.get("PMT_DATE") != null && !new SimpleDateFormat("dd/MM/yyyy").format(userInfo.get("PMT_DATE")).equals("01/01/1900")) {%>
                            <input type="text" style="width:150px;" class="input_date_box" id="pmtDate" name="pmtDate" maxlength="10" value="<%=new SimpleDateFormat("dd/MM/yyyy").format(userInfo.get("PMT_DATE"))%>" readonly="true"/>
                            <% } else {%>
                            <input type="text" style="width:150px;" class="input_date_box" id="pmtDate" name="pmtDate" maxlength="10" value="" readonly="true"/>
                            <% } %>
                        </td>
                    </tr>
                    <script>
                        $('#pmt_status option[value=<%=userInfo.get("PMT_STATUS") == null ? "0" : ((BigInteger) userInfo.get("PMT_STATUS")).intValue() == 1 ? "1" : "0"%>]').attr('selected','selected');
                        if ($('#pmt_status').val() == '1') {
                            $("#pmtDate").attr('disabled',false);
                        } else {
                            $("#pmtDate").attr('disabled',true);
                        }
                    </script>
                </table>
            </td>
        </tr>
        <input type="hidden" name="memberId" value="<%=userInfo.get("MEMBER_ID")%>"/>
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
<script>
    $("#admin_update_user_form").validate({
        lang: 'th'
    });
</script>
</html>