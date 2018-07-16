package model;

import java.util.Date;

public class Comment {
    private int StuNo;
    private String ArticleNo;
    private String CommentNo;
    private String comment;
    private Date SendTime;
    private String RelatedCommentNo;

    public String getRelatedStuNo() {
        return RelatedStuNo;
    }

    public void setRelatedStuNo(String relatedStuNo) {
        RelatedStuNo = relatedStuNo;
    }

    private String RelatedStuNo;


    public String getRelatedCommentNo() {
        return RelatedCommentNo;
    }

    public void setRelatedCommentNo(String relatedCommentNo) {
        RelatedCommentNo = relatedCommentNo;
    }


    public int getStuNo() {
        return StuNo;
    }

    public void setStuNo(int stuNo) {
        StuNo = stuNo;
    }

    public String getArticleNo() {
        return ArticleNo;
    }

    public void setArticleNo(String articleNo) {
        ArticleNo = articleNo;
    }

    public String getCommentNo() {
        return CommentNo;
    }

    public void setCommentNo(String commentNo) {
        CommentNo = commentNo;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getSendTime() {
        return SendTime;
    }

    public void setSendTime(Date sendTime) {
        SendTime = sendTime;
    }
}
