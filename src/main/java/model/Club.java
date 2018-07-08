package model;

public class Club {
    private int ClubNo;
    private String ClubName;
    private String Type;
    private String ClubInfo;
    private String Res_url;
    private int status;

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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
