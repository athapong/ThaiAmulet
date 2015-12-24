<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<%
        String tab = request.getParameter("tab");
%>
<tr>
    <td class="menu_left_header" colspan="2" style="text-align: left; padding-right: 14%;"><img src="./resources/images/logo.png"/></td>
</tr>
<tr>
    <td colspan="4">
        <div class="menu" style="padding-left:0px;">
            <table style="padding-left:0px; width:100%;" cellspacing="0px">
                <tr class="border_dotted" style="border: none; font-size: large;">
                    <% if (tab.equals("1")) {%>
                    <td class="menu_page_selected" style="width: 10%; text-align: center; padding-right:0px;">หน้าแรก</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 10%; text-align: center; padding-right:0px;" onclick="window.open('index','_self')">หน้าแรก</td>
                    <% } %>
                    <% if (tab.equals("2")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">สมัครสมาชิกใหม่</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('preregistpage','_self')">สมัครสมาชิกใหม่</td>
                    <% } %>
                    <% if (tab.equals("3")) {%>
                    <td class="menu_page_selected" style="width: 12%; text-align: center; padding-right:0px;">นโยบายของ web</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 12%; text-align: center; padding-right:0px;" onclick="window.open('policypage','_self')">นโยบายของ web</td>
                    <% } %>
                    <% if (tab.equals("4")) {%>
                    <td class="menu_page_selected" style="width: 12%; text-align: center; padding-right:0px;">ห้องสมุดพระเครื่อง</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 12%; text-align: center; padding-right:0px;" onclick="window.open('mgtkmservlet','_self')">ห้องสมุดพระเครื่อง</td>
                    <% } %>
                    <% if (tab.equals("5")) {%>
                    <td class="menu_page_selected" style="width: 15%; text-align: center; padding-right:0px;">กฎกติกามารยาท</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 15%; text-align: center; padding-right:0px;" onclick="window.open('rulepage','_self')">กฎกติกามารยาท</td>
                    <% } %>
                    <% if (tab.equals("6")) {%>
                    <td class="menu_page_selected" style="width: 12%; text-align: center; padding-right:0px;">ติดต่อเรา</td>
                    <% } else {%>
                    <td class="menu_page_unselected" style="width: 12%; text-align: center; padding-right:0px;" onclick="window.open('contuspage','_self')">ติดต่อเรา</td>
                    <% } %>

                </tr>
            </table>
        </div>

    </td>
</tr>
<% if (tab.equals("1")) {%>
<tr style="text-align: center;">
    <td colspan="2">&nbsp;</td>
</tr>
<tr>
    <td class="menu_left" colspan="4">&nbsp;</td>
</tr>
<% } %>