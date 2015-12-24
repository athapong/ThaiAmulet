<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page import="com.valhalla.amulet.entity.NewsEntity" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.util.Properties" %>
<%@ page import="com.valhalla.amulet.constants.AmuletConstants" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./resources/css/style.css" />
    <link rel="stylesheet" href="./resources/css/font-awesome-4.3.0/css/font-awesome.css" />
    <script src="./resources/jquery-ui-1.11.3.custom/external/jquery/jquery.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.3.custom/jquery-ui.css">
    <link rel="stylesheet" href="resources/jonthornton-jquery-timepicker/jquery.timepicker.css">
    <script src="./resources/jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/jquery.validate.min.js"></script>
    <script src="./resources/jQuery-validation-1.13.1/localization/messages_th.js"></script>
    <script src="./resources/jonthornton-jquery-timepicker/jquery.timepicker.min.js"></script>
    <script src="./resources/message.js"></script>
    <title>ผู้ดูแลระบบ::จัดการข้อมูลข่าวสาร</title>
    <%
        if (!AmuletUtils.isAdmin((UserBean) request.getSession().getAttribute("UserSession")) && !AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
            request.getRequestDispatcher("unauthorized").forward(request, response);
        }
        NewsEntity newsEntity = null;
        if (request.getSession().getAttribute("news_entity") != null) {
            newsEntity = (NewsEntity) request.getSession().getAttribute("news_entity");
        }
    %>
    <script>

        $(function() {
            $("#btnNewsPicUpload").change(function (){
                var fileName = $(this).val();
                $("#btnNewsPicUpload_filename").html(fileName);
            });
            $( "#newsDate" ).datepicker({
                showAnim: 'slideDown',
                duration: 'fast',
                dateFormat: "dd/mm/yy",
                changeMonth: true,
                changeYear: true,
                beforeShow: function(){
                    $(".ui-datepicker").css('font-size', 12)
                }
            });
            $('#newsTime').timepicker({
                'timeFormat': 'H:i',
                'scrollDefault': 'now' ,
                'show2400' : 'true',
                'disableTouchKeyboard' : 'false'
            });
        });
        $( document ).ready(function() {
            $('#newsTime').timepicker({
                'timeFormat': 'H:i',
                'scrollDefault': 'now' ,
                'show2400' : 'true',
                'disableTouchKeyboard' : 'false'
            });
            <% if (newsEntity == null) {%>
                $("#newsDate").datepicker('setDate', '+0d');
                $("#newsTime").timepicker('setTime', new Date());
            <% } else {%>
                var time = <%=AmuletUtils.strToTimeMilli(newsEntity.getNewsDate(), newsEntity.getNewsTime())%>;
                $("#newsTime").timepicker('setTime', new Date(time));
            <% } %>
        });
    </script>
    <%
        Properties properties = new Properties();
        try {
            properties.load(getServletConfig().getServletContext().getResourceAsStream("/resources/config/news_cat.properties"));
        }
        catch (Exception e) {
            System.err.println("Error loading categories, "+e.getMessage());
        }
    %>
</head>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
    })
