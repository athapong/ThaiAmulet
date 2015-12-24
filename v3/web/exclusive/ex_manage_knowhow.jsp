<%@ page import="com.valhalla.amulet.MatType1DAO" %>
<%@ page import="com.valhalla.amulet.MatType2DAO" %>
<%@ page import="com.valhalla.amulet.ProvinceDAO" %>
<%@ page import="com.valhalla.amulet.RegionDAO" %>
<%@ page import="com.valhalla.amulet.bean.AdminManageKnowHowBean" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.entity.MatType1Entity" %>
<%@ page import="com.valhalla.amulet.entity.MatType2Entity" %>
<%@ page import="com.valhalla.amulet.entity.ProvinceEntity" %>
<%@ page import="com.valhalla.amulet.entity.RegionEntity" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>Exclusive::รายการห้องสมุดพระเครื่อง(สำหรับการจัดการ) </title>
</head>
<script language="JavaScript">
    $(document).ready(function () {
        $("#inquire_knowhow_btn").click(function() {
            $( "#inquiry_knowhow_form" ).submit();
        });
        $("#isdropdownchange_btn").click(function() {
            $("#isdropdownchange").val('Y');
            $("#inquiry_knowhow_form").submit();
        });
        if ('<%=session.getAttribute("deleteknowhow")%>' == 'success') {
            $( "#oper_delete_status_txt").removeAttr("hidden");
            $( "#oper_delete_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
        if ('<%=session.getAttribute("updateknowhow")%>' == 'success') {
            $( "#oper_update_status_txt").removeAttr("hidden");
            $( "#oper_update_status_txt" ).fadeOut( 2000, function() {
                // Animation complete
            });
        }
    });
    function goToPage(p) {
        $("#page").val(p);
        inquiry_knowhow_form.submit();
    }
    function deleteknowhow(id) {
        if (confirm("ต้องการลบข้อมูลรายการห้องสมุดพระเครื่อง?")) {
            $("#deleteknowhow").val(id);
            inquiry_knowhow_form.submit();
        } else return;
    }
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });
</script>
<body>
<div class="loader"></div>
<form id="inquiry_knowhow_form" action="./mgtkmservlet" method="post">
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
    AdminManageKnowHowBean formBean = (AdminManageKnowHowBean) request.getSession().getAttribute("ex_manage_knowhow_form_bean");
    if (formBean == null) {
        formBean = new AdminManageKnowHowBean();
    }
    session.removeAttribute("deleteknowhow");
    session.removeAttribute("updateknowhow");

    List<RegionEntity> regionEntities = RegionDAO.getInstance().getRegionEntities();
    List<ProvinceEntity> provinceEntities = null;
    if (formBean.getRegion() != null && !formBean.getRegion().equals("")) {
        provinceEntities = ProvinceDAO.getInstance().getProvinceEntitiesByRegion(formBean.getRegion());
    }

    List<MatType1Entity> matType1Entities = MatType1DAO.getInstance().getMatType1Entities();
    List<MatType2Entity> matType2Entities = MatType2DAO.getInstance().getMatType2Entities();
