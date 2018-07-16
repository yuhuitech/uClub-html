<%--
  Created by IntelliJ IDEA.
  User: 22847
  Date: 2018/7/12
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="model.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="Test.Test" %>
<%@ page import="static operations.commentOperation.getAllComments" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="static operations.commentOperation.getCommentUUID" %>
<%@ page import="static operations.DAO.getDateTime" %>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="static operations.commentOperation.addComment" %>
<%@ page import="static operations.commentOperation.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="static operations.DAO.getStudentName" %><%--
  Created by IntelliJ IDEA.
  User: 22847
  Date: 2018/7/11
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    response.setContentType("text/html;charset=\"utf-8\"");

    //消除接受乱码的问题
    request.setCharacterEncoding("UTF-8");
    String resource = "mybatis.xml";//mybatis资源

    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

    String articleNo  = "123456789876543";
    //获取所有评论


    Integer stuNo = (Integer)request.getSession().getAttribute("UserNo");
    String commentNo = getCommentUUID();
    String comment = request.getParameter("comment");
    Date sendTime = getDateTime();


    //获取相关评论信息
    String relatedCommentNo = request.getParameter("commentNo");


    String CommentNo = request.getParameter("relatedCommentNo");
    String relatedStuNo = getStuNo(sqlSessionFactory,CommentNo);

    if (sqlSessionFactory != null && stuNo != 0 && articleNo != "" && commentNo != "" &&
            comment != ""&&comment != null && sendTime != null&& relatedCommentNo!=""&&relatedStuNo!="") {
        int addResult = addComment(sqlSessionFactory,stuNo,articleNo,commentNo,comment,sendTime,relatedCommentNo,relatedStuNo);
        if (addResult == -1) {
            System.out.println("写入数据库失败");
        } else {
            System.out.println("写入数据库成功");
        }

    } else {
        //显示提交失败
        System.out.println("评论失败");
    }

    List<Comment> Comments = getAllComments(sqlSessionFactory,articleNo);

    session.setAttribute("Comments",Comments);
    request.setAttribute("Comments",Comments);

%>
<html>
<head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>
            Gentelella Alela! |
        </title>
        <!-- Bootstrap -->
        <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- iCheck -->
        <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
        <!-- bootstrap-progressbar -->
        <link href="vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css"
              rel="stylesheet">
        <!-- jQuery custom content scroller -->
        <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
        <style>
            .block_content { margin-top: 50px; }
            span.replyMessage {
                position: relative;
                /* margin-left: 40%; */
                float: right;
                margin-right: 2%;
            }
            div#markdownArea {
                left: -12px;
                display: contents;
            }
            .markdownContainer {
                /*margin-left: px;*/
                margin-right: 30px;
            }
        </style>
        <!-- Custom Theme Style -->
        <link href="build/css/custom.min.css" rel="stylesheet">


   <%--—————————————————————— 分割线—————————————————————————————————--%>

    <title>Article</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/foundation/5.5.3/css/foundation.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/foundation/5.5.3/js/foundation.min.js"></script>
    <script src="https://cdn.bootcss.com/foundation/5.5.3/js/vendor/modernizr.js"></script>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
        var temp;
        var temp2;
        function show_modal() {
            $('#myModal').modal('show');
            document.getElementById("commentNo").value = temp;
            document.getElementById("relatedCommentNo").value = temp2;
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
                    url:'articleDetail.jsp',
                    data:{
                        'comment':$("#comment").val(),
                        'commentNo':$("#commentNo").val(),
                        'relatedCommentNo':$("#relatedCommentNo").val()

                    },
                    method:'POST',
                    success:function (data) {
                        alert('回复成功');
                        self.location.reload();

                        //winclose();
                    }
                }
            );
            // window.location.reload();
        }

    </script>
