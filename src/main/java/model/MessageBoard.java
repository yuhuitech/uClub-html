package model;

import java.util.Date;

public class MessageBoard {
    private int StuNo;
    private int ClubNo;
    private String MessageNo;
    private String Message;

    public int getStuNo() {
        return StuNo;
    }

    public void setStuNo(int stuNo) {
        StuNo = stuNo;
    }

    public int getClubNo() {
        return ClubNo;
    }

    public void setClubNo(int clubNo) {
        ClubNo = clubNo;
    }

    public String getMessageNo() {
        return MessageNo;
    }

    public void setMessageNo(String messageNo) {
        MessageNo = messageNo;
    }

    public String getMessage() {
        return Message;
    }

    public void setMessage(String message) {
        Message = message;
    }

    public Date getPostTime() {
        return PostTime;
    }

    public void setPostTime(Date postTime) {
        PostTime = postTime;
    }

    private Date PostTime;



}
