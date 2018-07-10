package servlet;

import Test.Test;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

@WebServlet(name = "ActCreateApply")
public class ActCreateApply extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=\"utf-8\"");
        PrintWriter out = response.getWriter();

        //消除接受乱码的问题
        request.setCharacterEncoding("UTF-8");

        //获取相关要使用的属性
        String name = request.getParameter("Act_name");
        String info = request.getParameter("Act_info");
        String time = request.getParameter("Act_time");
        String status = "未进行";
        int ClubNo = Integer.parseInt(request.getParameter("Club_id"));

        //进行数据库插入操作
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.AddActive(sqlSessionFactory,name,info,ClubNo,time,status);
        request.getRequestDispatcher(String.format("jsp/ClubInfo.jsp?ClubNo=%d",ClubNo)).forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
