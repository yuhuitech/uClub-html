<%@ page import="java.io.InputStream" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.DAO" %><%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/9
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <title>manageMember</title>
</head>
<body>
<%
    int ClubNo = Integer.parseInt(request.getParameter("ClubNo"));
    String resource = "mybatis.xml";
    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
    List<HashMap> members=DAO.getMembers(sqlSessionFactory,ClubNo);
%>

<script type="text/javascript">
    function getInfo(StuNo,ClubNo,Action) {
        var i=Action+StuNo;
        var Change="";
        try
        {
            Change=document.getElementById(i).value;
        }
        catch(err)
        {
            Change="";
        }

        $.ajax({
            type:'POST',
            url:"/memberManage",
            data:{
                "StuNo":StuNo,
                "ClubNo":ClubNo,
                "Action":Action,
                "Change":Change,
            },
            success:function() {
                window.location.href = "/jsp/manageMember.jsp?ClubNo="+ClubNo;
            }});

    }


</script>

<div>成员管理:</div>
<table border="1" id="table">
    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>职位</th>
        <th>部门</th>
        <th>性别</th>
        <th>学院</th>
        <th>年级</th>
        <th>电话</th>
        <th>邮箱</th>
        <th>简介</th>
        <th>加入时间</th>
        <th>退出时间</th>
        <th></th>
    </tr>
    <%
        for (HashMap map: members
                ) {
            if(map.get("leave_time")!=null) {
                continue;
            } else {
                out.print("<tr>");
                out.print("<td>"+map.get("StuNo")+"</td>");
                out.print("<td>"+map.get("StuName")+"</td>");
                out.print("<td>" + map.get("Job") + "<input type=\"text\" id=\"Job" + map.get("StuNo") + "\"><input type=\"button\" value=\"修改\" onclick=\"getInfo(" + map.get("StuNo") + "," + ClubNo + ",\'Job\')\"/></td>");
                out.print("<td>"+map.get("Department")+"<input type=\"text\" id=\"Department"+map.get("StuNo")+"\"><input type=\"button\" value=\"修改\" onclick=\"getInfo("+map.get("StuNo")+","+ClubNo+",\'Department\')\"/></td>");
                out.print("<td>"+map.get("Sex")+"</td>");
                out.print("<td>"+map.get("college")+"</td>");
                out.print("<td>"+map.get("grade")+"</td>");
                out.print("<td>"+map.get("Tel")+"</td>");
                out.print("<td>"+map.get("Email")+"</td>");
                out.print("<td>"+map.get("self_introduce")+"</td>");
                out.print("<td>"+map.get("join_time")+"</td>");
                out.print("<td>"+map.get("leave_time")+"</td>");
                out.print("<td><input type=\"button\" value=\"删除成员\" onclick=\"getInfo("+map.get("StuNo")+","+ClubNo+",\'Del\')\" /></td>");
                out.print("</tr>");
            }

        }
    %>
</table>



</body>
</html>
