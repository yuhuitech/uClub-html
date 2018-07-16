package operations;

import model.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageDAO
{
    List<Message> getMyMessage(@Param("StuNo") int userID);

    void changeMessageStatus(@Param("Message") int MessageNo);
}
