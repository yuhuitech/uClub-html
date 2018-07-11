<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2018/7/6
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="model.Club" %>
<%@ page import="java.util.List" %>
<%@ page import="operations.ClubOperations" %>
<%@ page import="Dao.ClubDAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.util.EnumMap" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.lang.String" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String resource = "mybatis.xml";

    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
    List<Club> Clubs = ClubOperations.getClubsALL(sqlSessionFactory);

        String status = request.getParameter("status");
       if (status!=null) {
           String test = request.getParameter("clubName");
           System.out.println(test);
            int id = Integer.parseInt(request.getParameter("clubNo"));
            String name = request.getParameter("clubName");
            String tag = request.getParameter("type");
            String info = request.getParameter("clubInfo");
            int statuscode = 100;
            switch(status){
                case "2":
                    statuscode = ClubOperations.deleteClub(sqlSessionFactory,id);
                    Clubs = ClubOperations.getClubsALL(sqlSessionFactory);
                    break;
                case "1":
                    statuscode = ClubOperations.upadteClub(sqlSessionFactory,id,name,tag,info);
                    Clubs = ClubOperations.getClubsALL(sqlSessionFactory);
                    break;

            }
            status = null;
           //RequestDispatcher requestDispatcher = request.getRequestDispatcher("manageClub.jsp");
            //requestDispatcher.forward(request, response);
        }


    session.setAttribute("Clubs",Clubs);
    request.setAttribute("Clubs",Clubs);


%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="pragma"content="no-cache">

    <meta http-equiv ="cache-control"content="no-cache">

    <meta http-equiv="expires"content="0">
    <title>ManageClub</title>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>





        var temp;
        function show_modal() {
            $('#myModal').modal('show');
            document.getElementById("clubNo").value = temp;
        }
        function load(){ search();}

        function winclose(){

            window.opener.location.reload();
        }

        $(function() {
            $('#tab').bootstrapTable({
                locale:'zh-CN',//中文支持
                // queryParams:queryParams,//请求服务器时所传的参数
                sidePagination:'server',//指定服务器端分页
                pagination: true,//是否开启分页（*）
                pageNumber:1,//初始化加载第一页，默认第一页
                pageSize:3,//单页记录数
                pageList:[1,3,5]//分页步进值
            });
        });

        function queryParams(params){
            return{
                page:params.offset/params.limit+1,//第几页
                rows: params.limit,//每页多少条
                title:$('#title').val()
            }
        }

        function search(){
            $('#tab').bootstrapTable('refresh', {url: 'listContent',pageNumber:1,pageSize:3});
        }

        function test() {
            $.ajax(
                {
                    url:'manageClub.jsp',
                    data:{
                        'status':1,
                        'clubNo':$("#clubNo").val(),
                        'clubName':$("#clubName").val(),
                        'type':$("#type").val(),
                        'clubInfo':$("#clubInfo").val()
                    },
                    method:'POST',
                    success:function (data) {
                        alert('attention');
                        self.location.reload();

                        //winclose();
                    }
                }
            );
           // window.location.reload();
        }
    </script>
</head>
<body>
<h1>管理社团</h1>
<div id="container" class="col-sm-offset-2 col-md-8">
    <table id="tab" class="table table-hover">
        <caption class="center table-header">社团表</caption>
        <thead>
        <tr class="success">
            <th>社团名</th>
            <th>社团类型</th>
            <th>社团信息</th>
            <th>操作</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${Clubs}" var="keyword" varStatus="id">
            <tr class="warning">
                <td><c:out value="${keyword.clubName}"/></td>
                <td><c:out value="${keyword.type}"/></td>
                <td><c:out value="${keyword.clubInfo}"/></td>
                <td>
                    <form action="manageClub.jsp?clubNo=${keyword.clubNo}&status=2" enctype = "multipart/form-data" method="post" autocomplete="off">
                        <button id="btn_edit" type="button" class="btn btn-primary" onclick="temp = '${keyword.clubNo}';show_modal();" >修改</button>
                        <button type="submit" class="btn btn-primary"  onclick="winclose();">删除</button>

                    </form>
                <td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <form action="manageClub.jsp?status=1" method="post" enctype = "multipart/form-data" id="editForm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">修改记录</h4>
                    </div>
                    <div class="modal-body">
                        <label  class="form-group" for="clubNo">clubNo:</label>
                        <div>
                            <input type="text" contenteditable="false" class="form-control" id="clubNo" name="clubNo" placeholder="请输入社团号">
                        </div>
                        <label class="form-group" for="clubName">clubName:</label>
                        <div>
                            <input type="text" class="form-control"  id="clubName" name="clubName" placeholder="请输入社团名">
                        </div>
                        <label class="form-group" for="type">type:</label>
                        <div>
                            <input type="text" class="form-control"  id="type" name="type" placeholder="请输入社团类型">
                        </div>
                        <label class="form-group" for="clubInfo">clubInfo:</label>
                        <div>
                            <input type="text" class="form-control" id="clubInfo"  name="clubInfo" placeholder="请输入社团信息">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%--onclick="document.getElementById('editForm').submit();winclose();"--%>
                        <button type="reset"  class="btn btn-default" ><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 重置</button>
                        <button type="button" id="btn_submit" onclick="test();" class="btn btn-primary" ><span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> 修改</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>




</body>
</html>
<script>




</script>