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

public class SendNotice extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();
        req.setCharacterEncoding("UTF-8");

        Integer StuNo= (Integer) session.getAttribute("UserNo");
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        int NoticeNo=DAO.getUUID();
        String Notice=req.getParameter("Notice");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
         DAO.sendNotice(sqlSessionFactory, NoticeNo,StuNo,ClubNo,Notice);
         System.out.println("成功发送公告");

    }
}
