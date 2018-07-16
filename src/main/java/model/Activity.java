package model;

public class Activity {

    private int ActiveNo;
    private String active_name;
    private String active_info;
    private int ClubNo;
    private String active_time;
    private String status;


    public int getActiveNo() {
        return ActiveNo;
    }

    public void setActiveNo(int ActiveNo) {
        this.ActiveNo = ActiveNo;
    }



    public String getActive_name() {
        return active_name;
    }

    public void setActive_name(String active_name) {
        this.active_name = active_name;
    }



    public String getActive_info() {
        return active_info;
    }

    public void setActive_info(String active_info) {
        this.active_info = active_info;
    }



    public int getClubNo() {
        return ClubNo;
    }

    public void setClubNo(int clubNo) {
        ClubNo = clubNo;
    }



    public String getActive_time() {
        return active_time;
    }

    public void setActive_time(String active_time) {
        this.active_time = active_time;
    }



    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


}
