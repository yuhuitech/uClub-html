package servlet;

import Test.Test;
import model.Activity;
import model.Club;
import operations.ClubDetailDao;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class ClubDetail extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session=req.getSession();
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        String Club_No = req.getParameter("Club_id");
        //int ClubNo = 1;
        if(Club_No !=null) {
            ClubNo = Integer.parseInt(Club_No);
        }
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        Club club=getClubDetail(sqlSessionFactory,ClubNo);
        req.setAttribute("ClubNo",ClubNo);
        req.setAttribute("ClubName",club.getClubName());
        req.setAttribute("ClubType",club.getType());
        req.setAttribute("ClubInfo",club.getClubInfo());

        List<Activity> activities=getClubActivities(sqlSessionFactory,ClubNo);
        req.setAttribute("activities",activities);
        //跳转

        req.getRequestDispatcher("/jsp/clubDetail.jsp").forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        doPost(req,resp);


    }

    Club getClubDetail(SqlSessionFactory sqlSessionFactory, int ClubNo){

        Club club=new Club();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            club = selectInterface.getClubDetail(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return club;
    };

    public static List<Activity> getClubActivities(SqlSessionFactory sqlSessionFactory, int ClubNo){

        List<Activity> list=new ArrayList<>();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            list=selectInterface.getClubActivities(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    };




}
