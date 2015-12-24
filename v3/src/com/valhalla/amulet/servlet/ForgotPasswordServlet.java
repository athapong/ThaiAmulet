/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.valhalla.amulet.UserDAO;
import com.valhalla.amulet.bean.UserBean;
import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.constants.AmuletConstants;
import com.valhalla.amulet.entity.MemberEntity;
import com.valhalla.amulet.entity.UserEntity;
import com.valhalla.amulet.utils.AmuletUtils;
import com.valhalla.amulet.utils.MailUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;
import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

/**
 * Servlet implementation class LoginServlet
 */
public class ForgotPasswordServlet extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxMemSize = 4 * 1024;
    private File file ;
    private String URL;
    private String urlPath;

    private String smtpHost;
    private String smtpPort;
    private String smtpMailName;
    private String smtpMailId;
    private String smtpMailPwd;
    private String smtpRegSubj;
    private String smtpRegSuccess;

    public void init( ){
        // Get the file location where it would be stored.
        URL = getServletContext().getInitParameter("web-url");
        urlPath = getServletContext().getInitParameter("file-upload-members");
        filePath = getServletContext().getRealPath("/") + urlPath;
        File path = new File(filePath);
        if (!path.exists()) {
            path.mkdirs();
        }

        // get email configurations
        smtpHost = getServletContext().getInitParameter("SMTP_HOST");
        smtpPort = getServletContext().getInitParameter("SMTP_PORT");
        smtpMailName = getServletContext().getInitParameter("SMTP_MAIL_NAME");
        smtpMailId = getServletContext().getInitParameter("SMTP_MAIL_ID");
        smtpMailPwd = getServletContext().getInitParameter("SMTP_MAIL_PWD");
        smtpRegSubj = getServletContext().getInitParameter("SMTP_REG_SUBJ");
        smtpRegSuccess = getServletContext().getInitParameter("SMTP_PWD_SUCCESS");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nameEmail = "";
        nameEmail = (String) request.getParameter("name_mail");
        nameEmail = nameEmail.trim();


        List<HashMap> resultMap = getPassword(nameEmail);
        if (resultMap.size() == 0) {
            // not found registered member
            // forward to result page
            dispatch(request, response, "/forgtpwdfailpage");
        } else {
            String email = (String) resultMap.get(0).get("EMAIL");
            String password = (String) resultMap.get(0).get("PASSWORD");
            // send email
            try {
                InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(smtpRegSuccess);
                String smtpPwdSuccessTxt = IOUtils.toString(inputStream, "UTF-8");
                smtpPwdSuccessTxt = smtpPwdSuccessTxt + password;
                MailUtils.sendEmail(smtpHost, smtpPort, smtpMailName, smtpMailId, smtpMailPwd, email, smtpRegSubj, smtpPwdSuccessTxt);
            } catch(Exception ex) {
                System.err.println(">> Fail sending email to :"+ email);
                System.err.println(">> Cause: "+ ex.getMessage());
            }

            // forward to result page
            dispatch(request, response, "/forgtpwdsuccesspage");
        }
    }

    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    public List<HashMap> getPassword(String name_email) {
        String result = "";
        String query = "SELECT USER.PASSWORD, MEMBER.EMAIL FROM MEMBER, USER WHERE MEMBER.MEMBER_ID=USER.USER_ID AND (USER_NAME like '"+name_email+"' or MEMBER.EMAIL like '"+name_email+"')";
        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        List<HashMap> resultMap = (List) entities;
        session.flush();
        return resultMap;
    }
}