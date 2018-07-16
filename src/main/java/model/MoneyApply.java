package model;

public class MoneyApply {
    private  int ApplyNo;
    private  int ActiveNo;
    private  String Reason;
    private  int price;
    private  String status;
    private  String active_name;
    private  String ClubName;

    public int getApplyNo() {
        return ApplyNo;
    }

    public int getActiveNo() {
        return ActiveNo;
    }

    public int getPrice() {
        return price;
    }

    public String getReason() {
        return Reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setApplyNo(int applyNo) {
        ApplyNo = applyNo;
    }

    public void setActiveNo(int ActiveNo) {
        ActiveNo = ActiveNo;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setReason(String reason) {
        Reason = reason;
    }

    public String getActive_name() {
        return active_name;
    }

    public void setActive_name(String active_name) {
        this.active_name = active_name;
    }

    public String getClubName() {
        return ClubName;
    }

    public void setClubName(String clubName) {
        ClubName = clubName;
    }
}
