package servlet;

import Test.Test;
import model.MoneyApply;
import net.sf.json.JSONArray;
import operations.MoneyOperations;
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
import operations.MoneyOperations;

@WebServlet(name = "FundManagement")
public class FundManagement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        response.setContentType("text/html; charset=utf-8");
        List<MoneyApply> applies = MoneyOperations.getAppliesALL(sqlSessionFactory);
        JSONArray jsonArray = JSONArray.fromObject(applies);
        String status = request.getParameter("status");
        if(status!=null)
        {
            int statuscode;
            int id = Integer.parseInt(request.getParameter("clubNo"));
            switch (status){
                case "1":
                    statuscode = MoneyOperations.checkPassed(sqlSessionFactory,id);
                    applies = MoneyOperations.getAppliesALL(sqlSessionFactory);
                    break;
                case"2":
                    statuscode = MoneyOperations.checkFailed(sqlSessionFactory,id);
                    applies = MoneyOperations.getAppliesALL(sqlSessionFactory);
                    break;
            }
        }

        request.setAttribute("Applies",applies);
        response.getWriter().write(jsonArray.toString());
        response.getWriter().flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
