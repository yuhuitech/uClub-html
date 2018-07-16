package servlet;

import Test.Test;
import model.Club;
import net.sf.json.JSONArray;
import operations.ClubOperations;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(name = "ClubManagement")
public class ClubManagement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        response.setContentType("text/html; charset=utf-8");
        List<Club> Clubs = ClubOperations.getClubsALL(sqlSessionFactory);
        JSONArray jsonArray = JSONArray.fromObject(Clubs);
        String status = request.getParameter("status");

        if(status!=null) {
            int id = Integer.parseInt(request.getParameter("clubNo"));

            String name = request.getParameter("clubName");
            String tag = request.getParameter("type");
            String info = request.getParameter("clubInfo");
            switch (status) {
                case "1":
                    int statuscode = ClubOperations.updateClub(sqlSessionFactory, id, name, tag, info);
                    Clubs = ClubOperations.getClubsALL(sqlSessionFactory);
                    break;
            }
        }
        request.setAttribute("Clubs",Clubs);
        response.getWriter().write(jsonArray.toString() );
        response.getWriter().flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
