package operations;
import Dao.ManageApplyDAO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Apply;

import javax.servlet.http.HttpServlet;

public class ManageApplyOperations {
    public static int getstatus(SqlSessionFactory sqlSessionFactory, int ApplyNo) {
        int status = -1; //初始化为-1，为不存在的申请状态
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            status = manageApplyDAO.getstatus(ApplyNo);
            session.commit();
            session.close();
            //return ClubName;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static List<Apply> getAppliesALL(SqlSessionFactory sqlSessionFactory) {
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getAppliesAll();
            for (Apply apply : Applies) {
                if (apply.getStatus() >=0 ) {// 只筛选状态为0 1 2 的申请
                    result.add(apply);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }



    public static  List<Apply> getAppliesAllV2(SqlSessionFactory sqlSessionFactory){
        List<Apply> result = new ArrayList<>();
                try{
                    // 获取Session连接
                    SqlSession session = sqlSessionFactory.openSession();
                    // 获取Mapper
                    ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
                    List<Apply> Applies = manageApplyDAO.getAppliesAllV2();
                    for(Apply apply:Applies){
                        if (apply.getStatus() >=0 ) {// 只筛选状态为0 1 2 的申请
                            result.add(apply);
                        }
                    }
                    session.commit();
                    session.close();


                } catch (Exception e) {
                    e.printStackTrace();
                }
        return result;
    }



    public static List<Apply> getAppliesPassedV2(SqlSessionFactory sqlSessionFactory){
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getAppliesPassedV2();
            for (Apply apply : Applies) {
                //if (apply.getStatus() ==1 ) {// 申请通过的状态1
                    result.add(apply);
              //  }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }



    public static List<Apply> getAppliesPassed(SqlSessionFactory sqlSessionFactory) {
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getAppliesPassed();
            for (Apply apply : Applies) {
                //if (apply.getStatus() ==1 ) {// 申请通过的状态1
                    result.add(apply);
               // }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static List<Apply> getAppliesFailedV2(SqlSessionFactory sqlSessionFactory){
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getAppliesFailedV2();
            for (Apply apply : Applies) {
               // if (apply.getStatus() ==2 ) {// 申请失败的状态2
                    result.add(apply);
               //        }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static List<Apply> getAppliesFailed(SqlSessionFactory sqlSessionFactory){
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getAppliesFailed();
            for (Apply apply : Applies) {
                if (apply.getStatus() ==2 ) {// 申请失败的状态2
                    result.add(apply);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static List<Apply> getAppliesUncheckedV2(SqlSessionFactory sqlSessionFactory)
    {
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getAppliesUncheckedV2();
            for (Apply apply : Applies) {
                if (apply.getStatus() ==0 ) {// 未审核的状态0
                    result.add(apply);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;

    }

    public static List<Apply> getAppliesUnchecked(SqlSessionFactory sqlSessionFactory){
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getAppliesUnchecked();
            for (Apply apply : Applies) {
                if (apply.getStatus() ==0 ) {// 未审核的状态0
                    result.add(apply);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String getApplyTime(SqlSessionFactory sqlSessionFactory ,int ApplyNo){
        String ApplyTime = new String();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            ApplyTime = manageApplyDAO.getApplyTime(ApplyNo);
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return ApplyTime;

    }


    public static int checkPassed(SqlSessionFactory sqlSessionFactory ,int ApplyNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            int Applies = manageApplyDAO.checkPass(ApplyNo);
            session.commit();
            session.close();
            return  Applies;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //返回值-1 表示审核通过
    }

    public static int checkFailed(SqlSessionFactory sqlSessionFactory,int ApplyNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            int Applies = manageApplyDAO.checkFailed(ApplyNo);
            session.commit();
            session.close();
            return  Applies;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;//返回值-2 表示审核未通过
    }

    public static String getStuName(SqlSessionFactory sqlSessionFactory,int StuNo){
        String StuName = new String();
        try{
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            StuName = manageApplyDAO.getStuName(StuNo);
            session.commit();
            session.close();
        } catch (Exception e) {
        e.printStackTrace();
    }
    return StuName;
    }

    public static List<Apply> getDissolveAppliesAll(SqlSessionFactory sqlSessionFactory) {
        List<Apply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            List<Apply> Applies = manageApplyDAO.getDissolveAppliesAll();
            for(Apply apply:Applies)
            {
                result.add(apply);
            }
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return  result;
    }

    public static int checkPassInDis(SqlSessionFactory sqlSessionFactory,int ApplyNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            int applies = manageApplyDAO.checkPassInDis(ApplyNo);
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static int checkFailInDis(SqlSessionFactory sqlSessionFactory,int ApplyNo){
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            int applies = manageApplyDAO.checkFailInDis(ApplyNo);
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
            return  -2;
    }

    public static int getUncheckCounts(SqlSessionFactory sqlSessionFactory){
        int counts = 0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            int applies = manageApplyDAO.getUncheckCounts();
            counts = applies;
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }

        return  counts;

    }

    public static int getcheckedCounts(SqlSessionFactory sqlSessionFactory){
        int counts = 0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            int applies = manageApplyDAO.getcheckedCounts();
            counts = applies;
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }

        return  counts;

    }

    public static int getDisCounts(SqlSessionFactory sqlSessionFactory){
        int counts = 0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ManageApplyDAO manageApplyDAO = session.getMapper(ManageApplyDAO.class);
            int applies = manageApplyDAO.getDisCounts();
            counts = applies;
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return  counts;
    }


}
