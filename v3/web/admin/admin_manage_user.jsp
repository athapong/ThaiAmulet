<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.AdminManageUserBean" %>
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
    <title>ผู้ดูแลระบบ::จัดการข้อมูลผู้ใช้</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
    $(document).ready(function () {
        $("#inquire_user_btn").click(function() {
            $( "#inquiry_user_form" ).submit();
        });
        if ('<%=session.getAttribute("deleteMember")%>' == 'success') {
            $( "#oper_delete_status_txt").removeAttr("hidden");
            $( "#oper_delete_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
        if ('<%=session.getAttribute("updateMember")%>' == 'success') {
            $( "#oper_update_status_txt").removeAttr("hidden");
            $( "#oper_update_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
    });
    function goToPage(p) {
        $("#page").val(p);
        inquiry_user_form.submit();
    }
    function deleteUser(id) {
        if (confirm("ต้องการลบข้อมูลสมาชิก?")) {
            $("#deleteMember").val(id);
            inquiry_user_form.submit();
        } else return;
    }
    $(function() {
        $("input#username").on({
            keydown: function(e) {
                if (e.which === 32)
                    return false;
            },
            change: function() {
                // Regex-remove all spaces in the final value
                this.value = this.value.replace(/\s/g, "");
            }
        });
    });
</script>
<body>
<div class="loader"></div>
<form id="inquiry_user_form" action="./custinqservlet" method="post">
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
    AdminManageUserBean formBean = (AdminManageUserBean) request.getSession().getAttribute("admin_manage_user_form_bean");
    if (formBean == null) {
        formBean = new AdminManageUserBean();
    }
    session.removeAttribute("deleteMember");
    session.removeAttribute("updateMember");
%>



    <table width="100%" border="0">
        <jsp:include page="admin/admin_menu.jsp?tab=2"/>
        <tr id="oper_update_status_txt" hidden="hidden">
            <td class="success_text" colspan="2">บันทึกสำเร็จแล้ว</td>
        </tr>
        <tr id="oper_delete_status_txt" hidden="hidden">
            <td class="success_text" colspan="2">ลบข้อมูลสำเร็จแล้ว</td>
        </tr>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;">ค้นหาข้อมูลสมาชิก</td>
            <td style="text-align: right;" onclick="window.open('admaddusrpage','_self')"><span class="button" style="width:10%;">&nbsp;&nbsp;&nbsp;เพิ่มผู้ใช้งาน&nbsp;&nbsp;&nbsp;</span></td>
        </tr>
        <tr class="menu_dot">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

            <tr style="border-color: #dcac4e">
                <td colspan="2">
                    <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                        <tr>
                            <td style="width:10%;">&nbsp;</td>
                            <td class="caption">ชื่อ</td>
                            <td>
                                <input type="text" style="width:200px; !important" class="input_box" id="firstname" name="firstname" maxlength="250" value="<%=formBean.getFname()%>"/>
                            </td>
                            <td class="caption">นามสกุล</td>
                            <td>
                                <input type="text" style="width:200px;" class="input_box" id="lastname" name="lastname" maxlength="250" value="<%=formBean.getLname()%>"/>
                            </td>
                            <td style="width:15%;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width:10%;">&nbsp;</td>
                            <td class="caption">username</td>
                            <td>
                                <input type="text" style="width:200px;" class="input_box" id="username" name="username" maxlength="25" value="<%=formBean.getUsername()%>"/>
                            </td>
                            <td class="caption">อีเมล</td>
                            <td>
                                <input type="text" style="width:200px;" class="input_box" id="email" name="email" maxlength="250" value="<%=formBean.getEmail()%>"/>
                            </td>
                            <td style="width:15%;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width:10%;">&nbsp;</td>
                            <td class="caption">เลขบัตรประชาชน</td>
                            <td>
                                <input type="number" style="width:200px;" class="input_box" id="idcardno" name="idcardno" maxlength="13" value="<%=formBean.getIdCardNo()%>"/>
                            </td>
                            <td class="caption">เบอร์โทรศัพท์</td>
                            <td>
                                <input type="number" style="width:200px;" class="input_box" id="phoneno" name="phoneno" maxlength="250" value="<%=formBean.getMobileNo()%>"/>
                            </td>
                            <td style="width:15%;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="caption" colspan="4">&nbsp;</td>
                            <td style="text-align: left;" id="inquire_user_btn"><span class="button" style="width:10%;">&nbsp;&nbsp;&nbsp;ค้นหา&nbsp;&nbsp;&nbsp;</span></td>
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
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ชื่อ</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">นามสกุล</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">username</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">ประเภทผู้ใช้งาน</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">อีเมล</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">ID No.</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">Phone No.</td>
                    <td style="width:5%; text-align: center; border-right:1px dotted #dcac4e;">ลบข้อมูล</td>
                    <td style="width:5%; text-align: center;">แก้ไขข้อมูล</td>
                </tr>
                <%
                    if (session.getAttribute("cust_inq_result") != null) {
                        List<HashMap> member = (List) session.getAttribute("cust_inq_result");
                        formBean.setPageCount(AmuletUtils.calTotalPage(member.size()));
                        for (int i=0;i<member.size();i++) {
                            if (i % 2 == 0) {
                %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #020821">
                    <% }  else { %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #151d3b">
                    <% } %>
                    <td style="width:10%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;"><%=(member.get(i).get("FNAME") == null ? "&nbsp;" : member.get(i).get("FNAME"))%></td>
                    <td style="width:10%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(member.get(i).get("LNAME") == null ? "&nbsp;" : member.get(i).get("LNAME"))%></td>
                    <td style="width:10%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(member.get(i).get("USER_NAME") == null ? "&nbsp;" : member.get(i).get("USER_NAME"))%></td>
                    <td style="width:10%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(member.get(i).get("ROLE_NAME") == null ? "&nbsp;" : member.get(i).get("ROLE_NAME"))%></td>
                    <td style="width:10%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(member.get(i).get("EMAIL") == null ? "&nbsp;" : member.get(i).get("EMAIL"))%></td>
                    <td style="width:10%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(member.get(i).get("ID_CARD") == null ? "&nbsp;" : member.get(i).get("ID_CARD"))%></td>
                    <td style="width:10%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(member.get(i).get("PHONE_NO2") == null ? "&nbsp;" : member.get(i).get("PHONE_NO2"))%></td>
                    <td style="width:5%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="javascript:deleteUser(<%=member.get(i).get("MEMBER_ID")%>)"><i class="fa fa-times-circle-o" style="color:#ff1d25;"></i></a></td>
                    <td style="width:5%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="./previewuserservlet?memberId=<%=member.get(i).get("MEMBER_ID")%>"><i class="fa fa-pencil-square-o"></i></a></td>
                </tr>
                <%
                        }
                    } else {
                %>
                        <tr class="content_txt" style="vertical-align: middle;">
                            <td colspan="9" style="width:100%; text-align: center; padding-left: 0px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ไม่พบข้อมูล</td>
                        </tr>
                <%
                        session.removeAttribute("cust_inq_result");
                        session.removeAttribute("admin_manage_user_form_bean");
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
    <input type="hidden" name="deleteMember" id="deleteMember"/>
</form>
</body>
</html>