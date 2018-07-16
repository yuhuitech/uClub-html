package servlet;

import Test.Test;
import operations.DAO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ChangeActiveStatus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();
        req.setCharacterEncoding("UTF-8");

        Integer StuNo= (Integer) session.getAttribute("UserNo");
        int ActiveNo= Integer.parseInt(req.getParameter("ActiveNo"));
     //   int ClubNo= Integer.parseInt(req.getParameter("clubNo"));
        String changeName=req.getParameter("title");
        String changeInfo=req.getParameter("descr");
        String isJoin=req.getParameter("join");
        String begin1=req.getParameter("startTime");
        String end1=req.getParameter("endTime");
        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");//yyyy-mm-dd, 会出现时间不对, 因为小写的mm是代表: 秒
        Date begin_time = null;
        Date end_time = null;
        try {
            begin_time = sdf.parse(begin1);
            end_time=sdf.parse(end1);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        begin1=sdf.format(begin_time);
        end1=sdf.format(end_time);

        String Status=req.getParameter("status");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.changeActiveStatus(sqlSessionFactory,ActiveNo,changeName,changeInfo,begin1,end1,Status);
        System.out.println("成功修改状态");
     //   req.getRequestDispatcher("/jsp/calendar.jsp").forward(req, resp);

        if(isJoin.equals("true")){
            DAO.joinActivity(sqlSessionFactory,StuNo,ActiveNo);
        }
        else {
            DAO.exitActivity(sqlSessionFactory,StuNo,ActiveNo);
        }

    }
}
