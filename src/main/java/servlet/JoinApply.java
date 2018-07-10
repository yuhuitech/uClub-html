package servlet;

import Test.Test;
import operations.JoinClubDao;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;

public class JoinApply extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();

        req.setCharacterEncoding("UTF-8");
        int ApplyNo=DAO.getUUID();
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        int ClubNo= Integer.parseInt(req.getParameter("ClubNo"));
        String JoinReason=req.getParameter("JoinReason");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        int i=joinClubApply(sqlSessionFactory,ApplyNo,StuNo,ClubNo,JoinReason);
        //跳转
        req.getRequestDispatcher("jsp/index.jsp").forward(req,resp);

    }


    int joinClubApply(SqlSessionFactory sqlSessionFactory,int ApplyNo, int StuNo,int ClubNo,String JoinReason){
        int i=0;
        try {
            SqlSession session = sqlSessionFactory.openSession();
            JoinClubDao selectInterface = session.getMapper(JoinClubDao.class);
            i=selectInterface.joinClubApply(ApplyNo,StuNo,ClubNo,JoinReason);
            System.out.println("成功插入数据");
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    };
}
