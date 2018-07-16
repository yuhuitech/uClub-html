package servlet;

import Test.Test;
import operations.DAO;
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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "ActCreateApply")
public class ActCreateApply extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=\"utf-8\"");
        PrintWriter out = response.getWriter();

        //消除接受乱码的问题
        request.setCharacterEncoding("UTF-8");

        //获取相关要使用的属性
        String name = request.getParameter("title");
        String info = request.getParameter("descr");
        String begin = request.getParameter("createStartTime");
        String end = request.getParameter("createEndTime");

        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");//yyyy-mm-dd, 会出现时间不对, 因为小写的mm是代表: 秒
        Date begin_time = null;
        Date end_time = null;
        try {
            begin_time = sdf.parse(begin);
            end_time=sdf.parse(end);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        begin=sdf.format(begin_time);
        end=sdf.format(end_time);
        String status = "未进行";
        int ClubNo = Integer.parseInt(request.getParameter("adminClubName"));
        int ActiveNo=DAO.getUUID();
//        String ClubName=request.getParameter("adminClubName");
        //进行数据库插入操作
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        DAO.AddActive(sqlSessionFactory,ActiveNo,name,info,ClubNo,begin,end,status);
//        request.getRequestDispatcher(String.format("jsp/ClubInfo.jsp?ClubNo=%d",ClubNo)).forward(request, response);
        response.getWriter().print(ActiveNo);
        response.getWriter().flush();


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
