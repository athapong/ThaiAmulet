<%@ page import="com.valhalla.amulet.bean.ExQueryReportBean" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
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
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/message.js"></script>
    <script src="resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <title>Exclusive::รายงานสรุปการใช้ข้อมูลลูกค้า</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });
    function goToPage(p) {
        $("#page").val(p);
        $( "#query_report_form" ).submit();
    }
    $(function() {
        $( "#dateStart" ).datepicker({
            showAnim: 'slideDown',
            duration: 'fast',
            dateFormat: "dd/mm/yy",
            changeMonth: true,
            changeYear: true,
            beforeShow: function(){
                $(".ui-datepicker").css('font-size', 12)
            }
        });

        $( "#dateEnd" ).datepicker({
            showAnim: 'slideDown',
            duration: 'fast',
            dateFormat: "dd/mm/yy",
            changeMonth: true,
            changeYear: true,
            beforeShow: function(){
                $(".ui-datepicker").css('font-size', 12)
            }
        });
    });

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
<%
    if (!AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
        request.getRequestDispatcher("unauthorized").forward(request, response);
    }

    // if session is valid
    UserBean bean = null;
    if (request.getSession().getAttribute("admin_session") == null) {
        response.sendRedirect("admin");
    } else {
        bean = (UserBean) request.getSession().getAttribute("admin_session");
    }
    ExQueryReportBean formBean = (ExQueryReportBean) request.getSession().getAttribute("ex_query_report_form_bean");
    if (formBean == null) {
        formBean = new ExQueryReportBean();
    }
%>
<form id="query_report_form" name="query_report_form" action="./qryrptservlet" method="post">
<body>
    <div class="loader"></div>
    <table width="100%" border="0">
        <jsp:include page="./exclusive/ex_menu.jsp?tab=2"/>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="3">รายงานสรุปการใช้ข้อมูลลูกค้า</td>
        </tr>
        <tr class="menu_dot">
            <td colspan="3" class="menu_dot">&nbsp;</td>
        </tr>
        <!-- begin search criteria -->
        <tr style="border-color: #dcac4e">
            <td colspan="3">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td style="width:10%;">&nbsp;</td>
                        <td class="caption">ชื่อ</td>
                        <td>
                            <input type="text" style="width:250px;" class="input_box" id="fname" name="fname" maxlength="250" value="<%=formBean.getFname()%>"/>
                        </td>
                        <td class="caption">นามสกุล</td>
                        <td><input type="text" style="width:250px;" class="input_box" id="lname" name="lname" maxlength="250" value="<%=formBean.getLname()%>"/></td>
                        <td style="width:15%;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="width:10%;">&nbsp;</td>
                        <td class="caption">username</td>
                        <td>
                            <input type="text" style="width:250px;" class="input_box" id="username" name="username" maxlength="250" value="<%=formBean.getUserName()%>"/>
                        </td>
                        <td class="caption">อีเมล</td>
                        <td>
                            <input type="email" style="width:250px;" class="input_box" id="email" name="email" maxlength="250" value="<%=formBean.getEmail()%>"/>
                        </td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:10%;">&nbsp;</td>
                        <td class="caption">เลขบัตรประชาชน</td>
                        <td>
                            <input type="number" style="width:250px;" class="input_box" id="idCardNo" name="idCardNo" maxlength="13" value="<%=formBean.getIdCardNo()%>"/>
                        </td>
                        <td class="caption">เลขอีมี่ (EMEI)/facebook account</td>
                        <td>
                            <input type="text" style="width:250px;" class="input_box" id="id4scan" name="id4scan" maxlength="250" value="<%=formBean.getId4Scan()%>" alt="เลชอีมี (EMEI) สำหรับ Android phone หรือ facebook account สำหรับ iPhone"/>
                        </td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:10%;">&nbsp;</td>
                        <td class="caption" style="width: 15%;">ช่วงเวลาค้นหาตั้งแต่</td>
                        <td>
                            <input type="text" style="width:150px;" class="input_date_box" readonly="true" id="dateStart" name="dateStart" value="<%=formBean.getDateStart()%>"/>
                        </td>
                        <td class="caption">ถึง</td>
                        <td>
                            <input type="text" style="width:150px;" class="input_date_box" readonly="true" id="dateEnd" name="dateEnd" value="<%=formBean.getDateEnd()%>"/>
                        </td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" colspan="4">&nbsp;</td>
                        <td style="text-align: left;" id="query_report_btn">
                            <input type="submit" name="searchBtnHidden" id="searchBtnHidden" hidden="hidden"/>
                            <span class="button" style="width:10%;" onclick="$('#searchBtnHidden').click();">&nbsp;&nbsp;&nbsp;ค้นหา&nbsp;&nbsp;&nbsp;</span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!-- end search criteria -->
        <!-- query report search result -->
        <tr>
            <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                <tr class="table_header">
                    <td style="width:15%; text-align: center; border-right:1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ชื่อ</td>
                    <td style="width:15%; text-align: center; border-right:1px dotted #dcac4e;">นามสกุล</td>
                    <td style="width:15%; text-align: center; border-right:1px dotted #dcac4e;">username</td>
                    <td style="width:15%; text-align: center; border-right:1px dotted #dcac4e;">อีเมล</td>
                    <td style="width:8%; text-align: center; border-right:1px dotted #dcac4e;">ID No.</td>
                    <td style="width:8%; text-align: center; border-right:1px dotted #dcac4e;">Phone No.</td>
                    <td style="width:16%; text-align: center;">จำนวนครั้งในการค้นหาข้อมูล</td>
                </tr>
                <%
                    if (session.getAttribute("query_report_result") != null) {
                        List<HashMap> queryReport = (List) session.getAttribute("query_report_result");
                        for (int i=0;i<queryReport.size();i++) {
                            if (i % 2 == 0) {
                %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #020821">
                    <% }  else { %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #151d3b">
                    <% } %>
                    <td style="width:15%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;"><%=queryReport.get(i).get("FNAME")%></td>
                    <td style="width:15%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=queryReport.get(i).get("LNAME")%></td>
                    <td style="width:15%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=queryReport.get(i).get("USER_NAME")%></td>
                    <td style="width:15%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=queryReport.get(i).get("EMAIL")%></td>
                    <td style="width:8%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=queryReport.get(i).get("ID_CARD")%></td>
                    <td style="width:8%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=queryReport.get(i).get("ID4SCAN")%></td>
                    <td style="width:16%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=queryReport.get(i).get("SEARCH_CNT")%></td>
                </tr>
                <%
                        }
                    } else {
                %>
                        <tr class="content_txt" style="vertical-align: middle;">
                            <td colspan="9" style="width:100%; text-align: center; padding-left: 0px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ไม่พบข้อมูล</td>
                        </tr>
                <%
                        session.removeAttribute("query_report_result");
                        session.removeAttribute("ex_query_report_form_bean");
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