package operations;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import Dao.JoinClubDao;
public class JoinApplyOperation {
    public static int joinClubApply(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo, String JoinReason){
        int i=0;
        try {
            SqlSession session = sqlSessionFactory.openSession();
            JoinClubDao selectInterface = session.getMapper(JoinClubDao.class);
//            i=selectInterface.joinClubApply(StuNo,ClubNo,JoinReason);
            System.out.println("成功插入数据");
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
}
