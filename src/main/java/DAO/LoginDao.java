package DAO;

import operations.DAO;
import org.apache.ibatis.annotations.Param;

public interface LoginDao {

     String getStudentPasswd(@Param("StuNo") int userID);

     String getTeacherPasswd(@Param("TeacherNo") int userID);
}