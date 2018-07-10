package operations;

import model.Club;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.List;


public class ClubOperations  {
   // @Override
   // protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    //    doGet(req,resp);
    //}
    public static String getClubName(SqlSessionFactory sqlSessionFactory, int ClubNo) {
        String ClubName = new String();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            ClubName = clubDAO.getClubName(ClubNo);
            session.commit();
            session.close();
            //return ClubName;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return ClubName;
    }

    public static String getType(SqlSessionFactory sqlSessionFactory, int ClubNo) {
        String Type = new String();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            Type = clubDAO.getType(ClubNo);
            session.commit();
            session.close();
            //return Type;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Type;
    }

    public static String getClubInfo(SqlSessionFactory sqlSessionFactory, int ClubNo) {
        String ClubInfo = new String();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            ClubInfo = clubDAO.getClubInfo(ClubNo);
            session.commit();
            session.close();
            //return ClubInfo;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ClubInfo;
    }

    public static int getstatus(SqlSessionFactory sqlSessionFactory, int ClubNo) {
        int status = -1;//状态初始化时为-1，即不存在的社团状态
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            status = clubDAO.getstatus(ClubNo);
            session.commit();
            session.close();
            //return status;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static List<Club> getClubs(SqlSessionFactory sqlSessionFactory, int ClubNo, String ClubName, String Type, String ClubInfo) {
        List<Club> Clubs = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            Clubs = clubDAO.getClubs(ClubNo, ClubName, Type, ClubInfo);
            session.commit();
            session.close();
            //return Clubs;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return Clubs;
    }

    public static int upadteClub(SqlSessionFactory sqlSessionFactory, int ClubNo, String ClubName, String Type, String ClubInfo) {
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            int Clubs = clubDAO.updateClub(ClubNo, ClubName, Type, ClubInfo);
            session.commit();
            session.close();
            return Clubs;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;
        //返回值状态-2，表示更新操作
    }

    public static int addClub(SqlSessionFactory sqlSessionFactory, int ClubNo, String ClubName, String Type, String ClubInfo) {
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            int Clubs = clubDAO.addClub(ClubNo, ClubName, Type, ClubInfo);
            session.commit();
            session.close();
            return Clubs;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -3;
        //返回值状态-3，表示增加一个社团的操作
    }

    public static Club getClub(SqlSessionFactory sqlSessionFactory, int ClubNo, String ClubName, String Type, String ClubInfo) {
        Club club = new Club();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            club = clubDAO.getClub(ClubNo);
            session.commit();
            session.close();
            //return club;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return club;
    }



    public static int deleteClub(SqlSessionFactory sqlSessionFactory, int ClubNo) {
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            int Clubs = clubDAO.deleteClub(ClubNo);
            session.commit();
            session.close();
            return Clubs;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -4;
        //返回值状态-4，表示删除一个社团的操作，但为了表的稳定性，不使用delete语句，而是增加一个状态码0和1,0表示社团不存在，1表示存在
    }

    public static List<Club> getClubsALL(SqlSessionFactory sqlSessionFactory) {
        List<Club> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            List<Club> Clubs = clubDAO.getClubsAll();
            for (Club club : Clubs) {
                if (club.getStatus() == 1) {// 状态码1，社团存在
                    result.add(club);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static List<Club> getAllJoinClubs(SqlSessionFactory sqlSessionFactory,int StuNo) {
        List<Club> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ClubDAO clubDAO = session.getMapper(ClubDAO.class);
            result = clubDAO.getAllJoinClubs(StuNo);
            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


}
