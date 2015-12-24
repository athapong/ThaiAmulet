package com.valhalla.amulet.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.valhalla.amulet.bean.JSONRq;
import com.valhalla.amulet.bean.JSONRs;
import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.entity.ColorEntity;
import org.apache.commons.lang.StringUtils;
import org.hibernate.CacheMode;
import org.hibernate.Query;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class MBGetMasterDataServlet extends HttpServlet {
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
            //String mobileNo = StringUtils.trim(jsonRq.getMobileNo());
            int validUser = 1; //UserDAO.getInstance().checkMemberExist(mobileNo);

            List entities = new ArrayList();
            if (validUser != -1) {
                if (jsonRq != null) {
                    if (jsonRq.getTable().equalsIgnoreCase("CHAMBER")) {
                        entities = getChamberList();
                    } else if (jsonRq.getTable().equalsIgnoreCase("CHARACTER")) {
                        entities = getCharacterList();
                    } else if (jsonRq.getTable().equalsIgnoreCase("COLOR")) {
                        entities = getColorList();
                    } else if (jsonRq.getTable().equalsIgnoreCase("DEFECTDESC")) {
                        entities = getDefectDescList();
                    } else if (jsonRq.getTable().equalsIgnoreCase("DEFECTPOSITION")) {
                        entities = getDefectPositionList();
                    } else if (jsonRq.getTable().equalsIgnoreCase("FORM1")) {
                        entities = getForm1List();
                    } else if (jsonRq.getTable().equalsIgnoreCase("FORM2")) {
                        entities = getForm2List();
                    } else if (jsonRq.getTable().equalsIgnoreCase("LOCKET")) {
                        entities = getLocketList();
                    } else if (jsonRq.getTable().equalsIgnoreCase("MATDESC")) {
                        entities = getMatDescList();
                    } else if (jsonRq.getTable().equalsIgnoreCase("MATTYPE1")) {
                        entities = getMatType1List();
                    } else if (jsonRq.getTable().equalsIgnoreCase("MATTYPE2")) {
                        entities = getMatType2List();
                    } else if (jsonRq.getTable().equalsIgnoreCase("MATERIAL")) {
                        entities = getMaterialList();
                    }
                }

                if (entities.size() == 0) {
                    jsonRs.setStatus("No record found.");
                } else {
                    jsonRs.setStatus("Success.");
                }
                jsonRs.setEntities(entities);
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

    private List getChamberList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from ChamberEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getCharacterList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from CharacterEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getColorList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from ColorEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getDefectDescList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from DefectDescEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getDefectPositionList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from DefectPositionEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getForm1List() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from Form1Entity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getForm2List() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from Form2Entity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getLocketList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from LocketEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getMatDescList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from MatDescEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getMatType1List() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from MatType1Entity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getMatType2List() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from MatType2Entity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }
    private List getMaterialList() {
        Session session = ConnectionManager.getSession();
        Query query = session.createQuery("from MaterialEntity");
        List list = query.list();
        session.setCacheMode(CacheMode.IGNORE);
        session.flush();
        session.close();
        return list;
    }










}
