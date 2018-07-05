package operations;

import org.apache.ibatis.annotations.Param;

public interface JoinClubDao {
    int joinClubApply(@Param("StuNo") int StuNo,
                       @Param("ClubNo") int ClubNo,
                       @Param("JoinReason") String JoinReason);

    String getClubName(@Param("ClubNo") int ClubNo);
}
