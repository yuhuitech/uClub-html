

<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/3
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login for Uclub</title>
</head>
<body>
<script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js">
</script>
<form  action="/login" method="post" class="white-pink">
    <h1>
        Login
    </h1>
    <label>
        <span>UserNo :</span>
        <input id="userNo" type="text" name="userNo"/>
    </label>
    <br>
    <label>
        <span>Password :</span>
        <input id="password" type="password" name="passwd" />
    </label>
    <br>
    <label>
        <span>选择登录模式 :</span>
        <select id="status" name="status"  value="${Status}">
            <option value="student" >学生模式</option>
            <option value="admin">管理员模式</option>
        </select>
    </label>

    <label>
        <div class="button_container">
            <input type="submit"  class="button" value="Login" />
        </div>
    </label>

    <%
        String userNo=request.getParameter("userNo");
        String status= request.getParameter("status");
        //<用户帐号,类型>
        session.setAttribute("UserNo",userNo);
        session.setAttribute("Status",status);
    %>
</form>
</body>

</html>
