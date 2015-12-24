/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.valhalla.amulet.AmuletMasterDAO;
import com.valhalla.amulet.bean.UserBean;
import com.valhalla.amulet.constants.AmuletConstants;
import com.valhalla.amulet.entity.AmuletMasterEntity;
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
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class ExclusiveDoUpdateAmuletServlet
 */
public class ExclusiveDoUpdateAmuletServlet extends HttpServlet {

    private String filePath;
    public void init( ){
        // Get the file location where it would be stored.
        filePath = getServletContext().getInitParameter("file-upload-amulets");
        File path = new File(filePath);
        if (!path.exists()) {
            path.mkdirs();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amulet_name = "";
        String s_width = "";
        String s_long = "";
        String s_tall = "";
        String material = "";
        String year_from = "";
        String year_to = "";
        String form_1 = "";
        String form_2 = "";
        String character = "";
        String color = "";
        String vernerable = "";
        String temple = "";
        String province = "";
        String amphur_code = "";
        String tambol_code = "";
        String chamber = "";
        String locket_fl = "";
        String mat_type_1 = "";
        String mat_type_2 = "";
        String meditaion_l = "";
        String price_from = "";
        String price_to = "";
        String defect_des_1 = "";
        String mat_des_1 = "";
        String mat_des_2 = "";
        String mat_des_3 = "";
        String mat_des_4 = "";
        String rating = "";
        String note = "";

        List<FileItem> fileUpload = new ArrayList<FileItem>();
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    if (item.getFieldName().equals("amulet_name")) {
                        amulet_name = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("s_width")) {
                        s_width = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("s_long")) {
                        s_long = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("s_tall")) {
                        s_tall = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("material")) {
                        material = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("year_from")) {
                        year_from = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("year_to")) {
                        year_to = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("form_1")) {
                        form_1 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("form_2")) {
                        form_2 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("character")) {
                        character = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("color")) {
                        color = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("vernerable")) {
                        vernerable = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("temple")) {
                        temple = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("province")) {
                        province = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("amphur_code")) {
                        amphur_code = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("tambol_code")) {
                        tambol_code = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("chamber")) {
                        chamber = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("locket_fl")) {
                        locket_fl = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("mat_type_1")) {
                        mat_type_1 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("mat_type_2")) {
                        mat_type_2 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("meditaion_l")) {
                        meditaion_l = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("price_from")) {
                        price_from = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("price_to")) {
                        price_to = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("defect_des_1")) {
                        defect_des_1 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("mat_des_1")) {
                        mat_des_1 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("mat_des_2")) {
                        mat_des_2 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("mat_des_3")) {
                        mat_des_3 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("mat_des_4")) {
                        mat_des_4 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("rating")) {
                        rating = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("note")) {
                        note = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    }
            } else {
                    fileUpload.add(item);
                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Cannot parse multipart request.", e);
        }

        AmuletMasterEntity entity = (AmuletMasterEntity) request.getSession().getAttribute("amulet_item_result");
        if (StringUtils.isNotEmpty(amulet_name)) {
            entity.setAmuletName(amulet_name);
        }
        if (StringUtils.isNotEmpty(s_width)) {
            entity.setsWidth(BigDecimal.valueOf(Double.valueOf(s_width)));
        }
        if (StringUtils.isNotEmpty(s_long)) {
            entity.setsLong(BigDecimal.valueOf(Double.valueOf(s_long)));
        }
        if (StringUtils.isNotEmpty(s_tall)) {
            entity.setsTall(BigDecimal.valueOf(Double.valueOf(s_tall)));
        }
        entity.setMaterial(AmuletUtils.unSelectedToEmptyStr(material));
        entity.setYearFrom(year_from);
        entity.setYearTo(year_to);
        entity.setAmuletCharacter(AmuletUtils.unSelectedToEmptyStr(character));
        entity.setColor(AmuletUtils.unSelectedToEmptyStr(color));
        entity.setForm1(form_1);
        entity.setForm2(form_2);
        entity.setVernerable(vernerable);
        entity.setTemple(temple);
        entity.setProvinceCode(AmuletUtils.unSelectedToEmptyStr(province));
        entity.setAmphurCode(AmuletUtils.unSelectedToEmptyStr(amphur_code));
        entity.setDistrictCode(AmuletUtils.unSelectedToEmptyStr(tambol_code));
        entity.setChamber(AmuletUtils.unSelectedToEmptyStr(chamber));
        entity.setLocketFl(AmuletUtils.unSelectedToEmptyStr(locket_fl));
        entity.setMatType1(AmuletUtils.unSelectedToEmptyStr(mat_type_1));
        entity.setMatType2(AmuletUtils.unSelectedToEmptyStr(mat_type_2));
        if (StringUtils.isNotEmpty(meditaion_l)) {
            entity.setMeditationL(BigDecimal.valueOf(Double.valueOf(meditaion_l)));
        }
        if (StringUtils.isNotEmpty(price_from)) {
            entity.setPriceFrom(BigDecimal.valueOf(Double.valueOf(price_from)));
        }
        if (StringUtils.isNotEmpty(price_to)) {
            entity.setPriceTo(BigDecimal.valueOf(Double.valueOf(price_to)));
        }
        entity.setDefectDes1(defect_des_1.trim());
        entity.setMatDes1(AmuletUtils.unSelectedToEmptyStr(mat_des_1));
        entity.setMatDes2(AmuletUtils.unSelectedToEmptyStr(mat_des_2));
        entity.setMatDes3(AmuletUtils.unSelectedToEmptyStr(mat_des_3));
        entity.setMatDes4(AmuletUtils.unSelectedToEmptyStr(mat_des_4));

        entity.setRating(AmuletUtils.unSelectedToEmptyStr(rating));
        entity.setNote(note);

        AmuletMasterDAO.getInstance().updateAmuletMaster(entity);

        for (FileItem fi:fileUpload) {
            if (StringUtils.isNotEmpty(fi.getName())) {
                String fname = AmuletUtils.uploadImage(fi, String.valueOf(entity.getAmuletCode()), filePath);
                if (fi.getFieldName().equals("pic1")) {
                    entity.setAmuletPic(AmuletConstants.HOST_STATIC_URL + AmuletConstants.AMULET_DIR+"/" + fname);
                }
            } else {
                if (request.getSession().getAttribute("amulet_item_result") != null) {
                    AmuletMasterEntity amuletMasterEntity = (AmuletMasterEntity) request.getSession().getAttribute("amulet_item_result");
                    if (fi.getFieldName().equals("pic1")) {
                        entity.setAmuletPic(amuletMasterEntity.getAmuletPic());
                    }
                }
            }
        }
        boolean updateSuccess = AmuletMasterDAO.getInstance().updateAmuletMaster(entity);
        if (updateSuccess) {
            UserBean user = (UserBean) request.getSession().getAttribute("admin_session");
            if (user.getRole().equals(AmuletConstants.ADMIN_TYPE)) {
                response.sendRedirect("amuletinqservlet");
            } else if (user.getRole().equals(AmuletConstants.EXCV_TYPE)) {
                response.sendRedirect("amuletresultpage"); //error page
            }

            request.getSession().setAttribute("updateamulet","success");
        } else {
            response.sendRedirect("ex_add_knowhow_fail"); //error page
        }
    }
}