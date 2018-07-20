package operations;


import Dao.DaoInterface;
import model.Activity;
import model.Apply;
import model.Club;
import model.Student;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;



public class DAO {

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


//    //通过老师号获取老师的ID

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
    public static void setClubInfo(SqlSessionFactory sqlSessionFactory, int ClubNo,String ClubName,String Type,String ClubInfo)
    {

        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
             selectInterface.setClubInfo(ClubNo,ClubName,Type,ClubInfo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //社团管理者给社团添加活动

    public static void AddActive(SqlSessionFactory sqlSessionFactory, int ActiveNo,String name, String info, int ClubNo, String begin_time, String end_time, String status)

    {

        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团

           selectInterface.AddActivity(ActiveNo,name,info,ClubNo,begin_time,end_time,status);

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


    //获取学院
    public static List<Apply> getClubApply(SqlSessionFactory sqlSessionFactory, int userID){
        List<Apply> selectApply= new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            selectApply = selectInterface.getClubApply(userID);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectApply;
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


    //加入活动
    public static int joinActivity(SqlSessionFactory sqlSessionFactory, int StuNo, int ActiveNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            int Apply = DAO.joinActivity(StuNo, ActiveNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return Apply;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;

    }

    //退出活动

    public static void exitActivity(SqlSessionFactory sqlSessionFactory, int StuNo, int ActiveNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.exitActivity(StuNo, ActiveNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //修改活动状态
    public static void changeActiveStatus(SqlSessionFactory sqlSessionFactory, int ActiveNo, String active_name, String active_info, String begin_time, String end_time, String Status){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.changeActiveStatus(ActiveNo,active_name,active_info,begin_time,end_time, Status);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

      //获得申请加入的名单
    public static List<HashMap> getJoinClubApply(SqlSessionFactory sqlSessionFactory, int ClubNo){
        List<HashMap> list=new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            list=DAO.getJoinClubApply(ClubNo);
            session.commit();
            session.close();

            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
     //通过加入社团申请
    public static int passJoinClub(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo, String Job, Date join_time){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.passJoinClub(StuNo, ClubNo, Job, join_time);
            session.commit();
            session.close();
            return 1;
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("出错");
            return 0;
        }

    }
           //从申请表中移除
    public static void delFromJoinClub(SqlSessionFactory sqlSessionFactory, int StuNo ,int ClubNo,int Status){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.delFromJoinClub(StuNo,ClubNo,Status);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
            //获取社团成员信息
    public static List<HashMap> getMembers(SqlSessionFactory sqlSessionFactory, int ClubNo){
        List<HashMap> list=new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            list=DAO.getMembers(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    //修改成员职位
    public static void changeMemberJob(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo, String Job,String Department){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.changeMemberJob(StuNo,ClubNo,Job,Department);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //修改成员部门
    public static void changeMemberDepartment(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo, String Department){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.changeMemberDepartment(StuNo,ClubNo,Department);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //填写退出社团时间
    public static void leaveClubTime(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo, Date leave_time){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.leaveClubTime(StuNo,ClubNo,leave_time);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    //退社团发申请
    public static void leaveApply(SqlSessionFactory sqlSessionFactory, int ApplyNo, int StuNo, int ClubNo, String Reason){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.leaveApply(ApplyNo,StuNo,ClubNo,Reason);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<HashMap> getLeaveClubApply(SqlSessionFactory sqlSessionFactory, int ClubNo){
        List<HashMap> list=new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            list=DAO.getLeaveClubApply(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //从申请表中移除
    public static void delFromLeaveClub(SqlSessionFactory sqlSessionFactory, int StuNo,int ClubNo,int Status){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.delFromLeaveClub(StuNo,ClubNo,Status);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
         }
    }

    public static void priceApply(SqlSessionFactory sqlSessionFactory, int ApplyNo, String ActivityNo, String Reason, String price){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.priceApply(ApplyNo,ActivityNo,Reason,price);
            session.commit();
            session.close();
             // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //解散社团申请
    public static void delClubApply(SqlSessionFactory sqlSessionFactory, int ApplyNo, int StuNo, int ClubNo, String Reason){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.delClubApply(ApplyNo,StuNo,ClubNo,Reason);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //获取学生职位
    public static String getStudentJob(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo){
        String job="";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            job=DAO.getStudentJob(StuNo,ClubNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return job;
    }

    //发送公告
    public static void sendNotice(SqlSessionFactory sqlSessionFactory, int NoticeNo, int StuNo, int ClubNo, String Notice){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.sendNotice(NoticeNo,StuNo,ClubNo,Notice);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //发送招募信息
    public static void sendRecruit(SqlSessionFactory sqlSessionFactory, int RecruitNo, int ClubNo, String Introduction, String recruit_text){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.sendRecruit(RecruitNo,ClubNo,Introduction,recruit_text);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //重新加入社团
    public static void rejoin(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper

            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.rejoin(StuNo,ClubNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //重新加入社团
    public static int isMember(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo){
        int i=0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            i=DAO.isMember(StuNo,ClubNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    //发送回复
    public static void reply(SqlSessionFactory sqlSessionFactory, int ApplyNo,int ReplyNo, String reason){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            DAO.reply(ApplyNo,ReplyNo,reason);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //查找加入社团所有的活动
    public static List<Activity> selectAllActivity(SqlSessionFactory sqlSessionFactory, int StuNo){
        List<Activity> list=new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            list=DAO.selectAllActivity(StuNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int isJoin(SqlSessionFactory sqlSessionFactory, int StuNo, int ActiveNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface DAO = session.getMapper(DaoInterface.class);
            int i=DAO.isJoin(StuNo,ActiveNo);
            session.commit();
            session.close();
            return i;
            // 显示插入之后Apply信息
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static Student getStudentInfo(SqlSessionFactory sqlSessionFactory, int StuNo)
    {
        Student stu = null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            stu = selectInterface.getStudentInfo(StuNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return stu;
    }





    public static void updateStuInfo(SqlSessionFactory sqlSessionFactory, int StuNo,String grade,String Tel, String Email, String self_introduce)
    {
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            selectInterface.updateStuInfo(StuNo,grade,Tel,Email,self_introduce);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static int getSexCount(SqlSessionFactory sqlSessionFactory, int ClubNo,String Sex)
    {
        int i=0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            i=selectInterface.getSexCount(ClubNo,Sex);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }


    public static List<Activity> getJoinActivity(SqlSessionFactory sqlSessionFactory, int StuNo)
    {
        List<Activity> i=null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            i=selectInterface.getJoinActivity(StuNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }




    /**************************回复相关********************************/

    public static List<HashMap> getCreateReply(SqlSessionFactory sqlSessionFactory, int StuNo)
    {
        List<HashMap> i=null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            i=selectInterface.getCreateReply(StuNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }


    public static List<HashMap> getDissolveReply(SqlSessionFactory sqlSessionFactory, int StuNo)
    {
        List<HashMap> i=null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            i=selectInterface.getDissolveReply(StuNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    public static List<HashMap> getJoinReply(SqlSessionFactory sqlSessionFactory, int StuNo)
    {
        List<HashMap> i=null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            i=selectInterface.getJoinReply(StuNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    public static List<HashMap> getLeaveReply(SqlSessionFactory sqlSessionFactory, int StuNo)
    {
        List<HashMap> i=null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            i=selectInterface.getLeaveReply(StuNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    public static List<HashMap> getPriceReply(SqlSessionFactory sqlSessionFactory, int StuNo)
    {
        List<HashMap> i=null;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            DaoInterface selectInterface = session.getMapper(DaoInterface.class);
            //获取该学生所有的社团
            i=selectInterface.getPriceReply(StuNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
}



