package com.valhalla.amulet.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.valhalla.amulet.bean.JSONRq;
import com.valhalla.amulet.bean.JSONRs;
import com.valhalla.amulet.connector.ConnectionManager;
import org.apache.commons.lang.StringUtils;
import org.hibernate.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;

public class MBPmtCheckServlet extends HttpServlet {
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
            String id4scan = StringUtils.trim(jsonRq.getId4scan());
            List entities = getPaymentFlag(id4scan);
            if (entities != null) {
                if (entities.size() == 0) {
                    jsonRs.setStatus("No record found.");
                } else {
                    jsonRs.setEntities(entities);
                    jsonRs.setStatus("Success.");
                }
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

    private List getPaymentFlag(String id4scan) {
        String query = "SELECT PMT_DATE, DATE_ADD(PMT_DATE, INTERVAL 1 YEAR) >= curdate()  AS PMT_STATUS FROM MEMBER WHERE MEMBER.ID4SCAN="+id4scan;
        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<HashMap> entities = sqlQuery.list();
        return entities;
    }
}
