package servlet;

import Test.Test;
import model.Club;
import operations.ClubOperations;
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

public class GetJoinCount extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("UTF-8");
        HttpSession session=req.getSession();
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        int count1=DAO.getJoinActivityCount(sqlSessionFactory,StuNo);
        List<Club> adminClubs=ClubOperations.getAllJoinClubs(sqlSessionFactory,StuNo);
        List<Club> joinClubs = DAO.getStudentClubs(sqlSessionFactory,StuNo,"成员");
        //  for(int i=0)
        if(adminClubs.size()!=0) {
            for (int i = 0; i < adminClubs.size(); i++) {
                for(int j=0;j< joinClubs.size();j++){
                    if(adminClubs.get(i).getClubNo()==joinClubs.get(j).getClubNo())adminClubs.remove(i);
                }
            }
        }
        int count2=joinClubs.size();
        int count3=DAO.getArticalCount(sqlSessionFactory,StuNo);
        int count4=adminClubs.size();

        String data=count1+","+count2+","+count3+","+count4;
        System.out.println(data);
       // session.setAttribute("events",events);
        resp.getWriter().print(data);
        resp.getWriter().flush();



    }
}
