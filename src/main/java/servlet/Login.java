package servlet;

import Test.Test;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import static servlet.DAO.*;


public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int userID = Integer.parseInt(req.getParameter("userNo"));
        String userPasswd = req.getParameter("passwd");
        String status = req.getParameter("status");
        String selectPasswd=null;
        String resource = "mybatis.xml";
        /*
         *为每位用户建立会话，并设置属性
         */
            List<Integer> ClubNo = new ArrayList();
            HttpSession session = req.getSession();
            if (session.isNew())
                session.setAttribute("bookID",ClubNo);

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        if(status.equals("student") )selectPasswd = getStudentPasswd(sqlSessionFactory,userID);
        else selectPasswd = getTeacherPasswd(sqlSessionFactory,userID);

        if(userPasswd.equals(selectPasswd)){
            System.out.println("密码正确");

             RequestDispatcher view = req.getRequestDispatcher("jsp/UserHome.jsp");
            view.forward(req, resp);
        }
        else System.out.println("输入密码错误,回去好好看表哟");
    }








}

