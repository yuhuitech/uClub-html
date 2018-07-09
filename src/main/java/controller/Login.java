package controller;

import DAO.DaoInterface;
import Test.*;
import operations.DAO;
import operations.LoginOperation;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=utf-8");

        int userID = Integer.parseInt(req.getParameter("userNo"));
        String userPasswd = req.getParameter("passwd");
        String status = req.getParameter("status");
        String selectPasswd=null;
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        //  String userName=getStudentName(sqlSessionFactory,userID);
        if(status.equals("student") )selectPasswd = DAO.getStudentPasswd(sqlSessionFactory,userID);
        else selectPasswd = DAO.getTeacherPasswd(sqlSessionFactory,userID);

        if(userPasswd.equals(selectPasswd)){
            System.out.println("密码正确");
            HttpSession session = req.getSession();
            session.setAttribute("UserNo", userID);
            session.setAttribute("Status",status);
            resp.getWriter().print("{'success':'true'}");
            resp.getWriter().flush();
            //已经写回了响应，不可重新分派，到此为止
        }
        else {
            resp.getWriter().print("{'success':'false'}");
            resp.getWriter().flush();
            System.out.println("输入密码错误,正确:"+selectPasswd+"   输入:"+userPasswd);
        }

    }
}

