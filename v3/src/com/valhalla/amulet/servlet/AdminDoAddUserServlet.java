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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

/**
 * Servlet implementation class LoginServlet
 */
public class AdminDoAddUserServlet extends HttpServlet {

    public void init( ){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sex = "M";
        String birthDate = "1900-01-01";

        UserEntity userEntity = new UserEntity();
        userEntity.setUserName(AmuletUtils.nullToEmptyStr(request.getParameter("usernameTxt")));
        userEntity.setPassword(AmuletUtils.nullToEmptyStr(request.getParameter("passwordTxt")));
        userEntity.setRoleCode(AmuletConstants.MEMBER_ROLE_CODE);

        MemberEntity memberEntity = new MemberEntity();
        memberEntity.setEmail(AmuletUtils.nullToEmptyStr(request.getParameter("email")));
        memberEntity.setFname(AmuletUtils.nullToEmptyStr(request.getParameter("firstname")));
        memberEntity.setIdCard(AmuletUtils.nullToEmptyStr(request.getParameter("idCardNo")));
        memberEntity.setLname(AmuletUtils.nullToEmptyStr(request.getParameter("lastname")));
        memberEntity.setPhoneNo2(AmuletUtils.nullToEmptyStr(request.getParameter("phoneno")));
        memberEntity.setBirthDate(Date.valueOf(birthDate));
        memberEntity.setSex(sex);
        boolean insertSuccess = UserDAO.getInstance().registerNewMember(userEntity, memberEntity);
        if (insertSuccess) {
            UserBean user = new UserBean();
            user.setFirstName(memberEntity.getFname());
            user.setLastName(memberEntity.getLname());
            user.setUserName(userEntity.getUserName());
            request.getSession().setAttribute(AmuletConstants.USER_SESSION, user);
            response.sendRedirect("addusersuccesspage"); //error page
        } else {
            response.sendRedirect("adduserfailpage"); //error page
        }
    }
}