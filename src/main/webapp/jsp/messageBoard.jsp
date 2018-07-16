<%--
  Created by IntelliJ IDEA.
  User: 22847
  Date: 2018/7/13
  Time: 16:41
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
<%@ page import="static operations.DAO.getStudentName" %>
<%@ page import="model.MessageBoard" %>
<%@ page import="operations.DAO" %>
<%@ page import="model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    response.setContentType("text/html;charset=\"utf-8\"");
    //消除接受乱码的问题
    request.setCharacterEncoding("UTF-8");
    String resource = "mybatis.xml";//mybatis资源

    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

    //获取传入的社团号ClubNo信息
    //String clubNo  = request.getParameter("ClubNo");
    int clubNo = 8;


    Integer stuNo = (Integer)request.getSession().getAttribute("UserNo");
    String messageNo = getCommentUUID();
    String message = request.getParameter("comment");
    Date postTime = getDateTime();

    if (sqlSessionFactory != null && stuNo != 0 && clubNo != -1 && messageNo != "" &&
            message != ""&& message!=null && postTime != null) {
        int addResult = add2MessageBoard(sqlSessionFactory,stuNo,clubNo,messageNo,message,postTime);
        if (addResult == -1) {
            System.out.println("写入数据库失败");
        } else {
            System.out.println("写入数据库成功");
        }

    } else {
        //显示提交失败
        System.out.println("未写入数据库");
    }

    List<MessageBoard> Messages = getMessageBoard(sqlSessionFactory,clubNo);

    session.setAttribute("Messages",Messages);
    request.setAttribute("Messages",Messages);
    Integer StuNo= (Integer) session.getAttribute("UserNo");
    Student student=DAO.getStudentInfo(sqlSessionFactory,StuNo);

