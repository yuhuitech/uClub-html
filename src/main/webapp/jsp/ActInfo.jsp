<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/5
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ActInfo</title>
</head>
<body>
<%
    //从get参数获取社团号
    int ClubNo = Integer.parseInt(request.getParameter("ClubNo"));

%>
<form method = "post" action = "/ActCreateApply">

    活动名： <input type = "text" name = "Act_name" value = ""><br/><br/>
    活动信息：<input type = "text" name = "Act_info" value = ""><br/><br/>
    活动时间： <input type = "text" name = "Act_time" value = ""><br/><br/> <%-- 注意这里的时间是一个字符串类型，感觉后期还要加属性--%>


    <button name="Club_id" type="submit" value = <%= ClubNo%>>提交更改</button>

</form>
</body>
</html>