</head>
<body class="nav-md" onload="compile();">
<div class="container body">
    <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
            <div class="left_col scroll-view">
                <div class="navbar nav_title" style="border: 0;">
                    <a href="index.html" class="site_title">
                        <i class="fa fa-paw">
                        </i>
                        <span>
                                    Gentelella Alela!
                                </span>
                    </a>
                </div>
                <div class="clearfix">
                </div>
                <!-- menu profile quick info -->
                <div class="profile clearfix">
                    <div class="profile_pic">
                        <img src="images/img.jpg" alt="..." class="img-circle profile_img">
                    </div>
                    <div class="profile_info">
                                <span>
                                    Welcome,
                                </span>
                        <h2>
                            John Doe
                        </h2>
                    </div>
                </div>
                <!-- /menu profile quick info -->
                <br />
                <!-- sidebar menu -->
                <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                    <div class="menu_section">
                        <h3>
                            通用
                        </h3>
                        <ul class="nav side-menu">
                            <li class="active">
                                <a>
                                    <i class="fa fa-home">
                                    </i>
                                    主页
                                    <span class="fa fa-chevron-down">
                                            </span>
                                </a>
                                <ul class="nav child_menu">
                                    <li>
                                        <a href="index2.html">
                                            趋势
                                        </a>
                                    </li>
                                    <li>
                                        <a href="index2.html">
                                            所有社团
                                        </a>
                                    </li>
                                    <li class="current-page">
                                        <a>
                                            文字
                                            <span class="fa fa-chevron-down">
                                                    </span>
                                        </a>
                                        <ul class="nav child_menu">
                                            <li class="sub_menu">
                                                <a href="plaza.html">
                                                    广场
                                                </a>
                                            </li>
                                            <li>
                                                <a href="plaza.html">
                                                    良品
                                                </a>
                                            </li>
                                            <li>
                                                <a href="plaza.html">
                                                    美食
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a>
                                    <i class="fa fa-edit">
                                    </i>
                                    申请
                                    <span class="fa fa-chevron-down">
                                            </span>
                                </a>
                                <ul class="nav child_menu">
                                    <li>
                                        <a href="form.html">
                                            申请创建社团
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a>
                                    <i class="fa fa-desktop">
                                    </i>
                                    社团中心
                                    <span class="fa fa-chevron-down">
                                            </span>
                                </a>
                                <ul class="nav child_menu">
                                    <li>
                                        <a href="my_group.html">
                                            加入的社团
                                        </a>
                                    </li>
                                    <li>
                                        <a href="inbox.html">
                                            收到的消息
                                        </a>
                                    </li>
                                    <li>
                                        <a href="calendar.jsp">
                                            活动日历
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a>
                                    <i class="fa fa-user">
                                    </i>
                                    我
                                    <span class="fa fa-chevron-down">
                                            </span>
                                </a>
                                <ul class="nav child_menu">
                                    <li>
                                        <a href="profile.html">
                                            我的简历
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- /sidebar menu -->
                <!-- /menu footer buttons -->
                <div class="sidebar-footer hidden-small">
                    <a data-toggle="tooltip" data-placement="top" title="Settings">
                                <span class="glyphicon glyphicon-cog" aria-hidden="true">
                                </span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true">
                                </span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="Lock">
                                <span class="glyphicon glyphicon-eye-close" aria-hidden="true">
                                </span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
                                <span class="glyphicon glyphicon-off" aria-hidden="true">
                                </span>
                    </a>
                </div>
                <!-- /menu footer buttons -->
            </div>
        </div>
        <!-- top navigation -->
        <div class="top_nav">
            <div class="nav_menu" id="pageSize">
                <nav>
                    <div class="nav toggle">
                        <a id="menu_toggle">
                            <i class="fa fa-bars">
                            </i>
                        </a>
                    </div>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="" id="miniMenu">
                            <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown"
                               aria-expanded="false">
                                <img src="images/img.jpg" alt="">
                                John Doe
                                <span class=" fa fa-angle-down">
                                        </span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu pull-right">
                                <li>
                                    <a href="javascript:;">
                                        Profile
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                                <span class="badge bg-red pull-right">
                                                    50%
                                                </span>
                                        <span>
                                                    Settings
                                                </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        Help
                                    </a>
                                </li>
                                <li>
                                    <a href="login.html">
                                        <i class="fa fa-sign-out pull-right">
                                        </i>
                                        Log Out
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li role="presentation" class="dropdown" id="messageDropDown">
                            <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown"
                               aria-expanded="false">
                                <i class="fa fa-envelope-o">
                                </i>
                                <span class="badge bg-green">
                                            6
                                        </span>
                            </a>
                            <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                                <li>
                                    <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                        <span>
                                                    <span>
                                                        John Smith
                                                    </span>
                                                    <span class="time">
                                                        3 mins ago
                                                    </span>
                                                </span>
                                        <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were
                                                    where...
                                                </span>
                                    </a>
                                </li>
                                <li>
                                    <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                        <span>
                                                    <span>
                                                        John Smith
                                                    </span>
                                                    <span class="time">
                                                        3 mins ago
                                                    </span>
                                                </span>
                                        <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were
                                                    where...
                                                </span>
                                    </a>
                                </li>
                                <li>
                                    <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                        <span>
                                                    <span>
                                                        John Smith
                                                    </span>
                                                    <span class="time">
                                                        3 mins ago
                                                    </span>
                                                </span>
                                        <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were
                                                    where...
                                                </span>
                                    </a>
                                </li>
                                <li>
                                    <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                        <span>
                                                    <span>
                                                        John Smith
                                                    </span>
                                                    <span class="time">
                                                        3 mins ago
                                                    </span>
                                                </span>
                                        <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were
                                                    where...
                                </span>
                                </a>
                                </li>
                                <li>
                                    <div class="text-center">
                                        <a>
                                            <strong>
                                                See All Alerts
                                            </strong>
                                            <i class="fa fa-angle-right">
                                            </i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <!-- /top navigation -->
        <!-- page content -->
        <div class="right_col" role="main">
            <div class="">
                <div class="page-title">
                    <div class="title_left">
                        <h2>
                            文章详情
                        </h2>
                    </div>
                </div>
                <div class="title_right">
                    <div class="col-md-4 col-sm-4 col-xs-12 form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" id="searchInfo" class="form-control" placeholder="去看看别的文章吧～">
                            <span class="input-group-btn">
                                        <button class="btn btn-default" onclick="searchSentence=$('#searchInfo').val();goToPageOption(1);"
                                                type="button">
                                            Go!
                                        </button>
                                    </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title" >
                            <div id="article_head" style="display: inline-grid;">

                            </div>
                            <br>
                            <h2 style="position:absolute;">via <span>江疏影</span></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="#">Settings 1</a>
                                        </li>
                                        <li><a href="#">Settings 2</a>
                                        </li>
                                    </ul>
                                </li>

                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="clearfix"></div>
                            <div class="markdownContainer">
                                <div class="col-md-12" id="markdownArea">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>跟帖</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="#">Settings 1</a>
                                        </li>
                                        <li><a href="#">Settings 2</a>
                                        </li>
                                    </ul>
                                </li>

                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <ul class="list-unstyled msg_list">

