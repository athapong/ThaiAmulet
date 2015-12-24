<%@ page import="com.valhalla.amulet.MaterialDAO" %>
<%@ page import="com.valhalla.amulet.bean.ExAmuletResultBean" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.entity.MaterialEntity" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script src="resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <script src="./resources/message.js"></script>
    <title>ข้อมูลพระเครื่อง</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });
    function goToPage(p) {
        $("#page").val(p);
        $( "#amulet_result_form" ).submit();
    }
    $(document).ready(function () {
        if ('<%=session.getAttribute("updateamulet")%>' == 'success') {
            <%
                session.removeAttribute("updateamulet");
            %>
            $( "#oper_update_status_txt").removeAttr("hidden");
            $( "#oper_update_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
    });
</script>
<%

    if (request.getSession().getAttribute("UserSession") != null && !AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession")) && !AmuletUtils.isUser((UserBean) request.getSession().getAttribute("UserSession"))) {
        request.getRequestDispatcher("unauthorized").forward(request, response);
    }
    // if session is valid
    UserBean bean = null;
    if (request.getSession().getAttribute("admin_session") == null) {
        //response.sendRedirect("admin");
    } else {
        bean = (UserBean) request.getSession().getAttribute("admin_session");
    }
    ExAmuletResultBean formBean = (ExAmuletResultBean) request.getSession().getAttribute("ex_amulet_result_form_bean");
    if (formBean == null) {
        formBean = new ExAmuletResultBean();
    }
%>
<form id="amulet_result_form" name="amulet_result_form" action="./ExDoInquiryAmuletServlet" method="post">
<body>
    <div class="loader"></div>
    <table width="100%" border="0">
        <% if (bean != null) {%>
            <jsp:include page="./exclusive/ex_menu.jsp?tab=4"/>
        <%} else {%>
            <jsp:include page="./cl_header.jsp?page="/>
        <%}%>
        <tr id="oper_update_status_txt" hidden="hidden">
            <td class="success_text" colspan="2">บันทึกสำเร็จแล้ว</td>
        </tr>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: center;" colspan="3">ผลการค้นหาพระเครื่อง</td>
        </tr>
        <tr class="menu_dot">
            <td colspan="3" class="menu_dot">&nbsp;</td>
        </tr>
        <!-- amulet search result -->
        <tr>
            <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                <tr class="table_header">
                    <td style="width:100%; text-align: left; border-right:1px dotted #dcac4e; border-left:1px dotted #dcac4e; padding-left: 5px;" colspan="2">รายการ</td>
                </tr>
                <%
                    if (session.getAttribute("amulet_result") != null) {
                        List<HashMap> queryReport = (List) session.getAttribute("amulet_result");
                        for (int i=0;i<queryReport.size();i++) {
                            if (i % 2 == 0) {
                %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #020821; height:100px; cursor: pointer;" onclick="window.open('ExDoInquiryAmuletServlet?amulet_code=<%=queryReport.get(i).get("AMULET_CODE")%>','_self')">
                    <% }  else { %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #151d3b; height:100px; cursor: pointer;" onclick="window.open('ExDoInquiryAmuletServlet?amulet_code=<%=queryReport.get(i).get("AMULET_CODE")%>','_self')">
                    <% } %>
                    <td style="width:10%; text-align: left; padding-left: 3px;">
                        <% if (queryReport.get(i).get("AMULET_PIC") != null) {%>
                            <div id="imgDiv">
                                <img src="<%=queryReport.get(i).get("AMULET_PIC")%>">
                            </div>
                        <% } else {%>
                            <div id="imgDiv">
                                <img src="resources/images/noimage.png" width="170px"/>
                            </div>
                        <% } %>
                    </td>
                    <td style="width:90%; text-align: left; padding-left: 3px;">
                        <table>
                            <tr class="content_txt">
                                <td style="color: #f2d576;"><%=queryReport.get(i).get("AMULET_NAME")%></td>
                            </tr>
                            <tr>
                                <td style="color: #f2f2f2;">ขนาด&nbsp;<%=queryReport.get(i).get("S_WIDTH") == null ? "-" : queryReport.get(i).get("S_WIDTH")%>&nbsp;/&nbsp;<%=queryReport.get(i).get("S_LONG") == null ? "-" : queryReport.get(i).get("S_LONG")%>&nbsp;/&nbsp;<%=queryReport.get(i).get("S_TALL") == null ? "-" : queryReport.get(i).get("S_TALL")%></td>
                            </tr>
                            <%
                                String materialDesc = "";
                                if (queryReport.get(i).get("MATERIAL") != null && !queryReport.get(i).get("MATERIAL").equals("")) {
                                    MaterialEntity materialEntity = MaterialDAO.getInstance().getMaterialEntity(queryReport.get(i).get("MATERIAL").toString());
                                    materialDesc = materialEntity.getMaterialDesc();
                                } else materialDesc = "-";

                            %>
                            <tr>
                                <td style="color: #f2f2f2;">ประเภทวัสดุ&nbsp;<%=materialDesc%>&nbsp;ตั้งแต่ยุค&nbsp;พ.ศ.&nbsp;<%=queryReport.get(i).get("YEAR_FROM") == null ? "-" : queryReport.get(i).get("YEAR_FROM")%>&nbsp;ถึง&nbsp;<%=queryReport.get(i).get("YEAR_TO") == null ? "-" : queryReport.get(i).get("YEAR_TO")%></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                        <tr class="content_txt" style="vertical-align: middle;">
                            <td colspan="9" style="width:100%; text-align: center; padding-left: 0px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ไม่พบข้อมูล</td>
                        </tr>
                <%
                        session.removeAttribute("amulet_result");
                        session.removeAttribute("ex_amulet_result_form_bean");
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
            <td colspan="2"><jsp:include  page="footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="page" id="page" value="<%=formBean.getCurrentPage()%>"/>
</body>
</form>
</html>