%>



    <table width="100%" border="0">
        <jsp:include page="./exclusive/ex_menu.jsp?tab=7"/>
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
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="2">รายการห้องสมุดพระเครื่อง</td>
            <td style="text-align: right;"><span class="button" style="width:10%;" onclick="window.open('addkmpage?param=add','_self')">&nbsp;&nbsp;&nbsp;เพิ่มข้อมูล&nbsp;&nbsp;&nbsp;</span></td>
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
                        <td class="caption">ตามหัวข้อ</td>
                        <td>
                            <input type="text" style="width:250px; !important" class="input_box" id="subject" name="subject" maxlength="250" value="<%=formBean.getSubject()%>"/>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:10%;">&nbsp;</td>
                        <td class="caption">ภาค</td>
                        <td>
                            <select class="select" name="region" style="border-radius: 4px; border: 1px solid #dcac4e; width:250px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=2 onchange="$('#isdropdownchange_btn').click()">
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (RegionEntity entity : regionEntities) {
                                        int value = entity.getGeoId();
                                        if (formBean != null && !formBean.getRegion().equals("") && value == Integer.parseInt(formBean.getRegion())) {%>
                                <option value="<%=value%>" selected><%=entity.getGeoName()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getGeoName()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption">จังหวัด</td>
                        <td>
                            <select class="select" name="province" style="border-radius: 4px; border: 1px solid #dcac4e; width:250px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=3>
                                <option value="" selected>กรุณาเลือก</option>
                                <% if (provinceEntities != null && formBean != null && !formBean.getRegion().equals("")) {%>
                                <%
                                    for (ProvinceEntity entity : provinceEntities) {
                                        String value = String.valueOf(entity.getProvinceId());
                                        if (formBean != null && value.equals(formBean.getProvince())) {%>
                                <option value="<%=value%>" selected><%=entity.getProvinceName()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getProvinceName()%></option>
                                <%}
                                }%>
                                <%}%>
                            </select>
                        </td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:10%;">&nbsp;</td>
                        <td class="caption">ผงหรือโลหะ</td>
                        <td>
                            <select class="select" name="matType1" style="border-radius: 4px; border: 1px solid #dcac4e; width:250px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=4>
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (MatType1Entity entity: matType1Entities) {
                                        String value = String.valueOf(entity.getMatType1Code());
                                        if (formBean != null && value.equals(formBean.getMatType1())) {%>
                                <option value="<%=value%>" selected><%=entity.getMatType1Desc()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getMatType1Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption">ประเภทเนื้อโลหะ</td>
                        <td>
                            <select class="select" name="matType2" style="border-radius: 4px; border: 1px solid #dcac4e; width:250px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=5>
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (MatType2Entity entity : matType2Entities) {
                                        String value = String.valueOf(entity.getMatType2Code());
                                        if (formBean != null && value.equals(formBean.getMatType2())) {%>
                                <option value="<%=value%>" selected><%=entity.getMatType2Desc()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getMatType2Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" colspan="4">&nbsp;</td>
                        <td style="text-align: left;" id="inquire_knowhow_btn"><span class="button" style="width:10%;">&nbsp;&nbsp;&nbsp;ค้นหา&nbsp;&nbsp;&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
        <!-- end search criteria -->
        <!-- knowhow search result -->
        <tr>
            <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                <tr class="table_header">
                    <td style="width:70%; text-align: center; border-right:1px dotted #dcac4e; border-left:1px dotted #dcac4e;">หัวข้อ</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">จำนวนผู้เข้าชม</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">ลบข้อมูล</td>
                    <td style="width:10%; text-align: center;">แก้ไขข้อมูล</td>
                </tr>
                <%
                    if (session.getAttribute("knowhow_inq_result") != null) {
                        List<HashMap> knowhow = (List) session.getAttribute("knowhow_inq_result");
                        for (int i=0;i<knowhow.size();i++) {
                            if (i % 2 == 0) {
                %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #020821">
                    <% }  else { %>
                <tr class="content_txt" style="vertical-align: middle; background-color: #151d3b">
                    <% } %>
                    <td style="width:70%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;"><%=(knowhow.get(i).get("SUBJECT_NAME") == null ? "&nbsp;" : AmuletUtils.trimWithDotMore((String) knowhow.get(i).get("SUBJECT_NAME"), 90))%></td>
                    <td style="width:10%; text-align: right; padding-right: 10px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><%=(knowhow.get(i).get("VIEW_CNT") == null ? "&nbsp;" : knowhow.get(i).get("VIEW_CNT"))%></td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="javascript:deleteknowhow(<%=knowhow.get(i).get("KH_ID")%>)"><i class="fa fa-times-circle-o" style="color:#ff1d25;"></i></a></td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="./ExDoUpdateKnowHowServlet?knowhowId=<%=knowhow.get(i).get("KH_ID")%>"><i class="fa fa-pencil-square-o"></i></a></td>
                </tr>
                <%
                        }
                    } else {
                %>
                        <tr class="content_txt" style="vertical-align: middle;">
                            <td colspan="9" style="width:100%; text-align: center; padding-left: 0px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e; border-left:1px dotted #dcac4e;">ไม่พบข้อมูล</td>
                        </tr>
                <%
                        session.removeAttribute("knowhow_inq_result");
                        session.removeAttribute("ex_manage_knowhow_form_bean");
                    }
                %>
                <tr style="height: 10px;">
                    <td colspan="3">&nbsp;</td>
                </tr>
            </table>
        </tr>
        <% if (formBean.getPageCount() > 0) {%>
        <tr class="paging">
            <td class="paging" colspan="3">
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
            <td colspan="3"><jsp:include  page="footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="page" id="page" value="<%=formBean.getCurrentPage()%>"/>
    <input type="hidden" name="deleteknowhow" id="deleteknowhow"/>
    <input type="hidden" name="isdropdownchange" id="isdropdownchange"/>
    <input type="submit" id="isdropdownchange_btn" hidden="hidden"/>
</form>
</body>
</html>