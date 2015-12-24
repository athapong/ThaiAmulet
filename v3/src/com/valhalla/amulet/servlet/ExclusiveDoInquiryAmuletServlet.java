/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.mysql.jdbc.StringUtils;
import com.valhalla.amulet.bean.AmuletMasterBean;
import com.valhalla.amulet.bean.ExAmuletResultBean;
import com.valhalla.amulet.bean.UserBean;
import com.valhalla.amulet.connector.ConnectionManager;
import com.valhalla.amulet.constants.AmuletConstants;
import com.valhalla.amulet.entity.AmuletMasterEntity;
import com.valhalla.amulet.utils.AmuletUtils;
import org.hibernate.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

/**
 * Servlet implementation class ExclusiveQueryReportServlet
 */
public class ExclusiveDoInquiryAmuletServlet extends HttpServlet {

    public void init( ){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBean userBean = new UserBean();
        if (request.getSession().getAttribute("admin_session") != null) {
            userBean = (UserBean) request.getSession().getAttribute("admin_session");
        }

        if (request.getParameter("isdropdownchange") != null && request.getParameter("isdropdownchange").equals("Y")) {
            AmuletMasterBean formBean = null;
            if (request.getSession().getAttribute("ex_amulet_master_form_bean") != null) {
                formBean = (AmuletMasterBean) request.getSession().getAttribute("ex_amulet_master_form_bean");
            } else {
                formBean = new AmuletMasterBean();
            }
            formBean.setAMULET_NAME(AmuletUtils.nullToEmptyStr(request.getParameter("amulet_name")));
            if (request.getParameter("s_width") != null) {
                formBean.setS_WIDTH(AmuletUtils.strToBigDecimal(request.getParameter("s_width")));
            }
            if (request.getParameter("s_long") != null) {
                formBean.setS_LONG(AmuletUtils.strToBigDecimal(request.getParameter("s_long")));
            }
            if (request.getParameter("s_tall") != null) {
                formBean.setS_TALL(AmuletUtils.strToBigDecimal(request.getParameter("s_tall")));
            }
            formBean.setMATERIAL(AmuletUtils.nullToZero(request.getParameter("material")));
            formBean.setYEAR_FROM(AmuletUtils.nullToEmptyStr(request.getParameter("year_from")));
            formBean.setYEAR_TO(AmuletUtils.nullToEmptyStr(request.getParameter("year_to")));
            formBean.setFORM_1(AmuletUtils.nullToZero(request.getParameter("form_1")));
            formBean.setFORM_2(AmuletUtils.nullToZero(request.getParameter("form_2")));
            formBean.setAMULET_CHARACTER(AmuletUtils.nullToZero(request.getParameter("character")));
            formBean.setCOLOR(AmuletUtils.nullToZero(request.getParameter("color")));
            formBean.setVERNERABLE(AmuletUtils.nullToEmptyStr(request.getParameter("vernerable")));
            formBean.setTEMPLE(AmuletUtils.nullToEmptyStr(request.getParameter("temple")));
            formBean.setPROVINCE_CODE(AmuletUtils.nullToZero(request.getParameter("province")));
            formBean.setAMPHUR_CODE(AmuletUtils.nullToZero(request.getParameter("amphur_code")));
            formBean.setDISTRICT_CODE(AmuletUtils.nullToZero(request.getParameter("tambol_code")));
            formBean.setCHAMBER(AmuletUtils.nullToZero(request.getParameter("chamber")));
            formBean.setLOCKET_FL(AmuletUtils.nullToZero(request.getParameter("locket_fl")));
            formBean.setMAT_TYPE_1(AmuletUtils.nullToZero(request.getParameter("mat_type_1")));
            formBean.setMAT_TYPE_2(AmuletUtils.nullToZero(request.getParameter("mat_type_2")));
            if (request.getParameter("meditation_l") != null) {
                formBean.setMEDITATION_L(AmuletUtils.strToBigDecimal(request.getParameter("meditation_l")));
            }
            if (request.getParameter("price_from") != null) {
                formBean.setPRICE_FROM(AmuletUtils.strToBigDecimal(request.getParameter("price_from")));
            }
            if (request.getParameter("price_to") != null) {
                formBean.setPRICE_TO(AmuletUtils.strToBigDecimal(request.getParameter("price_to")));
            }

            formBean.setDEFECT_DES_1(request.getParameter("defect_des_1"));
            formBean.setMAT_DES_1(AmuletUtils.nullToZero(request.getParameter("mat_des_1")));
            formBean.setMAT_DES_2(AmuletUtils.nullToZero(request.getParameter("mat_des_2")));
            formBean.setMAT_DES_3(AmuletUtils.nullToZero(request.getParameter("mat_des_3")));
            formBean.setMAT_DES_4(AmuletUtils.nullToZero(request.getParameter("mat_des_4")));
            formBean.setRATING(AmuletUtils.nullToZero(request.getParameter("rating")));
            formBean.setNOTE(AmuletUtils.nullToEmptyStr(request.getParameter("note")));
            request.getSession().setAttribute("ex_amulet_master_form_bean", formBean);

            if (request.getSession().getAttribute("admin_session") == null) {
                response.sendRedirect("amuletpage");
            } else {
                if (userBean.getRole().equals(AmuletConstants.EXCV_TYPE)) {
                    response.sendRedirect("inqamuletpage");
                } else if (userBean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {
                    if (request.getParameter("page").equals("AdminAddAmuletMaster")) {
                        response.sendRedirect("addamuletpage");
                    } else if (request.getParameter("page").equals("ExUpdateAmuletMaster")){
                        response.sendRedirect("updtamuletpage");
                    }

                }
            }
        } else {
            String startFrom = "0";
            if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
                startFrom = String.valueOf((Integer.parseInt(request.getParameter("page")) * 10) - 10);
            }

            String whereCond = " WHERE ";
            String totalResultSql = "SELECT AMULET_CODE, AMULET_NAME, S_WIDTH, S_LONG, S_TALL, AMULET_PIC, MATERIAL, YEAR_FROM, YEAR_TO FROM AMULET_MASTER ";
            String rowCntSql = "SELECT COUNT(AMULET_CODE) TOTAL_ROWS FROM AMULET_MASTER ";
            String limits = " LIMIT "+ startFrom +",10";
            if (!StringUtils.isNullOrEmpty(request.getParameter("amulet_name"))) {
                whereCond += " AMULET_NAME like '%"+ request.getParameter("amulet_name") +"%' AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("s_width"))) {
                whereCond += " S_WIDTH <= "+ request.getParameter("s_width")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("s_long"))) {
                whereCond += " S_LONG <= "+ request.getParameter("s_long")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("s_tall"))) {
                whereCond += " S_TALL <= "+ request.getParameter("s_tall")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("material"))) {
                whereCond += " MATERIAL = "+ request.getParameter("material")+" AND";
            }
            try {
                if (!StringUtils.isNullOrEmpty(request.getParameter("year_from"))) {
                    whereCond += " YEAR_FROM >= "+ request.getParameter("year_from")+ " AND";
                }
                if (!StringUtils.isNullOrEmpty(request.getParameter("year_to"))) {
                    whereCond += " YEAR_TO <= "+ request.getParameter("year_to")+ " AND";
                }
            } catch(Exception ex) {
                // do nothing
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("form_1"))) {
                whereCond += " FORM_1 = "+ request.getParameter("form_1")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("form_2"))) {
                whereCond += " FORM_2 = "+ request.getParameter("form_2")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("character"))) {
                whereCond += " AMULET_CHARACTER  = "+ request.getParameter("character")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("color"))) {
                whereCond += " COLOR = "+ request.getParameter("color")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("vernerable"))) {
                whereCond += " VERNERABLE like '%"+ request.getParameter("vernerable") +"%' AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("temple"))) {
                whereCond += " TEMPLE like '%"+ request.getParameter("temple") +"%' AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("province"))) {
                whereCond += "  PROVINCE_CODE = "+ request.getParameter("province")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("amphur_code"))) {
                whereCond += " AMPHUR_CODE = "+ request.getParameter("amphur_code")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("tambol_code"))) {
                whereCond += " DISTRICT_CODE = "+ request.getParameter("tambol_code")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("chamber"))) {
                whereCond += " CHAMBER = "+ request.getParameter("chamber")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("locket_fl"))) {
                whereCond += " LOCKET_FL = "+ request.getParameter("locket_fl")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("mat_type_1"))) {
                whereCond += " MAT_TYPE_1 = "+ request.getParameter("mat_type_1")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("mat_type_2"))) {
                whereCond += " MAT_TYPE_2 = "+ request.getParameter("mat_type_2")+" AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("meditaion_l"))) {
                whereCond += " MEDITATION_L <= "+ request.getParameter("meditaion_l")+" AND";
            }
            try {
                if (!StringUtils.isNullOrEmpty(request.getParameter("price_from"))) {
                    whereCond += " PRICE_FROM >= "+ request.getParameter("price_from")+ " AND";
                }
                if (!StringUtils.isNullOrEmpty(request.getParameter("price_to"))) {
                    whereCond += " PRICE_TO <= "+ request.getParameter("price_to")+ " AND";
                }
            } catch(Exception ex) {
                // do nothing
            }

            if (!StringUtils.isNullOrEmpty(request.getParameter("defect_des_1"))) {
                whereCond += " DEFECT_DES_1 like '%"+ request.getParameter("defect_des_1")+"%' AND";
            }

            if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_1"))) {
                whereCond += " ( MAT_DES_1 = "+ request.getParameter("mat_des_1")+" OR ";
                whereCond += " MAT_DES_2 = "+ request.getParameter("mat_des_1")+" OR ";
                whereCond += " MAT_DES_3 = "+ request.getParameter("mat_des_1")+" OR ";
                whereCond += " MAT_DES_4 = "+ request.getParameter("mat_des_1")+" )";
                whereCond += " AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_2"))) {
                whereCond += " ( MAT_DES_1 = "+ request.getParameter("mat_des_2")+" OR ";
                whereCond += " MAT_DES_2 = "+ request.getParameter("mat_des_2")+" OR ";
                whereCond += " MAT_DES_3 = "+ request.getParameter("mat_des_2")+" OR ";
                whereCond += " MAT_DES_4 = "+ request.getParameter("mat_des_2")+" )";
                whereCond += " AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_3"))) {
                whereCond += " ( MAT_DES_1 = "+ request.getParameter("mat_des_3")+" OR ";
                whereCond += " MAT_DES_2 = "+ request.getParameter("mat_des_3")+" OR ";
                whereCond += " MAT_DES_3 = "+ request.getParameter("mat_des_3")+" OR ";
                whereCond += " MAT_DES_4 = "+ request.getParameter("mat_des_3")+" )";
                whereCond += " AND";

            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_4"))) {
                whereCond += " ( MAT_DES_1 = "+ request.getParameter("mat_des_4")+" OR ";
                whereCond += " MAT_DES_2 = "+ request.getParameter("mat_des_4")+" OR ";
                whereCond += " MAT_DES_3 = "+ request.getParameter("mat_des_4")+" OR ";
                whereCond += " MAT_DES_4 = "+ request.getParameter("mat_des_4")+" )";
                whereCond += " AND";

            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("rating"))) {
                whereCond += " RATING = "+ request.getParameter("rating");
            }


            whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "AND");
            whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, " WHERE ");
            //totalResultSql = totalResultSql.concat(whereCond).concat(limits);
            String currentPage = "1";
            if (!StringUtils.isNullOrEmpty(request.getParameter("page"))) {
                currentPage = request.getParameter("page").equals("0") ? "1" : request.getParameter("page");
            }
            List<Object[]> entities = searchAmulet(request, response, currentPage);
            if (entities.size() > 0) {
                request.getSession().setAttribute("amulet_result", entities);
            } else {
                if (Integer.valueOf(currentPage) > 1) {
                    currentPage = String.valueOf(Integer.parseInt(currentPage) - 1);
                    entities = searchAmulet(request, response, currentPage);
                    if (entities.size() == 0) {
                        request.getSession().removeAttribute("amulet_result");
                    } else {
                        request.getSession().setAttribute("amulet_result", entities);
                    }
                } else {
                    request.getSession().removeAttribute("amulet_result");
                }
            }


            // get total result
            rowCntSql = rowCntSql.concat(whereCond);

            Session session = ConnectionManager.getSession();
            SQLQuery sqlQuery = session.createSQLQuery(rowCntSql);
            session.setCacheMode(CacheMode.IGNORE);
            sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
            entities = sqlQuery.list();

            List<HashMap> totalRows = (List) entities;
            int rows = 0;
            if (totalRows.size() > 0) rows = Integer.valueOf(totalRows.get(0).get("TOTAL_ROWS").toString());
            savePageSession(request, AmuletUtils.calTotal10PerPage(rows), currentPage);
            session.close();
            //response.sendRedirect("amuletresultpage");
            // clear input form
            request.getSession().removeAttribute("ex_amulet_master_form_bean");
            if (request.getSession().getAttribute("admin_session") == null) {
                response.sendRedirect("amuletresultpage");
            } else {
                if (userBean.getRole().equals(AmuletConstants.EXCV_TYPE)) {
                    response.sendRedirect("amuletresultpage");
                } else if (userBean.getRole().equals(AmuletConstants.ADMIN_TYPE)) {
                    response.sendRedirect("addamuletpage");
                }

            }
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amulet_code = "";

        // clear selection form bean
        request.getSession().removeAttribute("ex_amulet_master_form_bean");
        if (!StringUtils.isNullOrEmpty(request.getParameter("amulet_code"))) {
            amulet_code = request.getParameter("amulet_code");
        }
        String query = "FROM AmuletMasterEntity WHERE amuletCode = "+ amulet_code;

        Session session = ConnectionManager.getSession();
        Query queryStr = session.createQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        List<AmuletMasterEntity> list = queryStr.list();
        if (list.size() > 0) {
            request.getSession().setAttribute("amulet_item_result", list.get(0));
        } else {
            request.getSession().removeAttribute("amulet_item_result");
        }
        session.flush();


        session.close();
        response.sendRedirect("viewamuletpage");
    }

    private void savePageSession(HttpServletRequest request, int pageCount, String currentPage) {
        ExAmuletResultBean formBean = new ExAmuletResultBean();
        formBean.setPageCount(new Integer(pageCount));
        formBean.setCurrentPage(new Integer(currentPage));
        request.getSession().setAttribute("ex_amulet_result_form_bean", formBean);
    }

    private List<Object[]> searchAmulet(HttpServletRequest request, HttpServletResponse response, String currentPage) {
        String whereCond = " WHERE ";
        String query = "SELECT AMULET_CODE, AMULET_NAME, S_WIDTH, S_LONG, S_TALL, AMULET_PIC, MATERIAL, YEAR_FROM, YEAR_TO FROM AMULET_MASTER ";

        if (!StringUtils.isNullOrEmpty(request.getParameter("amulet_name"))) {
            whereCond += " AMULET_NAME like '%"+ request.getParameter("amulet_name") +"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("s_width"))) {
            whereCond += " S_WIDTH <= "+ request.getParameter("s_width")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("s_long"))) {
            whereCond += " S_LONG <= "+ request.getParameter("s_long")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("s_tall"))) {
            whereCond += " S_TALL <= "+ request.getParameter("s_tall")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("material"))) {
            whereCond += " MATERIAL = "+ request.getParameter("material")+" AND";
        }
        try {
            if (!StringUtils.isNullOrEmpty(request.getParameter("year_from"))) {
                whereCond += " YEAR_FROM >= "+ request.getParameter("year_from")+ " AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("year_to"))) {
                whereCond += " YEAR_TO <= "+ request.getParameter("year_to")+ " AND";
            }
        } catch(Exception ex) {
            // do nothing
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("form_1"))) {
            whereCond += " FORM_1 = "+ request.getParameter("form_1")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("form_2"))) {
            whereCond += " FORM_2 = "+ request.getParameter("form_2")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("character"))) {
            whereCond += " AMULET_CHARACTER  = "+ request.getParameter("character")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("color"))) {
            whereCond += " COLOR = "+ request.getParameter("color")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("vernerable"))) {
            whereCond += " VERNERABLE like '%"+ request.getParameter("vernerable") +"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("temple"))) {
            whereCond += " TEMPLE like '%"+ request.getParameter("temple") +"%' AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("province"))) {
            whereCond += "  PROVINCE_CODE = "+ request.getParameter("province")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("amphur_code"))) {
            whereCond += " AMPHUR_CODE = "+ request.getParameter("amphur_code")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("tambol_code"))) {
            whereCond += " DISTRICT_CODE = "+ request.getParameter("tambol_code")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("chamber"))) {
            whereCond += " CHAMBER = "+ request.getParameter("chamber")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("locket_fl"))) {
            whereCond += " LOCKET_FL = "+ request.getParameter("locket_fl")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("mat_type_1"))) {
            whereCond += " MAT_TYPE_1 = "+ request.getParameter("mat_type_1")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("mat_type_2"))) {
            whereCond += " MAT_TYPE_2 = "+ request.getParameter("mat_type_2")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("meditaion_l"))) {
            whereCond += " MEDITATION_L <= "+ request.getParameter("meditaion_l")+" AND";
        }
        try {
            if (!StringUtils.isNullOrEmpty(request.getParameter("price_from"))) {
                whereCond += " PRICE_FROM >= "+ request.getParameter("price_from")+ " AND";
            }
            if (!StringUtils.isNullOrEmpty(request.getParameter("price_to"))) {
                whereCond += " PRICE_TO <= "+ request.getParameter("price_to")+ " AND";
            }
        } catch(Exception ex) {
            // do nothing
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_pos_1"))) {
            whereCond += " DEFECT_POS_1 = "+ request.getParameter("defect_pos_1")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_pos_2"))) {
            whereCond += " DEFECT_POS_2 = "+ request.getParameter("defect_pos_2")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_pos_3"))) {
            whereCond += " DEFECT_POS_3 = "+ request.getParameter("defect_pos_3")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_pos_4"))) {
            whereCond += " DEFECT_POS_4 = "+ request.getParameter("defect_pos_4")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_des_1"))) {
            whereCond += " DEFECT_DES_1 = "+ request.getParameter("defect_des_1")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_des_2"))) {
            whereCond += " DEFECT_DES_2 = "+ request.getParameter("defect_des_2")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_des_3"))) {
            whereCond += " DEFECT_DES_3 = "+ request.getParameter("defect_des_3")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("defect_des_4"))) {
            whereCond += " DEFECT_DES_4 = "+ request.getParameter("defect_des_4")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_1"))) {
            whereCond += " MAT_DES_1 = "+ request.getParameter("mat_des_1")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_2"))) {
            whereCond += " MAT_DES_2 = "+ request.getParameter("mat_des_2")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_3"))) {
            whereCond += " MAT_DES_3 = "+ request.getParameter("mat_des_3")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("mat_des_4"))) {
            whereCond += " MAT_DES_4 = "+ request.getParameter("mat_des_4")+" AND";
        }
        if (!StringUtils.isNullOrEmpty(request.getParameter("rating"))) {
            whereCond += " RATING = "+ request.getParameter("rating");
        }
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, "AND");
        whereCond = org.apache.commons.lang.StringUtils.removeEnd(whereCond, " WHERE ");
        String startFrom = "0";
        startFrom = String.valueOf((Integer.parseInt(currentPage) * 10) - 10);
        query += whereCond + " limit "+ startFrom +",10";

        Session session = ConnectionManager.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(query);
        session.setCacheMode(CacheMode.IGNORE);
        sqlQuery.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Object[]> entities = sqlQuery.list();
        session.flush();
        return entities;
    }
}