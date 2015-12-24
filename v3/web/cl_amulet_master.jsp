<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/message.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <script src="./resources/checkid.js"></script>
    <title>คู่มือพระ.com :: ค้นหาข้อมูลพระเครื่อง</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });
    $(document).ready(function() {
        $("#isdropdownchange_btn").click(function() {
            $("#isdropdownchange").val('Y');
            $("#ex_inq_amulet_form").submit();
        }),
        $('#ex_inq_amulet_form').submit(function(e){
            if ($('#year_from').val() != "" && $('#year_to').val() != "") {
                year_from = $('#year_from').val();
                year_to = $('#year_to').val();
                if (year_from > year_to) {
                    alert("ช่วงปีที่ระบุไม่ถูกต้อง");
                    e.preventDefault();
                    return false;
                }
            }
        });
    });
</script>
<form id="ex_inq_amulet_form" action="ExDoInquiryAmuletServlet" method="post" style="text-align:center;">
<body>
    <div class="loader"></div>
    <table>
        <tr>
            <td colspan="2"><jsp:include page="cl_header.jsp?page=news"/></td>
        </tr>
        <tr>
            <td style="width:200px; padding-right: 23px; vertical-align: top;"><jsp:include page="cl_menuleft.jsp"/></td>
            <td class="content_txt"><jsp:include page="cl_inq_amulet.jsp"/></td>
        </tr>

    </table>
</body>
</form>
<script language="text/javascript">
    $("#ex_inq_amulet_form").validate({
        lang: 'th'
    });
</script>
</html>