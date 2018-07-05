<%@ page import="model.Club" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.DAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.util.EnumMap" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String resource = "mybatis.xml";

    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
    List<Club> adminClubs = DAO.getStudentClubs(sqlSessionFactory,580148,"社长");
    List<Club> joinClubs = DAO.getStudentClubs(sqlSessionFactory,580148,"成员");

%>
<html>
<head>
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
<form method = "post" action = "/ClubInfo">
<ul>
    <%
        if(member_status == 0)
        {
        for ( Club club:joinClubs){
    %>
    <li>
            <% out.println(club.getClubName());%>
             <button name ="Club_id" type = "submit" value = <%= club.getClubNo()%>> 查看 </button>
        <%}
        }
        else
            {
                  for ( Club club:adminClubs){
    %>
    <li>
            <% out.println(club.getClubName());%>
        <button name ="Club_id" type = "submit" value = <%= club.getClubNo()%>> 管理 </button>
            <%}
        }



%>

</ul>
</form>
</body>
</html>