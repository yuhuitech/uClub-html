package operations;

import model.Comment;
import model.MessageBoard;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import DAO.commentDao;

public class commentOperation {

    //插入到comment表
    public static int addComment(SqlSessionFactory sqlSessionFactory, int StuNo, String ArticleNo,
                                 String CommentNo, String comment, Date SendTime,String RelatedCommentNo, String RelatedStuNo) {
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            commentDao DAO = session.getMapper(commentDao.class);
            int result = DAO.addComment(StuNo, ArticleNo, CommentNo, comment, SendTime, RelatedCommentNo,RelatedStuNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static List<Comment> getAllComments(SqlSessionFactory sqlSessionFactory, String articleNo){
        List<Comment> comments = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            commentDao DAO = session.getMapper(commentDao.class);
            comments = DAO.getAllComments(articleNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return comments;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comments;
    }


    public static List<Comment> getAllReply(SqlSessionFactory sqlSessionFactory, String relatedCommentNo){
        List<Comment> comments = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            commentDao DAO = session.getMapper(commentDao.class);
            comments = DAO.getAllReply(relatedCommentNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return comments;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comments;
    }

    public static String getStuNo(SqlSessionFactory sqlSessionFactory, String relatedCommentNo){
        String stuNo = "";
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            commentDao DAO = session.getMapper(commentDao.class);
            stuNo = DAO.getStuNo(relatedCommentNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return stuNo;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stuNo;
    }


    //获得一个长度为16的字符串编号作为评论编号
    public static String getCommentUUID() {
        String uuid = "";
        //注意replaceAll前面的是正则表达式
        uuid= UUID.randomUUID().toString().replaceAll("-", "");
        System.out.println(uuid);
        uuid = uuid.substring(0,16);
        return  uuid;
    }




    //插入到message_board表
    public static int add2MessageBoard(SqlSessionFactory sqlSessionFactory, int StuNo, int ClubNo,
                                 String MessageNo, String Message, Date PostTime) {
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            commentDao DAO = session.getMapper(commentDao.class);
            int result = DAO.add2MessageBoard(StuNo, ClubNo, MessageNo, Message, PostTime);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }



    public static List<MessageBoard> getMessageBoard(SqlSessionFactory sqlSessionFactory, int clubNo){
        List<MessageBoard> messages = new ArrayList<>();
        try {
            // 获取Session连接
            SqlSession session = sqlSessionFactory.openSession();
            // 获取Mapper
            commentDao DAO = session.getMapper(commentDao.class);
            messages = DAO.getMessageBoard(clubNo);
            session.commit();
            session.close();
            // 显示插入之后Apply信息
            return messages;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return messages;
    }




}


