
import Test.Test;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;


public class applyClubServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        int userID = Integer.parseInt(req.getParameter("userNo"));
        //获取从页面上传递来的数据
        int stuNo = userID;
        String clubName = req.getParameter("clubName");
        String clubType = req.getParameter("clubType");
        String clubInfo = req.getParameter("clubInfo");
        String clubSize = req.getParameter("clubSize");

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

        req.setAttribute("stuNo", req.getParameter("userNo"));
        req.setAttribute("stuName", selectStuName);
        req.setAttribute("college", selectCollege);
        req.setAttribute("result", result);

        RequestDispatcher view = req.getRequestDispatcher("applyClub.jsp");
        view.forward(req, resp);

    }

    //获取学生姓名
    String getStudentName(SqlSessionFactory sqlSessionFactory, int userID){
        String selectStuName="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            applyClubDao selectInterface = session.getMapper(applyClubDao.class);
            selectStuName = selectInterface.getStudentName(userID);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectStuName;
    }

    //获取学院
    String getCollege(SqlSessionFactory sqlSessionFactory, int userID){
        String selectCollege="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
           applyClubDao selectInterface = session.getMapper(applyClubDao.class);
            selectCollege = selectInterface.getCollege(userID);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectCollege;
    }

    //插入Create_apply表
    public static int addClubApply(SqlSessionFactory sqlSessionFactory, int ApplyNo, String ClubName,
                                   String ClubType, String ClubInfo, int StuNo,
                                   String ClubSize, Date ApplyTime)
    {
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            applyClubDao DAO = session.getMapper(applyClubDao.class);
            int Apply = DAO.addClubApply(ApplyNo, ClubName, ClubType, ClubInfo, StuNo, ClubSize, ApplyTime);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return Apply;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    //获得一个8位随机数字
    int getUUID(){
        int applyNum=0;
        String orderNo = "" ;
        String trandNo = String.valueOf((Math.random() * 9 + 1) * 1000000);
        String sdf = new SimpleDateFormat("yyyyMMddHHMMSS").format(new Date());
        orderNo = trandNo.toString().substring(0, 4);
        orderNo = orderNo + sdf ;
        orderNo.replace(".", "");
        orderNo = orderNo.substring(0,8);
        applyNum = Integer.parseInt(orderNo);

        return  applyNum;
    }



    //获取当前时间
    Date getDateTime(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
        return new Date();
    }

}
