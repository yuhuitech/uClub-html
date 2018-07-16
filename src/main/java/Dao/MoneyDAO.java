package Dao;
import org.apache.ibatis.annotations.Param;
import model.MoneyApply;
import java.util.List;

public interface MoneyDAO {
    List<MoneyApply> getMoneyAppliesAll();
    int checkFailed (@Param("ApplyNo")int ApplyNo);
    int checkPassed (@Param("ApplyNo")int ApplyNo);
    List<MoneyApply> getMoneyAppliesPassed();
    List<MoneyApply> getMoneyAppliesFailed();
    int getMAcounts ();
    int getMAcountsHis();
}
