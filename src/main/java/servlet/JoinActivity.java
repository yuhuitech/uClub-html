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

public class JoinActivity extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();

        req.setCharacterEncoding("UTF-8");
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        int ActiveNo= Integer.parseInt(req.getParameter("ActiveNo"));
        System.out.println("UserNo="+StuNo+"  ActiveNo="+ActiveNo);
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.joinActivity(sqlSessionFactory,StuNo,ActiveNo);
        req.getRequestDispatcher("/jsp/activeDetail.jsp").forward(req, resp);

    }
}
