<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <title>ติดต่อเรา</title>
</head>

<body>
<%
    ServletContext context = session.getServletContext();
    String realContextPath = context.getRealPath(request.getContextPath());
%>
<table style="border-spacing: 0px; width: 704px;">
        <tr>
            <td class="text_header" colspan="3" style="text-align: center; padding-top: 10px;">ติดต่อเรา</td>
        </tr>
        <tr>
            <td class="solid_top" colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td style="width:296px; vertical-align: top"><img src="./resources/images/logo_s.png" style="width: 100%;max-height: 100%"></td>
            <td colspan="2" style="width: auto">
                <table width="100%" style="padding-left: 15px;">
                    <tr style="width:100%; vertical-align: top;">
                        <td class="bottom_dot" colspan="2">ฝ่ายบริการสมาชิก</td>
                    </tr>
                    <%
                        String address = realContextPath+"/resources/config/address.conf";
                        String addressTxt = AmuletUtils.getContent(address);
                    %>
                    <tr>
                        <td colspan="2" class="content_txt"><%out.print(addressTxt);%></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="bottom_dot" style="width:30%; vertical-align: top; ">ติดต่อสอบถามเรื่องเว็บไซต์</td>
            <td colspan="2" style="width: auto; padding-left: 15px; border: none; border-spacing:0; border-collapse: collapse;">
                <table width="100%" style="border: none; border-spacing:0; border-collapse: collapse;">
                    <tr style="width:100%; border: none; border-spacing:0; border-collapse: collapse;">
                        <td class="bottom_dot" style="vertical-align: top;">ตรวจสอบเช็คพระ</td>
                        <td>&nbsp;</td>
                        <td class="bottom_dot" style="vertical-align: top; width: 65%;">อีเมลติดต่อเว็บไซต์</td>
                    </tr>
                </table>
            </td>
        </tr>
        <%
            String contactWebsite = realContextPath+"/resources/config/contact_website.conf";
            String contactWebsiteTxt = AmuletUtils.getContent(contactWebsite);
            String contactCheckPra = realContextPath+"/resources/config/contact_checkpra.conf";
            String contactCheckPraTxt = AmuletUtils.getContent(contactCheckPra);
            String contactEmail = realContextPath+"/resources/config/contact_email.conf";
            String contactEmailTxt = AmuletUtils.getContent(contactEmail);
        %>
        <tr>
            <td class="content_txt" style="width:30%; vertical-align: top; "><%out.print(contactWebsiteTxt);%></td>
            <td colspan="2" style="width: auto; padding-left: 15px; border: none; border-spacing:0; border-collapse: collapse;">
                <table width="100%" style="border: none; border-spacing:0; border-collapse: collapse;">
                    <tr style="width:100%; border: none; border-spacing:0; border-collapse: collapse;">
                        <td class="content_txt" style="vertical-align: top;"><%out.print(contactCheckPraTxt);%></td>
                        <td>&nbsp;</td>
                        <td class="content_txt" style="vertical-align: top; width: 65%;"><%out.print(contactEmailTxt);%></td>
                    </tr>
                </table>
            </td>
        </tr>
</table>
</body>
</html>