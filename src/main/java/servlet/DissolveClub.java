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

public class DissolveClub extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();
        req.setCharacterEncoding("UTF-8");
        int ApplyNo=DAO.getUUID();
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        String Reason=req.getParameter("Reason");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        //判断是否是社长
        String job=DAO.getStudentJob(sqlSessionFactory,StuNo,ClubNo);
        if(job.equals("社长")) {
            DAO.delClubApply(sqlSessionFactory,ApplyNo,StuNo,ClubNo,Reason);
            System.out.println("成功发送解散社团申请");
        }
        else {
            System.out.println("权限不足，无法解散社团");
        }

    }
}
