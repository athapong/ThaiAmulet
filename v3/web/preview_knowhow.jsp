<%@ page import="com.valhalla.amulet.MatType1DAO" %>
<%@ page import="com.valhalla.amulet.MatType2DAO" %>
<%@ page import="com.valhalla.amulet.ProvinceDAO" %>
<%@ page import="com.valhalla.amulet.RegionDAO" %>
<%@ page import="com.valhalla.amulet.entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <script src="resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <link rel="stylesheet" href="./resources/fancybox/source/jquery.fancybox.css" type="text/css" media="screen" />
    <script type="text/javascript" src="./resources/fancybox/source/jquery.fancybox.js"></script>
    <title>คู่มือพระ.com :: ห้องสมุดพระเครื่อง</title>
</head>
<script type="text/javascript">
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
<body>
<form id="ex_add_knowhow_form" action="ClDoPreviewKnowHowServlet" method="post" acceptcharset="UTF-8">
    <%
        AmuletKnowhowEntity knowhowEntity = null;
        if (request.getSession().getAttribute("knowhow_entity") != null) {
            knowhowEntity = (AmuletKnowhowEntity) request.getSession().getAttribute("knowhow_entity");
        }

        RegionEntity regionEntity = null;
        if (knowhowEntity.getRegionCode() != null)
        {
            regionEntity = RegionDAO.getInstance().getRegionEntity(knowhowEntity.getRegionCode());
        }
        ProvinceEntity provinceEntity = null;
        if (knowhowEntity.getRegionCode() != null && !knowhowEntity.getProvince().equals("")) {
            provinceEntity = ProvinceDAO.getInstance().getProvinceEntity(knowhowEntity.getRegionCode());
        }
        MatType1Entity matType1Entity = null;
        if (knowhowEntity.getMatType1() != null) {
            matType1Entity = MatType1DAO.getInstance().getMatType1Entity(knowhowEntity.getMatType1());
        }
        MatType2Entity matType2Entity = null;
        if (knowhowEntity.getMatType2() != null) {
            matType2Entity = MatType2DAO.getInstance().getMatType2Entity(knowhowEntity.getMatType2());
        }
    %>
    <table width="100%" border="0">
        <tr style="vertical-align: middle">
            <td class="caption" style="padding-bottom: 10px; font-size: 1em; padding-left: 25px; text-align: left; padding-top:10px;" colspan="2"><label style="font-size: 1.5em;">หัวข้อ</label>&nbsp;&nbsp;<%=knowhowEntity == null ? "" : knowhowEntity.getSubjectName()%>
                <span class="button" style="width:10%; float: right; text-align: center;" onclick="window.open('mgtkmservlet','_self')" tabindex="11">ย้อนกลับ</span>
            </td>
        </tr>
        <tr class="menu_dot" style="padding-top:5px;">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td rowspan="2" style="width: 200px; vertical-align: top;">
                <div id="imgDiv">
                    <a class="fancybox" href="<%=knowhowEntity.getPic1()%>" title="<%=knowhowEntity.getSubjectName()%>">
                        <img src="<%=knowhowEntity.getPic1()%>" alt=""/>
                    </a>
                </div>

            </td>
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">
                    <tr>
                        <td class="caption" style="width: 10%;">ภาค</td>
                        <td class="content_txt_middle" style="width:40%;" colspan="3">
                            <%=regionEntity.getGeoName()%>
                        </td>

                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">จังหวัด</td>
                        <td class="content_txt_middle" colspan="3">
                            <%=provinceEntity.getProvinceName()%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ผงหรือโลหะ</td>
                        <td class="content_txt_middle" colspan="3">
                            <%=matType1Entity.getMatType1Desc()%>
                        </td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 10%;">ประเภทเนื้อโลหะ</td>
                        <td class="content_txt_middle" colspan="3">
                            <%=matType2Entity.getMatType2Desc()%>
                        </td>
                    </tr>

                    <tr class="menu_dot" style="padding-top:5px;">
                        <td colspan="4" class="menu_dot" style="line-height:1px;">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="caption" style="width: 20%; text-align:left;" colspan="4">รายละเอียด</td>

                    </tr>
                    <tr>
                        <td class="content_txt_middle" colspan="4">
                            <textarea id="content" name="content" required="required" style="width: 100%; height: 400px; font-family: fontawesomeregular; font-size:0.9em; color:#f2f2f2; background-color: #090c1a" tabindex="6" readonly><%=knowhowEntity == null ? "" : knowhowEntity.getContent()%></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="menu_left" colspan="2">
                <%if (knowhowEntity != null && knowhowEntity.getPublishFl() == 1) {%>
                <label style="caption-side: bottom">ตีพิมพ์แล้ว</label>
                <%} else {%>
                <label style="caption-side: bottom">ยังไม่ตีพิมพ์</label>
                <%}%>
            </td>
        </tr>
    </table>
</form>
</body>
</html>