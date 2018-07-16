package servlet;

import Test.Test;
import model.Apply;
import net.sf.json.JSONArray;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import static operations.DAO.*;

@WebServlet(name = "ClubCreate")
public class ClubCreate extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=\"utf-8\"");
        PrintWriter out = resp.getWriter();
        HttpSession session=req.getSession();
        //消除接受乱码的问题
        req.setCharacterEncoding("UTF-8");
        Integer userID = (Integer) session.getAttribute("UserNo");
        //获取从页面上传递来的数据
        int stuNo = userID;
        String clubName = req.getParameter("clubName");
        String clubType = req.getParameter("clubType");
        String clubInfo = req.getParameter("clubInfo");
        String clubSize = req.getParameter("clubSize");
        String searchStatus =  req.getParameter("searchStatus");
        //clubLogo待定
        String result ="";
        String status = req.getParameter("status");
        String selectStuName=null;
        String selectCollege=null;
        String resource = "mybatis.xml";

        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        selectStuName = getStudentName(sqlSessionFactory,userID);
        selectCollege =getCollege(sqlSessionFactory,userID);

        int applyNo = getUUID();//获得一个8位长度的随机数
        Date applyTime = getDateTime();

        if (clubName==null&&clubInfo ==null&&clubSize==null){
            //do nothing
        }
        else {
            if (sqlSessionFactory != null && applyNo != 0 && clubName != "" && clubType != "" &&
                    clubInfo != "" && stuNo != 0 && clubSize != "" && applyTime != null) {
                int addResult = addClubApply(sqlSessionFactory, applyNo, clubName, clubType, clubInfo, stuNo, clubSize, applyTime);
                //判断addResult给出提交结果
                if (addResult == -1) {
                    System.out.println("写入数据库失败");
                    result = "提交失败!";
                } else {
                    System.out.println("写入数据库成功");
                    result = "提交成功!";
                }

            } else {
                //显示提交申请失败
                System.out.println("申请提交失败");
                result = "请输入全部信息!";
            }
        }


        List<Apply> applies = getClubApply(sqlSessionFactory,stuNo);
        JSONArray jsonArray = JSONArray.fromObject(applies);
        System.out.println(jsonArray.toString());

        req.setAttribute("stuNo", req.getParameter("userNo"));
        req.setAttribute("stuName", selectStuName);
        req.setAttribute("college", selectCollege);
        req.setAttribute("result", result);
        if(searchStatus!=null) {
            resp.getWriter().write(jsonArray.toString());
            resp.getWriter().flush();
        }else {
            RequestDispatcher view = req.getRequestDispatcher("jsp/formWizards.jsp");
            view.forward(req, resp);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
