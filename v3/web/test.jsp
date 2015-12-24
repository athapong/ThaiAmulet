<%@ page import="com.valhalla.amulet.KnowHowDAO" %>
<%@ page import="com.valhalla.amulet.NewsDAO" %>
<%@ page import="com.valhalla.amulet.entity.AmuletKnowhowEntity" %>
<%@ page import="com.valhalla.amulet.entity.NewsEntity" %>
<%@ page import="com.valhalla.amulet.utils.AmuletUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>คู่มือพระ.com :: ลงทะเบียนสมาชิกใหม่</title>
</head>
<%
    try {
        ServletContext servletContext = session.getServletContext();
        String realContextPath = servletContext.getRealPath(File.separator);
        out.println("context="+servletContext.getContextPath());
        out.println("realContextPath="+realContextPath);
        String agreement = realContextPath +"/resources/config/welcome.conf";
        String welcomeTxt = AmuletUtils.getContent(agreement);

        String policy = realContextPath+"/resources/config/policy.conf";
        String policyTxt = AmuletUtils.getContent(policy);

        String address = realContextPath +"/resources/config/address.conf";
        String addressTxt = AmuletUtils.getContent(address);

        String contactWebsite = realContextPath +"/resources/config/contact_website.conf";
        String contactWebsiteTxt = AmuletUtils.getContent(contactWebsite);
        String contactCheckPra = realContextPath +"/resources/config/contact_checkpra.conf";
        String contactCheckPraTxt = AmuletUtils.getContent(contactCheckPra);
        String contactEmail = realContextPath +"/resources/config/contact_email.conf";
        String contactEmailTxt = AmuletUtils.getContent(contactEmail);

        List<AmuletKnowhowEntity> knowhowEntities = KnowHowDAO.getInstance().getKnowHowList();
        int repeat = 0;
        repeat = knowhowEntities == null ? 0 : knowhowEntities.size();
        List<NewsEntity> newsEntities = NewsDAO.getInstance().getNewsList();
        repeat = newsEntities != null && newsEntities.size() > repeat ? newsEntities.size() : repeat;
        for (int loop = 0;loop < repeat; loop++) {
            String newsImg = "";
            String knowhowImg = "";
            if (newsEntities.size() > loop) {
                if (newsEntities.get(loop).getNewsPic() == null) {
                    newsImg = "resources/images/noimage.png";
                } else newsImg = newsEntities.get(loop).getNewsPic();
            }
            if (knowhowEntities.size() > loop) {
                if (knowhowEntities.get(loop).getPic1() == null) {
                    knowhowImg = "resources/images/noimage.png";
                } else knowhowImg = knowhowEntities.get(loop).getPic1();
            }
        }
        String rulePath = realContextPath +"/resources/config/rule.conf";
        String ruleTxt = AmuletUtils.getContent(rulePath);
    } catch(Exception ex) {
        StringWriter errors = new StringWriter();
        ex.printStackTrace(new PrintWriter(errors));
        out.print(errors.toString());
    }

        %>
</body>
</html>