%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
      Leave Message
    </title>
    <style>
        .newStyle { margin: 0 0 0 0px; border-left: 0px solid #e8e8e8; overflow:
                visible; padding: 10px 3px; } .timeline h2.title:before { position: absolute;
                                                  left: -23px;
                                                  top: 3px;
                                                  display: block;
                                                  width: 3px;
                                                  height: 3px;
                                                  border: 3px solid #00CED1;
                                                  border-radius: 14px; }
        /*模态框在打开后,浏览器右边出现了padding的间距,下面的样式消除本间距.*/
        body {
            padding-right: 0px !important;
        }
        *.modal-open {
            overflow-y: scroll;
            padding-right: 0 !important;
        }
        .modal-dialog{

            width: 2000px;
        }
        .modal-body{
            height:500px;
            overflow:scroll;


        }
        /*.modal.in .modal-dialog{-webkit-transform:translate(0,-50%);-ms-transform:translate(0,-50%);-o-transform:translate(0,-50%);transform:translate(0,-50%)}
        .modal-dialog{position:absolute;width:auto;margin:0px auto;left:10px;right:0;top:10%}
        @media (min-width:1000px){.modal-dialog{width:600px}*/
    </style>
    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <!--<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">-->
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- jQuery custom content scroller -->
    <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css"
          rel="stylesheet" />
    <!-- Custom Theme Style -->
    <link href="build/css/custom.min.css" rel="stylesheet">
    <link href="vendors/DataTables/datatables.min.css" rel="stylesheet">
    <link href="vendors/DataTables/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/DataTables/DataTables-1.10.18/css/jquery.dataTables.css" rel="stylesheet">
    <link href="vendors/DataTables/Buttons-1.5.2/css/buttons.dataTables.min.css" rel="stylesheet">
    <link href="vendors/DataTables/Select-1.2.6/css/select.dataTables.min.css" rel="stylesheet">
    <link href="vendors/DataTables/Editor-2018-07-26-1.7.4/css/editor.dataTables.css" rel="stylesheet">


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
                    url:'messageBoard.jsp',
                    data:{
                        'comment':$("#comment").val(),

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

<body class="nav-md">
<div class="container body">
    <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
            <div class="left_col scroll-view">
                <div class="navbar nav_title" style="border: 0;">
                    <a href="index.html" class="site_title">
                        <i class="fa fa-paw">
                        </i>
                        <span>
                                    UClub!
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
                                    欢迎,
                                </span>
                        <h2>
                            <%=student.getStuName()%> 同学
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
                            <li>
                                <a>
                                    <i class="fa fa-home">
                                    </i>
                                    主页
                                    <span class="fa fa-chevron-down">
                                            </span>
                                </a>
                                <ul class="nav child_menu">
                                    <li>
                                        <a href="media_gallery.jsp">
                                            所有社团
                                        </a>
                                    </li>
                                    <li>
                                        <a href="index2.html">
                                            趋势
                                        </a>
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
                                        <a href="messageBoard.jsp">
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
                        <h3>
                            详情页面
                        </h3>
                    </div>
                </div>
                <div class="title_right">
                    <div class="col-md-4 col-sm-4 col-xs-12 form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="搜社团">
                            <span class="input-group-btn">
                                        <button class="btn btn-default" type="button">
                                            Go!
                                        </button>
                                    </span>
                        </div>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div class="row">

                    <div class="col-md-3  col-sm-3 col-xs-12">
                        <div class="col-md-15 col-sm-15 col-xs-15">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>
                                        社团名片
                                    </h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                                               aria-expanded="false">
                                                <i class="fa fa-wrench">
                                                </i>
                                            </a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li>
                                                    <a href="#">
                                                        管理成员
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        编辑活动
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        申请资金
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        申请场地
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        修改本版面信息
                                                    </a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <div class="clearfix">
                                    </div>
                                </div>
                                <div class="x_content">
                                    <div class="profile_left">
                                        <div class="profile_img">
                                            <div id="crop-avatar">
                                                <!-- Current avatar -->
                                                <img class="img-responsive avatar-view" src="images/picture.jpg" alt="Avatar"
                                                     title="Change the avatar">
                                            </div>
                                        </div>
                                        <h3>
                                            自强Studio
                                        </h3>
                                        <ul class="list-unstyled user_data">
                                            <li>
                                                <i class="fa fa-map-marker user-profile-icon">
                                                </i>
                                                武汉大学
                                            </li>
                                            <li>
                                                <i class="fa fa-briefcase user-profile-icon">
                                                </i>
                                                综合性社团
                                            </li>
                                            <li class="m-top-xs">
                                                <i class="fa fa-external-link user-profile-icon">
                                                </i>
                                                <a href="http://www.kimlabs.com/profile/" target="_blank">
                                                    访问微博首页
                                                </a>
                                            </li>
                                        </ul>
                                        <a class="btn btn-success" onclick="$('#applymentTable').modal('show');">
                                            <i class="fa fa-edit m-right-xs">
                                            </i>
                                            申请加入吧
                                        </a>
                                        <br />
                                        <!-- start skills -->
                                        <!-- end of skills -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-15 col-sm-15 col-xs-15">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>微数据</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li><a href="#">男女比</a>
                                                </li>
                                                <li><a href="#">部门人数比</a>
                                                </li>
                                                <li><a href="#">年龄比</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <canvas id="canvasDoughnut"></canvas>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-9  col-sm-9 col-xs-12">
                        <div class="col-md-15 col-sm-15 col-xs-15">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>
                                        <i>
                                        </i>
                                        社团小报
                                    </h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li>
                                            <a class="collapse-link">
                                                <i class="fa fa-chevron-up">
                                                </i>
                                            </a>
                                        </li>
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                                               aria-expanded="false">
                                                <i class="fa fa-wrench">
                                                </i>
                                            </a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li>
                                                    <a href="#" onclick="">
                                                        修改社团简介
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        管理留言
                                                    </a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <div class="clearfix">
                                    </div>
                                </div>
                                <div class="x_content">
                                    <!-- start accordion -->
                                    <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                                        <div class="panel">
                                            <a class="panel-heading" role="tab" id="headingOne" data-toggle="collapse"
                                               data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                <h4 class="panel-title">
                                                    社团简介
                                                </h4>
                                            </a>
                                            <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel"
                                                 aria-labelledby="headingOne" aria-expanded="false">
                                                <div class="panel-body">
                                                    自强Studio目前是武大规模最大，活动也很丰富的社团，热烈欢迎大家加入我们！
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel">
                                            <a class="panel-heading collapsed" role="tab" id="headingTwo" data-toggle="collapse"
                                               data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                <h4 class="panel-title">
                                                    社团文章
                                                </h4>
                                            </a>
                                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel"
                                                 aria-labelledby="headingTwo" aria-expanded="false">
                                                <div class="panel-body">
                                                    <ul class="list-unstyled timeline">
                                                        <li>
                                                            <div class="newStyle">
                                                                <div class="block_content">
                                                                    <h2 class="title">
                                                                        <a>
                                                                            Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?
                                                                        </a>
                                                                    </h2>
                                                                    <div class="byline">
                                                                            <span>
                                                                                13 hours ago
                                                                            </span>
                                                                        by
                                                                        <a>
                                                                            Jane Smith
                                                                        </a>
                                                                    </div>
                                                                    <p class="excerpt">
                                                                        Film festivals used to be do-or-die moments for movie makers. They were
                                                                        where you met the producers that could fund your project, and if the buyers
                                                                        liked your flick, they’d pay to Fast-forward and…
                                                                        <a>
                                                                            Read&nbsp;More
                                                                        </a>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="newStyle">
                                                                <div class="block_content">
                                                                    <h2 class="title">
                                                                        <a>
                                                                            Who Needs Sundance When You’ve Got Crowdfunding?
                                                                        </a>
                                                                    </h2>
                                                                    <div class="byline">
                                                                            <span>
                                                                                13 hours ago
                                                                            </span>
                                                                        by
                                                                        <a>
                                                                            Jane Smith
                                                                        </a>
                                                                    </div>
                                                                    <p class="excerpt">
                                                                        Film festivals used to be do-or-die moments for movie makers. They were
                                                                        where you met the producers that could fund your project, and if the buyers
                                                                        liked your flick, they’d pay to Fast-forward and…
                                                                        <a>
                                                                            Read&nbsp;More
                                                                        </a>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="newStyle">
                                                                <div class="block_content">
                                                                    <h2 class="title">
                                                                        <a>
                                                                            Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?
                                                                        </a>
                                                                    </h2>
                                                                    <div class="byline">
                                                                            <span>
                                                                                13 hours ago
                                                                            </span>
                                                                        by
                                                                        <a>
                                                                            Jane Smith
                                                                        </a>
                                                                    </div>
                                                                    <p class="excerpt">
                                                                        Film festivals used to be do-or-die moments for movie makers. They were
                                                                        where you met the producers that could fund your project, and if the buyers
                                                                        liked your flick, they’d pay to Fast-forward and…
                                                                        <a>
                                                                            Read&nbsp;More
                                                                        </a>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end of accordion -->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-15 col-sm-15 col-xs-15">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>留言板</h2>
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
                                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <ul class="list-unstyled msg_list">

<%! int count=0; %>
<c:forEach items="${Messages}" var="keyword" varStatus="id">
    <%
        String formatDate = null;
        //格式 24小时制：2016-07-06 09:39:58
        DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
        formatDate = dFormat.format( Messages.get(count).getPostTime());

        session.setAttribute("formatDate",formatDate);
        request.setAttribute("formatDate",formatDate);

        int stuId = Messages.get(count).getStuNo();

        String getStuName = getStudentName(sqlSessionFactory,stuId);

        session.setAttribute("getStuName",getStuName);
        request.setAttribute("getStuName",getStuName);

        count++;
    %>

    <li class="reply">
                                            <a>
                        <span class="image">
                          <img src="images/head.jpg" alt="img">
                        </span>
                                                <span>
                          <span><c:out value="${getStuName}"/> </span>
                          <span class="time"><c:out value="${formatDate}"/> </span>
                        </span>
                                                <span class="message">
                       <c:out value="${keyword.message}"/>
                        </span>
                                            </a>
                                        </li>


</c:forEach>
                                        <%
                                            count=0;
                                        %>
                                        <%--分割线--%>
                                        <form align="center" action="messageBoard.jsp" method="post">
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

                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
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


<!--
    作者：offline
    时间：2018-07-11
    描述：管理成员模态框浮动组件
-->
<!--<<!--div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"-->

<div class="modal fade bs-example-modal-lg" id="memberManageWidget" role="dialog" aria-labelledby="myLargeModalLabel" >
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" >
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改记录</h4>
            </div>
            <div class="modal-body" ]>
                <div  >
                    <table id="datatable-buttons-test" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" style="width:100%">
                        <thead>
                        <tr>
                            <th>First name</th>
                            <th>Last name</th>
                            <th>Position</th>
                            <th>Office</th>
                            <th>Age</th>
                            <th>Start date</th>
                            <th>Salary</th>
                            <th>Extn.</th>
                            <th>E-mail</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>李华</td>
                            <td>Nixon</td>
                            <td>System Architect</td>
                            <td>Edinburgh</td>
                            <td>61</td>
                            <td>2011/04/25</td>
                            <td>$320,800</td>
                            <td>5421</td>
                            <td>t.nixon@datatables.net</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>
            <div class="modal-footer">
                <button type="reset"  class="btn btn-default" ><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 重置</button>
                <button type="submit" id="btn_submit" class="btn btn-primary" ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 修改</button>
            </div>
        </div>
    </div>
