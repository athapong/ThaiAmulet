<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.*" %>
<%@ page import="com.valhalla.amulet.bean.AmuletMasterBean" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.entity.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<html>
<head>
    <meta equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <script src="./resources/message.js"></script>
    <script src="./resources/checkid.js"></script>
    <title>ค้นหาข้อมูลพระเครื่อง</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>

<script language="JavaScript">
    $(document).ready(function () {
        $("#isdropdownchange_btn").click(function() {
            $("#isdropdownchange").val('Y');
            $("#ex_inq_amulet_form").submit();
        });

        $("#doAddAmuletMaster").click(function() {
            $('#ex_inq_amulet_form').attr('action', 'ExDoAddAmuletServlet');
            $('#ex_inq_amulet_form').attr('method', 'post');
            $('#ex_inq_amulet_form').attr('enctype', 'multipart/form-data');
            $('#ex_inq_amulet_form').attr('acceptcharset', 'UTF-8');
            $("#ex_inq_amulet_form").submit();
        });
    });
</script>
<form id="ex_inq_amulet_form" action="ExDoInquiryAmuletServlet" method="post" style="text-align:center;">
<body>
    <div class="loader"></div>
    <%
        if (!AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession"))) {
            request.getRequestDispatcher("unauthorized").forward(request, response);
        }
        AmuletMasterBean formBean = (AmuletMasterBean) request.getSession().getAttribute("ex_amulet_master_form_bean");
        if (formBean == null) {
            formBean = new AmuletMasterBean();
        }
    %>
    <%
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
    %>
    <table width="100%" border="0" cellpadding="0" border="0" align="center" cellspacing="0">
        <jsp:include page="./admin/admin_menu.jsp?tab=4"/>
        <tr style="vertical-align: middle">
            <td class="caption" style="padding-bottom: 10px; color: #f2d576; font-size: 1em; text-align: left;" colspan="2"><label style="font-size: 1.5em;">ชื่อพระเครื่อง</label>&nbsp;
                <input type="text" id="amulet_name" name="amulet_name" style="width: 250px;" maxlength="100" value="<%=formBean.getAMULET_NAME() == null ? "" : formBean.getAMULET_NAME()%>"/>

                <span class="button" style="width:10%; display: inline-block; text-align: center; float:right;" onclick="window.open('amuletsrchresultpage','_self')" tabindex="11">ยกเลิก</span>
                <span style="float:right;">&nbsp;</span>
                <span id="doAddAmuletMaster" class="button" style="width:10%; display: inline-block; text-align: center; float:right;" tabindex="10">บันทึก</span>
            </td>

        </tr>
        <tr class="menu_dot" style="padding-top:5px;">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td rowspan="3" style="width:18%; vertical-align: top;">
                <li>
                    <input type="file" class="button_upload" id="pic1" name="pic1" accept="image/*" style="display:none;" required onchange="alert(this.val());" >
                    <input type="button" style="width:180px; font-size: 1.25em;" class="button_upload" onclick="document.getElementById('pic1').click()" value="เลือกไฟล์"/>
                </li>
            </td>
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right;">ขนาด กว้าง </td>
                        <td style="width: 10%;" colspan="3">
                            <input type="text"  id="s_width" name="s_width" class="numbersOnly" style="width: 80px;" value="<%=formBean.getS_WIDTH() == null ? "" : formBean.getS_WIDTH()%>"/><label class="caption"> ซม.&nbsp;&nbsp;ยาว </label><input type="text" id="s_long" name="s_long" style="width: 80px;" value="<%=formBean.getS_LONG() == null ? "" : formBean.getS_LONG()%>"/><label class="caption"> ซม.&nbsp;&nbsp;หนา </label><input type="text" id="s_tall" name="s_tall" style="width: 80px;" value="<%=formBean.getS_TALL() == null ? "" : formBean.getS_TALL()%>"/><label class="caption"> ซม.</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ประเภทวัสดุ</td>
                        <td style="width: 10%;" colspan="3">
                            <% List<MaterialEntity> materialEntities = MaterialDAO.getInstance().getMaterialEntities();%>
                            <select id="material" name="material" style="width: 150px;" class="select">
                                <option selected value="">กรุณาเลือก</option>
                                <% for (MaterialEntity entity : materialEntities) {%>
                                    <% if (entity.getMaterialCode() == Integer.parseInt(formBean.getMATERIAL().equals("") ? "0" : formBean.getMATERIAL())) {%>
                                    <option value="<%=entity.getMaterialCode()%>" selected><%=entity.getMaterialDesc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getMaterialCode()%>"><%=entity.getMaterialDesc()%></option>
                                    <% } %>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ยุคตั้งแต่ พ.ศ.</td>
                        <td style="width: 10%;"><input type="text" id="year_from" name="year_from" style="width: 150px;" maxlength="4" value="<%=formBean.getYEAR_FROM()%>"/></td>
                        <td class="caption" style="width: 10%;">ถึง พ.ศ.</td>
                        <td style="width: 10%;"><input type="text" id="year_to" name="year_to" style="width: 150px;" maxlength="4" value="<%=formBean.getYEAR_TO()%>"/></td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ทรง</td>
                        <td style="width: 10%;">
                            <% List<Form1Entity> form1Entities = Form1DAO.getInstance().getForm1Entities();%>
                            <select id="form_1" name="form_1" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (Form1Entity entity : form1Entities) {%>
                                    <% if (entity.getForm1Code() == Integer.parseInt(formBean.getFORM_1())) {%>
                                    <option value="<%=entity.getForm1Code()%>" selected><%=entity.getForm1Desc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getForm1Code()%>"><%=entity.getForm1Desc()%></option>
                                    <% } %>
                                <%}%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">รูปทรง</td>
                        <td style="width: 10%;">
                            <% List<Form2Entity> form2Entities = Form2DAO.getInstance().getForm2Entities();%>
                            <select id="form_2" name="form_2" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (Form2Entity entity : form2Entities) {%>
                                    <% if (entity.getForm2Code() == Integer.parseInt(formBean.getFORM_2())) {%>
                                    <option value="<%=entity.getForm2Code()%>" selected><%=entity.getForm2Desc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getForm2Code()%>"><%=entity.getForm2Desc()%></option>
                                    <% } %>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ปาง</td>
                        <td style="width: 10%;">
                            <% List<CharacterEntity> characterEntities = CharacterDAO.getInstance().getCharacterEntities();%>
                            <select id="character" name="character" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (CharacterEntity entity : characterEntities) {%>
                                    <% if (entity.getCharacterCode() == Integer.parseInt(formBean.getAMULET_CHARACTER())) {%>
                                    <option value="<%=entity.getCharacterCode()%>" selected><%=entity.getCharacterDesc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getCharacterCode()%>"><%=entity.getCharacterDesc()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">สี</td>
                        <td style="width: 10%;">
                            <% List<ColorEntity> colorEntities = ColorDAO.getInstance().getColorEntities();%>
                            <select id="color" name="color" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (ColorEntity entity : colorEntities) {%>
                                    <% if (entity.getColorCode() == Integer.parseInt(formBean.getCOLOR())) {%>
                                    <option value="<%=entity.getColorCode()%>" selected><%=entity.getColorDesc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getColorCode()%>"><%=entity.getColorDesc()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อหลวงพ่อ</td>
                        <td style="width: 10%;"><input type="text" id="vernerable" name="vernerable" style="width: 150px;" value="<%=formBean.getVERNERABLE()%>"/></td>
                        <td class="caption" style="width: 10%;">วัด</td>
                        <td style="width: 10%;"><input type="text" id="temple" name="temple" style="width: 150px;" value="<%=formBean.getTEMPLE()%>"/></td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">จังหวัด</td>
                        <td style="width: 10%;">
                            <% List<ProvinceEntity> provinceEntities = ProvinceDAO.getInstance().getProvinceEntities();%>
                            <select id="province" name="province" style="width: 150px;" class="select" onchange="$('#isdropdownchange_btn').click()">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (ProvinceEntity entity : provinceEntities) {%>
                                    <% if (entity.getProvinceId() == Integer.parseInt(formBean.getPROVINCE_CODE())) {%>
                                    <option value="<%=entity.getProvinceId()%>" selected><%=entity.getProvinceName()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getProvinceId()%>"><%=entity.getProvinceName()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">อำเภอ</td>
                        <td style="width: 10%;">
                            <% List<AmphurEntity> amphurEntities = AmphurDAO.getInstance().getAmphurEntities(Integer.parseInt(formBean.getPROVINCE_CODE()));%>
                            <select id="amphur_code" name="amphur_code" style="width: 150px;" class="select" onchange="$('#isdropdownchange_btn').click()">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (AmphurEntity entity : amphurEntities) {%>
                                    <% if (entity.getAmphurId() == Integer.parseInt(formBean.getAMPHUR_CODE())) {%>
                                    <option value="<%=entity.getAmphurId()%>" selected><%=entity.getAmphurName()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getAmphurId()%>"><%=entity.getAmphurName()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ตำบล</td>
                        <td style="width: 10%;">
                            <% List<TambolEntity> tambolEntities = TambolDAO.getInstance().getTambolEntities(Integer.parseInt(formBean.getPROVINCE_CODE()), Integer.parseInt(formBean.getAMPHUR_CODE()));%>
                            <select id="tambol_code" name="tambol_code" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (TambolEntity entity : tambolEntities) {%>
                                    <% if (entity.getDistrictId() == Integer.parseInt(formBean.getDISTRICT_CODE())) {%>
                                    <option value="<%=entity.getDistrictId()%>" selected><%=entity.getDistrictName()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getDistrictId()%>"><%=entity.getDistrictName()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">เกจฯ หรือ กรุ</td>
                        <td style="width: 10%;">
                            <% List<ChamberEntity> chamberEntities = ChamberDAO.getInstance().getChamberEntities();%>
                            <select id="chamber" name="chamber" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (ChamberEntity entity : chamberEntities) {%>
                                    <% if (entity.getChamberCode() == Integer.parseInt(formBean.getCHAMBER())) {%>
                                    <option value="<%=entity.getChamberCode()%>" selected><%=entity.getChamberDesc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getChamberCode()%>"><%=entity.getChamberDesc()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">ห้อยคอ หรือบูชา</td>
                        <td style="width: 10%;">
                            <% List<LocketEntity> locketEntities = LocketDAO.getInstance().getLocketEntities();%>

                            <select id="locket_fl" name="locket_fl" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (LocketEntity locketEntity : locketEntities) {%>
                                    <% if (locketEntity.getLocketCode() == Integer.parseInt(formBean.getLOCKET_FL())) {%>
                                    <option value="<%=locketEntity.getLocketCode()%>" selected><%=locketEntity.getLocketDesc()%></option>
                                    <% } else {%>
                                    <option value="<%=locketEntity.getLocketCode()%>"><%=locketEntity.getLocketDesc()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ผง หรือโลหะ</td>
                        <td style="width: 10%;">
                            <% List<MatType1Entity> matType1Entities = MatType1DAO.getInstance().getMatType1Entities();%>
                            <select id="mat_type_1" name="mat_type_1" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (MatType1Entity entity : matType1Entities) {%>
                                    <% if (entity.getMatType1Code() == Integer.parseInt(formBean.getMAT_TYPE_1())) {%>
                                    <option value="<%=entity.getMatType1Code()%>" selected><%=entity.getMatType1Desc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getMatType1Code()%>"><%=entity.getMatType1Desc()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">ประเภทเนื้อโลหะ</td>
                        <td style="width: 10%;">
                            <% List<MatType2Entity> matType2Entities = MatType2DAO.getInstance().getMatType2Entities();%>
                            <select id="mat_type_2" name="mat_type_2" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (MatType2Entity entity : matType2Entities) {%>
                                    <% if (entity.getMatType2Code() == Integer.parseInt(formBean.getMAT_TYPE_2())) {%>
                                    <option value="<%=entity.getMatType2Code()%>" selected><%=entity.getMatType2Desc()%></option>
                                    <% } else {%>
                                    <option value="<%=entity.getMatType2Code()%>"><%=entity.getMatType2Desc()%></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ขนาดหน้าตัก</td>
                        <td style="width: 10%;"><input type="text" id="meditation_l" name="meditation_l" style="width:150px;" value="<%=formBean.getMEDITATION_L() == null ? "" : formBean.getMEDITATION_L()%>"/>&nbsp;<label class="caption"> ซม.</label></td>
                        <td class="caption" style="width: 10%;">&nbsp;</td>
                        <td style="width: 10%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ราคาตั้งแต่</td>
                        <td style="width: 10%;"><input type="text" id="price_from" name="price_from" style="width:150px;" value="<%=formBean.getPRICE_FROM() == null ? "" : formBean.getPRICE_FROM()%>"/></td>
                        <td class="caption" style="width: 10%;">ถึง</td>
                        <td style="width: 10%;"><input type="text" id="price_to" name="price_to" style="width:150px;" value="<%=formBean.getPRICE_TO() == null ? "" : formBean.getPRICE_TO()%>"/></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="menu_left" colspan="4" style="color:#f2d576; text-align: center;">
                <label style="font-size: 1.5em;">เพิ่มเติม</label>
            </td>
        </tr>
        <tr class="menu_dot" style="padding-top:5px;">
            <td colspan="4" class="menu_dot" style="line-height:1px;">&nbsp;</td>
        </tr>

        <tr>
            <td rowspan="1" style="width: 15%;">
                &nbsp;
            </td>
            <td>
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px; border-bottom:none;">
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right; vertical-align: top;">ตำหนิอย่างไร</td>
                        <td class="caption" style="text-align: left;">
                            <textarea id="defect_des_1" name="defect_des_1" style="width: 100%; height: 200px; font-family: fontawesomeregular; font-size:0.9em; color:black; background-color: white"><%=formBean.getDEFECT_DES_1() == null ? "" : formBean.getDEFECT_DES_1()%></textarea>
                        </td>
                    </tr>
                </table>
            </td>

        </tr>
        <tr>
            <td rowspan="1" style="width: 15%;">
                &nbsp;
            </td>
            <td>
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right;">รายละเอียดมวลสาร</td>
                        <% List<MatDescEntity> matDescEntities = MatDescDAO.getInstance().getMatDescEntities();%>

                        <td class="caption" style="text-align: left;">
                            <select id="mat_des_1" name="mat_des_1" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (MatDescEntity entity : matDescEntities) {%>
                                <% if (entity.getMatDescCode() == Integer.parseInt(formBean.getMAT_DES_1())) {%>
                                <option value="<%=entity.getMatDescCode()%>" selected><%=entity.getMatDescDesc()%></option>
                                <% } else {%>
                                <option value="<%=entity.getMatDescCode()%>"><%=entity.getMatDescDesc()%></option>
                                <% } %>
                                <% } %>
                            </select>
                            และ
                            <select id="mat_des_2" name="mat_des_2" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (MatDescEntity entity : matDescEntities) {%>
                                <% if (entity.getMatDescCode() == Integer.parseInt(formBean.getMAT_DES_2())) {%>
                                <option value="<%=entity.getMatDescCode()%>" selected><%=entity.getMatDescDesc()%></option>
                                <% } else {%>
                                <option value="<%=entity.getMatDescCode()%>"><%=entity.getMatDescDesc()%></option>
                                <% } %>
                                <% } %>
                            </select>
                            และ
                            <select id="mat_des_3" name="mat_des_3" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (MatDescEntity entity : matDescEntities) {%>
                                <% if (entity.getMatDescCode() == Integer.parseInt(formBean.getMAT_DES_3())) {%>
                                <option value="<%=entity.getMatDescCode()%>" selected><%=entity.getMatDescDesc()%></option>
                                <% } else {%>
                                <option value="<%=entity.getMatDescCode()%>"><%=entity.getMatDescDesc()%></option>
                                <% } %>
                                <% } %>
                            </select>
                            และ
                            <select id="mat_des_4" name="mat_des_4" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (MatDescEntity entity : matDescEntities) {%>
                                <% if (entity.getMatDescCode() == Integer.parseInt(formBean.getMAT_DES_4())) {%>
                                <option value="<%=entity.getMatDescCode()%>" selected><%=entity.getMatDescDesc()%></option>
                                <% } else {%>
                                <option value="<%=entity.getMatDescCode()%>"><%=entity.getMatDescDesc()%></option>
                                <% } %>
                                <% } %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right;">Rating</td>
                        <% List<RatingEntity> ratingEntities = RatingDAO.getInstance().getRatingEntities();%>

                        <td class="caption" style="text-align: left;">
                            <select id="rating" name="rating" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (RatingEntity entity : ratingEntities) {%>
                                <% if (entity.getRatingCode() == Integer.parseInt(formBean.getRATING())) {%>
                                <option value="<%=entity.getRatingCode()%>" selected><%=entity.getRatingDesc()%></option>
                                <% } else {%>
                                <option value="<%=entity.getRatingCode()%>"><%=entity.getRatingDesc()%></option>
                                <% } %>
                                <% } %>
                            </select>
                        </td>
                    </tr>


                    <tr class="menu_dot" style="padding-top:5px;">
                        <td colspan="4" class="menu_dot" style="line-height:1px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" colspan="4" style="color:#f2d576; text-align: left;">
                            <label style="font-size: 1.25em;">รายละเอียด</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="content_txt_middle" colspan="4">
                            <textarea id="note" name="note" style="color:#000000; width: 100%; height: 400px; font-family: fontawesomeregular; font-size:0.9em;"><%=formBean.getNOTE()%></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>



    </table>
    <table style="width:100%;">
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="page" value="AdminAddAmuletMaster"/>
    <input type="hidden" name="isdropdownchange" id="isdropdownchange"/>
    <input type="submit" id="isdropdownchange_btn" hidden="hidden"/>
</body>
</form>
<script>
    $("#ex_inq_amulet_form").validate({
        lang: 'th'
    });
</script>
</html>