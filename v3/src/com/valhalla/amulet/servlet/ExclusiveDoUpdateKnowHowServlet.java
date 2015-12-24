/**
 * Created by athapong on 2/28/2015 AD.
 */
package com.valhalla.amulet.servlet;

import com.valhalla.amulet.KnowHowDAO;
import com.valhalla.amulet.bean.AdminManageKnowHowBean;
import com.valhalla.amulet.constants.AmuletConstants;
import com.valhalla.amulet.entity.AmuletKnowhowEntity;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class ExclusiveDoUpdateKnowHowServlet
 */
public class ExclusiveDoUpdateKnowHowServlet extends HttpServlet {

    private String filePath;

    public void init( ){
        // Get the file location where it would be stored.
        filePath = getServletContext().getInitParameter("file-upload-knowhow");
        File path = new File(filePath);
        if (!path.exists()) {
            path.mkdirs();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String subject = "";
        String region = "";
        String province = "";
        String matType1 = "";
        String matType2 = "";
        String publish = "";
        String knowhowId = "";
        String content = "";
        boolean refreshOnly = false;
        List<FileItem> fileUpload = new ArrayList<FileItem>();
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    if (item.getFieldName().equals("subject")) {
                        subject = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("region")) {
                        region = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("province")) {
                        province = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("matType1")) {
                        matType1 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("matType2")) {
                        matType2 = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("publish")) {
                        publish = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("knowhowId")) {
                        knowhowId = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("content")) {
                        content = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("isdropdownchange") && new String (item.getString().getBytes ("iso-8859-1"), "UTF-8").equals("Y")) {
                        AdminManageKnowHowBean formBean = null;
                        if (request.getSession().getAttribute("ex_manage_knowhow_form_bean") != null) {
                            formBean = (AdminManageKnowHowBean) request.getSession().getAttribute("ex_manage_knowhow_form_bean");
                        } else {
                            formBean = new AdminManageKnowHowBean();
                        }
                        formBean.setRegion(region);
                        formBean.setProvince(province);
                        formBean.setMatType1(matType1);
                        formBean.setMatType2(matType2);
                        request.getSession().setAttribute("ex_manage_knowhow_form_bean", formBean);
                        refreshOnly = true;
                    }
            } else {
                    fileUpload.add(item);
                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Cannot parse multipart request.", e);
        }

        if (refreshOnly) {
            response.sendRedirect("addkmpage");
        } else {
            AmuletKnowhowEntity entity = new AmuletKnowhowEntity();
            if (knowhowId != null &&  StringUtils.isNotEmpty(knowhowId)) {
                entity.setKhId(Integer.parseInt(knowhowId));
            }

            entity.setSubjectName(subject);
            entity.setRegionCode(region);
            entity.setProvince(province);
            entity.setMatType1(matType1);
            entity.setMatType2(matType2);
            entity.setContent(content);
            entity.setPublishFl(publish.equals("1") ? (byte) 1 : (byte) 0);
            boolean insertSuccess = KnowHowDAO.getInstance().addOrUpdateKnowHow(entity);

            for (FileItem fi:fileUpload) {
                if (StringUtils.isNotEmpty(fi.getName())) {
                    String fname = AmuletUtils.uploadImage(fi, String.valueOf(entity.getKhId()), filePath);
                    if (fi.getFieldName().equals("pic1")) {
                        entity.setPic1(AmuletConstants.HOST_STATIC_URL + AmuletConstants.KNOWHOW_DIR + "/" + fname);
                    } else if (fi.getFieldName().equals("pic2")) {
                        entity.setPic2(AmuletConstants.HOST_STATIC_URL + AmuletConstants.KNOWHOW_DIR + "/" + fname);
                    } else if (fi.getFieldName().equals("pic3")) {
                        entity.setPic3(AmuletConstants.HOST_STATIC_URL + AmuletConstants.KNOWHOW_DIR + "/" + fname);
                    } else if (fi.getFieldName().equals("pic4")) {
                        entity.setPic4(AmuletConstants.HOST_STATIC_URL + AmuletConstants.KNOWHOW_DIR + "/" + fname);
                    } else if (fi.getFieldName().equals("pic5")) {
                        entity.setPic5(AmuletConstants.HOST_STATIC_URL + AmuletConstants.KNOWHOW_DIR + "/" + fname);
                    }

                } else {
                    if (request.getSession().getAttribute("knowhow_entity") != null) {
                        AmuletKnowhowEntity amuletKnowHowEntity = (AmuletKnowhowEntity) request.getSession().getAttribute("knowhow_entity");
                        if (fi.getFieldName().equals("pic1")) {
                            entity.setPic1(amuletKnowHowEntity.getPic1());
                        } else if (fi.getFieldName().equals("pic2")) {
                            entity.setPic2(amuletKnowHowEntity.getPic2());
                        } else if (fi.getFieldName().equals("pic3")) {
                            entity.setPic3(amuletKnowHowEntity.getPic3());
                        } else if (fi.getFieldName().equals("pic4")) {
                            entity.setPic4(amuletKnowHowEntity.getPic4());
                        } else if (fi.getFieldName().equals("pic5")) {
                            entity.setPic5(amuletKnowHowEntity.getPic5());
                        }
                    }
                }
            }
            boolean updateSuccess = KnowHowDAO.getInstance().addOrUpdateKnowHow(entity);
            if (updateSuccess) {
                response.sendRedirect("mgtkmservlet"); //error page
                request.getSession().setAttribute("updateknowhow","success");
            } else {
                response.sendRedirect("ex_add_knowhow_fail"); //error page
            }
            request.getSession().removeAttribute("knowhow_entity");
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String knowhowId = "";
        knowhowId = request.getParameter("knowhowId");
        // get news info for this record
        AmuletKnowhowEntity amuletKnowHowEntity = KnowHowDAO.getInstance().getKnowhowInfo(knowhowId);
        request.getSession().setAttribute("knowhow_entity",amuletKnowHowEntity);
        if (request.getSession().getAttribute("admin_session") == null) {
            KnowHowDAO.getInstance().increaseViewCount(knowhowId);
            response.sendRedirect("viewkmpage"); //use the same page as add
        } else {
            response.sendRedirect("addkmpage"); //use the same page as add
        }

    }
}