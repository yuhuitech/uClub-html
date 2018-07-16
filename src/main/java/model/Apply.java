package model;

public class Apply {
    private int ApplyNo;
    private String ClubName="";//赋值是因为Apply表有这些字段，而解散申请表没有，如果不赋初值在得到list时会报错，下方同理
    private String ClubType="";
    private String ClubInfo="";
    private int StuNo;
    private String ClubSize="";
    private String ApplyTime="";
    private int status;
    private String StuName = "";//本身Apply表是没有这个字段的 ，但是为了之后的显示，我加了进去
    private String Reason = "";//解散申请表的字段，复用一下Apply这个实体类
    private int ClubNo = -1;//申请表没有ClubNo，解散申请表有


    public int getApplyNo() {
        return ApplyNo;
    }

    public void setApplyNo(int applyNo) {
        ApplyNo = applyNo;
    }

    public int getStuNo() {
        return StuNo;
    }

    public void setStuNo(int stuNo) {
        StuNo = stuNo;
    }

    public String getClubName() {
        return ClubName;
    }

    public void setClubName(String clubName) {
        ClubName = clubName;
    }

    public String getClubType() {
        return ClubType;
    }

    public void setClubType(String clubType) {
        ClubType = clubType;
    }

    public String getClubInfo() {
        return ClubInfo;
    }

    public void setClubInfo(String clubInfo) {
        ClubInfo = clubInfo;
    }

    public String getClubSize() {
        return ClubSize;
    }

    public void setClubSize(String clubSize) {
        ClubSize = clubSize;
    }

    public String getApplyTime() {
        return ApplyTime;
    }

    public void setApplyTime(String applyTime) {
        ApplyTime = applyTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStuName() {
        return StuName;
    }

    public void setStuName(String stuName) {
        StuName = stuName;
    }

    public String getReason() {
        return Reason;
    }

    public void setReason(String reason) {
        Reason = reason;
    }

    public int getClubNo() {
        return ClubNo;
    }

    public void setClubNo(int clubNo) {
        ClubNo = clubNo;
    }
}
