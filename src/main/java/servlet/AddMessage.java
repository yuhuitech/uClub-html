package servlet;

import Test.Test;
import operations.commentOperation;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

public class AddMessage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        int ClubNo= Integer.parseInt(request.getParameter("ClubNo"));
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        String MessageNo=commentOperation.getCommentUUID();
        String Message=request.getParameter("Message");
        Date PostTime=new Date();

        commentOperation.add2MessageBoard(sqlSessionFactory,StuNo,ClubNo,MessageNo,Message,PostTime);
    }
}
