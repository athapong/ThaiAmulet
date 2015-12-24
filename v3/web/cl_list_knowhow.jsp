<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" session="true" %>
<html>
<head lang="en">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <link rel="stylesheet" href="resources/css/style.css" />
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>

<body>
<div class="loader"></div>
<form id="inquiry_knowhow_form" action="./mgtkmservlet" method="post">
<table width="100%">
    <tr>
        <td colspan="2"><jsp:include page="cl_header.jsp?page=knowhow"/></td>
    </tr>
    <tr>
        <td style="width:200px; padding-right: 80px; vertical-align: top;"><jsp:include page="cl_menuleft.jsp"/></td>
        <td style="vertical-align: top;"><jsp:include page="knowhow.jsp"/></td>
    </tr>
</table>
</form>
</body>
</html>