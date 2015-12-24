<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/session.js"></script>

    <title>คู่มือพระ.com :: ห้องสมุดพระเครื่อง</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });

</script>
<form id="preview_knowhow_form" action="" method="post">
<body>
    <div class="loader"></div>
    <table>
        <tr>
            <td colspan="2"><jsp:include page="cl_header.jsp?page=knowhow"/></td>
        </tr>
        <tr>
            <td style="width:200px; padding-right: 23px; vertical-align: top;"><jsp:include page="cl_menuleft.jsp"/></td>
            <td class="content_txt"><jsp:include page="preview_knowhow.jsp"/></td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include page="footer.jsp"/></td>
        </tr>
    </table>
</body>
</form>
</html>