</div>


<!--
    作者：offline
    时间：2018-07-11
    描述：申请加入社团的模态框
-->

<div class="modal fade" id="applymentTable" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">申请加入社团</h4>
            </div>
            <div class="modal-body">
                <label  class="form-group" for="bookID">你想要加入的部门:</label>
                <div>
                    <input type="text" contenteditable="false" class="form-control" id="bookID" name="bookID" placeholder="请输入书的ID">
                </div>
                <label class="form-group" for="title">你想要加入的部门:</label>
                <div>
                    <input type="text" class="form-control"  id="title" name="title" placeholder="请输入书名">
                </div>
                <label class="form-group" for="price">你想要加入的部门:</label>
                <div>
                    <input type="text" class="form-control"  id="price" name="price" placeholder="请输入价格">
                </div>
                <label class="form-group" for="publishDate">你加入的理由:</label>
                <div>
                    <input type="text" class="form-control" id="publishDate"  name="publishDate" placeholder="请输入出版日期">
                </div>
            </div>
            <div class="modal-footer">
                <button type="reset"  class="btn btn-default" ><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 重置</button>
                <button  class="btn btn-primary" onclick="$('#applymentTable').modal('hide');$('#memberManageWidget').modal('show').css({

                    });">提交</button>
            </div>
        </div>

    </div>
