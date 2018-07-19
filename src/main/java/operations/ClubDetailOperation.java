package operations;

import Dao.ClubDetailDao;
import model.Activity;
import model.Club;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.List;
public class ClubDetailOperation {

    public static Club getClubDetail(SqlSessionFactory sqlSessionFactory, int ClubNo){

        Club club=new Club();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            club = selectInterface.getClubDetail(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return club;
    }

    public static List<Activity> getClubActivities(SqlSessionFactory sqlSessionFactory, int ClubNo){

        List<Activity> list=new ArrayList<>();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            list=selectInterface.getClubActivities(ClubNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Club> getAllClubs(SqlSessionFactory sqlSessionFactory){

        List<Club> list=new ArrayList<>();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            list=selectInterface.getAllClubs();
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static Activity getActiveDetail(SqlSessionFactory sqlSessionFactory, int ActiveNo){

        Activity act= new Activity();
        try {
            SqlSession session = sqlSessionFactory.openSession();
            ClubDetailDao selectInterface = session.getMapper(ClubDetailDao.class);
            act = selectInterface.getActiveDetail(ActiveNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return act;
    }

}
