<%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/5
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Join</title>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
</head>
<body>
<h1>申请表</h1>
<%
    Integer UserNo= (Integer) session.getAttribute("UserNo");
    Integer ClubNo= (Integer) request.getAttribute("ClubNo");
    String ClubName= (String) request.getAttribute("ClubName");
%>

<script>
    function join(UserNo,ClubNo,JoinReason) {
        $.ajax({
            type:'POST',
            url:"/joinApply",
            data: {
                "UserNo":UserNo,
                "ClubNo":ClubNo,
                "JoinReason": JoinReason,
            },async:false});
        window.location.href="/clubDetail?ClubNo="+ClubNo;
    }
</script>
<form name="form1" action="/joinApply" method="post">
    <div>申请加入社团:<%=ClubName%></div>
    <div>申请原因:</div>
    <textarea id="JoinReason" name="JoinReason" rows="10" cols="30"></textarea>
    <input type="button" value="提交申请"  onclick="join(<%=UserNo%>,<%=ClubNo%>,document.getElementById('JoinReason').innerText)" />
</form>

</body>
</html>
