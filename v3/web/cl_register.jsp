<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" session="true" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <link rel="stylesheet" href="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.css">
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/checkid.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <title>คู่มือพระ.com :: ลงทะเบียนสมาชิกใหม่</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
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
    function checkBirthDate() {
        $("#registerMemberForm").validate();
        if ($("#birthDate").val() == '') {
            alert("กรุณาระบุวันเกิด");
            return;
        } else {
            $("#registerMemberForm").submit();
        }
    }
</script>

<body>
<div class="loader"></div>
<div id="spinner"></div>
<form id="registerMemberForm" method="post" enctype="multipart/form-data" action="./registmembrservlet" acceptcharset="UTF-8">
    <table width="100%">
        <tr>
            <td colspan="2"><jsp:include page="cl_header.jsp?page=register"/></td>
        </tr>
        <tr>
            <td style="width:200px; padding-right: 80px; vertical-align: top;"><jsp:include page="cl_menuleft.jsp"/></td>
            <td style="vertical-align: top;"><jsp:include page="registerMember.jsp"/></td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="/footer.jsp"/></td>
        </tr>
    </table>
</form>
</body>
<script language="text/javascript">
    $("#registerMemberForm").validate();
    document.getElementById("uploadBtn").onchange = function () {
        document.getElementById("uploadFile").value = this.value;
    };
</script>
</html>