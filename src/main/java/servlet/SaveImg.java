package servlet;

import sun.misc.BASE64Decoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

@MultipartConfig
public class SaveImg extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        String name=req.getParameter("name");
        String part = req.getParameter("imgData");
        String fileName =StuNo + ".jpg";
        String basePath = req.getSession().getServletContext().getRealPath("/img/");
        String  filePath = basePath;
     //   System.out.println("保存图片的地址为："+filePath);
        String realFilePath = filePath+"\\"+fileName;
        BASE64Decoder decoder = new BASE64Decoder();
        try
        {
            part = part.replaceAll("data:image/png;base64,", "");
            //Base64解码
            byte[] b = decoder.decodeBuffer(part);
            for(int i=0;i<b.length;++i)
            {
                if(b[i]<0)
                {//调整异常数据
                    b[i]+=256;
                }
            }
            OutputStream out = new FileOutputStream(this.getServletContext().getRealPath("/jsp/images") + "/" + name + ".jpg");
            out.write(b);
            out.flush();
            out.close();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }
}
