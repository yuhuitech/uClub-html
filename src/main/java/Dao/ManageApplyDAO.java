package Dao;
import org.apache.ibatis.annotations.Param;
import model.Apply;
import java.util.List;
public interface ManageApplyDAO {
    int getstatus (@Param("status")int ApplyNo);
    List<Apply> getAppliesAll ();
    List<Apply> getAppliesUnchecked();
    List<Apply> getAppliesPassed();
    List<Apply> getAppliesFailed();
    String getApplyTime (@Param("ApplyTime")int ApplyNo);
    int checkPass (@Param("ApplyNo")int ApplyNo);
    int checkFailed(@Param("ApplyNo")int ApplyNo);
    String getStuName(@Param("StuNo")int StuNo);
    List<Apply> getDissolveAppliesAll();
    int checkPassInDis(@Param("ApplyNo")int ApplyNo);
    int checkFailInDis(@Param("ApplyNo") int ApplyNo);
    List<Apply> getAppliesAllV2();
    List<Apply> getAppliesUncheckedV2();
    List<Apply> getAppliesPassedV2();
    List<Apply> getAppliesFailedV2();
    int getUncheckCounts();
    int getDisCounts();
    int getcheckedCounts();
}
