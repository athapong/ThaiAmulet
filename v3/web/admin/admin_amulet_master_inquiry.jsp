<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.AmuletMasterInquiryBean" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>ผู้ดูแลระบบ::จัดการข้อมูลพระเครื่อง</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });
    $(document).ready(function () {
        $("#inquire_amulet_btn").click(function() {
            $( "#inquiry_amulet_form" ).submit();
        });
        if ('<%=session.getAttribute("deleteAmulet")%>' == 'success') {
            $( "#oper_delete_status_txt").removeAttr("hidden");
            $( "#oper_delete_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
        if ('<%=session.getAttribute("updateamulet")%>' == 'success') {
            $( "#oper_update_status_txt").removeAttr("hidden");
            $( "#oper_update_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
    });
    function goToPage(p) {
        $("#page").val(p);
        inquiry_amulet_form.submit();
    }
    function deleteAmulet(id) {
        if (confirm("ต้องการลบข้อมูลพระเครื่อง?")) {
            $("#deleteAmulet").val(id);
            inquiry_amulet_form.submit();
        } else return;
    }
</script>
<body>
<div class="loader"></div>
<form id="inquiry_amulet_form" action="./amuletinqservlet" method="post">
<%
    if (!AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession"))) {
        request.getRequestDispatcher("unauthorized").forward(request, response);
    }
    // if session is valid
    UserBean bean = null;
    if (request.getSession().getAttribute("admin_session") == null) {
        response.sendRedirect("admin");
    } else {
        bean = (UserBean) request.getSession().getAttribute("admin_session");
    }
    AmuletMasterInquiryBean formBean = (AmuletMasterInquiryBean) request.getSession().getAttribute("amulet_master_inquiry_form_bean");
    if (formBean == null) {
        formBean = new AmuletMasterInquiryBean();
    }
    session.removeAttribute("deleteAmulet");
    session.removeAttribute("updateamulet");
%>



    <table width="100%" border="0">
        <jsp:include page="admin/admin_menu.jsp?tab=4"/>
        <tr id="oper_update_status_txt" hidden="hidden">
            <td class="success_text" colspan="2">บันทึกสำเร็จแล้ว</td>
        </tr>
        <tr id="oper_delete_status_txt" hidden="hidden">
            <td class="success_text" colspan="2">ลบข้อมูลสำเร็จแล้ว</td>
        </tr>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;">รายการพระเครื่อง</td>
            <td style="text-align: right;"><span class="button" style="width:10%;" onclick="window.open('addamuletpage','_self')">&nbsp;&nbsp;&nbsp;เพิ่มพระเครื่อง&nbsp;&nbsp;&nbsp;</span></td>
        </tr>
        <tr class="menu_dot">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

            <tr style="border-color: #dcac4e">
                <td colspan="2">
                    <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                        <tr>
                            <td class="caption" style="text-align: left;">ชื่อพระเครื่อง
                                &nbsp;
                                <input type="text" style="width:250px; !important" class="input_box" id="amuletName" name="amuletName" maxlength="250" value="<%=formBean.getAmuletName()%>"/>
                                &nbsp;<span class="button" id="inquire_amulet_btn" style="width:10%; display:inline-block; text-align: center">ค้นหา</span>
                            </td>
                            <td style="width:15%;">&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>


        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <!-- customer search result -->
        <tr>
            <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                <tr class="table_header">
                    <td style="width:80%; text-align: center; border-right:1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ชื่อพระเครื่อง</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">ลบข้อมูล</td>
                    <td style="width:10%; text-align: center;">แก้ไขข้อมูล</td>
                </tr>
                <%
                    if (session.getAttribute("amulet_master_inq_result") != null) {
                        List<HashMap> amulets = (List) session.getAttribute("amulet_master_inq_result");
                        for (int i=0;i<amulets.size();i++) {
                            if (i % 2 == 0) {
                %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #020821">
                    <% }  else { %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #151d3b">
                    <% } %>
                    <td style="width:80%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;"><%=(amulets.get(i).get("AMULET_NAME") == null ? "&nbsp;" : amulets.get(i).get("AMULET_NAME"))%></td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="javascript:deleteAmulet(<%=amulets.get(i).get("AMULET_CODE")%>)"><i class="fa fa-times-circle-o" style="color:#ff1d25;"></i></a></td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="./ExDoInquiryAmuletServlet?amulet_code=<%=amulets.get(i).get("AMULET_CODE")%>"><i class="fa fa-pencil-square-o"></i></a></td>
                </tr>
                <%
                        }
                    } else {
                %>
                        <tr class="content_txt" style="vertical-align: middle;">
                            <td colspan="9" style="width:100%; text-align: center; padding-left: 0px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ไม่พบข้อมูล</td>
                        </tr>
                <%
                        session.removeAttribute("amulet_master_inq_result");
                        session.removeAttribute("amulet_master_inquiry_form_bean");
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
    <input type="hidden" name="deleteAmulet" id="deleteAmulet"/>
</form>
</body>
</html>