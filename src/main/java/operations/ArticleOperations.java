package operations;

import Dao.ArticleDao;
import Test.Test;
import model.Article;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ArticleOperations
{
        //获得所有文章
        public static List<Article> getAllArticle()
        {

            List<Article> articles = new ArrayList<>();
            try {
                String resource = "mybatis.xml";
                InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
                SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
                // 获取Session连接
                SqlSession session = sqlSessionFactory.openSession();
                // 获取Mapper
                ArticleDao selectInterface = session.getMapper(ArticleDao.class);
                articles = selectInterface.getAllArticles();
                session.commit();
                session.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
            return articles;
        }

        //根据article对象插入对象时
        public static void addArticle(int StuNo,int ClubNo,String title,String res_url,Date date)
        {

            try {
                String resource = "mybatis.xml";
                InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
                SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
                // 获取Session连接
                SqlSession session = sqlSessionFactory.openSession();
                // 获取Mapper
                ArticleDao selectInterface = session.getMapper(ArticleDao.class);
                selectInterface.addArticle(StuNo,ClubNo,title,res_url,date);
                session.commit();
                session.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    public static int getStuNoByArticleNo(SqlSessionFactory sqlSessionFactory,String articleNo)
    {

        int stuNo=0;
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            ArticleDao selectInterface = session.getMapper(ArticleDao.class);
            stuNo =  selectInterface.getStuNoByArticleNo(articleNo);
            session.commit();
            session.close();
            //return stuNo;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return stuNo;
    }
}
