<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2018/7/5
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="model.Club" %>
<%@ page import="java.util.List" %>
<%@ page import="operations.ClubOperations" %>
<%@ page import="DAO.ClubDAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.util.EnumMap" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.lang.String" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String resource = "mybatis.xml";

    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
    List<Club> Clubs = ClubOperations.getClubsALL(sqlSessionFactory);


%>

<html>
<head>
    <title>Myhome</title>
</head>
<body>
<h1>
    Welcome!
</h1>
<input type = "button" value = "管理社团" onclick = "window.location.href = '/jsp/manageClub.jsp'">
<input type = "button" value = "管理申请" onclick = "window.location.href = '/jsp/manageApply.jsp'">



</body>
</html>