</script>
<body>
<div class="loader"></div>
<form id="admin_add_news_form" action="addnewsservlet" method="post" enctype="multipart/form-data" acceptcharset="UTF-8">
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
    <table width="100%" border="0">
        <% if (bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {%>
        <jsp:include page="./admin/admin_menu.jsp?tab=3"/>
        <% } else if (bean.getRole().equals(AmuletConstants.EXCV_TYPE)) {%>
        <jsp:include page="./exclusive/ex_menu.jsp?tab=5"/>
        <% } %>
        <tr>
            <td class="normal_text" style="font-size: 2em; text-align: left;" colspan="2">เพิ่มข่าวสารจากผู้เชื่ยวชาญพระเครื่อง</td>
        </tr>
        <tr class="menu_dot">
            <td colspan="2" class="menu_dot">&nbsp;</td>
        </tr>

        <tr style="border-color: #dcac4e">
            <td colspan="2">
                <table style="vertical-align: top; width: 100%; border: 1px dotted #dcac4e; border-spacing: 5px;">

                    <tr>
                        <td class="caption" style="width: 10%;">รูปภาพ<span class="required">&nbsp;</span></td>
                        <td class="content_txt_middle" style="width: 90%;">
                            <input type="file" class="button_upload" id="btnNewsPicUpload" name="btnNewsPicUpload" accept="image/*" style="display:none;" required>
                            <input type="button" class="button_upload" onclick="document.getElementById('btnNewsPicUpload').click()" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เลือกไฟล์&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" tabindex="1"/>
                            &nbsp;<span id="btnNewsPicUpload_filename" class="caption_remark" style="font-size:1em;"></span>
                        </td>
                    </tr>
                    <tr style="border: 0px; line-height:5px;">
                        <td style="width:100%;text-align: left; border-top: 1px dotted #dcac4e;" class="text_header" colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">ประเภทกลุ่ม<span class="required">*</span></td>
                        <td class="content_txt_middle" colspan="2">
                            <select class="select" id="news_cat" name="news_cat" style="border-radius: 4px; border: 1px solid #dcac4e; width:200px; height:25px; font-family: fontawesomeregular; font-size:0.9em;" required="required" tabindex="2">
                                <%
                                    for (String key : properties.stringPropertyNames()) {
                                        String value = properties.getProperty(key);
                                        if (newsEntity != null && key.equals(newsEntity.getNewsCat())) {%>
                                            <option value="<%=key%>" selected><%=value%></option>
                                        <% } else {%>
                                            <option value="<%=key%>"><%=value%></option>
                                        <%}
                                    }%>
                            </select>
                        </td>
                        <td class="caption_remark">&nbsp;</td>

                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%;">หัวข้อ<span class="required">*</span></td>
                        <td class="content_txt_middle" colspan="3">
                            <input type="text" style="width:90%; font-family: fontawesomeregular; font-size:1em;" class="input_box" id="news_subj" name="news_subj" maxlength="250" required tabindex="3" value="<%=newsEntity == null ? "" : newsEntity.getNewsSubj()%>"/>
                        </td>
                    </tr>
                    <tr style="border: 0px; line-height:5px;">
                        <td style="width:100%;text-align: left; border-top: 1px dotted #dcac4e;" class="text_header" colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="caption" style="width: 20%; vertical-align: top; text-align: right;">รายละเอียด<span class="required">*</span></td>
                        <td class="content_txt_middle" colspan="3">
                            <textarea id="news_desc" name="news_desc" required="required" style="width: 90%; height: 400px; font-family: fontawesomeregular; font-size:0.9em;" tabindex="4"><%=newsEntity == null ? "" : newsEntity.getNewsDesc()%></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="border: 0px;">
            <td style="width:50%;text-align: left; padding-top: 5px;" class="text_header">&nbsp;
                <span class="button" style="width:30%; float: left; text-align: center;" onclick="$('#submit_btn').click()" tabindex="10">บันทึกข้อมูล</span>
                <span style="float:left;">&nbsp;</span>
                <span class="button" style="width:30%; float: left; text-align: center;" onclick="window.open('newsinqservlet','_self')" tabindex="11">ยกเลิก</span>
                <input type="submit" id="submit_btn" hidden="hidden"/>
            </td>
            <td class="caption" style="width:50%;text-align: right;">
                วันที่ <input type="text" class="input_date" id="newsDate" name="newsDate" required readonly="true"
                              value="<%=newsEntity == null ? "" : AmuletUtils.getDateStr(newsEntity.getNewsDate())%>"/>
                เวลา <input type="text" class="input_time" id="newsTime" name="newsTime" required />
            </td>
        </tr>
        <tr>
            <td class="menu_left" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2"><jsp:include  page="./footer.jsp"/></td>
        </tr>
    </table>
    <input type="hidden" name="newsId" value="<%=newsEntity == null ? "" : newsEntity.getNewsCode()%>"/>
</form>
</body>
<script>
    $("#admin_add_news_form").validate({
        lang: 'th'
    });
</script>
</html>