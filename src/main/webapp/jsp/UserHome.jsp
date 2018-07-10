<%@ page import="model.Club" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.DAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.util.EnumMap" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="operations.ClubOperations" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String resource = "mybatis.xml";

    Integer UserId = (Integer)request.getSession().getAttribute("UserNo");
    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
  //  List<Club> adminClubs = DAO.getStudentClubs(sqlSessionFactory,UserId,"社长");
    List<Club> adminClubs=ClubOperations.getAllJoinClubs(sqlSessionFactory,UserId);
    List<Club> joinClubs = DAO.getStudentClubs(sqlSessionFactory,UserId,"成员");
    adminClubs.removeAll(joinClubs);
%>
<html>
<head>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <title>myhome</title>
    <script>

    function changeClub(status){
    var form = document.createElement("form");
    form.action = '/jsp/UserHome.jsp';
    form.method = "get";
    form.style.display = "none";

    var member_status = document.createElement("textarea");
    member_status.name = 'member_status';
    member_status.value = status;
    form.appendChild(member_status);

    document.body.appendChild(form);
    form.submit();
    }

    function getClubNo(ClubNo) {
            window.location.href="/clubDetail?ClubNo="+ClubNo;
            document.getElementsByName("form1").submit();
        }

    </script>
<body>
<h1>
    Welcome! Jack
</h1>
<h2>
    <%
        int member_status = 0; //默认为0，查看自己仅仅加入的社团
        if(request.getParameter("member_status") != null){
            member_status = Integer.parseInt(request.getParameter("member_status"));
        }

            out.println("<input class = 'member_status' type='button' id = 'statusBtn' onclick = 'changeClub(0)' value = '查看加入的社团'/>");
            out.println("<input class = 'book_status' type='button' id = 'statusBtn' onclick = 'changeClub(1)' value = '查看管理的社团'/>");

    %>
</h2>

<ul>
    <%
        if(member_status == 0)
        {
        for ( Club club:joinClubs){
    %>

            <% //社团解散则不显示
               int temp=ClubOperations.getstatus(sqlSessionFactory,club.getClubNo());
               if(temp==0)continue;%>
               <li>
              <% out.println(club.getClubName());%>
                <form method = "post" action = "/clubDetail" name="form1" >
                <input type = "button" value="查看" onclick="getClubNo(<%=club.getClubNo()%>)" >  </input>
                </form>
        <%}
        }
        else
            {
                  for ( Club club:adminClubs){
    %>

            <%   int temp=ClubOperations.getstatus(sqlSessionFactory,club.getClubNo());
                 if(temp==0)continue;%>
                 <li>
               <%  out.println(club.getClubName());%>
                <form method = "post" action = "/ClubInfo">
                <button name ="Club_id" type = "submit" value = <%= club.getClubNo()%>> 管理 </button>
                </form>
            <%}
        }



%>


</ul>
    <form method = "post" action = "/ClubCreate">
        <button name ="userNo" type = "submit" value = <%= UserId %>> 创建社团 </button>
    </form>


</body>
</html>