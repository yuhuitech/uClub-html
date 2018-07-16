package servlet;

import Test.Test;
import net.sf.json.JSONArray;
import operations.ManageApplyOperations;
import operations.ClubOperations;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import model.Apply;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(name = "CreateApplyManagement")
public class CreateApplyManagement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        response.setContentType("text/html; charset=utf-8");
        List<Apply> applies = ManageApplyOperations.getAppliesUncheckedV2(sqlSessionFactory);
        JSONArray jsonArray = JSONArray.fromObject(applies);
        String status = request.getParameter("status");
        if(status!=null)
        {
            int id = Integer.parseInt(request.getParameter("clubNo"));
            String name = request.getParameter("clubName");
            String tag = request.getParameter("type");
            String info = request.getParameter("clubInfo");
            int statuscode;
            switch (status){
                case "1":
                     statuscode = ManageApplyOperations.checkPassed(sqlSessionFactory,id);
                    int op = ClubOperations.addClub(sqlSessionFactory,id,name,tag,info,"",1);
                    applies =ManageApplyOperations.getAppliesUncheckedV2(sqlSessionFactory);
                    break;

                case "2":
                     statuscode = ManageApplyOperations.checkFailed(sqlSessionFactory,id);
                     applies =ManageApplyOperations.getAppliesUncheckedV2(sqlSessionFactory);
            }
        }
        request.setAttribute("Applies",applies);
        response.getWriter().write(jsonArray.toString());
        response.getWriter().flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
