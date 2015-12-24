<%@ page import="com.valhalla.amulet.KnowHowDAO" %>
<%@ page import="com.valhalla.amulet.NewsDAO" %>
<%@ page import="com.valhalla.amulet.entity.AmuletKnowhowEntity" %>
<%@ page import="com.valhalla.amulet.entity.NewsEntity" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>คู่มือพระ.com :: ลงทะเบียนสมาชิกใหม่</title>
</head>
<%
    ServletContext context = session.getServletContext();
    String realContextPath = context.getRealPath(File.separator);
%>
<body>
<table style="border-spacing: 0px; width: 704px; float:right; padding-right:20px;">
    <tr>
        <td colspan="3" style="text-align: left;"><img src="resources/images/main_pic.png" style="width:704px;"></td>
    </tr>
    <tr>
        <td class="text_header" colspan="3" style="text-align: center; padding-top: 10px;">ยินดีต้อนรับสู่ คู่มือพระ.com</td>
    </tr>
    <tr>
        <td class="solid_top" colspan="3">&nbsp;</td>
    </tr>
    <%
        String agreement = realContextPath +"/resources/config/welcome.conf";
        String welcomeTxt = AmuletUtils.getContent(agreement);
    %>
    <tr>
        <td colspan="3" class="content_txt"><%out.print(welcomeTxt);%></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="text_header" colspan="3" style="text-align: center; padding-top: 10px;">นโยบายของ web</td>
    </tr>
    <tr>
        <td class="solid_top" colspan="3">&nbsp;</td>
    </tr>
    <%
        String policy = realContextPath+"/resources/config/policy.conf";
        String policyTxt = AmuletUtils.getContent(policy);
    %>
    <tr>
        <td colspan="3" class="content_txt"><%out.print(policyTxt);%></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="text_header" colspan="3" style="text-align: center; padding-top: 10px;">ติดต่อเรา</td>
    </tr>
    <tr>
        <td class="solid_top" colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td style="width:296px; vertical-align: top"><img src="resources/images/logo_s.png" style="width: 100%;max-height: 100%"></td>
        <td colspan="2" style="width: auto">
            <table width="100%" style="padding-left: 15px;">
                <tr style="width:100%; vertical-align: top;">
                    <td class="bottom_dot" colspan="2">ฝ่ายบริการสมาชิก</td>
                </tr>
                <%
                    String address = realContextPath +"/resources/config/address.conf";
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
        String contactWebsite = realContextPath +"/resources/config/contact_website.conf";
        String contactWebsiteTxt = AmuletUtils.getContent(contactWebsite);
        String contactCheckPra = realContextPath +"/resources/config/contact_checkpra.conf";
        String contactCheckPraTxt = AmuletUtils.getContent(contactCheckPra);
        String contactEmail = realContextPath +"/resources/config/contact_email.conf";
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
<table style="border-spacing: 0px; width: 704px; float:right;">
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="text_header" style="width:48%; vertical-align: top; ">ข่าวสารจากทาง web</td>
        <td style="width:4%">&nbsp;</td>
        <td class="text_header" style="width:48%; vertical-align: top; ">ห้องสมุดพระเครื่อง</td>
    </tr>
    <tr>
        <td class="solid_top">&nbsp;</td>
        <td>&nbsp;</td>
        <td class="solid_top">&nbsp;</td>
    </tr>
    <%
        List<AmuletKnowhowEntity> knowhowEntities = KnowHowDAO.getInstance().getKnowHowList();
        int repeat = 0;
        repeat = knowhowEntities == null ? 0 : knowhowEntities.size();
        List<NewsEntity> newsEntities = NewsDAO.getInstance().getNewsList();
        repeat = newsEntities != null && newsEntities.size() > repeat ? newsEntities.size() : repeat;
    %>
    <% for (int loop = 0;loop < repeat; loop++) {
        String newsImg = "";
        String knowhowImg = "";
        if (newsEntities.size() > loop) {
            if (newsEntities.get(loop).getNewsPic() == null) {
                newsImg = "resources/images/noimage.png";
            } else newsImg = newsEntities.get(loop).getNewsPic();
        }
        if (knowhowEntities.size() > loop) {
            if (knowhowEntities.get(loop).getPic1() == null) {
                knowhowImg = "resources/images/noimage.png";
            } else knowhowImg = knowhowEntities.get(loop).getPic1();
        }
    %>
    <tr>
        <td class="content_txt" style="width:48%; vertical-align: top; cursor: pointer;" onclick="window.open('addnewsservlet?newsId=<%=newsEntities.size() > loop ? newsEntities.get(loop).getNewsCode() : ""%>','_self')">
            <img src="<%=newsImg%>" style="max-width: 50px;"/>
            <%=newsEntities.size() > loop ? newsEntities.get(loop).getNewsSubj() : "" %>
        </td>
        <td style="width:4%">&nbsp;</td>
        <td class="content_txt" style="width:48%; vertical-align: top; cursor: pointer;" onclick="window.open('./ExDoUpdateKnowHowServlet?knowhowId=<%=knowhowEntities.size() > loop ? knowhowEntities.get(loop).getKhId() : ""%>','_self')">
            <img src="<%=knowhowImg%>" style="max-width: 50px;"/>
            <%=knowhowEntities.size() > loop ? knowhowEntities.get(loop).getSubjectName() : "" %>
        </td>
    </tr>
    <% } %>


    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <%
        String rulePath = realContextPath +"/resources/config/rule.conf";
        String ruleTxt = AmuletUtils.getContent(rulePath);
    %>
    <tr>
        <td class="text_header" colspan="3" style="width:100%; vertical-align: top; ">กฎกติกามารยาท</td>
    </tr>
    <tr>
        <td class="solid_top" colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td class="content_txt" colspan="3"><%out.print(ruleTxt);%></td>
    </tr>
</table>
</body>
</html>