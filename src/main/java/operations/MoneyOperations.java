package operations;
import Dao.MoneyDAO;
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
import model.MoneyApply;

import javax.servlet.http.HttpServlet;
public class MoneyOperations {
    public static List<MoneyApply> getAppliesALL(SqlSessionFactory sqlSessionFactory) {
        List<MoneyApply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MoneyDAO moneyDAO = session.getMapper(MoneyDAO.class);
            List<MoneyApply> Moneyapplies = moneyDAO.getMoneyAppliesAll();
            for (MoneyApply moneyApply : Moneyapplies) {
                if (moneyApply.getStatus() != null) {//
                    result.add(moneyApply);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }



    public static List<MoneyApply> getAppliesPassed(SqlSessionFactory sqlSessionFactory){
        List<MoneyApply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MoneyDAO moneyDAO = session.getMapper(MoneyDAO.class);
            List<MoneyApply> Moneyapplies = moneyDAO.getMoneyAppliesPassed();
            for (MoneyApply moneyApply : Moneyapplies) {
                if (moneyApply.getStatus() != null) {//
                    result.add(moneyApply);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static List<MoneyApply> getAppliesFailed(SqlSessionFactory sqlSessionFactory){
        List<MoneyApply> result = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MoneyDAO moneyDAO = session.getMapper(MoneyDAO.class);
            List<MoneyApply> Moneyapplies = moneyDAO.getMoneyAppliesFailed();
            for (MoneyApply moneyApply : Moneyapplies) {
                if (moneyApply.getStatus() != null) {//
                    result.add(moneyApply);
                }
            }
            session.commit();
            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static int checkFailed(SqlSessionFactory sqlSessionFactory, int ApplyNo) {
        try {
            SqlSession session = sqlSessionFactory.openSession();
            MoneyDAO moneyDAO = session.getMapper(MoneyDAO.class);
            int money = moneyDAO.checkFailed(ApplyNo);
            session.commit();
            session.close();
            return money;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;
    }


    public static int checkPassed(SqlSessionFactory sqlSessionFactory, int ApplyNo) {
        try {
            SqlSession session = sqlSessionFactory.openSession();
            MoneyDAO moneyDAO = session.getMapper(MoneyDAO.class);
            int money = moneyDAO.checkPassed(ApplyNo);
            session.commit();
            session.close();
            return money;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static int getMAcount(SqlSessionFactory sqlSessionFactory){
        int counts = 0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MoneyDAO moneyDAO = session.getMapper(MoneyDAO.class);
            int num = moneyDAO.getMAcounts();
            counts = num;
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return  counts;
    }


    public static int getMAcountHis(SqlSessionFactory sqlSessionFactory){
        int counts = 0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            MoneyDAO moneyDAO = session.getMapper(MoneyDAO.class);
            int num = moneyDAO.getMAcountsHis();
            counts = num;
            session.commit();
            session.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return  counts;
    }

}
