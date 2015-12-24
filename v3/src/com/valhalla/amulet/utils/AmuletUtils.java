package com.valhalla.amulet.utils;

import com.valhalla.amulet.bean.UserBean;
import com.valhalla.amulet.constants.AmuletConstants;
import org.apache.commons.fileupload.FileItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletConfig;
import java.io.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Properties;
import java.util.StringTokenizer;

public class AmuletUtils {
    private final static Logger logger = LogManager.getLogger(AmuletUtils.class);

    public static String converUtilDateToSqlDate(java.util.Date utilDate) {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String sqlDate = sdf.format(utilDate);
        return sqlDate;
    }

    public static String getContent(String realPath) throws FileNotFoundException, IOException{
        logger.info(">> AmuletUtils.getContent()");
        StringBuilder sb = new StringBuilder();
        try {
            BufferedReader reader = new BufferedReader(new FileReader(realPath));
            String line;
            while((line = reader.readLine())!= null){
                sb.append(line+"\n");
            }
            logger.info(">> AmuletUtils.getContent() success");

        } catch(FileNotFoundException fe) {
            logger.error(fe.getMessage());
            throw fe;
        }

        logger.info("<< AmuletUtils.getContent()");
        return sb.toString();
    }

    public static String nullToEmptyStr(String str) {
        return str == null ? new String("") : new String(str.trim());
    }

    public static String nullToZero(String str) {
        return str == null || str.equals("") ? new String("0") : new String(str.trim());
    }

    public static String unSelectedToEmptyStr(String str) {
        return str.equals("0") ? new String("") : new String(str.trim());
    }

    public static int calTotalPage(int totalRows) {
        return (int) Math.ceil((double)totalRows/8);
    }
    public static int calTotal10PerPage(int totalRows) {
        return (int) Math.ceil((double)totalRows/10);
    }


    public static String uploadImage(FileItem fileItem, String userId, String filePath) {
        File file;
        String fullName = "";
        try {
            // Process the uploaded file items
            if (!fileItem.isFormField()) {
                // Get the uploaded file parameters
                String fieldName = fileItem.getFieldName();
                String fileName = fileItem.getName();
                String contentType = fileItem.getContentType();
                boolean isInMemory = fileItem.isInMemory();
                long sizeInBytes = fileItem.getSize();
                // Write the file
                if (fileName.lastIndexOf("\\") >= 0) {
                    file = new File(filePath +"/"+ userId.concat("_").concat(fileName.substring(fileName.lastIndexOf("\\"))));
                    fullName = new String(userId.concat("_").concat(fileName.substring(fileName.lastIndexOf("\\"))));
                } else {
                    file = new File(filePath +"/"+ userId.concat("_").concat(fileName));
                    fullName = new String(userId.concat("_").concat(fileName));
                }
                fileItem.write(file);
            }
        } catch (Exception ex) {
            logger.error("AmuletUtils.uploadImage(), "+ ex.getMessage());
        }
        return fullName;
    }

    public static String trimWithDotMore(String str, int size) {
        String dotted = "...";
        if (str.length() > size) {
            str = str.substring(0, size) + dotted;
        }
        return str;
    }

    public static String getDateStr(Date timestamp) {
        java.util.Date utilDate = new java.util.Date(timestamp.getTime());
        String dateStr = new SimpleDateFormat("dd/MM/yyyy").format(utilDate);
        return dateStr;
    }

    public static String getTimeStr(Time timestamp) {
        java.util.Date utilDate = new java.util.Date(timestamp.getTime());
        String timeStr = new SimpleDateFormat("HH:mm").format(utilDate);
        return timeStr;
    }

    public static Date strToSqlDate(String date) {
        java.util.Date dateUtilStr = null;
        Date sqlDate = null;
        try {
            dateUtilStr = new SimpleDateFormat("dd/MM/yyyy").parse(date);
            sqlDate = new Date(dateUtilStr.getTime());
        } catch (Exception ex) {
            // do nothing
        }
        return sqlDate;
    }

    public static Time strToSqlTime(String timeStr) {
        java.util.Date dateUtilStr = null;
        Time sqlTime = null;
        try {
            dateUtilStr = new SimpleDateFormat("HH:mm").parse(timeStr);
            sqlTime = new Time(dateUtilStr.getTime());
        } catch (Exception ex) {
            // do nothing
        }
        return sqlTime;
    }

    public static long strToTimeMilli(Date date, Time time) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        Date sqlDate = null;
        try {
            if (!time.toString().equals("00:00:00")) {
                cal.set(Calendar.HOUR, time.getHours());
                cal.set(Calendar.MINUTE, time.getMinutes());
            }
        } catch (Exception ex) {
            // do nothing
        }
        return cal.getTimeInMillis();
    }

    public static long strToTimestampMin(String dateStr) throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        java.util.Date date = format.parse(dateStr + " " + "00:00:00"); // mysql datetime format
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.getTimeInMillis();
    }
    public static long strToTimestampMax(String dateStr) throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        java.util.Date date = format.parse(dateStr + " " + "23:59:59"); // mysql datetime format
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.getTimeInMillis();
    }

    public static BigDecimal strToBigDecimal(String str) {
        DecimalFormat nf = (DecimalFormat) NumberFormat.getInstance();
        nf.setParseBigDecimal(true);

        BigDecimal bd = (BigDecimal)nf.parse(str, new ParsePosition(0));
        return bd;
    }

    public static String pageFwdByRole(UserBean bean) {
        String page = "";
        if (bean != null) {
            if (bean.getRole().equals(AmuletConstants.USER_TYPE)) {  // User
                page = "./index";
            } else if (bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) { // Admin
                page = "./admindexpage";
            } else if (bean.getRole().equals(AmuletConstants.EXCV_TYPE)) { // Exclusive
                page = "./exindex";
            }
        }
        return page;
    }

    public static boolean isAdmin(UserBean bean) {
        String page = "";
        if (bean != null) {
            if (bean.getRole().equals(AmuletConstants.ADMIN_TYPE)) { // Admin
                return true;
            }
        } else return false;
        return false;
    }
    public static boolean isExclusive(UserBean bean) {
        String page = "";
        if (bean != null) {
            if (bean.getRole().equals(AmuletConstants.EXCV_TYPE)) { // Exclusive
                return true;
            }
        } else return false;
        return false;
    }
    public static boolean isUser(UserBean bean) {
        String page = "";
        if (bean != null) {
            if (bean.getRole().equals(AmuletConstants.USER_TYPE)) { // Normal Users
                return true;
            }
        } else return false;
        return false;
    }

    public static ArrayList<String> getYearList(ServletConfig servletConfig) {
        ArrayList yearList = new ArrayList();
        Properties prop = new Properties();
        try {
            String propPath = servletConfig.getServletContext().getRealPath(File.separator);
            propPath = propPath+"resources/config/prop.properties";
            prop.load(new FileReader(propPath));
        } catch(Exception ex) {
            // do nothing
        }
        String yearFromTo = prop.getProperty(AmuletConstants.YEAR_FROM_TO);
        StringTokenizer stk = new StringTokenizer(yearFromTo, ",");
        while(stk.hasMoreElements()) {
            yearList.add(stk.nextElement());
        }
        return yearList;
    }
}
