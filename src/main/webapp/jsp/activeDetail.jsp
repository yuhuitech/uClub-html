<%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/4
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Activity</title>
</head>
<body>
<%
    String ActiveName= (String) request.getAttribute("ActiveName");
    Integer ActiveClubNo= (Integer) request.getAttribute("ActiveClubNo");
    String ActiveTime= (String) request.getAttribute("ActiveTime");
    String ActiveStatus= (String) request.getAttribute("ActiveStatus");
    String ActiveInfo= (String) request.getAttribute("ActiveInfo");

%>
活动名称:
<h1 id="ActiveName">  <%=ActiveName%></h1>
活动社团:
<div id="ActiveClubNo"> <%=ActiveClubNo%></div>
活动时间:
<div id="ActiveTime"><%=ActiveTime%> </div>
活动状态:
<div id="ActiveStatus"><%=ActiveStatus%> </div>
活动详情:
<div id="ActiveInfo"><%=ActiveInfo%> </div>

<form action="" method="">
    <input type="submit" value="参加活动" />
</form>
</body>
</html>
