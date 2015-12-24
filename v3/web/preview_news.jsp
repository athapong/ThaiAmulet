<%@ page import="com.valhalla.amulet.NewsDAO" %>
<%@ page import="com.valhalla.amulet.entity.NewsEntity" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.util.Properties" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="resources/checkid.js"></script>
</head>
<%

    NewsEntity newsEntity = (NewsEntity) session.getAttribute("news_entity");
    Properties properties = new Properties();
    try {
        properties.load(getServletConfig().getServletContext().getResourceAsStream("/resources/config/news_cat.properties"));
    }
    catch (Exception e) {

    }
    NewsDAO.getInstance().increaseViewCount(""+newsEntity.getNewsCode());
%>
<body>
<table style="border-spacing: 0px; width: 100%;">
    <tr>
        <td class="menu_left_header" colspan="2" style="text-align: left;">ข่าวสารจากผู้เชี่ยวชาญพระเครื่อง</td>
    </tr>
    <tr>
        <td class="menu_dot" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td class="news_detail_img" colspan="2" style="border-top: 1px dotted #dcac4e;"><img src="<%=newsEntity.getNewsPic() == null ? "resources/images/noimage.png" : newsEntity.getNewsPic()%>"/></td>
    </tr>
    <tr>
        <td class="caption" style="width:100px; border-left: 1px dotted #dcac4e; vertical-align: top;">ประเภทกลุ่ม</td>
        <td class="content_txt" style="word-wrap:break-word; border-right: 1px dotted #dcac4e; vertical-align: top;"><%=properties.getProperty(newsEntity.getNewsCat())%></td>
    </tr>
    <tr>
        <td class="caption" style="width:100px; border-left: 1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; vertical-align: top;">หัวข้อ</td>
        <td class="content_txt" style="word-wrap:break-word; border-right: 1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; vertical-align: top;"><%=newsEntity == null ? "" : newsEntity.getNewsSubj()%></td>
    </tr>
    <tr>
        <td class="caption" style="width:100px; border-left: 1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; vertical-align: top;">รายละเอียด</td>
        <td class="content_txt" style="word-wrap:break-word; border-right: 1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; vertical-align: top;">
            <textarea id="note" name="note" style=" color:#f2f2f2; background-color:#020821; width: 100%; height: 300px; font-family: fontawesomeregular; font-size:0.9em;" tabindex="6" readonly><%=newsEntity == null ? "" : newsEntity.getNewsDesc()%></textarea>

        </td>
    </tr>
    <tr style="vertical-align: middle; padding-top: 20px;">
        <td class="caption" style="padding-bottom: 10px; padding-top:10px; font-size: 1em; text-align: right; color:#f2f2f2;" colspan="2">
            <span class="button" style="width:150px; float: left; text-align: center;" onclick="history.go(-1)" tabindex="11">กลับหน้าเดิม</span>
            <label class="caption">วันที่</label>&nbsp;<%=newsEntity == null ? "" : AmuletUtils.getDateStr(newsEntity.getNewsDate())%>&nbsp;
            <label class="caption">เวลา</label>&nbsp;<%=newsEntity == null ? "" : AmuletUtils.getTimeStr(newsEntity.getNewsTime())%>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
</table>
</body>
</html>