<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.mysql.jdbc.StringUtils" %>
<%@ page import="com.valhalla.amulet.*" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.entity.AmuletMasterEntity" %>
<%@ page import="com.valhalla.amulet.constants.AmuletConstants" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" href="./resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <link rel="stylesheet" href="./resources/fancybox/source/jquery.fancybox.css" type="text/css" media="screen" />
    <script type="text/javascript" src="./resources/fancybox/source/jquery.fancybox.js"></script>
    <%--<script src="./resources/message.js"></script>--%>
    <title>ข้อมูลพระเครื่อง</title>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    });

    $(document).ready(function() {
        $(".fancybox").fancybox({
            autoCenter : true,
            helpers : {
                title : {
                    type : 'over'
                },
                overlay : {
                    locked: true
                }
            }
        });
    });
</script>

<form id="#">
<body>
    <div class="loader"></div>
    <%
        AmuletMasterEntity amuletEntity = null;
        if (request.getSession().getAttribute("amulet_item_result") != null) {
            amuletEntity = (AmuletMasterEntity) request.getSession().getAttribute("amulet_item_result");
        }

        UserBean bean = null;
        if (request.getSession().getAttribute("admin_session") == null) {
            bean = (UserBean) request.getSession().getAttribute("UserSession");
        } else {
            bean = (UserBean) request.getSession().getAttribute("admin_session");
        }
    %>
    <table width="100%" border="0" style="font-family: fontawesomeregular;">
        <% if (bean != null && bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {%>
            <jsp:include page="./admin/admin_menu.jsp?tab=4"/>
        <% } else if (bean != null && bean.getRole().equals(AmuletConstants.EXCV_TYPE)) {%>
            <jsp:include page="./exclusive/ex_menu.jsp?tab=4"/>
        <%} else {%>
            <jsp:include page="./cl_menu.jsp?tab="/>
        <%}%>
        <tr style="vertical-align: middle">
            <td class="caption" style="color: #f2d576; font-size: 1em; text-align: left;" colspan="3">
                <label style="font-size: 1.5em;"><%=amuletEntity.getAmuletName() == null ? "-" : amuletEntity.getAmuletName()%></label>
                <% if (bean != null && !bean.getRole().equals(AmuletConstants.USER_TYPE)) {%>
                    <span class="button" style="width:10%; float: right; text-align: center;" onclick="window.open('updtamuletpage','_self')" tabindex="10">แก้ไข</span>
                <%}%>
            </td>
        </tr>
        <tr class="menu_dot" style="padding-top:5px;">
            <td colspan="3" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td rowspan="1" style="width: 200px; vertical-align: top;">
                <% if (amuletEntity.getAmuletPic() != null) {%>
                    <div id="imgDiv">
                        <a class="fancybox" href="<%=amuletEntity.getAmuletPic()%>" title="<%=amuletEntity.getAmuletName()%>">
                            <img src="<%=amuletEntity.getAmuletPic()%>" alt=""/>
                        </a>
                    </div>
                <% } else {%>
                    <div id="imgDiv">
                        <img src="resources/images/noimage.png" width="170px"/>
                    </div>
                <% } %>
                <br>
                <label class="caption" style="vertical-align: middle;">Rating</label>
                <%
                    if (!StringUtils.isNullOrEmpty(amuletEntity.getRating())) {
                        int rating = Integer.parseInt(amuletEntity.getRating());
                        for (int i=1;i<=rating;i++) {
                            out.print("<img src=\"resources/images/list_icon.png\" style=\"vertical-align: middle;\"/>&nbsp;");
                        }
                    }
                %>
            </td>
            <td colspan="3">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right;">ขนาด กว้าง </td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;" colspan="3">
                            <%=amuletEntity.getsWidth() == null ? "-" : amuletEntity.getsWidth()%><label class="caption"> ซม.&nbsp;&nbsp;ยาว </label><%=amuletEntity.getsLong() == null ? "-" : amuletEntity.getsLong()%><label class="caption"> ซม.&nbsp;&nbsp;หนา </label><%=amuletEntity.getsTall() == null ? "-" : amuletEntity.getsTall()%><label class="caption"> ซม.</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ประเภทวัสดุ</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;" colspan="3">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getMaterial())) {
                               out.print(MaterialDAO.getInstance().getMaterialEntity(amuletEntity.getMaterial()).getMaterialDesc());
                            } else {
                                out.print("-");
                            }%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ยุคตั้งแต่ พ.ศ.</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;"><%=amuletEntity.getYearFrom() == null ? "-" : amuletEntity.getYearFrom()%></td>
                        <td class="caption" style="width: 10%;">ถึง พ.ศ.</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;"><%=amuletEntity.getYearTo() == null ? "-" : amuletEntity.getYearTo()%></td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ทรง</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getForm1())) {
                                String form1 = Form1DAO.getInstance().getForm1Entity(amuletEntity.getForm1()).getForm1Desc();
                                out.print(form1 == null ? "-" : form1);
                            } else {
                                out.print("-");
                            }%>
                        </td>
                        <td class="caption" style="width: 10%;">รูปทรง</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getForm2())) {
                                out.print(Form2DAO.getInstance().getForm2Entity(amuletEntity.getForm2()).getForm2Desc());
                            } else {
                                out.print("-");
                            }%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ปาง</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getAmuletCharacter())) {
                                out.print(CharacterDAO.getInstance().getCharacterEntity(amuletEntity.getAmuletCharacter()).getCharacterDesc());
                            } else {
                                out.print("-");
                            }%>
                        </td>
                        <td class="caption" style="width: 10%;">สี</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getColor())) {
                                out.print(ColorDAO.getInstance().getColorEntity(amuletEntity.getColor()).getColorDesc());
                            } else {
                                out.print("-");
                            }%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ชื่อหลวงพ่อ</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;"><%=amuletEntity.getVernerable() == null ? "-" : amuletEntity.getVernerable()%></td>
                        <td class="caption" style="width: 10%;">วัด</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;"><%=amuletEntity.getTemple() == null ? "-" : amuletEntity.getTemple()%></td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">จังหวัด</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">

                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getProvinceCode())) {
                                String provinceName = ProvinceDAO.getInstance().getProvinceEntity(amuletEntity.getProvinceCode()).getProvinceName();
                                out.print(provinceName == null ? "-" : provinceName);
                            } else {
                                out.print("-");
                            }%>
                        </td>
                        <td class="caption" style="width: 10%;">อำเภอ</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getAmphurCode())) {
                                String amphurName = AmphurDAO.getInstance().getAmphurEntity(amuletEntity.getProvinceCode(), amuletEntity.getAmphurCode()).getAmphurName();
                                out.print(amphurName == null ? "-" : amphurName);
                            } else {
                                out.print("-");
                            }%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ตำบล</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty((amuletEntity.getProvinceCode())) && !StringUtils.isNullOrEmpty(amuletEntity.getAmphurCode()) && (!StringUtils.isNullOrEmpty(amuletEntity.getDistrictCode()))) {
                                String tambolName = TambolDAO.getInstance().getTambolEntity(amuletEntity.getProvinceCode(), amuletEntity.getAmphurCode(), amuletEntity.getDistrictCode()).getDistrictName();
                                out.print(tambolName == null ? "-" : tambolName);
                            } else {
                                out.print("-");
                            }%>
                        </td>
                        <td class="caption" style="width: 10%;" colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">เกจฯ หรือ กรุ</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getChamber())) {
                                String chamberDesc = ChamberDAO.getInstance().getChamberEntity(amuletEntity.getChamber()).getChamberDesc();
                                out.print(chamberDesc == null ? "-" : chamberDesc);
                            } else {
                                out.print("-");
                            }%>
                        </td>
                        <td class="caption" style="width: 10%;">ห้อยคอ หรือบูชา</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getLocketFl())) {
                                String locketDesc = LocketDAO.getInstance().getLocketEntity(amuletEntity.getLocketFl()).getLocketDesc();
                                out.print(locketDesc == null ? "-" : locketDesc);
                            } else {
                                out.print("-");
                            }%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ผง หรือโลหะ</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getMatType1())) {
                                out.print(MatType1DAO.getInstance().getMatType1Entity(amuletEntity.getMatType1()).getMatType1Desc());
                            } else {
                                out.print("-");
                            }%>
                        </td>
                        <td class="caption" style="width: 10%;">ประเภทเนื้อโลหะ</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getMatType2())) {
                                out.print(MatType2DAO.getInstance().getMatType2Entity(amuletEntity.getMatType2()).getMatType2Desc());
                            } else {
                                out.print("-");
                            }%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ขนาดหน้าตัก</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;"><%=amuletEntity.getMeditationL() == null ? "-" : amuletEntity.getMeditationL()%>&nbsp;<label class="caption"> ซม.</label></td>
                        <td class="caption" style="width: 10%;">&nbsp;</td>
                        <td style="width: 10%;">&nbsp;</td>
                    </tr>
                    <% if (bean != null && (bean.isAdmin() || bean.getPmtFlag())) {%>
                    <tr>
                        <td class="caption" style="width: 10%;">ราคาตั้งแต่</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;"><%=amuletEntity.getPriceFrom() == null ? "-" : amuletEntity.getPriceFrom()%></td>
                        <td class="caption" style="width: 10%;">ถึง</td>
                        <td style="width: 10%; color:#f2f2f2; font-size:1.25em;"><%=amuletEntity.getPriceTo() == null ? "-" : amuletEntity.getPriceTo()%></td>
                    </tr>

                    <tr class="menu_dot" style="padding-top:5px;">
                        <td colspan="4" class="menu_dot" style="line-height:1px;">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="caption" style="width: 10%; text-align: right; vertical-align: top;">ตำหนิอย่างไร</td>
                        <td class="caption" style="text-align: left; color:#f2f2f2; font-size:1.25em;" colspan="3">
                            <textarea id="defect_des_1" name="defect_des_1" required="required" style="color:#f2f2f2; background-color:#020821; width: 100%; height: 200px; font-family: fontawesomeregular; font-size:0.9em;" readonly><%=amuletEntity == null ? "" : amuletEntity.getDefectDes1()%></textarea>
                        </td>
                    </tr>
                    <% } %>
                    <tr class="menu_dot" style="padding-top:5px;">
                        <td colspan="4" class="menu_dot" style="line-height:1px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%; text-align: right;">รายละเอียดมวลสาร</td>
                        <td class="caption" style="text-align: left; color:#f2f2f2; font-size:1.25em;" colspan="3">
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getMatDes1())) {
                                out.print(MatDescDAO.getInstance().getMatDescEntity(amuletEntity.getMatDes1()).getMatDescDesc());
                            } else {
                                out.print("-");
                            }%>
                            และ
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getMatDes2())) {
                                out.print(MatDescDAO.getInstance().getMatDescEntity(amuletEntity.getMatDes2()).getMatDescDesc());
                            } else {
                                out.print("-");
                            }%>
                            และ
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getMatDes3())) {
                                out.print(MatDescDAO.getInstance().getMatDescEntity(amuletEntity.getMatDes3()).getMatDescDesc());
                            } else {
                                out.print("-");
                            }%>
                            และ
                            <% if (!StringUtils.isNullOrEmpty(amuletEntity.getMatDes4())) {
                                out.print(MatDescDAO.getInstance().getMatDescEntity(amuletEntity.getMatDes4()).getMatDescDesc());
                            } else {
                                out.print("-");
                            }%>
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
                            <textarea id="note" name="note" style=" color:#f2f2f2; background-color:#020821; width: 100%; height: 400px; font-family: fontawesomeregular; font-size:0.9em;" tabindex="6" readonly><%=amuletEntity.getNote() == null ? "" : amuletEntity.getNote()%></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="vertical-align: middle; padding-top: 20px;">
            <td class="caption" style="padding-bottom: 10px; font-size: 1em; padding-left: 25px; text-align: left;" colspan="3">
                <br/>

                <% if (bean != null && bean.getRole().equals(AmuletConstants.EXCV_TYPE)) {%>
                    <span class="button" style="width:10%; float: right; text-align: center;" onclick="window.open('inqamuletpage','_self')" tabindex="10">ค้นหาองค์อื่น</span>
                    <span style="float:right;">&nbsp;</span>
                    <span class="button" style="width:10%; float: right; text-align: center;" onclick="history.go(-1)" tabindex="11">กลับ</span>
                <%} else {%>
                    <span class="button" style="width:10%; float: right; text-align: center;" onclick="history.go(-1)" tabindex="11">กลับ</span>
                <%}%>
                <input type="submit" id="submit_btn" hidden="hidden"/>
            </td>
        </tr>
        <tr>
            <td colspan="3"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
</body>
</form>
</html>