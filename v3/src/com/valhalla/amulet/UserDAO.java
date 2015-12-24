package com.valhalla.amulet;

import com.valhalla.amulet.bean.UserBean;
import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.constants.AmuletConstants;
import com.valhalla.amulet.entity.MemberEntity;
import com.valhalla.amulet.entity.UserEntity;
import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import java.util.List;

public class UserDAO
{
    private static UserDAO userDAO;
    public static UserDAO getInstance() {
        if (userDAO == null) userDAO = new UserDAO();
        return userDAO;
    }
    public UserBean login(UserBean bean) {
        String username = bean.getUsername();
        String password = bean.getPassword();

        Session session = ConnectionManager.getSession();
        UserEntity userEntity = new UserEntity();
        userEntity.setUserName(username);
        userEntity.setPassword(password);

        session.beginTransaction();
        Criteria criteria = session.createCriteria(UserEntity.class);
        criteria.add(Restrictions.eq("userName", username));
        criteria.add(Restrictions.eq("password", password));
        List<UserEntity> userResult = criteria.list();
        session.close();
        ConnectionManager.close();
        if (userResult != null && userResult.size() > 0) {
            if (userResult.get(0).getRoleCode().equals(AmuletConstants.ADMIN_TYPE) || userResult.get(0).getRoleCode().equals(AmuletConstants.EXCV_TYPE)) {
                bean.setAdmin(true);
            } else {
                bean.setAdmin(false);
            }
            bean.setRole(userResult.get(0).getRoleCode());
            bean.setValid(true);
            // get payment status
            bean.setMemberId(String.valueOf(userResult.get(0).getUserId()));
        } else {
            bean.setValid(false);
        }
        return bean;
    }

    public UserBean loginCookie(String UUID) {
        Session session = ConnectionManager.getSession();
        UserBean bean = null;
        session.beginTransaction();
        Criteria criteria = session.createCriteria(UserEntity.class);
        criteria.add(Restrictions.eq("uuid", UUID));
        List<UserEntity> userResult = criteria.list();
        session.close();
        ConnectionManager.close();
        if (userResult != null && userResult.size() > 0) {
            bean = new UserBean();
            bean.setUserName(userResult.get(0).getUserName());
            bean.setPassword(userResult.get(0).getPassword());

            if (userResult.get(0).getRoleCode().equals(AmuletConstants.ADMIN_TYPE) || userResult.get(0).getRoleCode().equals(AmuletConstants.EXCV_TYPE)) {
                bean.setAdmin(true);
            } else {
                bean.setAdmin(false);
            }
            bean.setRole(userResult.get(0).getRoleCode());
            bean.setValid(true);
        } else {
            bean.setValid(false);
        }
        return bean;
    }

    public boolean registerNewMember(UserEntity user, MemberEntity memberEntity)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        session.save(user);
        session.flush();
        memberEntity.setMemberId(Integer.valueOf(user.getUserId()));
        session.save(memberEntity);
        session.getTransaction().commit();
        session.close();
        ConnectionManager.close();
        return true;
    }

    public boolean updateExistingMember(UserEntity user, MemberEntity memberEntity)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        user.setUserId(memberEntity.getMemberId());
        session.update(user);
        session.flush();
        session.update(memberEntity);
        session.getTransaction().commit();
        session.close();
        ConnectionManager.close();
        return true;
    }

    public void deleteMember(int memberId) {
        Session session = ConnectionManager.getSession();
        Transaction tx = session.beginTransaction();

        MemberEntity member = new MemberEntity();
        member.setMemberId(memberId);
        UserEntity user = new UserEntity();
        user.setUserId(memberId);

        Criteria criteria = session.createCriteria(UserEntity.class);
        criteria.add(Restrictions.eq("userId", memberId));
        List<UserEntity> userResult = criteria.list();
        session.delete(userResult.get(0));

        criteria = session.createCriteria(MemberEntity.class);
        criteria.add(Restrictions.eq("memberId", memberId));
        List<MemberEntity> memberResult = criteria.list();
        session.delete(memberResult.get(0));
        tx.commit();
        session.close();
        ConnectionManager.close();
    }

    public int checkMemberExist(String mobileNo) {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(MemberEntity.class);
        criteria.add(Restrictions.eq("id4scan", mobileNo));
        List<MemberEntity> memberEntities = criteria.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.close();
        ConnectionManager.close();
        if (memberEntities != null && memberEntities.size() > 0) {
            return memberEntities.get(0).getMemberId();
        }
        return -1;
    }

    public boolean setRememberMe(UserBean user, String UUID)  {
        Session session = ConnectionManager.getSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(UserEntity.class);
        criteria.add(Restrictions.eq("userName", user.getUsername()));
        criteria.add(Restrictions.eq("password", user.getPassword()));
        List<UserEntity> userResult = criteria.list();

        if (userResult.size() > 0) {
            UserEntity userEntity = userResult.get(0);
            userEntity.setUuid(UUID);
            session.update(userEntity);
        }

        session.flush();
        session.getTransaction().commit();
        session.close();
        ConnectionManager.close();
        return true;
    }
}
