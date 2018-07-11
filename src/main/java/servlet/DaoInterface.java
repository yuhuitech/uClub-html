package servlet;

import model.Activity;
import model.Club;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DaoInterface {

     String getStudentPasswd(@Param("StuNo") int userID);

     String getTeacherPasswd(@Param("TeacherNo") int userID);

     List<Club> getClubs (@Param("StuNo") int userId ,@Param("Job") String Job);

     Club getClubById(@Param("ClubNo") int clubNo);

     void setClubInfo(@Param("ClubNo") int clubNo,@Param("ClubInfo") String Info);

     void AddActivity(@Param("active_name") String name,@Param("active_info") String info,
                      @Param("ClubNo") int ClubNo,@Param("active_time") String time,
                      @Param("status") String status);

     String getStudentName(@Param("StuNo") int userID);

     String getCollege(@Param("StuNo") int userID);


     int addClubApply(@Param("ApplyNo") int applyNo,
                      @Param("ClubName") String clubName,
                      @Param("ClubType") String clubType,
                      @Param("ClubInfo") String clubInfo,
                      @Param("StuNo") int stuNo,
                      @Param("ClubSize") String clubSize,
                      @Param("ApplyTime") Date applyTime);


     int joinActivity(@Param("StuNo") int StuNo,
                      @Param("ActiveNo") int ActiveNo);

     void  exitActivity(@Param("StuNo") int StuNo,
                        @Param("ActiveNo") int ActiveNo);

    List<Activity> getClubActivities(@Param("ClubNo") int ClubNo);

    void changeActiveStatus(@Param("ActiveNo") int ActiveNo,
                            @Param("Status") String Status );

    List<HashMap> getJoinClubApply(@Param("ClubNo") int ClubNo);

    int passJoinClub (@Param("StuNo") int StuNo,
                       @Param("ClubNo") int ClubNo,
                       @Param("Job") String Job,
                       @Param("join_time") Date join_time);

    void delFromJoinClub(@Param("StuNo") int StuNo);

    List<HashMap> getMembers(@Param("ClubNo") int ClubNo);

    void changeMemberJob(@Param("StuNo") int StuNo,
                         @Param("ClubNo") int ClubNo,
                         @Param("Job") String Job);

    void changeMemberDepartment (@Param("StuNo") int StuNo,
                                 @Param("ClubNo") int ClubNo,
                                 @Param("Department") String Department);

    void delMember(@Param("StuNo") int StuNo,
                   @Param("ClubNo") int ClubNo);

    void leaveClubTime(@Param("StuNo") int StuNo,
                       @Param("ClubNo") int ClubNo,
                       @Param("leave_time") Date leave_time);

    void leaveApply(@Param("ApplyNo") int ApplyNo,
                    @Param("StuNo") int StuNo,
                    @Param("ClubNo") int ClubNo,
                    @Param("Reason") String Reason);

    List<HashMap> getLeaveClubApply(@Param("ClubNo") int ClubNo);

    void delFromLeaveClub(@Param("StuNo") int StuNo);

    void priceApply(@Param("ApplyNo") int ApplyNo,
                    @Param("ActivityNo") String ActivityNo,
                    @Param("Reason") String Reason,
                    @Param("price") String price );

    void delClubApply(@Param("ApplyNo") int ApplyNo,
                      @Param("StuNo") int StuNo,
                      @Param("ClubNo") int ClubNo,
                      @Param("Reason") String Reason );

    String getStudentJob(@Param("StuNo") int  StuNo,
                         @Param("ClubNo") int ClubNo);

    void sendNotice(@Param("NoticeNo") int NoticeNo,
                      @Param("StuNo") int StuNo,
                      @Param("ClubNo") int ClubNo,
                      @Param("Notice") String Notice );

    void sendRecruit(@Param("RecruitNo") int RecruitNo,
                     @Param("ClubNo") int ClubNo,
                     @Param("Introduction") String Introduction,
                     @Param("recruit_text") String recruit_text );

    void rejoin(@Param("StuNo") int StuNo,
                @Param("ClubNo") int ClubNo);

    int isMember(@Param("StuNo") int StuNo,
                 @Param("ClubNo") int ClubNo);

    void reply(@Param("ApplyNo") int ApplyNo,
                 @Param("reason") String reason);
}

