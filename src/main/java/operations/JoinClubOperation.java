package operations;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import DAO.JoinClubDao;
public class JoinClubOperation {

    public static String getClubName(SqlSessionFactory sqlSessionFactory, int ClubNo){
        String ClubName="";
        try {
            SqlSession session = sqlSessionFactory.openSession();
            JoinClubDao selectInterface = session.getMapper(JoinClubDao.class);
            ClubName=selectInterface.getClubName(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ClubName;
    }

}
