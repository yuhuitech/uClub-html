package servlet;

import Test.Test;
import model.Activity;
import operations.ClubOperations;
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
        resp.setContentType("text/html; charset=utf-8");
        int ActiveNo = 0;
        if(req.getParameter("ANo")!=null) ActiveNo = Integer.parseInt(req.getParameter("ANo"));
        else ActiveNo= Integer.parseInt(req.getParameter("activeNo"));
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        Activity act=ClubOperations.getActiveDetail(sqlSessionFactory,ActiveNo);
        HttpSession session=req.getSession();
        req.setAttribute("ActiveNo",ActiveNo);
        req.setAttribute("ActiveName",act.getActive_name());
        req.setAttribute("ActiveClubNo",act.getClubNo());
        req.setAttribute("ActiveBegin",act.getBegin_time());
        req.setAttribute("ActiveEnd",act.getEnd_time());
        req.setAttribute("ActiveStatus",act.getStatus());
        req.setAttribute("ActiveInfo",act.getActive_info());

      /*  resp.getWriter().print("{\"ActiveName\":\""+act.getActive_name()+"\" ,\"ActiveInfo\": \""+act.getActive_info()+"\" ," +
                "\"ActiveBegin\":\""+act.getBegin_time()+"\" ,\"ActiveEnd\":\""+act.getEnd_time()+" \",\"ActiveStatus\": \""+act.getStatus()+"\"}");
        resp.getWriter().flush();*/
        //跳转
        req.getRequestDispatcher("/jsp/activeDetail.jsp").forward(req,resp);

    }

}
