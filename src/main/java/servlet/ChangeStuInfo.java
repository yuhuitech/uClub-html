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

public class ChangeStuInfo extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session=req.getSession();
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        String grade=req.getParameter("grade");
        String Tel=req.getParameter("Tel");
        String Email=req.getParameter("Email");
        String self_introduce=req.getParameter("self_introduce");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        DAO.updateStuInfo(sqlSessionFactory,StuNo,grade,Tel,Email,self_introduce);
        System.out.println("修改个人数据成功");

    }
}
