<%@ page import="com.valhalla.amulet.bean.AdminManageNewsBean" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
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
    <script language="JavaScript">
        function goToPage(p) {
            $("#page").val(p);
            inquiry_news_form.submit();
        }
    </script>
</head>
<body>
    <table style="border-spacing: 0px; width: 80%">
        <tr>
            <td class="menu_left_header" colspan="3" style="text-align: center;">ข่าวสารจากผู้เชี่ยวชาญพระเครื่อง</td>
        </tr>
        <tr>
            <td class="menu_dot" colspan="3">&nbsp;</td>
        </tr>
        <tr class="table_header">
            <td>&nbsp;</td>
            <td>ข่าวสารจากทาง web</td>
            <td style="padding-right:10px; text-align: right;">จำนวนผู้เข้าชม</td>
        </tr>
        <%
            if (session.getAttribute("news_inq_result") != null) {
            List<HashMap> news = (List) session.getAttribute("news_inq_result");
            for (int i=0;i<news.size();i++) {
            if (i % 2 == 0) {
        %>
        <tr style="cursor: pointer;" onclick="window.open('addnewsservlet?newsId=<%=news.get(i).get("NEWS_CODE")%>','_self')">
            <td class="news_detail_img"><img src="<%=(news.get(i).get("NEWS_PIC") == null ? "resources/images/noimage.png" : news.get(i).get("NEWS_PIC"))%>" style="max-width: 50px;"/></td>
            <td class="news_detail1_txt"><%=(news.get(i).get("NEWS_SUBJ") == null ? "&nbsp;" : (String) news.get(i).get("NEWS_SUBJ"))%></td>
            <td class="news_count1"><%=(news.get(i).get("VIEW_COUNT") == null ? "&nbsp;" : news.get(i).get("VIEW_COUNT"))%></td>
        </tr>
        <%} else {%>
        <tr style="cursor: pointer;" onclick="window.open('addnewsservlet?newsId=<%=news.get(i).get("NEWS_CODE")%>','_self')">
            <td class="news_detail_img"><img src="<%=(news.get(i).get("NEWS_PIC") == null ? "resources/images/noimage.png" : news.get(i).get("NEWS_PIC"))%>" style="max-width: 50px;"/></td>
            <td class="news_detail2_txt"><%=(news.get(i).get("NEWS_SUBJ") == null ? "&nbsp;" : (String) news.get(i).get("NEWS_SUBJ"))%></td>
            <td class="news_count2"><%=(news.get(i).get("VIEW_COUNT") == null ? "&nbsp;" : news.get(i).get("VIEW_COUNT"))%></td>
        </tr>
        <%}
        }
        }
        %>

        <tr>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td class="paging">หน้าที่</td>
            <%
            AdminManageNewsBean formBean = (AdminManageNewsBean) request.getSession().getAttribute("admin_manage_news_form_bean");
            if (formBean == null) {
            formBean = new AdminManageNewsBean();
            }
            %>
                <% if (formBean.getPageCount() > 0) {%>
            <td class="paging" colspan="2">
                <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                    <span style="float: right;width: 95%" class="paging">
                        <span class="paging" onclick="goToPage(1)"><<</span>
                        <% for (int i=0;i<formBean.getPageCount();i++) {
                            if (i+1 == formBean.getCurrentPage()) {
                                out.print("<span class=\"paging_current\" onclick=\"goToPage("+(i+1)+")\">&nbsp;"+(i+1)+"&nbsp;</span>");
                            } else {
                                out.print("<span class=\"paging\" onclick=\"goToPage("+(i+1)+")\">&nbsp;"+(i+1)+"&nbsp;</span>");
                            }
                        } %>
                        <span class="paging" onclick="goToPage(<%=formBean.getPageCount()%>)">>></span>
                    </span>
                </table>
            </td>
        <%}%>
        </tr>
    </table>
    <input type="hidden" name="page" id="page" value="<%=formBean.getCurrentPage()%>"/>
</body>
</html>