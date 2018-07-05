package servlet;

import model.Club;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public interface DaoInterface {

     String getStudentPasswd(@Param("StuNo") int userID);

     String getTeacherPasswd(@Param("TeacherNo") int userID);

     List<Club> getClubs (@Param("StuNo") int userId ,@Param("Job") String Job);

     Club getClubById(@Param("ClubNo") int clubNo);

     void setClubInfo(@Param("ClubNo") int clubNo,@Param("ClubInfo") String Info);

     void AddActivity(@Param("active_name") String name,@Param("active_info") String info,
                      @Param("ClubNo") int ClubNo,@Param("active_time") String time,
                      @Param("status") String status);


}