<%--分割线--%>
                                <form align="center" action="articleDetail.jsp" method="post">
                                    <div align="center" >
                                        <label align="left" >我也说两句..</label><br>
                                        <textarea style="width: 600px ; height: 100px" type="text" name="comment"></textarea>
                                        <br>
                                        <label align="center" >
                                            <div class="button_container" align="center" >
                                                <input type="submit" class="button" value="发送" />
                                            </div>
                                        </label>
                                    </div>
                                </form>
    <%--分割线--%>
    <%! int count=0; %>
    <c:forEach items="${Comments}" var="keyword" varStatus="id">
        <%
            String formatDate = null;
            //格式 24小时制：2016-07-06 09:39:58
            DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
            formatDate = dFormat.format( Comments.get(count).getSendTime());

            session.setAttribute("formatDate",formatDate);
            request.setAttribute("formatDate",formatDate);

            int stuId = Comments.get(count).getStuNo();

            String getStuName = getStudentName(sqlSessionFactory,stuId);

            session.setAttribute("getStuName",getStuName);
            request.setAttribute("getStuName",getStuName);

        %>
        <li>
            <a>
                <span class="time">
                    <p style="color: black"><c:out value="${getStuName}"/> <c:out value="${formatDate}"/></p>
        </span>
        </span>
        <div class="clearfix"></div>
        <span class="message">
         <h4 align="left"><c:out value="${keyword.comment}"/></h4>
              <form action="articleDetail.jsp?commentNo=${keyword.commentNo}?relatedCommentNo=${keyword.relatedCommentNo}" enctype = "multipart/form-data" method="post" autocomplete="off">
                 <label style="font-size: 10px;color: #987cb9 " id="btn_edit" type="text"  onclick="temp = '${keyword.commentNo}';temp2 = '${keyword.relatedCommentNo}';show_modal();" >回复</label>
            </form>
        </span>
        <span class="replyMessage" >
                </span>
        </a>
        </li>

        <%
            List<Comment> Reply = getAllReply(sqlSessionFactory,Comments.get(count).getCommentNo());
            session.setAttribute("Reply",Reply);
            request.setAttribute("Reply",Reply);
            count++;
        %>
        <%! int n=0;%>
        <c:forEach items="${Reply}" var="keyword" varStatus="id">

            <%
                String formatTime = null;
                //格式 24小时制：2016-07-06 09:39:58
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                formatTime = dateFormat.format( Reply.get(n).getSendTime());

                session.setAttribute("formatTime",formatTime);
                request.setAttribute("formatTime",formatTime);


                int stuID1 = Reply.get(n).getStuNo();
                String stuID2 = Reply.get(n).getRelatedStuNo();
                String getName1 = getStudentName(sqlSessionFactory,stuID1);
                String getName2="";
                if (stuID2!=null) {
                    getName2= getStudentName(sqlSessionFactory, Integer.parseInt(stuID2));
                }
                session.setAttribute("getName1",getName1);
                request.setAttribute("getName1",getName1);

                session.setAttribute("getName2",getName2);
                request.setAttribute("getName2",getName2);
            %>
    <li>
        <a>

            <span class="time" >
                <p style="color: black"><c:out value="${formatTime}"/>
                </p>
            </span>
            </span>
            <div class="clearfix">
            <span class="message">
                <div style="color: black">
                        </div>
            <span style="color: black"> <p style="font-size: 14px;color: black" align="left"><c:out value="——"/><c:out value="${getName1}"/>回复<c:out value="${getName2}"/>:<c:out value="${keyword.comment}"/></span>
            <form action="articleDetail.jsp?commentNo=${keyword.commentNo}?relatedCommentNo=${keyword.relatedCommentNo}" enctype = "multipart/form-data" method="post" autocomplete="off">
                 <label style="font-size: 10px;color: #987cb9 " id="btn_edit" type="text" onclick="temp = '${keyword.relatedCommentNo}';temp2 = '${keyword.commentNo}';show_modal();" >回复</label>
             </form>

            </span>
                        </div>
                <span class="replyMessage" >

              </span>
        </a>
    </li>
            <%n++;%>
        </c:forEach>
        <%n=0;%>
    </c:forEach>
    <%
        count=0;
    %>
                            </ul>
                        </div>
                    </div>
                </div>


            </div>
