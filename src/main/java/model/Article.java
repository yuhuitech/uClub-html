package model;

import operations.ArticleOperations;
import operations.DAO;

import java.io.*;
import java.util.Date;
import java.util.UUID;

public class Article
{
    public int getArticleNo()
    {
        return ArticleNo;
    }

    public void setArticleNo(int articleNo)
    {
        ArticleNo = articleNo;
    }

    private int ArticleNo;
    private String res_url;//文章对应的存储空间
    private  Date date;//文章的发布时间
    int StuNo;//发布文章的学生
    int ClubNo;//文章对应的社团
    String title;//文章标题

    public int getStuNo()
    {
        return StuNo;
    }

    public void setStuNo(int stuNo)
    {
        StuNo = stuNo;
    }

    public int getClubNo()
    {
        return ClubNo;
    }

    public void setClubNo(int clubNo)
    {
        ClubNo = clubNo;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getRes_url()
    {
        return res_url;
    }

    public void setRes_url(String res_url)
    {
        this.res_url = res_url;
    }

    public Date getDate()
    {
        return date;
    }

    public void setDate(Date date)
    {
        this.date = date;
    }

  public void CreateArticle(int StuNo,int CLubNo,String title,String url,String article) throws IOException
  {
           this.StuNo = StuNo;
           this.ClubNo = CLubNo;
           this.title = title;
           this.date = DAO.getDateTime();
           this.res_url = getCommentUUID();
           this.setText(url+"article/"+this.res_url+".txt",article);
           ArticleOperations.addArticle(this.StuNo,this.ClubNo,this.title,this.res_url,this.date);

    }

    public void setText(String text) throws IOException
    {
        setText(this.res_url,text);
    }

    //外界会决定是创建文件还是改写文件
    private void setText(String url,String text) throws IOException
    {
        File writename = new File(url); // 相对路径，如果没有则要建立一个新的output。txt文件
        OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(writename),"UTF-8");
        writename.createNewFile(); // 创建新文件
        BufferedWriter out = new BufferedWriter(osw);
        out.write(text); // \r\n即为换行
        out.flush(); // 把缓存区内容压入文件
        out.close(); // 最后记得关闭文件
    }




    public String getText(String url) {
        BufferedReader input;
        String line = null;
        String ret = "";
        url = url+"article/"+this.res_url+".txt";
        try {
            FileInputStream fis = new FileInputStream(url);
            InputStreamReader isr = new InputStreamReader(fis,"UTF-8");
            input = new BufferedReader(isr);
            while ((line = input.readLine()) != null)
                ret += line+"\n";
            input.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ret;
    }

    public String getStandardText(String url) {
        BufferedReader input;
        String line = null;
        String ret = "";
        url = url+"article/"+this.res_url+".txt";
        try {
            FileInputStream fis = new FileInputStream(url);
            InputStreamReader isr = new InputStreamReader(fis,"UTF-8");
            input = new BufferedReader(isr);
            while ((line = input.readLine()) != null)
                ret += line+"&#10;";
            input.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ret.trim();
    }

    //获得一个长度为16的字符串编号作为评论编号
    private String getCommentUUID() {
        String uuid = "";
        //注意replaceAll前面的是正则表达式
        uuid= UUID.randomUUID().toString().replaceAll("-", "");
        System.out.println(uuid);
        uuid = uuid.substring(0,16);
        return  uuid;
    }



}
