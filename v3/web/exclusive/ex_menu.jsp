<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="com.valhalla.amulet.bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<%
        if (!AmuletUtils.isExclusive((UserBean) request.getSession().getAttribute("UserSession"))) {
            request.getRequestDispatcher("unauthorized").forward(request, response);
        }
        String tab = request.getParameter("tab");
%>

<tr>
    <td class="menu_left_header" colspan="2" style="text-align: left;"><img src="./resources/images/logo.png"/></td>
    <td nowrap class="normal_text2" style="vertical-align: top; text-align:right;">
        <span id="logout" onclick="logout(this)" style="cursor:pointer">ออกจากระบบ</span><br/>
        <span class="large_text">Exclusive</span>
    </td>
</tr>
<tr>
    <td colspan="4">
        <div class="menu" style="padding-left:0px;">
            <table style="padding-left:0px; width:100%;" cellspacing="0px">
                <tr class="border_dotted" style="border: none; font-size: large;">
                    <% if (tab.equals("1")) {%>
                    <td class="menu_page_selected" style="width: 10%; text-align: center; padding-right:0px;">หน้าแรก</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 10%; text-align: center; padding-right:0px;" onclick="window.open('exindex','_self')">หน้าแรก</td>
                    <% } %>
                    <% if (tab.equals("2")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">รายงานสรุปการใช้ข้อมูลลูกค้า</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('qryrptservlet?go=#','_self')">รายงานสรุปการใช้ข้อมูลลูกค้า</td>
                    <% } %>
                    <% if (tab.equals("3")) {%>
                    <td class="menu_page_selected" style="width: 12%; text-align: center; padding-right:0px;">ดูนโยบายของ web</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 12%; text-align: center; padding-right:0px;" onclick="window.open('expolicypage','_self')">ดูนโยบายของ web</td>
                    <% } %>
                    <% if (tab.equals("4")) {%>
                    <td class="menu_page_selected" style="width: 12%; text-align: center; padding-right:0px;">ค้นหาข้อมูลพระเครื่อง</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 12%; text-align: center; padding-right:0px;" onclick="window.open('inqamuletpage','_self')">ค้นหาข้อมูลพระเครื่อง</td>
                    <% } %>
                    <% if (tab.equals("5")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">รายการข่าวสารจาก web</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('newsinqservlet','_self')">รายการข่าวสารจาก web</td>
                    <% } %>
                    <% if (tab.equals("6")) {%>
                    <td class="menu_page_selected" style="width: 12%; text-align: center; padding-right:0px;">กฎกติการมารยาท</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 12%; text-align: center; padding-right:0px;" onclick="window.open('exrulepage','_self')">กฎกติการมารยาท</td>
                    <% } %>
                    <% if (tab.equals("7")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">รายการห้องสมุดพระเครื่อง</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('mgtkmservlet','_self')">รายการห้องสมุดพระเครื่อง</td>
                    <% } %>
                    <% if (tab.equals("8")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">ติดต่อเรา</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('excontactuspage','_self')">ติดต่อเรา</td>
                    <% } %>
                </tr>
            </table>
        </div>

    </td>
</tr>
<%--2--%>
<% if (tab.equals("1")) {%>
<tr style="text-align: center;">
    <td colspan="2">&nbsp;</td>
</tr>

<tr>
    <td class="menu_left" colspan="4">&nbsp;</td>
</tr>
<% } %>