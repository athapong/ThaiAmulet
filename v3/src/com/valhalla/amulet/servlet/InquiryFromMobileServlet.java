package com.valhalla.amulet.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.valhalla.amulet.SearchStatisticDAO;
import com.valhalla.amulet.UserDAO;
import com.valhalla.amulet.bean.AmuletMasterBean;
import com.valhalla.amulet.bean.JSONRq;
import com.valhalla.amulet.bean.JSONRs;
import com.valhalla.amulet.connector.ConnectionManager;
import org.apache.commons.lang.StringUtils;
import org.hibernate.CacheMode;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class InquiryFromMobileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get received JSON data from request
        request.setCharacterEncoding("UTF-8");
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
        String json = "";
        if(br != null){
            json = br.readLine();
        }
        // initiate jackson mapper
        ObjectMapper mapper = new ObjectMapper();

        // Convert received JSON to Article
        JSONRq jsonRq = new JSONRq();
        JSONRs jsonRs = new JSONRs();

        try {
            jsonRq = mapper.readValue(json, JSONRq.class);
            jsonRs.setReq(jsonRq);
            // authenticate customer using mobile number
            //String id4scan = StringUtils.trim(jsonRq.getId4scan());
            int validUser = 1;//UserDAO.getInstance().checkMemberExist(id4scan);

            // do inquiry info from database
            List<AmuletMasterBean> entities = new ArrayList<AmuletMasterBean>();

            if (validUser != -1) {
                String sqlStr = StringUtils.trim(jsonRq.getSql());
                entities = getAmuletMaster(sqlStr);
                if (entities.size() == 0) {
                    jsonRs.setStatus("No record found.");
                } else {
                    jsonRs.setStatus("Success.");
                }
                jsonRs.setEntities(entities);
                SearchStatisticDAO.getInstance().insertSearchStat(validUser);
            } else {
                // return no authorize
                jsonRs.setStatus("No authorized.");
            }
        } catch(Exception ex) {
            jsonRs.setStatus(ex.getMessage());
        }
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        // Send List<Article> as JSON to client
        mapper.writeValue(response.getOutputStream(), jsonRs);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    private List<AmuletMasterBean> getAmuletMaster(String queryStr) {
        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(queryStr);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Transformers.aliasToBean(AmuletMasterBean.class));
        List<AmuletMasterBean> entities = sqlQuery.list();
        session.flush();
        session.close();
        return entities;
    }
}
