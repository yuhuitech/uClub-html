package model;

import operations.DAO;

import javax.servlet.ServletContext;
import java.io.*;

public class Club {

    private int ClubNo;
    private String ClubName;
    private String Type;
    private String ClubInfo;
    private String Res_url;
    private int status;
    private int memberNum ;
    private int activeNum;
    private int articalNum;
    private double boy_girl;

    public Club()
    {
        memberNum = 0;
        activeNum = 0;
        articalNum = 0;
        boy_girl = 0;
    }

    public double getBoy_girl()
    {
        return boy_girl;
    }

    public void setBoy_girl(double boy_girl)
    {
        this.boy_girl = boy_girl;
    }



    public int getMemberNum()
    {
        return memberNum;
    }

    public void setMemberNum(int memberNum)
    {
        this.memberNum = memberNum;
    }

    public int getActiveNum()
    {
        return activeNum;
    }

    public void setActiveNum(int activeNum)
    {
        this.activeNum = activeNum;
    }

    public int getArticalNum()
    {
        return articalNum;
    }

    public void setArticalNum(int articalNum)
    {
        this.articalNum = articalNum;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getClubNo() {
        return ClubNo;
    }

    public void setClubNo(int clubNo) {
        ClubNo = clubNo;
    }

    public String getClubName() {
        return ClubName;
    }

    public void setClubName(String clubName) {
        ClubName = clubName;
    }

    public String getType() {
        return Type;
    }

    public void setType(String type) {
        Type = type;
    }

    public String getClubInfo() {
        return ClubInfo;
    }

    public void setClubInfo(String clubInfo) {
        ClubInfo = clubInfo;
    }

    public String getRes_url() {
        return Res_url;
    }

    public void setRes_url(String res_url) {
        Res_url = res_url;
    }




}
