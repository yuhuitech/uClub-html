package servlet;

import Test.Test;
import model.Activity;
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
import java.util.List;

public class GetJoinClubActivity extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("UTF-8");
        HttpSession session=req.getSession();
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        String resource = "mybatis.xml";

        String Status= (String) session.getAttribute("Status");
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        List<Activity> list=null;
        if(Status.equals("student")) list=DAO.selectAllActivity(sqlSessionFactory,StuNo);
        else list=DAO.getActivities(sqlSessionFactory);


         String events="[";
        for (Activity act: list){
            events+="{\"id\":\""+act.getActiveNo()+"\",\"title\":\""+act.getActive_name()+"\",\"info\":\""+act.getActive_info()+
                    "\",\"start\":\""+act.getBegin_time()+"\",\"end\":\""+act.getEnd_time()+"\",\"status\":\""+act.getStatus()+
                    "\",\"color\":\"#008080\",\"clubName\":\""+DAO.getClubById(sqlSessionFactory,act.getClubNo()).getClubName()+"\",\"isJoin\":\""+DAO.isJoin(sqlSessionFactory,StuNo,act.getActiveNo())+"\"},";
        }
        if(events.length()>1) events = events.substring(0,events.length() - 1);
        events+="]";
        System.out.println(events);
        session.setAttribute("events",events);
        resp.getWriter().print(events);
        resp.getWriter().flush();



    }
}
