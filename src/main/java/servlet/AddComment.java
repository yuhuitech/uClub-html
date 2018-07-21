package servlet;

import model.Article;
import model.Comment;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import Test.Test;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

import static operations.DAO.getDateTime;
import static operations.commentOperation.*;
import static operations.commentOperation.deleteComment;

@WebServlet(name = "AddComment")
public class AddComment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=\"utf-8\"");

        //消除接受乱码的问题
        request.setCharacterEncoding("UTF-8");
        String resource = "mybatis.xml";//mybatis资源
        HttpSession session=request.getSession();
        //消除接受乱码的问题
        //Integer userID = (Integer) session.getAttribute("UserNo");
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        int status= Integer.parseInt(request.getParameter("status"));
        String articleNum=request.getParameter("articleNo");
        List<Article> articles = ( List<Article>)session.getAttribute("articles");
        Article article = articles.get(Integer.parseInt(articleNum));
        String comment=request.getParameter("content");

        String articleNo = String.valueOf(article.getArticleNo());

        String commentID=request.getParameter("commentID");



        Integer stuNo = (Integer)request.getSession().getAttribute("UserNo");
        String commentNo = getCommentUUID();

        Date sendTime = getDateTime();


        //获取相关评论信息
        String relatedCommentNo = request.getParameter("relatedCommentNo");


        String relatedStuNo = getStuNo(sqlSessionFactory,relatedCommentNo);

        if (sqlSessionFactory != null && stuNo != 0 && articleNo != ""&& commentNo != "" &&
                comment != ""&&comment != null && sendTime != null&& relatedCommentNo!=""&&relatedStuNo!="") {
            int addResult = addComment(sqlSessionFactory,stuNo,articleNo,commentNo,comment,sendTime,relatedCommentNo,relatedStuNo);
            if (addResult == -1) {
                System.out.println("写入数据库失败");
            } else {
                System.out.println("写入数据库成功");
            }

        } else {
            //显示提交失败
            System.out.println("评论失败");
        }

        //下面是删除评论的部分
        if(status==3||status==4){
            int delResult=-1;
            delResult=deleteComment(sqlSessionFactory,commentID);
            if (delResult == -1) {
                System.out.println("删除评论失败");
            } else {
                System.out.println("删除评论成功");
            }
        }



        response.getWriter().write(commentNo);
        response.getWriter().flush();


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
