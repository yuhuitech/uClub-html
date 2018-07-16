package model;

import java.util.Date;

public class Message
{
    private int MessageNo;
    private String MessageInfo;
    private int type;
    private Date time;
    private int StuNo;
    private int status;

    public int getMessageNo()
    {
        return MessageNo;
    }

    public void setMessageNo(int messageNo)
    {
        MessageNo = messageNo;
    }

    public String getMessageInfo()
    {
        return MessageInfo;
    }

    public void setMessageInfo(String messageInfo)
    {
        MessageInfo = messageInfo;
    }

    public int getType()
    {
        return type;
    }

    public void setType(int type)
    {
        this.type = type;
    }

    public Date getTime()
    {
        return time;
    }

    public void setTime(Date time)
    {
        this.time = time;
    }

    public int getStuNo()
    {
        return StuNo;
    }

    public void setStuNo(int stuNo)
    {
        StuNo = stuNo;
    }

    public int getStatus()
    {
        return status;
    }

    public void setStatus(int status)
    {
        this.status = status;
    }
}
