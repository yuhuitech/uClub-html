package model;

public class Teacher {
    private int TeacherNo;
    private String TeacherName;
    private String Teacher_tel;
    private String Teacher_email;
    private String teacher_password;

    public int getTeacherNo() {
        return TeacherNo;
    }

    public void setTeacherNo(int teacherNo) {
        TeacherNo = teacherNo;
    }

    public String getTeacherName() {
        return TeacherName;
    }

    public void setTeacherName(String teacherName) {
        TeacherName = teacherName;
    }

    public String getTeacher_tel() {
        return Teacher_tel;
    }

    public void setTeacher_tel(String teacher_tel) {
        Teacher_tel = teacher_tel;
    }

    public String getTeacher_email() {
        return Teacher_email;
    }

    public void setTeacher_email(String teacher_email) {
        Teacher_email = teacher_email;
    }

    public String getTeacher_password() {
        return teacher_password;
    }

    public void setTeacher_password(String teacher_password) {
        this.teacher_password = teacher_password;
    }
}
