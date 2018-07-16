package operations;

import model.Activity;
import model.Club;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface ClubDetailDao {
    Club getClubDetail(@Param("ClubNo") int ClubNo);

    List<Activity> getClubActivities(@Param("ClubNo") int ClubNo);

    Activity getActiveDetail(@Param("ActiveNo") int ActiveNo);

    List<Club>getRandomClub(@Param("num") int num);

    int getMemberNumByClub(@Param("ClubNo") int ClubNo);

    int getArticleNumByClub(@Param("ClubNo") int ClubNo);

    int getActiveNumByClub(@Param("ClubNo") int ClubNo);

}
