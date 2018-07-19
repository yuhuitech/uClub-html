package Dao;

import model.Comment;
import model.MessageBoard;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface commentDao {

    //贴吧评论写入数据库
    int addComment(@Param("StuNo") int StuNo,
                   @Param("ArticleNo") String ArticleNo,
                   @Param("CommentNo") String CommentNo,
                   @Param("comment") String comment,
                   @Param("SendTime") Date sendTime,
                   @Param("RelatedCommentNo") String RelatedCommentNo,
                    @Param("RelatedStuNo") String RelatedStuNo);



    //获得所有评论
    List<Comment> getAllComments(@Param("ArticleNo") String articleNo);

    //获得所有回复
    List<Comment> getAllReply(@Param("RelatedCommentNo") String relatedCommentNo);

    String getStuNo(@Param("RelatedCommentNo") String relatedCommentNo);


    //下面部分是留言板


    int add2MessageBoard(@Param("StuNo") int StuNo,
                         @Param("ClubNo") int ClubNo,
                         @Param("MessageNo") String MessageNo,
                         @Param("Message") String Message,
                         @Param("PostTime") Date PostTime);

    List<MessageBoard> getMessageBoard(@Param("ClubNo") int clubNo);

    void delMessageBoard(@Param("MessageNo") String MessageNo);
}