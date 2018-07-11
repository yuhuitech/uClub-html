package operations;

import model.Club;
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

    int  addClub(@Param("ClubNo") int ClubNo, @Param("ClubName") String ClubName, @Param("Type") String Type, @Param("ClubInfo") String ClubInfo);

    Club getClub(@Param("ClubNo") String ClubNo);

    int deleteClub(@Param("ClubNo") int ClubNo);



}
