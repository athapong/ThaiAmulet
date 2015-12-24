<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import="com.valhalla.amulet.KnowHowDAO" %>
<%@ page import="com.valhalla.amulet.NewsDAO" %>
<%@ page import="com.valhalla.amulet.entity.AmuletKnowhowEntity" %>
<%@ page import="com.valhalla.amulet.entity.NewsEntity" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%

    Class.forName("com.mysql.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/athapong_amulet","athapong_amulet","8Yk@W#9i6");
            Statement st= con.createStatement();
    ResultSet rs=st.executeQuery("select * from USER where USER_ID=1");
    if(rs.next())
    {
        out.println(rs.getString("USER_NAME"));
    }
    else
    out.println("No Data");


    NewsDAO.getInstance();
%>