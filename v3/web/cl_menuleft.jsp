<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<table width="100%" border="0" style="vertical-align: top">
    <tr>
        <td class="menu_left_header" >Menu</td>
    </tr>
    <tr>
        <td class="menu_dot">&nbsp;</td>
    </tr>
    <% if (session.getAttribute("UserSession") == null) {%>
        <tr>
            <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="./preregistpage" class="menu_top" style="text-decoration: none;font-size:1em;">สมัครสมาชิก</a></td>
        </tr>
        <tr>
            <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="./forgtpwdpage" class="menu_top" style="text-decoration: none;font-size:1em;">ลืมรหัสผ่าน</a></td>
        </tr>
    <%}%>
    <tr>
        <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="./index" class="menu_top" style="text-decoration: none;font-size:1em;">หน้าแรก</a></td>
    </tr>
    <tr>
        <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="./policypage" class="menu_top" style="text-decoration: none;font-size:1em;">นโยบายของ web</a></td>
    </tr>
    <tr>
        <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="./amuletpage" class="menu_top" style="text-decoration: none;font-size:1em;">ค้นหาข้อมูลพระเครื่อง</a></td>
    </tr>
    <tr>
        <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="newsinqservlet" class="menu_top" style="text-decoration: none;font-size:1em;">ข่าวสารจากทาง web</a></td>
    </tr>
    <tr>
        <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="mgtkmservlet" class="menu_top" style="text-decoration: none;font-size:1em;">ห้องสมุดพระเครื่อง</a></td>
    </tr>
    <tr>
        <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="./rulepage" class="menu_top" style="text-decoration: none;font-size:1em;">กฎกติกามารยาท</a></td>
    </tr>
    <tr>
        <td class="menu_left"><img src="./resources/images/list_icon.png" style="vertical-align: middle" />&nbsp;<a href="./contuspage" class="menu_top" style="text-decoration: none;font-size:1em;">ติดต่อเรา</a></td>
    </tr>
</table>