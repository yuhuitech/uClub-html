package servlet;

import model.Club;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

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


}
