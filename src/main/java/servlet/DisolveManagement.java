package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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


@WebServlet(name = "DisolveManagement")
public class DisolveManagement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        response.setContentType("text/html; charset=utf-8");
        List<Apply> applies = ManageApplyOperations.getDissolveAppliesAll(sqlSessionFactory);
        JSONArray jsonArray = JSONArray.fromObject(applies);
        String status = request.getParameter("status");
        if(status!=null){
            int statuscode;
            int id = Integer.parseInt(request.getParameter("clubNo"));
            int apid = Integer.parseInt(request.getParameter("applyNo"));
            switch (status){
                case "1":
                    statuscode =ManageApplyOperations.checkPassInDis(sqlSessionFactory,apid);
                    int op = ClubOperations.deleteClub(sqlSessionFactory,id);
                case"2":
                    statuscode = ManageApplyOperations.checkFailInDis(sqlSessionFactory,apid);
            }
        }
        request.setAttribute("Applies",applies);
        response.getWriter().write(jsonArray.toString());
        response.getWriter().flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
