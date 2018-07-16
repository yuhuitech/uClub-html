package Dao;

import model.Apply;
import operations.DAO;
import org.apache.ibatis.annotations.Param;
import java.util.Date;
import java.util.List;


public interface ApplyClubDao {

    String getStudentName(@Param("StuNo") int userID);

    String getCollege(@Param("StuNo") int userID);


    int addClubApply(@Param("ApplyNo") int applyNo,
                     @Param("ClubName") String clubName,
                     @Param("ClubType") String clubType,
                     @Param("ClubInfo") String clubInfo,
                     @Param("StuNo") int stuNo,
                     @Param("ClubSize") String clubSize,
                     @Param("ApplyTime") Date applyTime);

    int addClub(@Param("ClubNo") int clubNo,
                @Param("ClubName") String clubName,
                @Param("ClubType") String clubType,
                @Param("ClubInfo") String clubInfo,
                @Param("Res_url") String res_url,
                @Param("status") String status,
                @Param("CreateTime") Date createTime);



}