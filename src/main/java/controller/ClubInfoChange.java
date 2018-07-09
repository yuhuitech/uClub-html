package controller;

import operations.DAO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import Test.*;

@WebServlet(name = "ClubInfoChange")
public class ClubInfoChange extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=\"utf-8\"");
        PrintWriter out = response.getWriter();

        //消除接受乱码的问题
        request.setCharacterEncoding("UTF-8");

        String club_info = request.getParameter("Club_info");
        int club_id = Integer.parseInt(request.getParameter("Club_id"));
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.setClubInfo(sqlSessionFactory,club_id,club_info);
        request.getRequestDispatcher("jsp/UserHome.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
