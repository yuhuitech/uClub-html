<%--
  Created by IntelliJ IDEA.
  User: wangtao
  Date: 2018/7/4
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Apply For Club</title>
</head>
<body>
<!--本jsp表单的action会指向applyClubServlet -->
<form action="/applyClubServlet" method="post" id="applyClubForm" >
    <h1 style="align-content: center">
        创建社团申请
    </h1>
    <%
        String userNo = request.getParameter("userNo");
        String stuName = (String) request.getAttribute("stuName");
        String college = (String) request.getAttribute("college");


        out.println("<label>");
        out.println("<label><span>学号:</span></label>");
        out.println("<input type=\"text\" name=\"userNo\" value=\""+userNo+"\" readonly=\"readonly\" style=\"border: none;outline: none;\" /><br><br>");
        out.println("<label><span>姓名:</span></label>");
        out.println("<input type=\"text\" name=\"stuName\" value=\""+stuName+"\" readonly=\"readonly\" style=\"border: none;outline: none;\" /><br><br>");
        out.println("<label><span>学院:</span></label>");
        out.println("<input type=\"text\" name=\"college\" value=\""+college+"\" readonly=\"readonly\" style=\"border: none;outline: none;\" /><br><br>");
        out.println("</label>");

    %>

    <label><span>社团名称clubName:</span></label>
    <input type="text" name="clubName" id="clubName">
    <br><br>
    <label><span>社团标签clubType:</span></label>
    <select name="clubType">
        <option value ="舞蹈">舞蹈</option>
        <option value ="体育">体育</option>
        <option value ="音乐">音乐</option>
        <option value ="绘画">绘画</option>
        <option value ="文学">文学</option>
        <option value ="电子竞技">电子竞技</option>
        <option value ="棋牌">棋牌</option>
        <option value ="户外">户外</option>
        <option value ="其他">其他</option>
    </select>
    <br><br>
    <label><span>社团简介clubInfo:</span></label><br>
    <textarea style="width: 500px ; height: 100px" type="text" name="clubInfo"></textarea>>
    <br><br>
    <label><span>预计规模clubSize:</span></label>
    <select name="clubSize">
        <option value ="0-50人">0-50人</option>
        <option value ="50-100人">50-100人</option>
        <option value="100人以上">100人以上</option>
    </select>
    <br><br>
    <%--<label><span>社团图标clubLogo :</span></label>--%>
    <%--<input type="text" name="clubLogo">--%>
    <%--<br><br>--%>

    <label>
        <div class="button_container">
            <input type="submit" class="button" value="提交申请" />
        </div>
    </label>

    <script language="javascript">
        function submit_form(){
            var gnl=confirm("确认提交申请?");
            if (gnl==true){
                return true;
            }else{
                return false;
            }
        }
        </script>

    <br><br><br>
    <%
        String result = (String) request.getAttribute("result");
        out.println("<label  style=\"color: red\">"+result+"</label>");

    %>
</form>
</body>
</html>
