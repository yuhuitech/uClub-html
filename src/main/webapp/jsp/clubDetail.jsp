<%@ page import="java.util.List" %>
<%@ page import="model.Activity" %>
<%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/4
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    Integer ClubNo = (Integer) request.getAttribute("ClubNo");
    Integer UserNo= (Integer) session.getAttribute("UserNo");
    String clubName= (String) request.getAttribute("ClubName");
    String clubInfo= (String) request.getAttribute("ClubInfo");
    String clubType= (String) request.getAttribute("ClubType");
    List<Activity> clubAct= (List<Activity>) request.getAttribute("activities");
%>
<head>
    <title>Details of club</title>
</head>

<body>


<img name="ClubImg" src="" />
社团名称:
<h1 id="ClubName">  <%=clubName%></h1>
社团简介:
<div id="ClubInfo"> <%=clubInfo%></div>
社团类型:
<div id="ClubType"><%=clubType%> </div>
活动列表：

<script type="text/javascript">
    function getActiveNo(activeNo) {
        window.location.href="/activeDetail?activeNo="+activeNo;
        document.getElementsByName("form1").submit();
    }

    function getClubNo(ClubNo) {
        window.location.href="/joinClubApply?ClubNo="+ClubNo+"&act=join";
        document.getElementsByName("form2").submit();
    }

    function getClubNo2(ClubNo) {
        window.location.href="/joinClubApply?ClubNo="+ClubNo+"&act=leave";
        document.getElementsByName("form3").submit();
    }
</script>
<form name='form1' action="/activeDetail" method="post">

<%
    for(Activity act : clubAct){
        out.print("<br>");
        out.print("<div>"+act.getActive_name()+" </div>");
        out.print("<input type=\"button\" name=\"ActiveNo\" value=\"点击查看\" onclick=\"getActiveNo("+act.getActiveNo()+")\"/>");
        out.print("<br>");
    }
%>

</form>

<br>

<form name="form2" action="/joinClubApply" method="get">
<%
    out.print("<input type=\"button\" name=\"ClubNo\" value=\"申请加入\" onclick=\"getClubNo("+ClubNo+")\"/>");
%>
</form>
<br>

<form name="form3" action="/joinClubApply" method="post">
    <%
        out.print("<input type=\"button\" name=\"\" value=\"申请退社\" onclick=\"getClubNo2("+ClubNo+")\"/>");
    %>
</form>

</body>
</html>
