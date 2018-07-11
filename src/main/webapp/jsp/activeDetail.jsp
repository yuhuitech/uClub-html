<%@ page import="operations.DAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %><%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/4
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <title>Activity</title>
</head>
<body>
<%
    //获取信息
    Integer StuNo= (Integer) session.getAttribute("UserNo");
    Integer ActiveNo= (Integer) request.getAttribute("ActiveNo");
    String ActiveName= (String) request.getAttribute("ActiveName");
    Integer ActiveClubNo= (Integer) request.getAttribute("ActiveClubNo");
    Date ActiveBegin= (Date) request.getAttribute("ActiveBegin");
    Date ActiveEnd= (Date) request.getAttribute("ActiveEnd");
    String ActiveStatus= (String) request.getAttribute("ActiveStatus");
    String ActiveInfo= (String) request.getAttribute("ActiveInfo");
    SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) request.getServletContext().getAttribute("SqlSessionFactory");
    String ClubName= DAO.getClubById(sqlSessionFactory,ActiveClubNo).getClubName();

%>
<script>
    function getInfo(StuNo,ActiveNo) {
        $.ajax({
            type:'POST',
            url:"/joinActivity",
            data:{
                "StuNo":StuNo,
                "ActiveNo":ActiveNo,
            },
            success:function(){
                alert("成功加入活动!");
            }
        });
        alert("成功加入活动!");
    }
    function exitActivity(StuNo,ActiveNo) {
        $.ajax({
            type:'POST',
            url:"/exitActivity",
            data:{
                "StuNo":StuNo,
                "ActiveNo":ActiveNo,
            },
            success:function() {
                alert("成功退出活动!");
            }
        });
        alert("成功退出活动!");
    }
</script>
活动名称:
<h1 id="ActiveName">  <%=ActiveName%></h1>
活动社团:
<div id="ActiveClubNo"> <%=ClubName%></div>
活动开始时间:
<div id="ActiveTime"><%=ActiveBegin%> </div>
活动结束时间：
<div id="ActiveTime"><%=ActiveEnd%> </div>
活动状态:
<div id="ActiveStatus"><%=ActiveStatus%> </div>
活动详情:
<div id="ActiveInfo"><%=ActiveInfo%> </div>

    <input type="button" value="参加活动" onclick="getInfo(<%=StuNo%>,<%=ActiveNo%>)" />
<br>
<br>
<br>
    <input type="button" value="退出活动" onclick="exitActivity(<%=StuNo%>,<%=ActiveNo%>)"/>


</body>
</html>
