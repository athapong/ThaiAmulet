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
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <script src="./resources/message.js"></script>
    <title>คู่มือพระ.com :: รายการห้องสมุดพระเครื่อง</title>
</head>
<script language="JavaScript">
    $(document).ready(function () {
        $("#inquire_knowhow_btn").click(function() {
            $( "#inquiry_knowhow_form" ).submit();
        });
    });
    function goToPage(p) {
        $("#page").val(p);
        inquiry_knowhow_form.submit();
    }
    $("#isdropdownchange_btn").click(function() {
        $("#isdropdownchange").val('Y');
        $("#inquiry_knowhow_form").submit();
    });
</script>
<body>
<form id="inquiry_knowhow_form" action="./mgtkmservlet" method="post">

    <%
        // if session is valid
        UserBean bean = null;
        AdminManageKnowHowBean formBean = (AdminManageKnowHowBean) request.getSession().getAttribute("ex_manage_knowhow_form_bean");
        if (formBean == null) {
            formBean = new AdminManageKnowHowBean();
        }
        List<RegionEntity> regionEntities = RegionDAO.getInstance().getRegionEntities();
        List<ProvinceEntity> provinceEntities = null;
        if (formBean.getRegion() != null && !formBean.getRegion().equals("")) {
            provinceEntities = ProvinceDAO.getInstance().getProvinceEntitiesByRegion(formBean.getRegion());
        }

        List<MatType1Entity> matType1Entities = MatType1DAO.getInstance().getMatType1Entities();
        List<MatType2Entity> matType2Entities = MatType2DAO.getInstance().getMatType2Entities();
    %>
    <table width="100%" border="0">
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;">รายการห้องสมุดพระเครื่อง</td>
            <td style="text-align: right;"></td>
        </tr>
        <tr class="menu_dot">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>
        <!-- begin search criteria -->
        <tr style="border-color: #dcac4e">
            <td colspan="3">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td style="width:5%;">&nbsp;</td>
                        <td class="caption" style="width: 10%;">ตามหัวข้อ</td>
                        <td>
                            <input type="text" style="width:150px; !important" class="input_box" id="subject" name="subject" maxlength="250" value="<%=formBean.getSubject()%>"/>
                        </td>
                        <td class="caption">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:5%;">&nbsp;</td>
                        <td class="caption">ภาค</td>
                        <td>
                            <select class="select" name="region" style="border-radius: 4px; border: 1px solid #dcac4e; width:150px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=2 onchange="$('#isdropdownchange_btn').click()">
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (RegionEntity regionEntity : regionEntities) {
                                        int value = regionEntity.getGeoId();
                                        if (formBean != null && formBean.getRegion().equals(String.valueOf(value))) {
                                %>
                                    <option value="<%=value%>" selected><%=regionEntity.getGeoName()%></option>
                                <% } else {%>
                                    <option value="<%=value%>"><%=regionEntity.getGeoName()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption" style="width:20%;">จังหวัด</td>
                        <td>
                            <select class="select" name="province" style="border-radius: 4px; border: 1px solid #dcac4e; width:200px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=3>
                                <option value="" selected>กรุณาเลือก</option>
                                <% if (provinceEntities != null) {
                                        for (ProvinceEntity provinceEntity : provinceEntities) {
                                            int value = provinceEntity.getProvinceId();
                                            if (formBean != null && formBean.getProvince().equals(String.valueOf(provinceEntity.getProvinceId()))) {%>
                                                <option value="<%=value%>" selected><%=provinceEntity.getProvinceName()%></option>
                                        <%  } else {%>
                                                <option value="<%=value%>"><%=provinceEntity.getProvinceName()%></option>
                                        <%  }
                                    }
                                }%>
                            </select>
                        </td>
                        <td style="width:15%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width:10%;">&nbsp;</td>
                        <td class="caption">ผงหรือโลหะ</td>
                        <td>
                            <select class="select" name="matType1" style="border-radius: 4px; border: 1px solid #dcac4e; width:150px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=4>
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (MatType1Entity matType1Entity : matType1Entities) {
                                        int value = matType1Entity.getMatType1Code();
                                        if (formBean != null && formBean.getMatType1().equals(String.valueOf(matType1Entity.getMatType1Code()))) {%>
                                    <option value="<%=matType1Entity.getMatType1Code()%>" selected><%=matType1Entity.getMatType1Desc()%></option>
                                <% } else {%>
                                    <option value="<%=matType1Entity.getMatType1Code()%>"><%=matType1Entity.getMatType1Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption">ประเภทเนื้อโลหะ</td>
                        <td>
                            <select class="select" name="matType2" style="border-radius: 4px; border: 1px solid #dcac4e; width:200px; height:25px; font-family: fontawesomeregular; font-size:1.25em;" tabindex=5>
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (MatType2Entity matType2Entity : matType2Entities) {
                                        int value = matType2Entity.getMatType2Code();
                                        if (formBean != null && formBean.getMatType2().equals(String.valueOf(matType2Entity.getMatType2Code()))) {%>
                                <option value="<%=matType2Entity.getMatType2Code()%>" selected><%=matType2Entity.getMatType2Desc()%></option>
                                <% } else {%>
                                <option value="<%=matType2Entity.getMatType2Code()%>"><%=matType2Entity.getMatType2Desc()%></option>
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
                    <td style="width:70%; text-align: center; border-right:1px dotted #dcac4e; border-left:1px dotted #dcac4e;" colspan="2">หัวข้อ</td>
                    <td style="width:10%; text-align: center; border-right:1px dotted #dcac4e;">จำนวนผู้เข้าชม</td>
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
                    <td class="news_detail_img2"><a href="ExDoUpdateKnowHowServlet?knowhowId=<%=knowhow.get(i).get("KH_ID")%>"><img src="<%=(knowhow.get(i).get("PIC_1") == null ? "resources/images/noimage.png" : knowhow.get(i).get("PIC_1"))%>" style="max-width: 50px;"/></a></td>
                    <td style="width:70%; text-align: left; padding-left: 3px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="ExDoUpdateKnowHowServlet?knowhowId=<%=knowhow.get(i).get("KH_ID")%>"><%=(knowhow.get(i).get("SUBJECT_NAME") == null ? "&nbsp;" : AmuletUtils.trimWithDotMore((String) knowhow.get(i).get("SUBJECT_NAME"), 90))%></a></td>
                    <td style="width:15%; text-align: right; padding-right: 10px; border-right:1px dotted #dcac4e; border-bottom: 1px dotted #dcac4e;"><a href="ExDoUpdateKnowHowServlet?knowhowId=<%=knowhow.get(i).get("KH_ID")%>"><%=(knowhow.get(i).get("VIEW_CNT") == null ? "&nbsp;" : knowhow.get(i).get("VIEW_CNT"))%></a></td>
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
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>
        </tr>
        <% if (formBean.getPageCount() > 0) {%>
        <tr class="paging">
            <td class="paging" colspan="2" style="text-align:center;">
                <table style="border-spacing: 0px; vertical-align: top; width: 100%;">
                    <span style="float: center; width:5%;" class="paging">หน้าที่</span>
                    <span style="float: center;width: 95%" class="paging">
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
    <input type="hidden" name="isdropdownchange" id="isdropdownchange"/>
    <input type="submit" id="isdropdownchange_btn" hidden="hidden"/>
</form>
</body>
</html>