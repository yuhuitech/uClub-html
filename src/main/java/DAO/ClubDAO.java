package Dao;

import model.Club;
import operations.DAO;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface ClubDAO {
    String getClubName(@Param("ClubNo") int ClubNo);
    String getType(@Param("Type") int ClubNo);
    String getClubInfo(@Param("ClubInfo") int ClubNo);
    int getstatus(@Param("status") int ClubNo);
    List<Club> getClubsAll();
    List<Club> getClubs(@Param("ClubNo") int ClubNo, @Param("ClubName") String ClubName, @Param("Type") String Type, @Param("ClubInfo") String ClubInfo);
    int updateClub(@Param("ClubNo") int ClubNo, @Param("ClubName") String ClubName, @Param("Type") String Type, @Param("ClubInfo") String ClubInfo);

//    int  addClub(@Param("ClubNo") int ClubNo, @Param("ClubName") String ClubName, @Param("Type") String Type, @Param("ClubInfo") String ClubInfo);

    Club getClub(@Param("ClubNo") int ClubNo);

    int deleteClub(@Param("ClubNo") int ClubNo);

    List<Club> getAllJoinClubs(@Param("StuNo") int StuNo);

    int getClubCounts();
    int  addClub(@Param("ClubNo")int ClubNo,
                 @Param("ClubName")String ClubName,
                 @Param("Type")String Type,
                 @Param("ClubInfo")String ClubInfo,
                 @Param("Res_url")String Res_url,
                 @Param("status")int status);



}
