package operations;

import Dao.ClubDetailDao;
import model.Club;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.List;

public class RandomOperations
{
    //获取随机8个社团
    public static List<Club> getRandomClub(SqlSessionFactory sqlSessionFactory, int num)
    {
        List<Club> random_clubs = new ArrayList<>();
        try {

            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            random_clubs = selectInterface.getRandomClub(num);
            session.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return random_clubs;
    }


}
