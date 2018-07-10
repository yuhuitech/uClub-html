<%@ page import="servlet.DAO" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="model.Club" %>
<%@ page import="Test.Test" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Activity" %>
<%@ page import="servlet.ClubDetail" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/5
  Time: 10:59
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
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
    List<Activity> activities= ClubDetail.getClubActivities(sqlSessionFactory,ClubNo);
    List<HashMap> join_apply=DAO.getJoinClubApply(sqlSessionFactory,ClubNo);
    List<HashMap> leave_apply=DAO.getLeaveClubApply(sqlSessionFactory,ClubNo);
%>

<script>
    var temp=0;
    function getInfo(StuNo,ClubNo,Action) {
        $.ajax({
            type:'POST',
            url:"/passJoinApply",
            data:{
                "StuNo":StuNo,
                "ClubNo":ClubNo,
                "Action":Action,
            },
            success:function() {
                window.location.href = "/jsp/ClubInfo.jsp?ClubNo="+ClubNo;
            }});
    }

    function getLeaveInfo(StuNo,ClubNo,Action) {
        $.ajax({
            type:'POST',
            url:"/passLeaveApply",
            data:{
                "StuNo":StuNo,
                "ClubNo":ClubNo,
                "Action":Action,
            },
            success:function() {
                window.location.href = "/jsp/ClubInfo.jsp?ClubNo="+ClubNo;
            }});
    }



    function sendPriceApply(price,Reason,ClubNo) {
        $.ajax({
            type:'POST',
            url:"/priceApply",
            data:{
                "ActivityNo":temp,
                "price":price,
                "Reason":Reason,
            },
            success:function() {
                window.location.href = "/jsp/ClubInfo.jsp?ClubNo="+ClubNo;
            }});

    }

    function delClub(ClubNo,Reason) {
        if(delcfm()==false) return;

        $.ajax({
            type:'POST',
            url:"/dissolveClub",
            data:{
                "ClubNo":ClubNo,
                "Reason":Reason,
            },
            success:function() {
                window.location.href = "/jsp/UserHome.jsp";
            }});

    }

    function notice(ClubNo,Notice) {
        if(delcfm()==false) return;

        $.ajax({
            type:'POST',
            url:"/sendNotice",
            data:{
                "ClubNo":ClubNo,
                "Notice":Notice,
            },
            success:function() {
                window.location.href = "/jsp/ClubInfo.jsp?ClubNo="+ClubNo;
            }});

    }

    function recruit(ClubNo,Introduction,recruit_text) {
        if(delcfm()==false) return;
        $.ajax({
            type:'POST',
            url:"/sendRecruit",
            data:{
                "ClubNo":ClubNo,
                "Introduction":Introduction,
                "recruit_text":recruit_text,
            },
            success:function() {
                window.location.href = "/jsp/ClubInfo.jsp?ClubNo="+ClubNo;
            }});
    }

    function delcfm() {
        if (!confirm("确认发送？")) {
            window.event.returnValue = false;
        }
    }
    function display(ANo) {
        temp=ANo;
        document.getElementById("priceApply").style.display="";
    }

    function display2(id) {
        document.getElementById(id).style.display="";
    }

    function display3(n) {
        if(n==1) {
            document.getElementById("hiddenAct").style.display = "";
            document.getElementById("hiddenActivity").value="隐藏已关闭活动";
            document.getElementById("hiddenActivity").setAttribute("onclick","display3(0)");
        }
        else {
            document.getElementById("hiddenAct").style.display = "none";
            document.getElementById("hiddenActivity").value="显示已关闭活动";
            document.getElementById("hiddenActivity").setAttribute("onclick","display3(1)");
        }
    }

</script>


<form method = "post" action = "/ClubInfoChange">
    <%out.println(club.getClubName());%><br/><br/>
    <%out.println(club.getType());%><br/><br/>
    <input type = "text" name = "Club_info" value = <%= club.getClubInfo()%>><br/><br/>
    <button name="Club_id" type="submit" value = <%= club.getClubNo()%>>提交更改</button>
</form>


<br>
<form action="/changeActiveStatus" method="post">
    <%
        for (Activity act:activities
             ) {
            if(act.getStatus().equals("已关闭"))continue;
            out.print("<div>"+act.getActive_name()+"("+act.getStatus()+") </div>");
            out.print("<input name=\"ClubNo\" type=\"hidden\" value=\""+ClubNo+"\" />");
            out.print("<br>");
            out.print("<select id=\"ActiveStatus\" name=\"ActiveStatus"+act.getActiveNo()+"\"  value=\"${Status}\">");
            out.print("    <option value=\"未进行\" >未进行</option>");
            out.print("    <option value=\"正在进行\">正在进行</option>");
            out.print("    <option value=\"已关闭\">已关闭</option>");
            out.print("    <option value=\"已结束\">已结束</option>");
            out.print("</select>");
            out.print("<button name=\"ChangeActiveStatus\" type=\"submit\" value=\""+act.getActiveNo()+"\" >修改活动状态</button>");
            out.print("<input type=\"button\" value=\"申请经费\" onclick=\"display("+act.getActiveNo()+")\">");
        }
    %>

</form>

