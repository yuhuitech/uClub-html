package controller;

import Test.Test;

import operations.JoinClubDao;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;

public class JoinClubApply extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      //  doPost(req,resp);

        int ClubNo = Integer.parseInt(req.getParameter("ClubNo"));
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        String ClubName=getClubName(sqlSessionFactory,ClubNo);
        req.setAttribute("ClubName",ClubName);
        req.setAttribute("ClubNo",ClubNo);
        //跳转
        req.getRequestDispatcher("joinClubApply.jsp").forward(req,resp);
        }




    String getClubName(SqlSessionFactory sqlSessionFactory, int ClubNo){
        String ClubName="";
        try {
            SqlSession session = sqlSessionFactory.openSession();
            JoinClubDao selectInterface = session.getMapper(JoinClubDao.class);
            ClubName=selectInterface.getClubName(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ClubName;
    }

}
