package operations;

import model.Article;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ArticleDao
{
   List<Article> getAllArticles ();
   void addArticle(@Param("StuNo") int StuNo, @Param("ClubNo") int ClubNo, @Param("res_url") String res_url, @Param("date") Date date);
}
