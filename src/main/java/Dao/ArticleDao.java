package Dao;

import model.Article;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ArticleDao
{
   List<Article> getAllArticles ();
   void addArticle(@Param("StuNo") int StuNo, @Param("ClubNo") int ClubNo, @Param("Title") String title,@Param("res_url") String res_url, @Param("date") Date date);

   int getStuNoByArticleNo(@Param("ArticleNo") String ArticleNo);
}
