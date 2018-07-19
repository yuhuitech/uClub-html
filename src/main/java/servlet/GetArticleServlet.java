package servlet;

import model.Article;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class GetArticleServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        resp.setContentType("text/html; charset=utf-8");
        int artcle_num = Integer.parseInt( req.getParameter("articleNo"));
        List<Article> articles = ( List<Article>)req.getSession().getAttribute("articles");
        Article article = articles.get(artcle_num);
        String path = (String)req.getSession().getAttribute("Path");
        String text = article.getText(path);
        resp.getWriter().write(text);
        resp.getWriter().flush();
    }
}
