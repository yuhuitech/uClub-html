package servlet;

import Test.Test;
import model.Activity;
import operations.ClubDetailDao;
import operations.DAO;
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

public class ActiveDetail extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int ActiveNo = Integer.parseInt(req.getParameter("activeNo"));
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        //将访问记录插入数据库内
        DAO.AddActiveRecord(sqlSessionFactory,(Integer)req.getSession().getAttribute("UserNo"),ActiveNo);

        //获取活动详情信息并写入属性
        Activity act=getActiveDetail(sqlSessionFactory,ActiveNo);
        HttpSession session=req.getSession();
        req.setAttribute("ActiveName",act.getActive_name());
        req.setAttribute("ActiveClubNo",act.getClubNo());
        req.setAttribute("ActiveTime",act.getActive_time());
        req.setAttribute("ActiveStatus",act.getStatus());
        req.setAttribute("ActiveInfo",act.getActive_info());

        //跳转
        req.getRequestDispatcher("/jsp/activeDetail.jsp").forward(req,resp);

    }

    public static Activity getActiveDetail(SqlSessionFactory sqlSessionFactory, int ActiveNo){

        Activity act= new Activity();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            act = selectInterface.getActiveDetail(ActiveNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return act;
    };

}
