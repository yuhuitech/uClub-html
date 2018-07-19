package servlet;

import model.Article;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ArticleCreate")
public class ArticleCreate extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        int StuNo = (Integer) request.getSession().getAttribute("UserNo");
        String path = (String)request.getSession().getAttribute("Path");
        String passage = request.getParameter("passage");
        String author = request.getParameter("author");
        String title = request.getParameter("title");
        Article article = new Article();
        article.CreateArticle(StuNo,12362018,title,path,passage);
        String a = article.getText(path);
        System.out.println(a);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

    }
}
