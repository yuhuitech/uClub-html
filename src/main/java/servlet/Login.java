package servlet;

import Test.*;
import com.mysql.cj.xdevapi.JsonString;
import operations.LoginDao;
import operations.applyClubDao;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
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
        if(status.equals("student") )selectPasswd = getStudentPasswd(sqlSessionFactory,userID);
        else selectPasswd = getTeacherPasswd(sqlSessionFactory,userID);

        if(userPasswd.equals(selectPasswd)){
            System.out.println("密码正确");
            HttpSession session = req.getSession();
            session.setAttribute("UserNo", userID);
            session.setAttribute("Status",status);
            resp.getWriter().print("{'success':'true'}");
            resp.getWriter().flush();
            //页面跳转
             RequestDispatcher view = req.getRequestDispatcher("index.jsp");
            view.forward(req, resp);
        }
        else {
            resp.getWriter().print("{'success':'false'}");
            resp.getWriter().flush();
            System.out.println("输入密码错误,正确:"+selectPasswd+"   输入:"+userPasswd);
        }

    }

    String getStudentPasswd(SqlSessionFactory sqlSessionFactory, int userID){
        String selectPasswd="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            LoginDao selectInterface = session.getMapper(LoginDao.class);
            selectPasswd = selectInterface.getStudentPasswd(userID);
            session.commit();
            session.close();
            // 显示插入之后User信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectPasswd;
    }

    String getTeacherPasswd(SqlSessionFactory sqlSessionFactory, int userID){
        String selectPasswd="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            LoginDao selectInterface = session.getMapper(LoginDao.class);
            //区分学生和管理员
            selectPasswd = selectInterface.getTeacherPasswd(userID);
            session.commit();
            session.close();
            // 显示插入之后User信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectPasswd;
    }







}

