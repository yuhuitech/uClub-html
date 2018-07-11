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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ChangeActiveStatus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        req.setCharacterEncoding("UTF-8");
        int ActiveNo= Integer.parseInt(req.getParameter("ActiveNo"));
        int ClubNo= Integer.parseInt(req.getParameter("Club_id"));
        String changeName=req.getParameter("changeName");
        String changeInfo=req.getParameter("changeInfo");
        Date changeBegin = null;
        Date changeEnd = null;
        try {
            changeBegin = sdf.parse(req.getParameter("changeBegin"));
            changeEnd=sdf.parse(req.getParameter("changeEnd"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String begin=sdf.format(changeBegin);
        String end=sdf.format(changeEnd);

        String Status=req.getParameter("ActiveStatus");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.changeActiveStatus(sqlSessionFactory,ActiveNo,changeName,changeInfo,begin,end,Status);
        System.out.println("成功修改状态");
        req.getRequestDispatcher("/jsp/ClubInfo.jsp?ClubNo="+ClubNo).forward(req, resp);

    }
}
