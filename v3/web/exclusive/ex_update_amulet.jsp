<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.mysql.jdbc.StringUtils" %>
<%@ page import="com.valhalla.amulet.*" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.entity.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="com.valhalla.amulet.bean.AmuletMasterBean" %>
<%@ page import="com.valhalla.amulet.constants.AmuletConstants" %>
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
    <title>ข้อมูลพระเครื่อง</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
    $(document).ready(function () {
        $("#isdropdownchange_btn").click(function() {
            $("#isdropdownchange").val('Y');
            $("#ex_update_amulet_form").submit();
        });
        $("#doUpdateAmuletMaster").click(function() {
            $('#ex_update_amulet_form').attr('action', 'ExDoUpdateAmuletServlet');
            $('#ex_update_amulet_form').attr('method', 'post');
            $('#ex_update_amulet_form').attr('enctype', 'multipart/form-data');
            $('#ex_update_amulet_form').attr('acceptcharset', 'UTF-8');
            $("#ex_update_amulet_form").submit();
        });
    });
</script>
<body>
<div class="loader"></div>
<form id="ex_update_amulet_form" name="ex_update_amulet_form" action="ExDoInquiryAmuletServlet" method="post" acceptcharset="UTF-8">
    <%
        if (!AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession")) && !AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession"))) {
            request.getRequestDispatcher("unauthorized").forward(request, response);
        }
        AmuletMasterBean formBean = (AmuletMasterBean) request.getSession().getAttribute("ex_amulet_master_form_bean");
        AmuletMasterEntity amuletEntity = null;
        if (request.getSession().getAttribute("amulet_item_result") != null) {
            amuletEntity = (AmuletMasterEntity) request.getSession().getAttribute("amulet_item_result");
        }
        if (formBean != null){
            // replicate amuletEntity with formBean
            amuletEntity = (AmuletMasterEntity) request.getSession().getAttribute("amulet_item_result");
            amuletEntity.setAmuletName(formBean.getAMULET_NAME());
            amuletEntity.setsWidth(formBean.getS_WIDTH());
            amuletEntity.setsLong(formBean.getS_LONG());
            amuletEntity.setsTall(formBean.getS_TALL());
            amuletEntity.setMaterial(formBean.getMATERIAL());
            amuletEntity.setYearFrom(formBean.getYEAR_FROM());
            amuletEntity.setYearTo(formBean.getYEAR_TO());
            amuletEntity.setForm1(formBean.getFORM_1());
            amuletEntity.setForm2(formBean.getFORM_2());
            amuletEntity.setAmuletCharacter(formBean.getAMULET_CHARACTER());
            amuletEntity.setColor(formBean.getCOLOR());
            amuletEntity.setVernerable(formBean.getVERNERABLE());
            amuletEntity.setTemple(formBean.getTEMPLE());
            amuletEntity.setProvinceCode(formBean.getPROVINCE_CODE());
            amuletEntity.setAmphurCode(formBean.getAMPHUR_CODE());
            amuletEntity.setDistrictCode(formBean.getDISTRICT_CODE());
            amuletEntity.setChamber(formBean.getCHAMBER());
            amuletEntity.setLocketFl(formBean.getLOCKET_FL());
            amuletEntity.setMatType1(formBean.getMAT_TYPE_1());
            amuletEntity.setMatType2(formBean.getMAT_TYPE_2());
            amuletEntity.setMeditationL(formBean.getMEDITATION_L());
            amuletEntity.setPriceFrom(formBean.getPRICE_FROM());
            amuletEntity.setPriceTo(formBean.getPRICE_TO());
            amuletEntity.setDefectDes1(formBean.getDEFECT_DES_1());
            amuletEntity.setMatDes1(formBean.getMAT_DES_1());
            amuletEntity.setMatDes2(formBean.getMAT_DES_2());
            amuletEntity.setMatDes3(formBean.getMAT_DES_3());
            amuletEntity.setMatDes4(formBean.getMAT_DES_4());
            amuletEntity.setRating(formBean.getRATING());
            amuletEntity.setNote(formBean.getNOTE());
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


    %>
    <table width="100%" border="0">
        <%
            bean = (UserBean) request.getSession().getAttribute("admin_session");
            if (bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {
        %>
        <jsp:include page="./admin/admin_menu.jsp?tab=4"/>
        <% } else if (bean.getRole().equals(AmuletConstants.EXCV_TYPE)) {%>
        <jsp:include page="./exclusive/ex_menu.jsp?tab=4"/>
        <% } %>
        <tr style="vertical-align: middle">
            <td class="caption" style="padding-bottom: 10px; color: #f2d576; font-size: 1em; text-align: center;" colspan="2"><label style="font-size: 1.5em;">แก้ไขข้อมูลพระเครื่อง</label></td>
        </tr>
        <tr class="menu_dot" style="padding-top:5px;">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td rowspan="1" style="width: 200px; vertical-align: top;">
                <li>
                    <input type="file" class="button_upload" id="pic1" name="pic1" accept="image/*" style="display:none;">
                    <input type="button" style="width:180px; font-size: 1.25em;" class="button_upload" onclick="document.getElementById('pic1').click()" value="เลือกไฟล์"/>
                </li>
            </td>
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อพระเครื่อง</td>
                        <td style="width: 10%;" colspan="3">
                            <input type="text" id="amulet_name" name="amulet_name" style="width: 150px;" maxlength="100" value="<%=amuletEntity.getAmuletName()%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right;">ขนาด กว้าง </td>
                        <td style="width: 10%;" colspan="3">
                            <input type="number"  id="s_width" name="s_width" class="numbersOnly" style="width: 80px;" value="<%=amuletEntity.getsWidth() == null ? "" : amuletEntity.getsWidth()%>"/><label class="caption"> ซม.&nbsp;&nbsp;ยาว </label><input type="text" id="s_long" name="s_long" style="width: 80px;" value="<%=amuletEntity.getsLong() == null ? "" : amuletEntity.getsLong()%>"/><label class="caption"> ซม.&nbsp;&nbsp;หนา </label><input type="text" id="s_tall" name="s_tall" style="width: 80px;" value="<%=amuletEntity.getsTall() == null ? "" : amuletEntity.getsTall()%>"/><label class="caption"> ซม.</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ประเภทวัสดุ</td>
                        <td style="width: 10%;" colspan="3">
                            <% List<MaterialEntity> materialEntities = MaterialDAO.getInstance().getMaterialEntities();%>
                            <select id="material" name="material" style="width: 150px;" class="select">
                                <option value="0" selected>กรุณาเลือก</option>
                                <% for (MaterialEntity entity : materialEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getMaterial()) && amuletEntity.getMaterial().equals(entity.getMaterialCode())) {
                                %>
                                        <option value="<%=entity.getMaterialCode()%>" selected><%=entity.getMaterialDesc()%></option>
                                <%  } else {%>
                                        <option value="<%=entity.getMaterialCode()%>"><%=entity.getMaterialDesc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ยุคตั้งแต่ พ.ศ.</td>
                        <td style="width: 10%;"><input type="number" id="year_from" name="year_from" style="width: 150px;" maxlength="4" value="<%=amuletEntity.getYearFrom() == null ? "" : amuletEntity.getYearFrom()%>"/></td>
                        <td class="caption" style="width: 10%;">ถึง พ.ศ.</td>
                        <td style="width: 10%;"><input type="number" id="year_to" name="year_to" style="width: 150px;" maxlength="4" value="<%=amuletEntity.getYearTo() == null ? "" : amuletEntity.getYearTo()%>"/></td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ทรง</td>
                        <td style="width: 10%;">
                            <% List<Form1Entity> form1Entities = Form1DAO.getInstance().getForm1Entities();%>
                            <select id="form_1" name="form_1" style="width: 150px;" class="select">
                                <option value="0" selected>กรุณาเลือก</option>
                                <% for (Form1Entity form1Entity : form1Entities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getForm1()) && amuletEntity.getForm1().equals(form1Entity.getForm1Code())) {
                                %>
                                    <option value="<%=form1Entity.getForm1Code()%>" selected><%=form1Entity.getForm1Desc()%></option>
                                <%  } else {%>
                                    <option value="<%=form1Entity.getForm1Code()%>"><%=form1Entity.getForm1Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">รูปทรง</td>
                        <td style="width: 10%;">
                            <% List<Form2Entity> form2Entities = Form2DAO.getInstance().getForm2Entities();%>
                            <select id="form_2" name="form_2" style="width: 150px;" class="select">
                                <% for (Form2Entity form2Entity : form2Entities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getForm2()) && amuletEntity.getForm2().equals(form2Entity.getForm2Code())) {
                                %>
                                <option value="<%=form2Entity.getForm2Code()%>" selected><%=form2Entity.getForm2Desc()%></option>
                                <%  } else {%>
                                <option value="<%=form2Entity.getForm2Code()%>"><%=form2Entity.getForm2Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ปาง</td>
                        <td style="width: 10%;">
                            <% List<CharacterEntity> characterEntities = CharacterDAO.getInstance().getCharacterEntities();%>
                            <select id="character" name="character" style="width: 150px;" class="select">
                                <option value="0" selected>กรุณาเลือก</option>
                                <% for (CharacterEntity characterEntity : characterEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getAmuletCharacter()) && amuletEntity.getAmuletCharacter().equals(characterEntity.getCharacterCode())) {
                                %>
                                <option value="<%=characterEntity.getCharacterCode()%>" selected><%=characterEntity.getCharacterDesc()%></option>
                                <%  } else {%>
                                <option value="<%=characterEntity.getCharacterCode()%>"><%=characterEntity.getCharacterDesc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">สี</td>
                        <td style="width: 10%;">
                            <% List<ColorEntity> colorEntities = ColorDAO.getInstance().getColorEntities();%>
                            <select id="color" name="color" style="width: 150px;" class="select">
                                <% for (ColorEntity colorEntity : colorEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getColor()) && amuletEntity.getColor().equals(colorEntity.getColorCode())) {
                                %>
                                <option value="<%=colorEntity.getColorCode()%>" selected><%=colorEntity.getColorDesc()%></option>
                                <%  } else {%>
                                <option value="<%=colorEntity.getColorCode()%>"><%=colorEntity.getColorDesc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อหลวงพ่อ</td>
                        <td style="width: 10%;"><input type="text" id="vernerable" name="vernerable" style="width: 150px;" value="<%=amuletEntity.getVernerable() == null ? "" : amuletEntity.getVernerable()%>"/></td>
                        <td class="caption" style="width: 10%;">วัด</td>
                        <td style="width: 10%;"><input type="text" id="temple" name="temple" style="width: 150px;" value="<%=amuletEntity.getTemple() == null ? "" : amuletEntity.getTemple()%>"/></td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">จังหวัด</td>
                        <td style="width: 10%;">
                            <% List<ProvinceEntity> provinceEntities = ProvinceDAO.getInstance().getProvinceEntities();%>
                            <select id="province" name="province" style="width: 150px;" class="select" onchange="$('#isdropdownchange_btn').click()">
                                <option value="0" selected>กรุณาเลือก</option>
                                <% for (ProvinceEntity provinceEntity : provinceEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getProvinceCode()) && Integer.parseInt(amuletEntity.getProvinceCode()) == provinceEntity.getProvinceId()) {
                                %>
                                <option value="<%=provinceEntity.getProvinceId()%>" selected><%=provinceEntity.getProvinceName()%></option>
                                <%  } else {%>
                                <option value="<%=provinceEntity.getProvinceId()%>"><%=provinceEntity.getProvinceName()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">อำเภอ</td>
                        <td style="width: 10%;">
                            <%
                                List<AmphurEntity> amphurEntities = new ArrayList<AmphurEntity>();
                                if (!StringUtils.isNullOrEmpty(amuletEntity.getProvinceCode())) {
                                    amphurEntities = AmphurDAO.getInstance().getAmphurEntities(Integer.valueOf(amuletEntity.getProvinceCode()));
                                }
                            %>
                            <select id="amphur_code" name="amphur_code" style="width: 150px;" class="select" onchange="$('#isdropdownchange_btn').click()">
                                <option value="0" selected>กรุณาเลือก</option>
                                <% for (AmphurEntity amphurEntity : amphurEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getAmphurCode()) && amuletEntity.getAmphurCode().equals(String.valueOf(amphurEntity.getAmphurId()))) {
                                %>
                                <option value="<%=amphurEntity.getAmphurId()%>" selected><%=amphurEntity.getAmphurName()%></option>
                                <%  } else {%>
                                <option value="<%=amphurEntity.getAmphurId()%>"><%=amphurEntity.getAmphurName()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ตำบล</td>
                        <td style="width: 10%;">
                            <%
                                List<TambolEntity> tambolEntities = new ArrayList<TambolEntity>();
                                if (!StringUtils.isNullOrEmpty(amuletEntity.getDistrictCode())) {
                                    tambolEntities = TambolDAO.getInstance().getTambolEntities(Integer.parseInt(amuletEntity.getProvinceCode()), Integer.parseInt(amuletEntity.getAmphurCode()));
                                }
                            %>
                            <select id="tambol_code" name="tambol_code" style="width: 150px;" class="select">
                                <option value="0" selected>กรุณาเลือก</option>
                                <% for (TambolEntity tambolEntity : tambolEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getDistrictCode()) && amuletEntity.getDistrictCode().equals(String.valueOf(tambolEntity.getDistrictId()))) {
                                %>
                                <option value="<%=tambolEntity.getDistrictId()%>" selected><%=tambolEntity.getDistrictName()%></option>
                                <%  } else {%>
                                <option value="<%=tambolEntity.getDistrictId()%>"><%=tambolEntity.getDistrictName()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">เกจฯ หรือ กรุ</td>
                        <td style="width: 10%;">
                            <% List<ChamberEntity> chamberEntities = ChamberDAO.getInstance().getChamberEntities();%>
                            <select id="chamber" name="chamber" style="width: 150px;" class="select">
                                <% for (ChamberEntity chamberEntity : chamberEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getChamber()) && amuletEntity.getChamber().equals(String.valueOf(chamberEntity.getChamberCode()))) {
                                %>
                                <option value="<%=chamberEntity.getChamberCode()%>" selected><%=chamberEntity.getChamberDesc()%></option>
                                <%  } else {%>
                                <option value="<%=chamberEntity.getChamberCode()%>"><%=chamberEntity.getChamberDesc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">ห้อยคอ หรือบูชา</td>
                        <td style="width: 10%;">
                            <% List<LocketEntity> locketEntities = LocketDAO.getInstance().getLocketEntities();%>

                            <select id="locket_fl" name="locket_fl" style="width: 150px;" class="select">
                                <option value="0" selected>กรุณาเลือก</option>
                                <% for (LocketEntity locketEntity : locketEntities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getLocketFl()) && amuletEntity.getLocketFl().equals(String.valueOf(locketEntity.getLocketCode()))) {
                                %>
                                <option value="<%=locketEntity.getLocketCode()%>" selected><%=locketEntity.getLocketDesc()%></option>
                                <%  } else {%>
                                <option value="<%=locketEntity.getLocketCode()%>"><%=locketEntity.getLocketDesc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ผง หรือโลหะ</td>
                        <td style="width: 10%;">
                            <% List<MatType1Entity> matType1Entities = MatType1DAO.getInstance().getMatType1Entities();%>
                            <select id="mat_type_1" name="mat_type_1" style="width: 150px;" class="select">
                                <% for (MatType1Entity matType1Entity : matType1Entities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getMatType1()) && amuletEntity.getMatType1().equals(String.valueOf(matType1Entity.getMatType1Code()))) {
                                %>
                                <option value="<%=matType1Entity.getMatType1Code()%>" selected><%=matType1Entity.getMatType1Desc()%></option>
                                <%  } else {%>
                                <option value="<%=matType1Entity.getMatType1Code()%>"><%=matType1Entity.getMatType1Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">ประเภทเนื้อโลหะ</td>
                        <td style="width: 10%;">
                            <% List<MatType2Entity> matType2Entities = MatType2DAO.getInstance().getMatType2Entities();%>
                            <select id="mat_type_2" name="mat_type_2" style="width: 150px;" class="select">
                                <% for (MatType2Entity matType2Entity : matType2Entities) {
                                    if(!StringUtils.isNullOrEmpty(amuletEntity.getMatType2()) && amuletEntity.getMatType2().equals(String.valueOf(matType2Entity.getMatType2Code()))) {
                                %>
                                <option value="<%=matType2Entity.getMatType2Code()%>" selected><%=matType2Entity.getMatType2Desc()%></option>
                                <%  } else {%>
                                <option value="<%=matType2Entity.getMatType2Code()%>"><%=matType2Entity.getMatType2Desc()%></option>
                                <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ขนาดหน้าตัก</td>
                        <td style="width: 10%;"><input type="number" id="meditaion_l" name="mediation_l" style="width:150px;" value="<%=amuletEntity.getMeditationL() == null ? "" : amuletEntity.getMeditationL()%>"/>&nbsp;<label class="caption"> ซม.</label></td>
                        <td class="caption" style="width: 10%;">&nbsp;</td>
                        <td style="width: 10%;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ราคาตั้งแต่</td>
                        <td style="width: 10%;"><input type="number" id="price_from" name="price_from" style="width:150px;" value="<%=amuletEntity.getPriceFrom() == null ? "" : amuletEntity.getPriceFrom()%>"/></td>
                        <td class="caption" style="width: 10%;">ถึง</td>
                        <td style="width: 10%;"><input type="number" id="price_to" name="price_to" style="width:150px;" value="<%=amuletEntity.getPriceTo() == null ? "" : amuletEntity.getPriceTo()%>"/></td>
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

        <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px; border-bottom:none;">
            <tr>
                <td class="caption" style="width: 30%; text-align: right; vertical-align: top;">ตำหนิอย่างไร</td>
                <td class="caption" style="text-align: left;">
                    <textarea id="defect_des_1" name="defect_des_1" style="width: 100%; height: 200px; font-family: fontawesomeregular; font-size:0.9em; color:black; background-color: white"><%=amuletEntity == null ? "" : amuletEntity.getDefectDes1()%></textarea>
                </td>
            </tr>
        </table>
        <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
            <tr>
                <td class="caption" style="width: 30%; text-align: right;">รายละเอียดมวลสาร</td>
                <% List<MatDescEntity> matDescEntities = MatDescDAO.getInstance().getMatDescEntities();%>

                <td class="caption" style="text-align: left;">
                    <select id="mat_des_1" name="mat_des_1" style="width: 150px;" class="select">
                        <option value="0" selected>กรุณาเลือก</option>
                        <% for (MatDescEntity matDescEntity : matDescEntities) {
                            if(!StringUtils.isNullOrEmpty(amuletEntity.getMatDes1()) && amuletEntity.getMatDes1().equals(String.valueOf(matDescEntity.getMatDescCode()))) {
                        %>
                        <option value="<%=matDescEntity.getMatDescCode()%>" selected><%=matDescEntity.getMatDescDesc()%></option>
                        <%  } else {%>
                        <option value="<%=matDescEntity.getMatDescCode()%>"><%=matDescEntity.getMatDescDesc()%></option>
                        <%}
                        }%>
                    </select>
                    และ
                    <select id="mat_des_2" name="mat_des_2" style="width: 150px;" class="select">
                        <option value="0" selected>กรุณาเลือก</option>
                        <% for (MatDescEntity matDesc2Entity : matDescEntities) {
                            if(!StringUtils.isNullOrEmpty(amuletEntity.getMatDes1()) && amuletEntity.getMatDes2().equals(String.valueOf(matDesc2Entity.getMatDescCode()))) {
                        %>
                        <option value="<%=matDesc2Entity.getMatDescCode()%>" selected><%=matDesc2Entity.getMatDescDesc()%></option>
                        <%  } else {%>
                        <option value="<%=matDesc2Entity.getMatDescCode()%>"><%=matDesc2Entity.getMatDescDesc()%></option>
                        <%}
                        }%>
                    </select>
                    และ
                    <select id="mat_des_3" name="mat_des_3" style="width: 150px;" class="select">
                        <option value="0" selected>กรุณาเลือก</option>
                        <% for (MatDescEntity matDesc3Entity : matDescEntities) {
                            if(!StringUtils.isNullOrEmpty(amuletEntity.getMatDes3()) && amuletEntity.getMatDes3().equals(String.valueOf(matDesc3Entity.getMatDescCode()))) {
                        %>
                        <option value="<%=matDesc3Entity.getMatDescCode()%>" selected><%=matDesc3Entity.getMatDescDesc()%></option>
                        <%  } else {%>
                        <option value="<%=matDesc3Entity.getMatDescCode()%>"><%=matDesc3Entity.getMatDescDesc()%></option>
                        <%}
                        }%>
                    </select>
                    และ
                    <select id="mat_des_4" name="mat_des_4" style="width: 150px;" class="select">
                        <option value="0" selected>กรุณาเลือก</option>
                        <% for (MatDescEntity matDesc4Entity : matDescEntities) {
                            if(!StringUtils.isNullOrEmpty(amuletEntity.getMatDes4()) && amuletEntity.getMatDes4().equals(String.valueOf(matDesc4Entity.getMatDescCode()))) {
                        %>
                        <option value="<%=matDesc4Entity.getMatDescCode()%>" selected><%=matDesc4Entity.getMatDescDesc()%></option>
                        <%  } else {%>
                        <option value="<%=matDesc4Entity.getMatDescCode()%>"><%=matDesc4Entity.getMatDescDesc()%></option>
                        <%}
                        }%>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="caption" style="width: 30%; text-align: right;">Rating</td>
                <% List<RatingEntity> ratingEntities = RatingDAO.getInstance().getRatingEntities();%>

                <td class="caption" style="text-align: left;">
                    <select id="rating" name="rating" style="width: 150px;" class="select">
                        <option value="0" selected>กรุณาเลือก</option>
                        <% for (RatingEntity ratingEntity : ratingEntities) {
                            if(!StringUtils.isNullOrEmpty(amuletEntity.getRating()) && amuletEntity.getRating().equals(String.valueOf(ratingEntity.getRatingCode()))) {
                        %>
                        <option value="<%=ratingEntity.getRatingCode()%>" selected><%=ratingEntity.getRatingDesc()%></option>
                        <%  } else {%>
                        <option value="<%=ratingEntity.getRatingCode()%>"><%=ratingEntity.getRatingDesc()%></option>
                        <%}
                        }%>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="caption" style="width: 20%; text-align:right; vertical-align:top;">รายละเอียด</td>
                <td class="content_txt_middle" colspan="4">
                    <textarea id="note" name="note" style="width: 100%; height: 400px; font-family: fontawesomeregular; font-size:0.9em;" tabindex="6"><%=amuletEntity.getNote() == null ? "" : amuletEntity.getNote()%></textarea>
                </td>
            </tr>
        </table>
        <tr style="vertical-align: middle; padding-top: 20px;">
            <td class="caption" style="padding-bottom: 10px; font-size: 1em; padding-left: 25px; text-align: left;" colspan="2">
                <br/>
                <span class="button" style="width:10%; float: right; text-align: center;" onclick="window.open('amuletinqservlet','_self')" tabindex="11">ยกเลิก</span>
                <span style="float:right;">&nbsp;</span>
                <span id="doUpdateAmuletMaster" class="button" style="width:10%; float: right; text-align: center;" tabindex="10">บันทึก</span>
            </td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="amuletId" id="amuletId" value="<%=amuletEntity == null ? "" : amuletEntity.getAmuletCode()%>"/>
    <input type="hidden" name="isdropdownchange" id="isdropdownchange"/>
    <input type="submit" id="isdropdownchange_btn" hidden="hidden"/>
    <input type="hidden" name="page" value="ExUpdateAmuletMaster"/>
</form>
</body>
<script>
    $("#ex_update_amulet_form").validate({
        lang: 'th'
    });
</script>
</html>