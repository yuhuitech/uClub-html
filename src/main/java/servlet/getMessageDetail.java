package servlet;

import Test.Test;
import model.Message;
import net.sf.json.JSONObject;
import operations.DAO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import static operations.DAO.getDateTime;

public class getMessageDetail extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("UTF-8");
        Integer StuNo= (Integer) req.getSession().getAttribute("UserNo");
        String name= req.getParameter("name");
        int index= Integer.parseInt(req.getParameter("index"));
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        List<Message> messages =(List<Message>) req.getSession().getAttribute("messages");
        List<HashMap> createReply=DAO.getCreateReply(sqlSessionFactory,StuNo);
        List<HashMap> dissolveReply=DAO.getDissolveReply(sqlSessionFactory,StuNo);
        List<HashMap> joinReply=DAO.getJoinReply(sqlSessionFactory,StuNo);
        List<HashMap> leaveReply=DAO.getLeaveReply(sqlSessionFactory,StuNo);
        List<HashMap> priceReply=DAO.getPriceReply(sqlSessionFactory,StuNo);

        Object obj=new Object();
        if(name.equals("messages"))obj=messages.get(index);
        if(name.equals("createReply"))obj=createReply.get(index);
        if(name.equals("dissolveReply"))obj=dissolveReply.get(index);
        if(name.equals("joinReply"))obj=joinReply.get(index);
        if(name.equals("leaveReply"))obj=leaveReply.get(index);
        if(name.equals("priceReply"))obj=priceReply.get(index);

        JSONObject mapObject=JSONObject.fromObject(obj);

        System.out.println(mapObject.toString());
        resp.getWriter().write(mapObject.toString());
        resp.getWriter().flush();


    }
}
