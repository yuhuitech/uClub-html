package operations;

import model.Record;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface RecordDao {
    void  AddClubRecord(@Param("StuNo") int stuNo,@Param("ClubNo") int clubNo,@Param("ReqTime") Date time);

    void AddActiveRecord(@Param("StuNo") int stuNo,@Param("ActiveNo") int clubNo,@Param("ReqTime") Date time);

    List<Record> getActiveTimes();

    List<Record> getClubTimes();




}
