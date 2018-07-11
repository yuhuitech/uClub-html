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


public class LeaveApply extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();

        req.setCharacterEncoding("UTF-8");
        int ApplyNo=DAO.getUUID();
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        String Reason=req.getParameter("Reason");
       // String Reason= new String(req.getParameter("Reason").getBytes("iso-8859-1"), "utf-8");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.leaveApply(sqlSessionFactory,ApplyNo, StuNo, ClubNo,Reason);
        req.getRequestDispatcher("/clubDetail.jsp").forward(req, resp);

    }
}