<%--这里是showModal弹出框--%>
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <form action="comment.jsp"method="post" enctype = "multipart/form-data" id="editForm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">回复</h4>
                            </div>
                            <div class="modal-body">
                                <label  class="form-group" for="comment"></label>
                                <input type="text" style="width: 550px;height: 110px" contenteditable="true" class="form-control" id="comment" name="comment" placeholder="请输入回复">
                                <input type="hidden"  class="form-control" id="commentNo" name="commentNo">
                                <input type="hidden"  class="form-control" id="relatedCommentNo" name="relatedCommentNo" >
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="reset"  class="btn btn-default" ><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 重置</button>
                            <button type="button" id="btn_submit"  onclick="test()" class="btn btn-primary" ><span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> 发送</button>
                        </div>
                    </form>
                </div>
            </div>



            <div class="clearfix">
            </div>
        </div>
        <!-- /page content -->
        <!-- footer content -->
        <footer>
            <div class="pull-right">
                Copyright © UClub All Rights Reserved
            </div>
            <div class="clearfix">
            </div>
        </footer>
        <!-- /footer content -->
    </div>
</div>
<div id="custom_notifications" class="custom-notifications dsp_none">
    <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
    </ul>
    <div class="clearfix">
    </div>
    <div id="notif-group" class="tabbed_notifications">
    </div>
</div>
<!-- jQuery -->
<script src="vendors/jquery/dist/jquery.min.js">
</script>
<!-- Bootstrap -->
<script src="vendors/bootstrap/dist/js/bootstrap.min.js">
</script>
<!-- FastClick -->
<script src="vendors/fastclick/lib/fastclick.js">
</script>
<!-- NProgress -->
<script src="vendors/nprogress/nprogress.js">
</script>
<!-- bootstrap-progressbar -->
<script src="vendors/bootstrap-progressbar/bootstrap-progressbar.min.js">
</script>
<!-- iCheck -->
<script src="vendors/iCheck/icheck.min.js">
</script>
<!-- Custom Theme Scripts -->
<script src="build/js/custom.min.js">
</script>
</body>
</html>
<script src="mobile.js"></script>