/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.valhalla.amulet.UserDAO;
import com.valhalla.amulet.bean.UserBean;
import com.valhalla.amulet.constants.AmuletConstants;
import com.valhalla.amulet.entity.MemberEntity;
import com.valhalla.amulet.entity.UserEntity;
import com.valhalla.amulet.utils.AmuletUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Servlet implementation class LoginServlet
 */
public class AdminDoUpdateUserServlet extends HttpServlet {

    private String filePath;
    public void init( ){
        // Get the file location where it would be stored.
        filePath = getServletContext().getInitParameter("file-upload-members");
        File path = new File(filePath);
        if (!path.exists()) {
            path.mkdirs();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = "";
        String lastName = "";
        String sex = "";
        String birthDate = "";
        String pmtDate = "";
        String idCardNo = "";
        String id4scan = "";
        String mobileNo = "";
        String email = "";
        String userName = "";
        String password = "";
        String memberId = "";
        String roleCode = "";
        List<FileItem> fileUpload = new ArrayList<FileItem>();
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    if (item.getFieldName().equals("memberId")) {
                        memberId = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("firstname")) {
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
                    } else if (item.getFieldName().equals("phoneNo2")) {
                        mobileNo = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("email")) {
                        email = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("username")) {
                        userName = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("password")) {
                        password = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("roleCode")) {
                        roleCode = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("pmtDate")) {
                        pmtDate = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    }
                } else {
                    fileUpload.add(item);
                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Cannot parse multipart request.", e);
    }


    UserEntity userEntity = new UserEntity();
        userEntity.setUserName(userName);
        userEntity.setPassword(password);
        userEntity.setRoleCode(roleCode);
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

        if (pmtDate != null && !pmtDate.equals("")) {
            try {
                java.util.Date pmtDtJav = new SimpleDateFormat(AmuletConstants.DATE_PICKER_FORMAT).parse(pmtDate);
                String pmtDateMySql = AmuletUtils.converUtilDateToSqlDate(pmtDtJav);
                memberEntity.setPmtDate(Date.valueOf(pmtDateMySql));
            } catch(Exception ex) {
                memberEntity.setPmtDate(null);
            }
        }
        memberEntity.setEmail(email);
        memberEntity.setFname(firstName);
        memberEntity.setIdCard(idCardNo);
        memberEntity.setLname(lastName);
        memberEntity.setId4scan(id4scan);
        memberEntity.setPhoneNo2(mobileNo);
        memberEntity.setSex(sex);
        memberEntity.setMemberId(Integer.valueOf(memberId));
        for (FileItem fi:fileUpload) {
            if (StringUtils.isNotEmpty(fi.getName())) {
                String fname = AmuletUtils.uploadImage(fi, String.valueOf(memberEntity.getMemberId()), filePath);
                if (fi.getFieldName().equals("btnIdCardUpload")) {
                    memberEntity.setIdCardPic(AmuletConstants.HOST_STATIC_URL + AmuletConstants.MEMBER_DIR + "/" + fname);
                }
                if (fi.getFieldName().equals("btnHouseCertUpload")) {
                    memberEntity.setIdHomePic(AmuletConstants.HOST_STATIC_URL + AmuletConstants.MEMBER_DIR+"/" + fname);
                }
            } else {
                List<HashMap> userList = (List) request.getSession().getAttribute("preview_user_result");
                HashMap userInfo = userList.get(0);
                if (fi.getFieldName().equals("btnIdCardUpload")) {
                    memberEntity.setIdCardPic((String) userInfo.get("ID_CARD_PIC"));
                }
                if (fi.getFieldName().equals("btnHouseCertUpload")) {
                    memberEntity.setIdHomePic((String) userInfo.get("ID_HOME_PIC"));
                }
            }
        }
        boolean updateSuccess = UserDAO.getInstance().updateExistingMember(userEntity, memberEntity);
        if (updateSuccess) {
            UserBean user = new UserBean();
            user.setFirstName(memberEntity.getFname());
            user.setLastName(memberEntity.getLname());
            user.setUserName(userEntity.getUserName());
            request.getSession().setAttribute(AmuletConstants.USER_SESSION, user);
            response.sendRedirect("custinqservlet"); //error page
            request.getSession().setAttribute("updateMember","success");
        } else {
            response.sendRedirect("adduserfailpage"); //error page
        }
    }
}