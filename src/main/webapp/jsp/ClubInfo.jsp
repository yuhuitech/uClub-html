<%@ page import="operations.DAO" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="model.Club" %>
<%@ page import="Test.Test" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/5
  Time: 10:59
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <title>UserHome</title>
</head>
<body>
<%
    int ClubNo = Integer.parseInt(request.getParameter("ClubNo"));
   //通过数据库连接根据ID号取到相应的社团对象
    String resource = "mybatis.xml";
    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
    Club club = DAO.getClubById(sqlSessionFactory,ClubNo);
%>

<form method = "post" action = "/ClubInfoChange">
    <%out.println(club.getClubName());%><br/><br/>
    <%out.println(club.getType());%><br/><br/>
    <input type = "text" name = "Club_info" value = <%= club.getClubInfo()%>><br/><br/>

    <button name="Club_id" type="submit" value = <%= club.getClubNo()%>>提交更改</button>

</form>

<form method = "post" action = "/ActCreate">
    <button name="Act_Create_Club" type="submit" value = <%= club.getClubNo()%>>创建活动</button>
</form>>


</body>
</html>