<br>
<form id="hiddenAct" style="display:none" action="" method="post">
    <%
        for (Activity act:activities
                ) {
            if(act.getStatus().equals("已关闭")) {
                out.print("<div>" + act.getActive_name() + "(" + act.getStatus() + ") </div>");
                out.print("<input name=\"ClubNo\" type=\"hidden\" value=\"" + ClubNo + "\" />");
                out.print("<br>");
                out.print("<select id=\"ActiveStatus\" name=\"ActiveStatus" + act.getActiveNo() + "\"  value=\"${Status}\">");
                out.print("    <option value=\"未进行\" >未进行</option>");
                out.print("    <option value=\"正在进行\">正在进行</option>");
                out.print("    <option value=\"已关闭\">已关闭</option>");
                out.print("    <option value=\"已结束\">已结束</option>");
                out.print("</select>");
                out.print("<button name=\"ChangeActiveStatus\" type=\"submit\" value=\"" + act.getActiveNo() + "\" >修改活动状态</button>");
                out.print("<input type=\"button\" value=\"申请经费\" onclick=\"display(" + act.getActiveNo() + ")\">");
            }
        }
    %>
</form>

<input type="button" id="hiddenActivity" value="显示已关闭活动" onclick="display3(1)">



<form id="priceApply" style="display:none" action="" method="post">
    <div>费用:</div>
    <input type="text" id="price" />
    <div>说明:</div>
    <input type="text" id="reason" />
    <br>
    <input type="button" value="提交" onclick="sendPriceApply(document.getElementById('price').value,document.getElementById('reason').value,<%=ClubNo%>)">
</form>



<form method = "post" action = "/ActCreate">
    <button name="Act_Create_Club" type="submit" value = <%= club.getClubNo()%>>创建活动</button>
</form>


<br>
<a href="http://hall.future.org.cn/" > 场地申请</a>
<br>
<br>
<div>申请加入社团列表:</div>
    <table border="1" id="table1">
        <tr>
            <th>学号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>学院</th>
            <th>年级</th>
            <th>电话</th>
            <th>邮箱</th>
            <th>简介</th>
            <th>申请原因</th>
            <th></th>
            <th></th>
        </tr>

    <%
        for (HashMap map:join_apply
                ) {
            out.print("<tr>");
            out.print("<td>"+map.get("StuNo")+"</td>");
            out.print("<td>"+map.get("StuName")+"</td>");
            out.print("<td>"+map.get("Sex")+"</td>");
            out.print("<td>"+map.get("college")+"</td>");
            out.print("<td>"+map.get("grade")+"</td>");
            out.print("<td>"+map.get("Tel")+"</td>");
            out.print("<td>"+map.get("Email")+"</td>");
            out.print("<td>"+map.get("self_introduce")+"</td>");
            out.print("<td>"+map.get("JoinReason")+"</td>");
            out.print("<td><input type=\"button\" value=\"通过\" onclick=\"getInfo("+map.get("StuNo")+","+ClubNo+",\'pass\')\"></button></td>");
            out.print("<td><input type=\"button\" value=\"移除\" onclick=\"getInfo("+map.get("StuNo")+","+ClubNo+",\'remove\')\"></button></td>");
            out.print("</tr>");

        }
    %>
    </table>

<div>申请退出社团列表:</div>
<table border="1" id="table2">
    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>学院</th>
        <th>年级</th>
        <th>电话</th>
        <th>邮箱</th>
        <th>简介</th>
        <th>退出原因</th>
        <th></th>
        <th></th>
    </tr>

    <%
        for (HashMap map:leave_apply
                ) {
            out.print("<tr>");
            out.print("<td>"+map.get("StuNo")+"</td>");
            out.print("<td>"+map.get("StuName")+"</td>");
            out.print("<td>"+map.get("Sex")+"</td>");
            out.print("<td>"+map.get("college")+"</td>");
            out.print("<td>"+map.get("grade")+"</td>");
            out.print("<td>"+map.get("Tel")+"</td>");
            out.print("<td>"+map.get("Email")+"</td>");
            out.print("<td>"+map.get("self_introduce")+"</td>");
            out.print("<td>"+map.get("Reason")+"</td>");
            out.print("<td><input type=\"button\" value=\"通过\" onclick=\"getLeaveInfo("+map.get("StuNo")+","+ClubNo+",\'del\')\"></button></td>");
            out.print("<td><input type=\"button\" value=\"移除\" onclick=\"getLeaveInfo("+map.get("StuNo")+","+ClubNo+",\'remove\')\"></button></td>");
            out.print("</tr>");
        }
    %>
</table>


<input type = "button" value = "查看和管理所有成员" onclick = "window.location.href = '/jsp/manageMember.jsp?ClubNo='+<%=ClubNo%>" />

<br>
<br>
<input type="button" value="解散社团" onclick="display2('dissolveApply')"/>
<form id="dissolveApply" style="display:none" action="" method="post">
    <div>社团名称:</div>
    <%=club.getClubName() %>
    <div>申请解散社团说明:</div>
    <input type="text" id="dissolveReason" />
    <br>
    <input type="button" value="提交" onclick="delClub(<%=ClubNo%>,document.getElementById('dissolveReason').value)">
</form>


<br>
<br>
<input type="button" value="发送社团公告" onclick="display2('notice')"/>
<form id="notice" style="display:none" action="" method="post">
    <div>公告内容:</div>
    <input type="text" id="noticeText" />
    <br>
    <input type="button" value="提交" onclick="notice(<%=ClubNo%>,document.getElementById('noticeText').value)">
</form>

<br>
<br>
<input type="button" value="发布招新信息" onclick="display2('recruit')"/>
<form id="recruit" style="display:none" action="" method="post">
    <div>社团简介:</div>
    <input type="text" id="introduction" />
    <div>招募文本:</div>
    <input type="text" id="recruitText" />
    <br>
    <input type="button" value="提交" onclick="recruit(<%=ClubNo%>,document.getElementById('introduction').value,document.getElementById('recruitText').value)">
</form>


</body>
</html>