</div>


<!--
    作者：offline
    时间：2018-07-11
    描述：下面是浮动编辑组件
-->
<div class="compose col-md-6 col-xs-12" id="newMessage">
    <div class="compose-header">
        回复 添加新留言
        <button type="button" class="close compose-close" id="compose-close">
            <span>-</span>
        </button>
    </div>
    <div class="compose-body">
        <div id="alerts"></div>
        <label>回复内容</label>
        <textarea class="form-control" rows="10" placeholder="请输入回复内容，不超过200字"></textarea>
    </div>
    <div class="compose-footer">
        <button id="send" class="btn btn-sm btn-success" type="button">Send</button>
    </div>
</div>

<!-- jQuery -->
<script src="vendors/jquery/dist/jquery.min.js">

</script>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<!--<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>-->
<!-- Bootstrap -->
<script src="vendors/bootstrap/dist/js/bootstrap.min.js">
</script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<!--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->

<!-- FastClick -->
<script src="vendors/fastclick/lib/fastclick.js">
</script>
<!-- NProgress -->
<script src="vendors/nprogress/nprogress.js">
</script>
<!-- morris.js -->
<script src="vendors/raphael/raphael.min.js">
</script>
<script src="vendors/morris.js/morris.min.js">
</script>
<!-- bootstrap-progressbar -->
<script src="vendors/bootstrap-progressbar/bootstrap-progressbar.min.js">
</script>
<!-- bootstrap-daterangepicker -->
<script src="vendors/moment/min/moment.min.js">
</script>
<script src="vendors/bootstrap-daterangepicker/daterangepicker.js">
</script>
<!-- jQuery custom content scroller -->
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js">
</script>
<!-- Chart.js -->
<script src="vendors/Chart.js/dist/Chart.min.js"></script>
<!-- Custom Theme Scripts -->
<script src="build/js/custom.min.js">

</script>
<!--<script src="newjquery.js"></script>-->
<!-- Bootstrap -->
<!--<script src="vendors/bootstrap/dist/js/bootstrap.min.js">-->
<!--</script>-->
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<!--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->
<!--<!-- Datatables -->
<!--<script src="vendors/DataTables/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>-->
<!--<script src="vendors/datatables.net/js/jquery.dataTables.min.js"></script>-->
<!--<script src="vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>-->
<!--<script src="vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>-->
<!--<script src="vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>-->
<!--<script src="vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>-->
<!--<script src="vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>-->
<!--<script src="vendors/datatables.net-buttons/js/buttons.print.min.js"></script>-->
<!--<script src="vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>-->
<!--<script src="vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>-->
<!--<script src="vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>-->
<!--<script src="vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>-->
<!--<script src="vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>-->
<!--<script src="vendors/jszip/dist/jszip.min.js"></script>-->
<!--<script src="vendors/pdfmake/build/pdfmake.min.js"></script>-->
<!--<script src="vendors/pdfmake/build/vfs_fonts.js"></script>-->
<script src="vendors/DataTables/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>
<!--<script src="vendors/DataTables/DataTables-1.10.18/js/dataTables.bootstrap.min.js"></script>-->
<script src="vendors/DataTables/Buttons-1.5.2/js/dataTables.buttons.min.js"></script>
<script src="vendors/DataTables/Select-1.2.6/js/dataTables.select.min.js"></script>
<script src="vendors/DataTables/Editor-2018-07-26-1.7.4/js/dataTables.editor.min.js"></script>

</body>
</html>
<script src="mobile.js"></script>