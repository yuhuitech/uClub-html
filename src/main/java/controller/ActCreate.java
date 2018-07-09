package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ActCreate")
public class ActCreate extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=\"utf-8\"");
        PrintWriter out = response.getWriter();

        //消除接受乱码的问题
        request.setCharacterEncoding("UTF-8");
        //获取社团号
        int Club_id = Integer.parseInt(request.getParameter("Act_Create_Club"));
        //将社团号作为参数传递给下一个页面
        request.getRequestDispatcher(String.format("jsp/ActInfo.jsp?ClubNo=%d",Club_id )).forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
