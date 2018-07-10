package servlet;

import Test.Test;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;

public class ChangeActiveStatus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();

        req.setCharacterEncoding("UTF-8");
        int ActiveNo= Integer.parseInt(req.getParameter("ChangeActiveStatus"));
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        String Status=req.getParameter("ActiveStatus"+ActiveNo);
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.changeActiveStatus(sqlSessionFactory,ActiveNo,Status);
        System.out.println("成功修改状态");
        req.getRequestDispatcher("/jsp/ClubInfo.jsp?ClubNo="+ClubNo).forward(req, resp);

    }
}
