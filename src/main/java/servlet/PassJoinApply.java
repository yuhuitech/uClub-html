package servlet;

import Test.Test;
import operations.DAO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import static operations.DAO.getDateTime;

public class PassJoinApply extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        int StuNo= Integer.parseInt(req.getParameter("StuNo"));
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        String Action=req.getParameter("Action");
        int ApplyNo= Integer.parseInt(req.getParameter("ApplyNo"));
        Date date=getDateTime();
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        if(Action.equals("pass")) {
              int i= DAO.isMember(sqlSessionFactory, StuNo, ClubNo);
              if(i!=0){
                  DAO.rejoin(sqlSessionFactory, StuNo, ClubNo);
                  DAO.delFromJoinClub(sqlSessionFactory, StuNo);
                  DAO.reply(sqlSessionFactory,ApplyNo,"恭喜你已经成为社团的一员!");
                  System.out.println("成员已经在表中，现在重新加入");
              }
              else {
                  DAO.passJoinClub(sqlSessionFactory, StuNo, ClubNo, "成员", date);
                  DAO.delFromJoinClub(sqlSessionFactory, StuNo);
                  DAO.reply(sqlSessionFactory, ApplyNo, "恭喜你已经成为社团的一员!");
                  System.out.println("加入社团成功");
              }
                  req.getRequestDispatcher("/jsp/ClubInfo.jsp?ClubNo=" + ClubNo).forward(req, resp);
        }
        else {
            DAO.delFromJoinClub(sqlSessionFactory, StuNo);
            DAO.reply(sqlSessionFactory,ApplyNo,"很遗憾，你加入社团的申请没有通过。");
            System.out.println("从申请表单中移除");
        }

    }

}
