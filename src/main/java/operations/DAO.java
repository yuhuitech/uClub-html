package operations;

import model.Club;
import model.Record;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAO {

    //获取学生的密码
    public static String getStudentPasswd(SqlSessionFactory sqlSessionFactory, int userID){
        String selectPasswd="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            selectPasswd = selectInterface.getStudentPasswd(userID);
            session.commit();
            session.close();
            // 显示插入之后User信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectPasswd;
    }

    //通过老师号获取老师的ID
    public static String getTeacherPasswd(SqlSessionFactory sqlSessionFactory, int userID){
        String selectPasswd="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //区分学生和管理员
            selectPasswd = selectInterface.getTeacherPasswd(userID);
            session.commit();
            session.close();
            // 显示插入之后User信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectPasswd;
    }

    //通过学生的职位类型获取他的社团号
    public static List<Club> getStudentClubs(SqlSessionFactory sqlSessionFactory, int userID,String Job)
    {
        List<Club> club = null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            club = selectInterface.getClubs(userID,Job);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return club;
    }

    //通过社团号获取社团对象
    public static Club getClubById(SqlSessionFactory sqlSessionFactory, int clubNo)
    {
        Club club = null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            club = selectInterface.getClubById(clubNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return club;
    }

    //社团管理者设置社团简介信息
    public static void setClubInfo(SqlSessionFactory sqlSessionFactory, int ClubNo,String ClubInfo)
    {

        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
             selectInterface.setClubInfo(ClubNo,ClubInfo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //社团管理者给社团添加活动
    public static void AddActive(SqlSessionFactory sqlSessionFactory, String name,String info,int ClubNo,String time,String status)
    {

        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
           selectInterface.AddActivity(name,info,ClubNo,time,status);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //下面是刚刚加的
    public static String getStudentName(SqlSessionFactory sqlSessionFactory, int userID){
        String selectStuName="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            selectStuName = selectInterface.getStudentName(userID);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectStuName;
    }

    //获取学院
    public static String getCollege(SqlSessionFactory sqlSessionFactory, int userID){
        String selectCollege="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
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
            DaoInterface DAO = session.getMapper(DaoInterface.class);
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

    //插入Request_club_record表
    public static void AddClubRecord(SqlSessionFactory sqlSessionFactory, int StuNo,int ClubNo)
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

    //获取各学生的社团访问情况
    public static List<Record> getActiveTimes(SqlSessionFactory sqlSessionFactory)
    {
        List<Record> record = new ArrayList<>();
        try {

            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            RecordDao selectInterface = session.getMapper(RecordDao.class);
            record = selectInterface.getActiveTimes();
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
       return record;
    }

    public static List<Record> getClubTimes(SqlSessionFactory sqlSessionFactory)
    {

        List<Record> record = new ArrayList<>();
        try {

            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            RecordDao selectInterface = session.getMapper(RecordDao.class);
            record = selectInterface.getClubTimes();
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return record;
    }

    //获取各学生的活动访问情况

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



