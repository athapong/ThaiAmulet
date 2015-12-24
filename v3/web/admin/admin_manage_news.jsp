<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.AdminManageNewsBean" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="com.valhalla.amulet.constants.AmuletConstants" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>ผู้ดูแลระบบ::จัดการข่าวสาร</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });
    $(document).ready(function () {
        $("#inquire_news_btn").click(function() {
            $( "#inquiry_news_form" ).submit();
        });
        if ('<%=session.getAttribute("addNews")%>' == 'success') {
            $( "#oper_add_status_txt").removeAttr("hidden");
            $( "#oper_add_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
        if ('<%=session.getAttribute("deleteNews")%>' == 'success') {
            $( "#oper_delete_status_txt").removeAttr("hidden");
            $( "#oper_delete_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
        if ('<%=session.getAttribute("updateNews")%>' == 'success') {
            $( "#oper_update_status_txt").removeAttr("hidden");
            $( "#oper_update_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
    });
    function goToPage(p) {
        $("#page").val(p);
        inquiry_news_form.submit();
    }
    function deleteNews(id) {
        if (confirm("ต้องการลบข้อมูลข่าวสาร?")) {
            $("#deleteNews").val(id);
            inquiry_news_form.submit();
        } else return;
    }
</script>
<body>
<div class="loader"></div>
<form id="inquiry_news_form" action="./newsinqservlet" method="post">
<%
    if (!AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession")) && !AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
        request.getRequestDispatcher("unauthorized").forward(request, response);
    }
    // if session is valid
    UserBean bean = null;
    if (request.getSession().getAttribute("admin_session") == null) {
        response.sendRedirect("admin");
    } else {
        bean = (UserBean) request.getSession().getAttribute("admin_session");
    }
    AdminManageNewsBean formBean = (AdminManageNewsBean) request.getSession().getAttribute("admin_manage_news_form_bean");
    if (formBean == null) {
        formBean = new AdminManageNewsBean();
    }
    session.removeAttribute("addNews");
    session.removeAttribute("deleteNews");
    session.removeAttribute("updateNews");
%>



    <table width="100%" border="0">
        <% if (bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {%>
        <jsp:include page="./admin/admin_menu.jsp?tab=3"/>
        <% } else if (bean.getRole().equals(AmuletConstants.EXCV_TYPE)) {%>
        <jsp:include page="./exclusive/ex_menu.jsp?tab=5"/>
        <% } %>

        <tr id="oper_update_status_txt" hidden="hidden">
            <td class="success_text" colspan="3">บันทึกสำเร็จแล้ว</td>
        </tr>
        <tr id="oper_add_status_txt" hidden="hidden">
            <td class="success_text" colspan="3">บันทึกสำเร็จแล้ว</td>
        </tr>
        <tr id="oper_delete_status_txt" hidden="hidden">
            <td class="success_text" colspan="3">ลบข้อมูลสำเร็จแล้ว</td>
        </tr>
        <tr>
            <% if (bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {%>
            <td class="normal_text" style="font-size: 2em; text-align: left;">จัดการข่าวสาร web</td>
            <%} else if (bean.getRole().equals(AmuletConstants.EXCV_TYPE)) {%>
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="2">จัดการข่าวสาร web</td>
            <%}%>
            <td style="text-align: right;"><span class="button" style="width:10%;" onclick="window.open('addnewspage','_self')">&nbsp;&nbsp;&nbsp;เพิ่มข่าวสาร&nbsp;&nbsp;&nbsp;</span></td>
        </tr>
        <tr class="menu_dot">
            <td colspan="3" class="menu_dot">&nbsp;</td>
        </tr>

        <!-- customer search result -->
        <tr>
            <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                <tr class="table_header">
                    <td style="width:70%; text-align: center; border-right:1px dotted #dcac4e; border-left:1px dotted #dcac4e;">หัวข้อ</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">จำนวนผู้เข้าชม</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">ลบข้อมูล</td>
                    <td style="width:10%; text-align: center;">แก้ไขข้อมูล</td>
                </tr>
                <%
                    if (session.getAttribute("news_inq_result") != null) {
                        List<HashMap> news = (List) session.getAttribute("news_inq_result");
                        for (int i=0;i<news.size();i++) {
                            if (i % 2 == 0) {
                %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #020821">
                    <% }  else { %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #151d3b">
                    <% } %>
                    <td style="width:70%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;"><%=(news.get(i).get("NEWS_SUBJ") == null ? "&nbsp;" : AmuletUtils.trimWithDotMore((String) news.get(i).get("NEWS_SUBJ"), 90))%></td>
                    <td style="width:10%; text-align: right; padding-right: 10px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(news.get(i).get("VIEW_COUNT") == null ? "&nbsp;" : news.get(i).get("VIEW_COUNT"))%></td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="javascript:deleteNews(<%=news.get(i).get("NEWS_CODE")%>)"><i class="fa fa-times-circle-o" style="color:#ff1d25;"></i></a></td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="./addnewsservlet?newsId=<%=news.get(i).get("NEWS_CODE")%>"><i class="fa fa-pencil-square-o"></i></a></td>
                </tr>
                <%
                        }
                    } else {
                %>
                        <tr class="content_txt" style="vertical-align: middle;">
                            <td colspan="9" style="width:100%; text-align: center; padding-left: 0px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ไม่พบข้อมูล</td>
                        </tr>
                <%
                        session.removeAttribute("news_inq_result");
                        session.removeAttribute("admin_manage_news_form_bean");
                    }
                %>
                <tr style="height: 10px;">
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>
        </tr>
        <% if (formBean.getPageCount() > 0) {%>
        <tr class="paging">
            <td class="paging" colspan="2">
                <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                    <span style="float: left; width:5%;" class="paging">หน้าที่</span>
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
        </tr>
        <%}%>
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="page" id="page" value="<%=formBean.getCurrentPage()%>"/>
    <input type="hidden" name="deleteNews" id="deleteNews"/>
</form>
</body>
</html>