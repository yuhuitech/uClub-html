package operations;

import Dao.ClubDetailDao;
import Dao.RecordDao;
import model.Activity;
import model.Record;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class RecordOperations
{
    //插入Request_club_record表
    public static void AddClubRecord(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo)
    {

        try {
            //获取当前系统时间等下进行插入
            Date time = getDateTime();
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            RecordDao selectInterface = session.getMapper(RecordDao.class);
            //获取该学生所有的社团
            selectInterface.AddClubRecord(StuNo,ClubNo,time);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static Activity getActiveDetail(SqlSessionFactory sqlSessionFactory, int ActiveNo){

        Activity act= new Activity();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            act = selectInterface.getActiveDetail(ActiveNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return act;
    };

    //插入Request_Active_record表
    public static void AddActiveRecord(SqlSessionFactory sqlSessionFactory, int StuNo,int ClubNo)
    {

        try {
            //获取当前系统时间等下进行插入
            Date time = getDateTime();
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            RecordDao selectInterface = session.getMapper(RecordDao.class);
            //获取该学生所有的社团
            selectInterface.AddActiveRecord(StuNo,ClubNo,time);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //获取各学生的活动访问情况
    public static List<Record> getActiveTimes(SqlSession session)
    {
        List<Record> record = new ArrayList<>();
        try {


            RecordDao selectInterface = session.getMapper(RecordDao.class);
            record = selectInterface.getActiveTimes();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return record;
    }

    //获取各学生的活动访问情况
    public static List<Record> getClubTimes(SqlSession session)
    {

        List<Record> record = new ArrayList<>();
        try {


            // 获取Mapper
            RecordDao selectInterface = session.getMapper(RecordDao.class);
            record = selectInterface.getClubTimes();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return record;
    }

    //获取所有学生的活动参与情况
    public static List<Record> getAllStudentActive(SqlSession session)
    {

        List<Record> activeRecord = new ArrayList<>();
        try {


            // 获取Mapper
            RecordDao selectInterface = session.getMapper(RecordDao.class);
            activeRecord = selectInterface.getAllStudentActive();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return activeRecord;
    }

    //获得所有学生的社团参与情况（以职位进行分割）
    public static List<Record> getAllStudentClub(SqlSession session, String job)
    {

        List<Record> clubRecord = new ArrayList<>();
        try {

            RecordDao selectInterface = session.getMapper(RecordDao.class);
            clubRecord = selectInterface.getAllStudentClub(job);


        } catch (Exception e) {
            e.printStackTrace();
        }
        return clubRecord;
    }

    //获得一个8位随机数字
    public static int getUUID(){
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
    public static Date getDateTime(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
        return new Date();
    }
}
