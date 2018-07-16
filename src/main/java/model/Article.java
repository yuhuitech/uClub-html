package model;

import operations.ArticleOperations;
import operations.DAO;

import java.io.*;
import java.util.Date;
import java.util.UUID;

public class Article
{
    private String res_url;//文章对应的存储空间
    private  Date date;//文章的发布时间
    int StuNo;//发布文章的学生
    int ClubNo;//文章对应的社团

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

   public Article(int StuNo,int CLubNo,String url,String article) throws IOException
   {
           this.StuNo = StuNo;
           this.ClubNo = CLubNo;
           this.date = DAO.getDateTime();
           this.res_url = getCommentUUID();
           this.setText(url+"article/"+this.res_url+".txt",article);
           ArticleOperations.addArticle(this.StuNo,this.ClubNo,this.res_url,this.date);

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

    public String getText()
    {
        return getText(this.res_url);
    }

    private String getText(String url) {
        BufferedReader input;
        String line = null;
        String ret = "";
        try {
            FileInputStream fis = new FileInputStream(url);
            InputStreamReader isr = new InputStreamReader(fis,"UTF-8");
            input = new BufferedReader(isr);
            while ((line = input.readLine()) != null)
                ret += line;
            input.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ret;
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
