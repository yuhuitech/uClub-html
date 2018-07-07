package controller;
import model.Club;
import operations.ClubOperations;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.session.SqlSessionFactory;
import org.omg.PortableInterceptor.INACTIVE;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
@MultipartConfig
public class ClubManagement extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException{
        HttpSession session = req.getSession();
        req.setCharacterEncoding("utf-8");
        String ClubNoS = req.getParameter("ClubNo");
        int ClubNo;
        String statusS = req.getParameter("status");
        int status;
        String Type = req.getParameter("Type");
        String ClubInfo = req.getParameter("ClubInfo");
        String ClubName = req.getParameter("ClubName");
//此文件不用 仅保留
    }
}
