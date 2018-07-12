package servlet;

import Test.Test;
import model.Club;
import model.Record;
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
import java.util.*;

@WebServlet(name = "Recommend")
public class Recommend extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=\"utf-8\"");
        PrintWriter out = response.getWriter();

        //消除接受乱码的问题
        request.setCharacterEncoding("UTF-8");

        //连接数据库必要的使用，三句话
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        //调用数据库操作，获得与学号绑定的两个数组
        List<Record> clubRecord = DAO.getClubTimes(sqlSessionFactory);
        List<Record> activeRecord = DAO.getActiveTimes(sqlSessionFactory);

        //获取与学号绑定的参加活动数
        List<Record> joinAcitiveRecord = DAO.getAllStudentActive(sqlSessionFactory);
        //获取与学号绑定的参加社团数（分为成员和管理员两种）
        List<Record> joinClubRecordLow = DAO.getAllStudentClub(sqlSessionFactory,"成员");
        List<Record> joinClubRecordHeigh = DAO.getAllStudentClub(sqlSessionFactory,"社长");
        joinClubRecordHeigh.addAll(DAO.getAllStudentClub(sqlSessionFactory,"部长"));
        //temp数组是两者的集合，用于在求相似度时可以直接使用两种的集合
        List<Record> temp = new ArrayList<>();
        temp.addAll(joinClubRecordLow);
        temp.addAll(joinClubRecordHeigh);
        //用嵌套List二维数组来存放不同的社团或是活动间的相似度
        Map<Integer,Map<Integer,Double>> SimliarMatrix;
        Record recordTemp = new Record();

        //活动推荐

        //获取活动相似度矩阵
        SimliarMatrix = recordTemp.getSimilarList(joinAcitiveRecord);
        //下面创建每一个活动对该用户的推荐度map表
        Map<Integer,Double> recommendNum = recordTemp.getActiveRecommendNum(activeRecord,joinAcitiveRecord,SimliarMatrix,
                (Integer) request.getSession().getAttribute("UserNo"));
        //最后进行排序，得到排序的活动号排名并且剔除已经参加的活动
        List<Integer> activeRecommend = recordTemp.getSort(recommendNum,(Integer) request.getSession().getAttribute("UserNo"));

        //活动推荐结束

        //社团推荐
        //获取社团相似度矩阵
        Record recordTemp2 = new Record();
        SimliarMatrix = recordTemp2.getSimilarList(temp);
        //创建每一个社团对该用户的推荐map表
        Map<Integer,Double> recommendNum2 = recordTemp2.getActiveRecommendNum(clubRecord,joinClubRecordLow,joinClubRecordHeigh,SimliarMatrix,
                (Integer) request.getSession().getAttribute("UserNo"));
        //最后进行排序，并剔除已经参加的社团
        List<Integer> clubRecommend = recordTemp2.getSort(recommendNum2,(Integer) request.getSession().getAttribute("UserNo"));




        //将上面两个Record对象存放在请求中
        request.setAttribute("activeRecommend",activeRecommend);
        request.setAttribute("clubRecommend",clubRecommend);

        //跳转到推荐页面
        request.getRequestDispatcher("jsp/Recommend.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
