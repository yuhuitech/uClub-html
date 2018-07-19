package servlet;

import Test.Test;
import net.sf.json.JSONArray;
import operations.DAO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class GetJoinList extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        response.setContentType("text/html; charset=utf-8");
        int ClubNo= Integer.parseInt(request.getParameter("ClubNo"));
        List applies = DAO.getJoinClubApply(sqlSessionFactory,ClubNo);
        JSONArray jsonArray = JSONArray.fromObject(applies);

        request.setAttribute("Applies",applies);
        System.out.println(jsonArray.toString());
        response.getWriter().write(jsonArray.toString());
        response.getWriter().flush();
    }
}
