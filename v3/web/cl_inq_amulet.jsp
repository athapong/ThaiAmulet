<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.*" %>
<%@ page import="com.valhalla.amulet.bean.AmuletMasterBean" %>
<%@ page import="com.valhalla.amulet.entity.*" %>
<%@ page import="com.valhalla.amulet.constants.AmuletConstants" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.util.*" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%
        AmuletMasterBean formBean = (AmuletMasterBean) request.getSession().getAttribute("ex_amulet_master_form_bean");
        if (formBean == null) {
            formBean = new AmuletMasterBean();
        }
        UserBean userBean = (UserBean) session.getAttribute("UserSession");
    %>
    <table width="100%" border="0">
        <tr style="vertical-align: middle">
            <td class="caption" style="padding-bottom: 10px; color: #f2d576; font-size: 1em; text-align: left;" colspan="2"><label style="font-size: 1.5em;">ค้นหาข้อมูลพระเครื่อง</label></td>
        </tr>
        <tr class="menu_dot" style="padding-top:5px;">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td class="caption" style="width: 10%; text-align:left;" colspan="4">กรอกข้อมูลรายละเอียดของพระเท่าที่ท่านทราบ</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อพระเครื่อง</td>
                        <td style="width: 10%;" colspan="3">
                            <input type="text" id="amulet_name" name="amulet_name" style="width: 150px;" maxlength="100" value="<%=formBean.getAMULET_NAME() == null ? "" : formBean.getAMULET_NAME()%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right;">ขนาด กว้างไม่เกิน </td>
                        <td style="width: 10%;" colspan="3">
                            <input type="text"  id="s_width" name="s_width" class="numbersOnly" style="width: 80px;" value="<%=formBean.getS_WIDTH() == null ? "" : formBean.getS_WIDTH()%>"/><label class="caption"> ซม.&nbsp;&nbsp;ยาวไม่เกิน </label><input type="text" id="s_long" name="s_long" style="width: 80px;" value="<%=formBean.getS_LONG() == null ? "" : formBean.getS_LONG()%>"/><label class="caption"> ซม.&nbsp;&nbsp;หนาไม่เกิน </label><input type="text" id="s_tall" name="s_tall" style="width: 80px;" value="<%=formBean.getS_TALL() == null ? "" : formBean.getS_TALL()%>"/><label class="caption"> ซม.</label>
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
                    <%
                        ArrayList<String> yearList = (ArrayList<String>)AmuletUtils.getYearList(getServletConfig());
                    %>
                    <tr>
                        <td class="caption" style="width: 10%;">ยุคตั้งแต่ พ.ศ.</td>
                        <td style="width: 10%;">
                            <select id="year_from" name="year_from" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (String yearFrom : yearList) {%>
                                <% if (yearFrom.equals(formBean.getYEAR_FROM())) {%>
                                <option value="<%=yearFrom%>" selected><%=yearFrom%></option>
                                <% } else {%>
                                <option value="<%=yearFrom%>"><%=yearFrom%></option>
                                <% } %>
                                <%}%>
                            </select>
                        </td>
                        <td class="caption" style="width: 10%;">ถึง พ.ศ.</td>
                        <td style="width: 10%;">
                            <select id="year_to" name="year_to" style="width: 150px;" class="select">
                                <option value="" selected>กรุณาเลือก</option>
                                <% for (String yearTo : yearList) {%>
                                <% if (yearTo.equals(formBean.getYEAR_TO())) {%>
                                <option value="<%=yearTo%>" selected><%=yearTo%></option>
                                <% } else {%>
                                <option value="<%=yearTo%>"><%=yearTo%></option>
                                <% } %>
                                <%}%>
                            </select>
                        </td>
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
                        <td class="caption" style="width: 10%;">ขนาดหน้าตักไม่เกิน</td>
                        <td style="width: 10%;"><input type="text" id="meditation_l" name="meditation_l" style="width:150px;" value="<%=formBean.getMEDITATION_L() == null ? "" : formBean.getMEDITATION_L()%>"/>&nbsp;<label class="caption"> ซม.</label></td>
                        <td class="caption" style="width: 10%;">&nbsp;</td>
                        <td style="width: 10%;">&nbsp;</td>
                    </tr>
                    <% if (userBean != null && userBean.getPmtFlag()) {%>
                    <tr>
                        <td class="caption" style="width: 10%;">ราคาตั้งแต่</td>
                        <td style="width: 10%;"><input type="text" id="price_from" name="price_from" style="width:150px;" value="<%=formBean.getPRICE_FROM() == null ? "" : formBean.getPRICE_FROM()%>"/></td>
                        <td class="caption" style="width: 10%;">ถึง</td>
                        <td style="width: 10%;"><input type="text" id="price_to" name="price_to" style="width:150px;" value="<%=formBean.getPRICE_TO() == null ? "" : formBean.getPRICE_TO()%>"/></td>
                    </tr>
                    <% } %>
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
        <% if (userBean != null && userBean.getPmtFlag()) {%>
            <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px; border-bottom:none;">
                <tr>
                    <td class="caption" style="width: 10%; text-align: right; vertical-align: top;">ตำหนิอย่างไร</td>
                    <td class="caption" style="text-align: left;">
                        <textarea id="defect_des_1" name="defect_des_1" style="width: 100%; height: 100px; font-family: fontawesomeregular; font-size:0.9em; color:black;"></textarea>
                    </td>
                </tr>
            </table>
        <% } %>
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

        </table>
        <tr style="vertical-align: middle; padding-top: 20px;">
            <td class="caption" style="padding-bottom: 10px; font-size: 1em;" colspan="2">
                <br/>
                <span class="button" style="width:10%; display: inline-block; text-align: center;" onclick="$('#submit_btn').click()" tabindex="10">ค้นหา</span>
                <span style="float:right;">&nbsp;</span>
                <span class="button" style="width:10%; display: inline-block; text-align: center;" onclick="window.open('exindex','_self')" tabindex="11">ยกเลิก</span>
                <input type="submit" id="submit_btn" hidden="hidden"/>
            </td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="isdropdownchange" id="isdropdownchange"/>
    <input type="submit" id="isdropdownchange_btn" hidden="hidden"/>
