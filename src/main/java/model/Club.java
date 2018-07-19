package model;

public class Club {
    private int ClubNo;
    private String ClubName;
    private String Type;
    private String ClubInfo;
    private String Res_url;
    private int status;
    private int memberNum;
    private int activeNum;
    private int boy_to_girl;

    public int getArticalNum() {
        return articalNum;
    }

    public void setArticalNum(int articalNum) {
        this.articalNum = articalNum;
    }

    private int articalNum;

    public int getMemberNum() {
        return memberNum;
    }

    public void setMemberNum(int memberNum) {
        this.memberNum = memberNum;
    }

    public int getActiveNum() {
        return activeNum;
    }

    public void setActiveNum(int activeNum) {
        this.activeNum = activeNum;
    }

    public int getArticleNum() {
        return articleNum;
    }

    public void setArticleNum(int articleNum) {
        this.articleNum = articleNum;
    }

    private int articleNum;



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
