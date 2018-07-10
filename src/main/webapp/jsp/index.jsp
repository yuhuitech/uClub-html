<%@ page import="java.util.HashMap" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="model.Club" %>
<%@ page import="java.util.List" %>
<%@ page import="operations.ClubOperations" %><%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/4
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
</head>
<body>

<script type="text/javascript">
    function getClubNo(ClubNo) {
        window.location.href="/clubDetail?ClubNo="+ClubNo;
        document.getElementsByName("form1").submit();
    }
</script>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) request.getServletContext().getAttribute("SqlSessionFactory");
    List<Club> clubs = ClubOperations.getClubsALL(sqlSessionFactory);
    request.setAttribute("Clubs",clubs);
%>
<form action="/clubDetail" method="post" name="form1">
<%
    for (Club club :clubs) {
        out.println("<br>");
        out.println("<br>");
        out.print("<div>"+club.getClubName()+" </div>");
        out.print(" <input type=\"button\" value=\"点击\"  onclick=\"getClubNo("+club.getClubNo()+")\" />");
        out.println("<br>");
    }
    %>

</form>
<input type = "button" value = "个人中心" onclick = "window.location.href = '/jsp/UserHome.jsp'">

</body>
</html>
