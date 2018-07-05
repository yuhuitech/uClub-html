package servlet;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ClubInfo")
public class ClobInfo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //ClubNo为正即为管理员对应，为负是社员对应
        int ClubNo = Integer.parseInt(request.getParameter("Club_id"));


        //带两个参数的页面跳转（该参数没有安全性问题，故可以显示在url中）
        request.getRequestDispatcher(String.format("jsp/ClubInfo.jsp?ClubNo=%d",ClubNo )).forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
