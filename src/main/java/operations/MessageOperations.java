package operations;

import model.Message;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.List;

public class MessageOperations
{
    //下面是有关message相关方法的实现
    //从用户号获得所有的信息
    public static List<Message> getMyMessage(SqlSessionFactory sqlSessionFactory, int UserNo)
    {

        List<Message> result = new ArrayList<>();
        try {

            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MessageDAO selectInterface = session.getMapper(MessageDAO.class);
            result = selectInterface.getMyMessage(UserNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void changeMessageStatus(SqlSessionFactory sqlSessionFactory, int MessageNo)
    {

        try {

            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MessageDAO selectInterface = session.getMapper(MessageDAO.class);
            selectInterface.changeMessageStatus(MessageNo);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
