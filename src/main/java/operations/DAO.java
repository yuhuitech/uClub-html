package operations;

import Test.Test;
import model.Article;
import model.Club;
import model.Message;
import model.Record;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;
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
    public static List<Record> getAllStudentClub(SqlSession session,String job)
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

    //获得所有文章
    public static List<Article> getAllArticle()
    {

        List<Article> articles = new ArrayList<>();
        try {
            String resource = "mybatis.xml";
            InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
            SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ArticleDao selectInterface = session.getMapper(ArticleDao.class);
            articles = selectInterface.getAllArticles();
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return articles;
    }

    //根据article对象插入对象时
    public static void addArticle(int StuNo,int ClubNo,String res_url,Date date)
    {

        try {
            String resource = "mybatis.xml";
            InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
            SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ArticleDao selectInterface = session.getMapper(ArticleDao.class);
            selectInterface.addArticle(StuNo,ClubNo,res_url,date);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //获取随机8个社团
    public static List<Club>getRandomClub(SqlSessionFactory sqlSessionFactory,int num)
    {
        List<Club> random_clubs = new ArrayList<>();
        try {

            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            random_clubs = selectInterface.getRandomClub(num);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return random_clubs;
    }

    //根据社团号获取成员量，文章量，活动量几个信息
    public static int getMemberNumByClub(SqlSession session,int ClubNo)
    {
        int nums = 0;
        try {


            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            nums = selectInterface.getMemberNumByClub(ClubNo);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return nums;
    }

    public static int getArticleNumByClub(SqlSession session,int ClubNo)
    {
        int nums = 0;
        try {
            // 获取Mapper
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            nums = selectInterface.getArticleNumByClub(ClubNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nums;
    }

    public static int getActiveNumByClub(SqlSession session,int ClubNo)
    {
        int nums = 0;
        try {
            // 获取Mapper
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            nums = selectInterface.getActiveNumByClub(ClubNo);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return nums;
    }

    //下面是有关message相关方法的实现
    //从用户号获得所有的信息
    public static List<Message> getMyMessage(SqlSessionFactory sqlSessionFactory,int UserNo)
    {

        List<Message> result = new ArrayList<>();
        try {

            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MessageDAO selectInterface = session.getMapper(MessageDAO.class);
            result = selectInterface.getMyMessage(UserNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
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



