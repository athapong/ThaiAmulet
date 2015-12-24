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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import javax.servlet.RequestDispatcher;
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
import java.util.Iterator;
import java.util.List;

/**
 * Servlet implementation class LoginServlet
 */
public class RegisterMemberServlet extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 50 * 1024;
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
        smtpRegSuccess = getServletContext().getInitParameter("SMTP_REG_SUCCESS");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = "";
        String lastName = "";
        String sex = "";
        String birthDate = "";
        String idCardNo = "";
        String id4scan = "";
        String mobileNo = "";
        String email = "";
        String userName = "";
        String password = "";
        String idCardPic = "";
        String houseCertPic = "";
        List<FileItem> fileUpload = new ArrayList<FileItem>();
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    if (item.getFieldName().equals("firstname")) {
                        firstName = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("lastname")) {
                        lastName = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("sex")) {
                        sex = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("birthDate")) {
                        birthDate = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("idCardNo")) {
                        idCardNo = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("id4scan")) {
                        id4scan = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("mobileNo")) {
                        mobileNo = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("email")) {
                        email = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("username")) {
                        userName = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("password")) {
                        password = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    }
                } else {
                    if (item.getFieldName().equals("btnIdCardUpload")) {
                        idCardPic = URL + urlPath + item.getName();
                    } else if (item.getFieldName().equals("btnHouseCertUpload")) {
                        houseCertPic = URL + urlPath + item.getName();
                    }
                    fileUpload.add(item);
                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Cannot parse multipart request.", e);
        }


        UserEntity userEntity = new UserEntity();
        userEntity.setUserName(userName);
        userEntity.setPassword(password);
        userEntity.setRoleCode(AmuletConstants.MEMBER_ROLE_CODE);

        MemberEntity memberEntity = new MemberEntity();
        if (birthDate != null && !birthDate.equals("")) {
            try {
                java.util.Date birthDtJav = new SimpleDateFormat(AmuletConstants.DATE_PICKER_FORMAT).parse(birthDate);
                String birthDateMySql = AmuletUtils.converUtilDateToSqlDate(birthDtJav);
                memberEntity.setBirthDate(Date.valueOf(birthDateMySql));
            } catch(Exception ex) {
                memberEntity.setBirthDate(null);
            }
        }
        memberEntity.setEmail(email);
        memberEntity.setFname(firstName);
        memberEntity.setIdCard(idCardNo);
        memberEntity.setLname(lastName);
        memberEntity.setId4scan(id4scan);
        memberEntity.setPhoneNo2(mobileNo);
        memberEntity.setSex(sex);
        memberEntity.setIdCardPic(idCardPic);
        memberEntity.setIdHomePic(houseCertPic);
        boolean insertSuccess = UserDAO.getInstance().registerNewMember(userEntity, memberEntity);
        if (insertSuccess) {
            uploadImage(fileUpload, String.valueOf(memberEntity.getMemberId()));
            UserBean user = new UserBean();
            user.setFirstName(memberEntity.getFname());
            user.setLastName(memberEntity.getLname());
            user.setUserName(userEntity.getUserName());

            // send email
            try {
                InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(smtpRegSuccess);
                String smtpRegSuccessTxt = IOUtils.toString(inputStream, "UTF-8");
                MailUtils.sendEmail(smtpHost, smtpPort, smtpMailName, smtpMailId, smtpMailPwd, memberEntity.getEmail(), smtpRegSubj, smtpRegSuccessTxt);
            } catch(Exception ex) {
                System.err.println(">> Fail sending email to :"+ memberEntity.getEmail());
                System.err.println(">> Cause: "+ ex.getMessage());
            }
            // redirect to register success page

            request.getSession().setAttribute(AmuletConstants.USER_SESSION, user);
            response.sendRedirect("registerSuccess.jsp");
        } else {
            response.sendRedirect("registerFail.jsp");
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String aDo = request.getParameter("do");
        if (aDo.equals(AmuletConstants.CHECK_USER_EXIST)) {
            if (request.getParameter("userName") != null) {
                String userName = request.getParameter("userName");
                boolean userExist = checkUserExist(userName);
                PrintWriter out = response.getWriter();
                out.print(userExist);
                out.close();
            }
            if (request.getParameter("email") != null) {
                String email = request.getParameter("email");
                boolean userExist = checkEmailExist(email);
                PrintWriter out = response.getWriter();
                out.print(userExist);
                out.close();
            }
        } else {
            // the popup edit page
            dispatch(request, response, "/edit");
        }
    }

    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    public boolean checkUserExist(String username) {
        boolean userExist = false;
        Session session = ConnectionManager.getSession();
        UserEntity userEntity = new UserEntity();
        userEntity.setUserName(username);
        session.beginTransaction();
        Criteria criteria = session.createCriteria(UserEntity.class);
        criteria.add(Restrictions.eq("userName", username));
        List<UserEntity> userResult = criteria.list();
        session.close();
        if (userResult != null && userResult.size() > 0) {
            userExist = true;
        } else {
            userExist = false;
        }
        return userExist;
    }

    public boolean checkEmailExist(String email) {
        boolean userExist = false;
        Session session = ConnectionManager.getSession();
        MemberEntity mEntity = new MemberEntity();
        mEntity.setEmail(email);
        session.beginTransaction();
        Criteria criteria = session.createCriteria(MemberEntity.class);
        criteria.add(Restrictions.eq("email", email));
        List<MemberEntity> mResult = criteria.list();
        session.close();
        if (mResult != null && mResult.size() > 0) {
            userExist = true;
        } else {
            userExist = false;
        }
        return userExist;
    }

    private void uploadImage(List<FileItem> fileItems, String userId) {
        try{
            // Process the uploaded file items
            Iterator i = fileItems.iterator();
            while ( i.hasNext () )
            {
                FileItem fi = (FileItem)i.next();
                if ( !fi.isFormField () )
                {
                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    String contentType = fi.getContentType();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    // Write the file
                    if( fileName.lastIndexOf("\\") >= 0 ){
                        file = new File( filePath +
                                userId.concat("_").concat(fileName.substring(fileName.lastIndexOf("\\")))) ;
                    }else{
                        file = new File( filePath +
                                userId.concat("_").concat(fileName.substring(fileName.lastIndexOf("\\")+1))) ;
                    }
                    fi.write( file ) ;
                }
            }
        }catch(Exception ex) {
            System.err.println(">> Uploading image failed" + ex.getMessage());
        }
    }
}