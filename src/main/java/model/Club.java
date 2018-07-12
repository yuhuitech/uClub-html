package model;

import java.io.*;

public class Club {
    private int ClubNo;
    private String ClubName;
    private String Type;
    private String ClubInfo;
    private String Res_url;
    private int status;

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

    public void setText(String url,String text) throws IOException
    {
        File writename = new File(url); // 相对路径，如果没有则要建立一个新的output。txt文件
        OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(writename),"UTF-8");
        writename.createNewFile(); // 创建新文件
        BufferedWriter out = new BufferedWriter(osw);
        out.write(text); // \r\n即为换行
        out.flush(); // 把缓存区内容压入文件
        out.close(); // 最后记得关闭文件
    }
}
