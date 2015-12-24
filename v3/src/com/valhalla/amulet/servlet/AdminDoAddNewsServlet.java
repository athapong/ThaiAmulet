package com.valhalla.amulet.servlet;

import com.valhalla.amulet.NewsDAO;
import com.valhalla.amulet.constants.AmuletConstants;
import com.valhalla.amulet.entity.NewsEntity;
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

public class AdminDoAddNewsServlet extends HttpServlet {
    private String filePath;

    public void init( ){
        // Get the file location where it would be stored.
        filePath = getServletContext().getInitParameter("file-upload-news");
        File path = new File(filePath);
        if (!path.exists()) {
            path.mkdirs();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newsCat = "";
        String newsSubj = "";
        String newsDesc = "";
        String newsDate = "";
        String newsTime = "";
        String newsId = "";
        List<FileItem> fileUpload = new ArrayList<FileItem>();
        request.setCharacterEncoding("UTF-8");
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    if (item.getFieldName().equals("news_cat")) {
                        newsCat = new String (item.getString().getBytes("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("news_subj")) {
                        newsSubj = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("news_desc")) {
                        newsDesc = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("newsDate")) {
                        newsDate = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("newsTime")) {
                        newsTime = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    } else if (item.getFieldName().equals("newsId")) {
                        newsId = new String (item.getString().getBytes ("iso-8859-1"), "UTF-8");
                    }
                } else {
                    fileUpload.add(item);
                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Cannot parse multipart request.", e);
        }
        NewsEntity newsEntity = new NewsEntity();
        if (!newsId.equals("")) {
            newsEntity.setNewsCode(Integer.parseInt(newsId));
        }
        newsEntity.setNewsCat(newsCat);
        newsEntity.setNewsSubj(newsSubj);
        newsEntity.setNewsDesc(newsDesc);
        newsEntity.setNewsDate(AmuletUtils.strToSqlDate(newsDate));
        newsEntity.setNewsTime(AmuletUtils.strToSqlTime(newsTime));
        // upload image
        for (FileItem fi:fileUpload) {
            if (StringUtils.isNotEmpty(fi.getName())) {
                String fname = AmuletUtils.uploadImage(fi, String.valueOf(newsEntity.getNewsCode()), filePath);
                if (fi.getFieldName().equals("btnNewsPicUpload")) {
                    newsEntity.setNewsPic(AmuletConstants.HOST_STATIC_URL + AmuletConstants.NEWS_DIR + "/" + fname);
                }
            }
        }
        boolean result = NewsDAO.getInstance().addNews(newsEntity);
        if (result) {
            response.sendRedirect("newsinqservlet"); //error page
            request.getSession().setAttribute("addNews","success");
        } else {
            response.sendRedirect("newsinqservlet"); //error page
            request.getSession().setAttribute("addNews","error");
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newsCode = "";
        newsCode = request.getParameter("newsId");
        // get news info for this record
        NewsEntity newsEntity = NewsDAO.getInstance().getNewsInfo(newsCode);
        request.getSession().setAttribute("news_entity",newsEntity);
        //response.sendRedirect("addnewspage"); //use the same page as add

        if (request.getSession().getAttribute("admin_session") == null) {
            response.sendRedirect("viewnewspage");
        } else {
            response.sendRedirect("addnewspage");
        }

    }
}
