package model;

import static java.lang.System.out;

public class Record {
    private int AcNo;
    private int StuNo;
    private int times;
    private int type;

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }

    public Record() {
        this.type = 0; //初始值type为0，代表是club的记录
    }

    public int getAcNo() {
        return AcNo;
    }

    public void setAcNo(int acNo) {
        AcNo = acNo;
    }

    public int getStuNo() {
        return StuNo;
    }

    public void setStuNo(int stuNo) {
        StuNo = stuNo;
    }



    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    //转换类型方法（是社团还是活动的记录）
    public void changeType()
    {
        if(this.type == 0) this.type = 1;
        else this.type = 0;
    }

    public void print()
    {
        out.println("学号："+this.StuNo);
        out.println("活动或社团号"+this.AcNo);
        out.println("浏览次数"+this.times);
    }
}
