<%@ page import="com.valhalla.amulet.MatType1DAO" %>
<%@ page import="com.valhalla.amulet.MatType2DAO" %>
<%@ page import="com.valhalla.amulet.ProvinceDAO" %>
<%@ page import="com.valhalla.amulet.RegionDAO" %>
<%@ page import="com.valhalla.amulet.bean.AdminManageKnowHowBean" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.entity.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <script src="./resources/message.js"></script>
    <title>Exclusive::รายการห้องสมุดพระเครื่อง(สำหรับการจัดการ) </title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });
    $(document).ready(function () {
        $("#isdropdownchange_btn").click(function () {
            $("#isdropdownchange").val('Y');
            $("#ex_add_knowhow_form").submit();
        });
    });
</script>
<body>
<div class="loader"></div>
<form id="ex_add_knowhow_form" action="ExDoUpdateKnowHowServlet" method="post" enctype="multipart/form-data" acceptcharset="UTF-8">
    <%
        if (!AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
            request.getRequestDispatcher("unauthorized").forward(request, response);
        }
        AmuletKnowhowEntity knowhowEntity = null;
        if (request.getSession().getAttribute("knowhow_entity") != null) {
            knowhowEntity = (AmuletKnowhowEntity) request.getSession().getAttribute("knowhow_entity");
        }
        if (request.getParameter("param") != null && request.getParameter("param").equals("add")) {
            knowhowEntity = null;
        }
        // if session is valid
        if (request.getSession().getAttribute("admin_session") == null) {
            request.getRequestDispatcher("admin").forward(request,response);
        }
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
        List<RegionEntity> regionEntities = RegionDAO.getInstance().getRegionEntities();
        List<ProvinceEntity> provinceEntities = null;
        if (knowhowEntity != null && knowhowEntity.getRegionCode() != null && !knowhowEntity.getRegionCode().equals("")) {
            provinceEntities = ProvinceDAO.getInstance().getProvinceEntitiesByRegion(knowhowEntity.getRegionCode());
        }
        if (formBean.getRegion() != null && !formBean.getRegion().equals("")) {
            provinceEntities = ProvinceDAO.getInstance().getProvinceEntitiesByRegion(formBean.getRegion());
        }

        List<MatType1Entity> matType1Entities = MatType1DAO.getInstance().getMatType1Entities();
        List<MatType2Entity> matType2Entities = MatType2DAO.getInstance().getMatType2Entities();
    %>
    <table width="100%" border="0">
        <jsp:include page="./exclusive/ex_menu.jsp?tab=7"/>
        <tr style="vertical-align: middle">
            <td class="caption" style="padding-bottom: 10px; padding-top:10px; font-size: 1em; padding-left: 25px; text-align: left;" colspan="3"><label style="font-size: 1.5em;">หัวข้อ</label><span class="required">*</span>&nbsp;&nbsp;<input type="text" style="width:350px;" class="input_box" id="subject" name="subject" maxlength="250" value="<%=knowhowEntity == null ? "" : knowhowEntity.getSubjectName()%>" tabindex=1 required/>
                <span class="button" style="width:10%; float: right; text-align: center;" onclick="window.open('mgtkmservlet','_self')" tabindex="11">ยกเลิก</span>
                <span style="float:right;">&nbsp;</span>
                <span class="button" style="width:10%; float: right; text-align: center;" onclick="$('#submit_btn').click()" tabindex="10">บันทึก</span>
                <input type="submit" id="submit_btn" hidden="hidden"/>
            </td>
        </tr>
        <tr class="menu_dot" style="padding-top:5px;">
            <td colspan="3" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td rowspan="3" style="width: 200px; vertical-align: top;">
                <li>
                    <input type="file" class="button_upload" id="pic1" name="pic1" accept="image/*" style="display:none;" required>
                    <input type="button" style="width:180px; font-size: 1.25em;" class="button_upload" onclick="document.getElementById('pic1').click()" value="เลือกไฟล์"/>
                </li>
                <li>
                    <input type="file" class="button_upload" id="pic2" name="pic2" accept="image/*" style="display:none;" required>
                    <input type="button" style="width:180px; font-size: 1.25em;" class="button_upload" onclick="document.getElementById('pic2').click()" value="เลือกไฟล์"/>
                </li>
                <li>
                    <input type="file" class="button_upload" id="pic3" name="pic3" accept="image/*" style="display:none;" required>
                    <input type="button" style="width:180px; font-size: 1.25em;" class="button_upload" onclick="document.getElementById('pic3').click()" value="เลือกไฟล์"/>
                </li>
                <li>
                    <input type="file" class="button_upload" id="pic4" name="pic4" accept="image/*" style="display:none;" required>
                    <input type="button" style="width:180px; font-size: 1.25em;" class="button_upload" onclick="document.getElementById('pic4').click()" value="เลือกไฟล์"/>
                </li>
                <li>
                    <input type="file" class="button_upload" id="pic5" name="pic5" accept="image/*" style="display:none;" required>
                    <input type="button" style="width:180px; font-size: 1.25em;" class="button_upload" onclick="document.getElementById('pic5').click()" value="เลือกไฟล์"/>
                </li>
            </td>
            <td colspan="3">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td class="caption" style="width: 10%;">ภาค<span class="required">*</span></td>
                        <td class="content_txt_middle" style="width:40%;" colspan="3">
                            <select class="select" name="region" style="border-radius: 4px; border: 1px solid #dcac4e; width:150px; height:25px; font-family: fontawesomeregular; font-size:0.9em;" tabindex=2 onchange="$('#isdropdownchange_btn').click()">
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (RegionEntity entity : regionEntities) {
                                        int value = entity.getGeoId();
                                        if (formBean != null
                                                && (!formBean.getRegion().equals("") && value == Integer.parseInt(formBean.getRegion()) )
                                                || (knowhowEntity != null && value == Integer.parseInt(knowhowEntity.getRegionCode()))) {%>
                                <option value="<%=value%>" selected><%=entity.getGeoName()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getGeoName()%></option>
                                <%}
                                }%>
                            </select>
                        </td>

                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">จังหวัด<span class="required">*</span></td>
                        <td class="content_txt_middle" colspan="3">
                            <select class="select" name="province" style="border-radius: 4px; border: 1px solid #dcac4e; width:150px; height:25px; font-family: fontawesomeregular; font-size:0.9em;" tabindex=3>
                                <option value="" selected>กรุณาเลือก</option>
                                <% if (provinceEntities != null) {%>
                                <%
                                    for (ProvinceEntity entity : provinceEntities) {
                                        String value = String.valueOf(entity.getProvinceId());
                                        if (formBean != null
                                                && (!formBean.getProvince().equals("") && value.equals(Integer.parseInt(formBean.getProvince())))
                                                || (knowhowEntity != null && value.equals(knowhowEntity.getProvince()))) {%>
                                <option value="<%=value%>" selected><%=entity.getProvinceName()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getProvinceName()%></option>
                                <%}
                                }%>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ผงหรือโลหะ<span class="required">*</span></td>
                        <td class="content_txt_middle" colspan="3">
                            <select class="select" name="matType1" style="border-radius: 4px; border: 1px solid #dcac4e; width:150px; height:25px; font-family: fontawesomeregular; font-size:0.9em;" tabindex=4 >
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (MatType1Entity entity: matType1Entities) {
                                        String value = String.valueOf(entity.getMatType1Code());
                                        if (formBean != null
                                                && (!formBean.getMatType1().equals("") && value.equals(Integer.parseInt(formBean.getMatType1())))
                                                || (knowhowEntity != null && value.equals(knowhowEntity.getMatType1()))) {%>
                                <option value="<%=value%>" selected><%=entity.getMatType1Desc()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getMatType1Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ประเภทเนื้อโลหะ<span class="required">*</span></td>
                        <td class="content_txt_middle" colspan="3">
                            <select class="select" name="matType2" style="border-radius: 4px; border: 1px solid #dcac4e; width:150px; height:25px; font-family: fontawesomeregular; font-size:0.9em;" tabindex=5>
                                <option value="" selected>กรุณาเลือก</option>
                                <%
                                    for (MatType2Entity entity : matType2Entities) {
                                        String value = String.valueOf(entity.getMatType2Code());
                                        if (formBean != null
                                                && (!formBean.getMatType2().equals("") && value.equals(Integer.parseInt(formBean.getMatType2())))
                                                || (knowhowEntity != null && value.equals(knowhowEntity.getMatType2()))) {%>
                                <option value="<%=value%>" selected><%=entity.getMatType2Desc()%></option>
                                <% } else {%>
                                <option value="<%=value%>"><%=entity.getMatType2Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>

                    <tr class="menu_dot" style="padding-top:5px;">
                        <td colspan="4" class="menu_dot" style="line-height:1px;">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="caption" style="width: 20%; text-align:left;" colspan="4">รายละเอียด<span class="required">*</span></td>

                    </tr>
                    <tr>
                        <td class="content_txt_middle" colspan="4">
                            <textarea id="content" name="content" style="width: 100%; height: 400px; font-family: fontawesomeregular; font-size:0.9em;" tabindex="6" required><%=knowhowEntity == null ? "" : knowhowEntity.getContent()%></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="menu_left" colspan="3">
                <%if (knowhowEntity != null && knowhowEntity.getPublishFl() == 1) {%>
                    <input type="checkbox" id="publish" name="publish" value="1" checked tabindex="7"/>
                <%} else {%>
                    <input type="checkbox" id="publish" name="publish" value="1" tabindex="7"/>
                <%}%>
                <label style="caption-side: bottom">ตีพิมพ์หรือไม่</label>
            </td>
        </tr>
        <tr>
            <td colspan="3"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="knowhowId" id="knowhowId" value="<%=knowhowEntity == null ? "" : knowhowEntity.getKhId()%>"/>
    <input type="hidden" name="isdropdownchange" id="isdropdownchange"/>
    <input type="submit" id="isdropdownchange_btn" hidden="hidden"/>
</form>

</body>
<script>
    $("#ex_add_knowhow_form").validate({
        lang: 'th'
    });
</script>
</html>