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
import java.util.Date;

import static operations.DAO.getDateTime;

public class MemberManage extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();

        req.setCharacterEncoding("UTF-8");
        int StuNo=Integer.parseInt(req.getParameter("StuNo"));
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        String Action=req.getParameter("Action");
        String Change=req.getParameter("Change");
        Date date=getDateTime();
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        if(Action.equals("Job")) {
            DAO.changeMemberJob(sqlSessionFactory, StuNo, ClubNo, Change);
        }
        else if(Action.equals("Department")){
            DAO.changeMemberDepartment(sqlSessionFactory,StuNo,ClubNo,Change);
        }
        else if(Action.equals("Del")){
            DAO.leaveClubTime(sqlSessionFactory, StuNo, ClubNo, date );
        }
        req.getRequestDispatcher("/jsp/manageMember.jsp?ClubNo="+ClubNo).forward(req, resp);

    }

}
