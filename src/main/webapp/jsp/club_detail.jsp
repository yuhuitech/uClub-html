<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Test.Test" %>
<%@ page import="operations.ClubOperations" %>
<%@ page import="operations.DAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.ClubDetail" %>
<%@ page import="operations.ClubDetailOperation" %>
<%@ page import="operations.commentOperation" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<%@ page import="static operations.ArticleOperations.getArticleByClubNo" %>
<%@ page import="static operations.ManageApplyOperations.getStuName" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html lang="en">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>
            Gentelella Alela! |
        </title>
        <style>
            .hiddenCol{
                display: none;
            }
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
            span.replyMessage {
                position: relative;
                /* margin-left: 40%; */
                float: right;
                margin-right: 1%;
            }
            li.reply-message.innerMessage {
                display: flex ;
            }
            .reply-message.innerMessage {
                position: relative;
                /* margin-left: 40%; */
                float: right;
                margin-right: 2%;
            }
        </style>
        <style>
            .right_col {
                min-height:800px !important;
            }
        </style>
        <style type="text/css">
            #user-photo {
                width:300px;
                height:300px;
                margin-top: 10px;
            }
            #photo {
                max-width:100%;
                max-height:200px;
            }
            .img-preview-box {
                text-align: center;
            }
            .img-preview-box > div {
                display: inline-block;
                margin-right: 10px;
            }
            .img-preview {
                overflow: hidden;
            }
            .img-preview-box .img-preview-lg {
                width: 150px;
                height: 150px;
            }
            .img-preview-box .img-preview-md {
                width: 100px;
                height: 100px;
            }
            .img-preview-box .img-preview-sm {
                width: 50px;
                height: 50px;
                border-radius: 50%;
            }
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
         <!--Datatables -->
        <link href="vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
        <link href="vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
        <link href="vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
        <link href="vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
        <link href="vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.bootcss.com/cropper/4.0.0/cropper.css" rel="stylesheet">
        <!--<link href="vendors/DataTables/datatables.min.css" rel="stylesheet">-->
        <!--<link href="vendors/DataTables/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet">-->
        <!--<link href="vendors/DataTables/DataTables-1.10.18/css/jquery.dataTables.css" rel="stylesheet">-->
        <!--<link href="vendors/DataTables/Buttons-1.5.2/css/buttons.dataTables.min.css" rel="stylesheet">-->
        <!--<link href="vendors/DataTables/Select-1.2.6/css/select.dataTables.min.css" rel="stylesheet">-->
        <!--<link href="vendors/DataTables/Editor-2018-07-26-1.7.4/css/editor.dataTables.css" rel="stylesheet">-->
        <%
            Integer StuNo= (Integer) session.getAttribute("UserNo");
            int ClubNo= Integer.parseInt(request.getParameter("ClubNo"));
            String resource = "mybatis.xml";
            InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
            SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
            Student student=DAO.getStudentInfo(sqlSessionFactory,StuNo);
            Club club=DAO.getClubById(sqlSessionFactory,ClubNo);
            int female=DAO.getSexCount(sqlSessionFactory,ClubNo,"女");
            int male=DAO.getSexCount(sqlSessionFactory,ClubNo,"男");
            List<Activity> acts=ClubDetailOperation.getClubActivities(sqlSessionFactory,ClubNo);
            String job=DAO.getStudentJob(sqlSessionFactory,StuNo,ClubNo);
            session.setAttribute("job",job);
            List<MessageBoard> message=commentOperation.getMessageBoard(sqlSessionFactory,ClubNo);


            List<Article> clubArticle = getArticleByClubNo(sqlSessionFactory,ClubNo);

            session.setAttribute("articles",clubArticle);
            request.setAttribute("articles",clubArticle);
        %>


    </head>
    
    <body class="nav-md">
        <div class="container body">
            <div class="main_container">
                <div class="col-md-3 left_col menu_fixed">
                    <div class="left_col scroll-view">
                        <div class="navbar nav_title" style="border: 0;">
                            <a href="Recommend.jsp" style="padding-left: 2px; height: 100px;" class="site_title" style=" padding-left: 2px;"><img style="display: flex; margin-top: 15px;" src="images/logo8.png"/><span>&nbsp;</span></a>
                        </div>

                        <div class="clearfix"></div>

                        <!-- menu profile quick info -->
                        <div class="profile clearfix">
                            <div class="profile_pic">
                                <img id="userImg" src="images/<%=StuNo%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/user.png'" alt="..." class="img-circle profile_img">
                            </div>
                            <div class="profile_info">
                                <span>欢迎,</span>
                                <h2><%=student.getStuName()%> 同学</h2>
                            </div>
                        </div>
                        <!-- /menu profile quick info -->

                        <br />

                        <!-- sidebar menu -->
                        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                            <div class="menu_section">
                                <h3>通用</h3>
                                <ul class="nav side-menu">
                                    <li><a><i class="fa fa-home"></i> 主页 <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="Recommend.jsp">趋势</a></li>
                                            <li><a href="media_gallery.jsp">所有社团</a></li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-edit"></i> 广场 <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="plaza.jsp">进入广场</a></li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-edit"></i> 申请 <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="formWizards.jsp">申请创建社团</a></li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-desktop"></i> 社团中心 <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="my_group.html">加入的社团</a></li>
                                            <li><a href="messageBoard.jsp">收到的消息</a></li>
                                            <li><a href="calendar.jsp">活动日历</a></li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-user"></i> 我 <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="profile.jsp">我的简历</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <!-- /sidebar menu -->

                        <!-- /menu footer buttons -->

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
                                        <img class="originalPhoto" src="images/<%=StuNo%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/user.png'" alt="">
                                        <%=student.getStuName()%>
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
                                            <a href="../login.jsp">
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
                                        <i class="fa fa-envelope-o" style=" line-height: 32px;">
                                        </i>
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
                                                    <c:choose>
                                                        <c:when test="${job!='成员'&&job!=null}">
                                                            <li>
                                                                <a onclick="manageClubMemberEnter();">
                                                                    管理成员
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="$('#clubActivityApplyForm').modal('show');">
                                                                    申请资金
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="http://hall.future.org.cn/">
                                                                    申请场地
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="$('#changeClubInfo').modal('show');">
                                                                    修改社团信息
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="manageClubMemberApplyEnter();">
                                                                    管理申请信息
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="manageMemberExitApplyEnter();">
                                                                    管理退出申请
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="$('#dropoutTable').modal('show');">
                                                                    申请退出社团
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="$('#dissolveTable').modal('show');">
                                                                    申请解散
                                                                </a>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li>
                                                                <a onclick="$('#dropoutTable').modal('show');">
                                                                    申请退出社团
                                                                </a>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>



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
                                                    <img id="ClubImg" class="img-responsive avatar-view" src="images/<%=ClubNo%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/logo.png'" alt="Avatar"
                                                    title="Change the avatar">
                                                </div>
                                            </div>
                                            <h3 id="clubName">
                                                <%=club.getClubName()%>
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
                                                 <span id="clubType"> <%=club.getType()%></span>
                                                </li>
                                            </ul>
                                            <%
                                                int temp=DAO.isMember(sqlSessionFactory,StuNo,ClubNo);
                                                if(temp==0){
                                            %>
                                            <a class="btn btn-round btn-success" onclick="$('#applymentTable').modal('show');">
                                                <i class="fa fa-edit m-right-xs">
                                                </i>
                                                申请加入吧
                                            </a>
                                            <%
                                                }
                                            %>
                                            <br />
                                            <a class="btn btn-round btn-success">
                                                <i class="fa fa-users m-right-xs">
                                                </i>
                                                社团通讯录
                                            </a>
                                            <br />
                                            <!-- start skills -->
                                            <!-- end of skills -->

                                            <%
                                                if(temp==0)out.print("<img src=\"images/notPassed1.jpg\" style=\"    width: 33%;\n" +
                                                        "    vertical-align: middle;\n" +
                                                        "    opacity: 0.7;\n" +
                                                        "    position: absolute;\n" +
                                                        "    top: 68%;\n" +
                                                        "    left: 60%;\n" +
                                                        "    transform: rotate(-10deg);\">");
                                                else out.print("<img src=\"images/passed1.jpg\" style=\"    width: 33%;\n" +
                                                        "    vertical-align: middle;\n" +
                                                        "    opacity: 0.7;\n" +
                                                        "    position: absolute;\n" +
                                                        "    top: 68%;\n" +
                                                        "    left: 60%;\n" +
                                                        "    transform: rotate(-10deg);\">");
                                            %>

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
                                                    <div class="panel-body" id="clubInfo">
                                                        <%=club.getClubInfo()%>
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
                                                            <div id="articles">
                                                                <%
                                                                int count = 0;
                                                                for (Article article:clubArticle){
                                                                %>
                                                                <li class="innerArticle">
                                                                <div class="newStyle">
                                                                    <div class="block_content">
                                                                        <h2 class="title">
                                                                            <a>
                                                                              <%=article.getTitle()%>
                                                                            </a>
                                                                        </h2>
                                                                        <div class="byline">
                                                                            <span>
                                                                        <%
                                                                            String formatDate = null;
                                                                            //格式 24小时制：2016-07-06 09:39:58
                                                                            DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                                                                            formatDate = dFormat.format(article.getDate());
                                                                        %>
                                                                                 <%=formatDate%>
                                                                            </span>
                                                                            by
                                                                            <a>
                                                                                <%=getStuName(sqlSessionFactory,article.getStuNo())%>
                                                                            </a>
                                                                        </div>
                                                                        <p class="excerpt">
                                                                            <%String path = (String)session.getAttribute("Path");%>
                                                                            <%=article.getStandardText(path)%>
                                                                            <%
                                                                                out.print("<a href=\"articleDetail.jsp?url="+count+"\">");
                                                                                count++;
                                                                            %>
                                                                            Read&nbsp;More
                                                                            </a>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                                <%}%>

                                                            </div>
                                                        </ul>
                                                        <div class="row" id="pageDivide">
                                                            <div class="col-sm-12 col-sm-12  col-xs-12">
                                                                <div class="dataTables_paginate paging_simple_numbers" id="datatable_paginate">
                                                                    <ul class="pagination" id="choosePage">
                                                                        <li class="paginate_button previous" id="datatable_previous" onclick="articlePageDivider.goToPageOption(articlePageDivider.currentPage-1);">
                                                                            <a  aria-controls="datatable" data-dt-idx="0" tabindex="0" style="padding: 4px 5px !important;">
                                                                                <-
                                                                            </a>
                                                                        </li>
                                                                        <li id="outerPage1" class="paginate_button " onclick="articlePageDivider.goToPageOption(articlePageDivider.pageRange[0])" >
                                                                            <a id="Page1" aria-controls="datatable" data-dt-idx="1" tabindex="0" style="padding: 4px 5px !important;">
                                                                                1
                                                                            </a>
                                                                        </li>
                                                                        <li id="outerPage2" class="paginate_button " onclick="articlePageDivider.goToPageOption(articlePageDivider.pageRange[1])" >
                                                                            <a id="Page2" aria-controls="datatable" data-dt-idx="2" tabindex="0" style="padding: 4px 5px !important;">
                                                                                2
                                                                            </a>
                                                                        </li>
                                                                        <li id="outerPage3" class="paginate_button " onclick="articlePageDivider.goToPageOption(articlePageDivider.pageRange[2])" >
                                                                            <a id="Page3" aria-controls="datatable" data-dt-idx="3" tabindex="0" style="padding: 4px 5px !important;">
                                                                                3
                                                                            </a>
                                                                        </li>
                                                                        <li id="outerPage4" class="paginate_button " onclick="articlePageDivider.goToPageOption(articlePageDivider.pageRange[3])">
                                                                            <a id="Page4"  aria-controls="datatable" data-dt-idx="4" tabindex="0" style="padding: 4px 5px !important;">
                                                                                4
                                                                            </a>
                                                                        </li>
                                                                        <li id="outerPage5" class="paginate_button " onclick="articlePageDivider.goToPageOption(articlePageDivider.pageRange[4])">
                                                                            <a id="Page5"  aria-controls="datatable" data-dt-idx="5" tabindex="0" style="padding: 4px 5px !important;">
                                                                                5
                                                                            </a>
                                                                        </li>
                                                                        <li class="paginate_button next" id="datatable_next" onclick="articlePageDivider.goToPageOption(articlePageDivider.currentPage+1);">
                                                                            <a  aria-controls="datatable" data-dt-idx="7" tabindex="0" style="padding: 4px 5px !important;">
                                                                                ->
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
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
                    <li><a class="reply"><i class="fa fa-edit"></i></a>
                    </li>
                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                      <ul class="dropdown-menu" role="menu">
                        <li><a href="#">删除</a></li>
                      </ul>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div id="messagesAll">
                  <ul class="list-unstyled msg_list">

<!---                        ---->
                  <%
                      DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                      for(MessageBoard msg:message){
                  %>
                      <li class="reply-message innerMessage replyFather">
                          <a>
                                        <span class="image">
                                            <img src="images/<%=msg.getStuNo()%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/user.png'" alt="img">
                                        </span>
                              <span>
                            <span><%=DAO.getStudentName(sqlSessionFactory,msg.getStuNo())%></span>
                                  <%
                                      if(job!=null){
                                      if(!job.equals("成员")){
                                  %>
                            <span class="replyMessage">
                                <i class="removeReply fa fa-remove" id="<%=msg.getMessageNo()%>"></i>
                            </span>
                                  <%
                                      }}
                                  %>

                            <span class="time">
                               <%=sdf.format(msg.getPostTime())%>
                            </span>
                        </span>
                              <%--<div class="clearfix"></div>--%>
                              <span class="message">
                         <%=msg.getMessage()%>
                        </span>
                          </a>
                      </li>
                      <%
                          }
                      %>
<!--                    -->


                  </ul>
                    </div>
                    <div class="row" >
                        <div class="col-sm-12 col-sm-12  col-xs-12">
                            <div class="dataTables_paginate paging_simple_numbers" >
                                <ul class="pagination" >
                                    <li class="paginate_button previous"  onclick="messageDivider.goToPageOption(messageDivider.currentPage-1);">
                                        <a  aria-controls="datatable" data-dt-idx="0" tabindex="0" style="padding: 4px 5px !important;">
                                            <-
                                        </a>
                                    </li>
                                    <li id="outerMessagePage1" class="paginate_button " onclick="messageDivider.goToPageOption(messageDivider.pageRange[0])" style="display: none;">
                                        <a id="messagePage1" aria-controls="datatable" data-dt-idx="1" tabindex="0" style="padding: 4px 5px !important;">
                                            1
                                        </a>
                                    </li>
                                    <li id="outerMessagePage2" class="paginate_button " onclick="messageDivider.goToPageOption(messageDivider.pageRange[1])" style="display: none;">
                                        <a id="messagePage2" aria-controls="datatable" data-dt-idx="2" tabindex="0" style="padding: 4px 5px !important;">
                                            2
                                        </a>
                                    </li>
                                    <li id="outerMessagePage3" class="paginate_button " onclick="messageDivider.goToPageOption(messageDivider.pageRange[2])" style="display: none;">
                                        <a id="messagePage3" aria-controls="datatable" data-dt-idx="3" tabindex="0" style="padding: 4px 5px !important;">
                                            3
                                        </a>
                                    </li>
                                    <li id="outerMessagePage4" class="paginate_button " onclick="messageDivider.goToPageOption(messageDivider.pageRange[3])" style="display: none;">
                                        <a id="messagePage4"  aria-controls="datatable" data-dt-idx="4" tabindex="0" style="padding: 4px 5px !important;">
                                            4
                                        </a>
                                    </li>
                                    <li id="outerMessagePage5" class="paginate_button " onclick="messageDivider.goToPageOption(messageDivider.pageRange[4])" style="display: none;">
                                        <a id="messagePage5"  aria-controls="datatable" data-dt-idx="5" tabindex="0" style="padding: 4px 5px !important;">
                                            5
                                        </a>
                                    </li>
                                    <li class="paginate_button next" onclick="messageDivider.goToPageOption(messageDivider.currentPage+1);">
                                        <a  aria-controls="datatable" data-dt-idx="7" tabindex="0" style="padding: 4px 5px !important;">
                                            ->
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
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
                    描述：申请资金的模态框
                -->
        <div class="modal fade bs-example-modal-lg" id="clubActivityApplyForm" role="dialog" aria-labelledby="myLargeModalLabel" >
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="editDetailTitle">申请资金</h4>
                    </div>
                    <div class="modal-body" >
                        <label class="form-group" for="clubActivity">选择社团活动</label>
                        <div>
                            <select class="select2_multiple form-control" name="clubActivity" id="clubActivity" >
                                <%
                                for(Activity act:acts){
                                    out.println("<option value=\""+act.getActiveNo()+"\">"+act.getActive_name()+"</option>");
                                }
                                %>
                            </select>
                        </div>
                        <label class="form-group" for="fondAmount">申请资金</label>
                        <div>
                            <input type="text" class="form-control" id="fondAmount"  name="fondAmount" placeholder="请输入申请资金:">
                        </div>
                        <label class="form-group" for="applyForFondReason">申请理由</label>
                        <div>
                            <input type="text" class="form-control" id="applyForFondReason"  name="applyForFondReason" placeholder="请输入申请理由:">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="clubActivity_submit" class="btn btn-round btn-success" onclick="priceApply()"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 确定</button>
                    </div>
                </div>
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
                    <div class="modal-body">
                     <div  >
					   <table id="datatable-buttons-test" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                          <th></th>
                          <th>Name</th>
                          <th>Position</th>
                          <th>Office</th>
                          <th>Age</th>
                          <th>Start date</th>
                          <th>Salary</th>
                        </tr>
                      </thead>
                           <tbody>
                           <tr>
                               <td></td>
                               <td>Tiger Nixon</td>
                               <td>System Arcggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggghitecgggggggggggggggggggggggggggggggggggggghitecggggggggggggggggghitecggggggggggggggggggggggggggggghitect</td>
                               <td>Edinburgh</td>
                               <td>61</td>
                               <td>2011/04/25</td>
                               <td>$320,800</td>
                           </tr>
                           <tr>
                               <td></td>
                               <td>Garrett Winters</td>
                               <td>Accountant</td>
                               <td>Tokyo</td>
                               <td>63</td>
                               <td>2011/07/25</td>
                               <td>$170,750</td>
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
        <div class="modal fade bs-example-modal-sm" id="applymentTable" role="dialog" aria-labelledby="mySmallModalLabel" >
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">申请加社团</h4>
                    </div>
                    <div class="modal-body">
                        <label class="form-group" for="joinReason">加入理由&意向部门:</label>
                        <div>
                            <textarea type="text" class="form-control" id="joinReason"  name="joinReason" placeholder="请输入加入理由&意向部门:"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="applymentTable_submit" class="btn btn-round btn-success" onclick="joinClubApply()"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 确定</button>
                    </div>
                </div>
            </div>
        </div>

        <!--
        	作者：offline
        	时间：2018-07-11
        	描述：申请退出社团的模态框
        -->
        <div class="modal fade bs-example-modal-sm" id="dropoutTable" role="dialog" aria-labelledby="mySmallModalLabel" >
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">申请退出</h4>
                    </div>
                    <div class="modal-body">
                        <label class="form-group" for="dropoutReason">退出理由:</label>
                        <div>
                            <textarea type="text" class="form-control" id="dropoutReason"  name="dropoutReason" placeholder="请输入退出理由"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="dropoutTable_submit" class="btn btn-round btn-success" onclick="exitClub()"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 确定</button>
                    </div>
                </div>
            </div>
        </div>


        <!--
        	作者：offline
        	时间：2018-07-11
        	描述：申请解散社团的模态框
        -->
        <div class="modal fade bs-example-modal-sm" id="dissolveTable" role="dialog" aria-labelledby="mySmallModalLabel" >
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">申请解散社团</h4>
                    </div>
                    <div class="modal-body">
                        <label class="form-group" for="dissolveReason">解散理由:</label>
                        <div>
                            <textarea type="text" class="form-control" id="dissolveReason"  name="dissolveReason" placeholder="请输入解散理由"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="dissolveTable_submit" class="btn btn-round btn-success" onclick="dissolveClub()"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 确定</button>
                    </div>
                </div>
            </div>
        </div>

    <!---->
        <!--
        	作者：offline
        	时间：2018-07-11
        	描述：下面是浮动编辑组件
        -->
        <div class="compose col-md-6 col-xs-12" id="newMessage">
      	<div class="compose-header">
            添加新留言
        <button type="button" class="close compose-close" id="compose-close">
          <span>-</span>
        </button>
      </div>
      <div class="compose-body">
        <div id="alerts"></div>
    		<label>留言内容</label>
		<textarea id="Message" class="form-control" rows="10" placeholder="请输入回复内容，不超过200字"></textarea>
      </div>
      <div class="compose-footer">
        <button id="send" class="btn btn-sm btn-success" type="button" onclick="postMessage()">发送留言</button>
      </div>
    </div>




        <!--
            作者：offline
            时间：2018-07-11
            描述：修改社团信息的模态框
        -->
        <div class="modal fade" id="changeClubInfo" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="clubDetailModify">修改社团信息</h4>
                    </div>
                    <div class="modal-body">
                        <label  class="form-group" for="newClubName">社团名称:</label>
                        <div>
                            <input type="text" contenteditable="false" class="form-control" id="newClubName" name="newClubName" placeholder="请输入社团名称" value="<%=club.getClubName()%>">
                        </div>
                        <label class="form-group" for="newClubInfo">社团简介:</label>
                        <div>
                            <input type="text" class="form-control"  id="newClubInfo" name="newClubInfo" placeholder="请输入社团简介" value="<%=club.getClubInfo()%>">
                        </div>
                        <label class="form-group" for="newClubType">社团类型:</label>
                        <div>
                            <input type="text" class="form-control"  id="newClubType" name="newClubType" placeholder="请输入社团类型" value="<%=club.getType()%>">
                        </div>
                        <label class="form-group">社团图片:</label>
                        <div>
                            <div class="user-photo-box">
                                <img id="user-photo" src="images/<%=ClubNo%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/logo.png'">
                            </div>
                            <br>
                            <button type="reset"  class="btn btn-default btn-round" data-target="#changePortraitModal" data-toggle="modal"><span class="glyphicon" aria-hidden="true"></span>选择头像</button>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button  class="btn btn-round btn-success" onclick="sendPhotoToServer();">提交</button>
                    </div>
                </div>
            </div>
        </div>



        <!--修改社团头像的模态框-->
        <div class="modal fade" id="changePortraitModal"  role="dialog" aria-hidden="true" style="z-index: 1060">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title text-primary">
                            <i class="fa fa-pencil"></i>
                            更换社团头像
                        </h4>
                    </div>
                    <div class="modal-body">
                        <p class="tip-info text-center">
                            未选择图片
                        </p>
                        <div class="img-container hidden">
                            <img src="" alt="" id="photo">
                        </div>
                        <div class="img-preview-box hidden">
                            <hr>
                            <span>150*150:</span>
                            <div class="img-preview img-preview-lg">
                            </div>
                            <span>100*100:</span>
                            <div class="img-preview img-preview-md">
                            </div>
                            <span>30*30:</span>
                            <div class="img-preview img-preview-sm">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <label class="btn btn-danger pull-left" for="photoInput">
                            <input type="file" class="sr-only" id="photoInput" accept="image/*">
                            <span>打开图片</span>
                        </label>
                        <button class="btn btn-primary disabled" disabled="true" onclick="sendPhoto();">提交</button>
                        <button class="btn btn-close" aria-hidden="true" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>


        <!--管理成员表的展示-->

        <div class="modal fade bs-example-modal-lg" id="manageClubMember" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">管理人员</h4>
                    </div>
                    <div class="modal-body">
                        <div>
                            <table id="manageClubMember-table" class="table table-striped table-bordered"cellpadding="0" cellspacing="0" border="0" >

                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade bs-example-modal-lg" id="editCreateApplyTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                        <h4 class="modal-title" >阅览信息</h4>
                    </div>
                    <div class="modal-body">

                        <label class="form-group" for="stuNoInClubMemberTable">学号</label>
                        <div>
                            <input type="text" class="form-control" id="stuNoInClubMemberTable"  name="stuNoInClubMemberTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="stuNameInClubMemberTable">姓名</label>
                        <div>
                            <input type="text" class="form-control" id="stuNameInClubMemberTable"  name="stuNameInClubMemberTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="jobInClubMemberTable">职务</label>
                        <div>
                            <input type="text" class="form-control" id="jobInClubMemberTable"  name="jobInClubMemberTable" placeholder="无">
                        </div>
                        <label class="form-group" for="apartmentInClubMemberTable">部门</label>
                        <div>
                            <input type="text" class="form-control" id="apartmentInClubMemberTable"  name="apartmentInClubMemberTable" placeholder="无">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-round btn-danger" id="btn_create_club_pass"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 删除</button>
                        <button type="button" id="btn_create_club_refuse" class="btn btn-round btn-default"  onclick="changeJobAndDepartment()"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 修改</button>
                    </div>
                </div>
            </div>
        </div>


        <!--管理成员加入申请表的展示-->

        <div class="modal fade bs-example-modal-lg" id="manageClubMemberApply" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">管理申请人员</h4>
                    </div>
                    <div class="modal-body">
                        <div>
                            <table id="manageClubMemberApply-table" class="table table-striped table-bordered"cellpadding="0" cellspacing="0" border="0" >

                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade bs-example-modal-lg" id="editClubMemberApplyTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                        <h4 class="modal-title" >阅览信息</h4>
                    </div>
                    <div class="modal-body">
                        <input id="ApplyNo" type="hidden" value="" />
                        <label class="form-group" for="stuNoInClubMemberApplyTable">学号</label>
                        <div>
                            <input type="text" class="form-control" id="stuNoInClubMemberApplyTable"  name="stuNoInClubMemberApplyTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="stuNameInClubMemberApplyTable">姓名</label>
                        <div>
                            <input type="text" class="form-control" id="stuNameInClubMemberApplyTable"  name="stuNameInClubMemberApplyTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="personalInClubMemberApplyTable">个人简介</label>
                        <div>
                            <input type="text" class="form-control" id="personalInClubMemberApplyTable"  name="personalInClubMemberApplyTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="joinReasonInClubMemberApplyTable">加入理由</label>
                        <div>
                            <input type="text" class="form-control" id="joinReasonInClubMemberApplyTable"  name="joinReasonInClubMemberApplyTable" placeholder="无" disabled>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-round btn-danger" id="btn_join_club_pass" onclick="passJoinApply('ignore')"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 拒绝</button>
                        <button type="button" id="btn_join_club_refuse" class="btn btn-round btn-default"  onclick="passJoinApply('pass')"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 同意</button>
                    </div>
                </div>
            </div>
        </div>



        <!--管理成员退出社团申请表的展示-->

        <div class="modal fade bs-example-modal-lg" id="manageMemberExitApply" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">管理申请人员</h4>
                    </div>
                    <div class="modal-body">
                        <div>
                            <table id="manageMemberExitApply-table" class="table table-striped table-bordered"cellpadding="0" cellspacing="0" border="0" >

                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade bs-example-modal-lg" id="editMemberExitApplyTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                        <h4 class="modal-title" >阅览信息</h4>
                    </div>
                    <div class="modal-body">
                        <label class="form-group" for="stuNoInMemberExitApplyTable">学号</label>
                        <div>
                            <input type="text" class="form-control" id="stuNoInMemberExitApplyTable"  name="stuNoInMemberExitApplyTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="stuNameInMemberExitApplyTable">姓名</label>
                        <div>
                            <input type="text" class="form-control" id="stuNameInMemberExitApplyTable"  name="stuNameInMemberExitApplyTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="jobInMemberExitApplyTable">职务</label>
                        <div>
                            <input type="text" class="form-control" id="jobInMemberExitApplyTable"  name="jobInMemberExitApplyTable" placeholder="无" disabled>
                        </div>
                        <label class="form-group" for="exitReasonlInMemberExitApplyTable">退出理由</label>
                        <div>
                            <input type="text" class="form-control" id="exitReasonlInMemberExitApplyTable"  name="exitReasonlInMemberExitApplyTable" placeholder="无" disabled>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-round btn-danger" id="btn_exit_club_pass" onclick="passExitApply('ignore')"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 拒绝</button>
                        <button type="button" id="btn_exit_club_refuse" class="btn btn-round btn-default"  onclick="passExitApply('del')"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 同意</button>
                    </div>
                </div>
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
        <script src="vendors/DataTables/DataTables-1.10.18/js/dataTables.bootstrap.min.js"></script>
        <script src="vendors/DataTables/Buttons-1.5.2/js/dataTables.buttons.min.js"></script>
        <script src="vendors/DataTables/Select-1.2.6/js/dataTables.select.min.js"></script>
        <script src="vendors/DataTables/JSZip-2.5.0/jszip.js"></script>
        <script src="vendors/DataTables/pdfmake-0.1.36/pdfmake.js"></script>
        <script src="vendors/DataTables/Buttons-1.5.2/js/buttons.html5.min.js"></script>
        <script src="vendors/DataTables/Buttons-1.5.2/js/buttons.flash.min.js"></script>
        <script src="vendors/DataTables/Buttons-1.5.2/js/buttons.print.js"></script>
        <script src="vendors/DataTables/Buttons-1.5.2/js/buttons.bootstrap.min.js"></script>
        <script src="vendors/DataTables/pdfmake-0.1.36/vfs_fonts.js"></script>
        <!--<script src="vendors/DataTables/Editor-2018-07-26-1.7.4/js/dataTables.editor.js"></script>-->
        <script src="vendors/cropper/dist/cropper.min.js"></script>
    </body>
     
        
</html>

<script>




    var remarkShowLength = 10;//默认现实的字符串长度

var editingTableID;
//在此版面中，共需要管理1张表，

var selectedRol;


var table =  $("#datatable-buttons-test").DataTable({
    "sZeroRecords": "没有检索到数据",
    // "sProcessing": "<img src='./loading.gif' />",加载中的动画效果
    "bStateSave": true,
    "bInfo": true,//页脚信息
    // "bAutoWidth": true,//自动宽度
    "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
    columns: [{
        data: null

        },
        {
            data: "Name",
            title: "姓名"
        },
        {
            data: "Position",
            title: "职位"
        },
        {
            data: "Office",
            title: "办公地点"
        },
        {
            data: "Age",
            title: "年龄"
        },
        {
            data: "Start date",
            title: "上岗时间"
        },
        {
            data: "Salary",
            title: "薪金"
        }],
    "columnDefs": [{
        "searchable": false,
        "orderable": false,
        "targets": [0]},
        {
            "targets": [2] , //隐藏第六列，从第0列开始
            "visible": false
        },
    ],
    "order": [[1, 'asc']],
    "oLanguage": {
       "sLengthMenu": "每页显示 _MENU_ 条记录",
       "sZeroRecords": "没有检索到数据",
       "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
       "sInfoEmpty": "没有数据",
       "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
       "sSearch": "搜索",
       "oPaginate": {
           "sFirst": "首页",
           "sPrevious": "前一页",
           "sNext": "后一页",
           "sLast": "尾页"
       }
   },


					  dom: "Blfrtip",
					  buttons: [
						{
						  text:'拷贝',							
						  extend: "copy",
						  className: "btn-sm"
						},
						{
						  extend: "csv",
						  className: "btn-sm",
						  text:'csv表格',
						},
					
						{
						  extend: "excel",
						  className: "btn-sm",
						  text:'excel',
                            filename:"",
                            customize: function ( xlsx ) {
                                var sheet = xlsx.xl.worksheets['sheet1.xml'];
                                $('c[r=A1] t', sheet).text( '结果' );
                                $('c[c=A1] t', sheet).text( '' );
                            }
						},
                          {
                              extend: "pdf",
                              className: "btn-sm",
                              text:'pdf',
                          },
                          {
                              extend: "print",
                              className: "btn-sm",
                              text:'打印',
                          },
					  ],
					  responsive: true
					});
table.on('order.dt search.dt',
    function() {
        table.column(0, {
            search: 'applied',
            order: 'applied'
        }).nodes().each(function(cell, i) {
            cell.innerHTML = i + 1;
        });
    }).draw();


$('#datatable-buttons-test tbody').on('click', 'tr', function () {

        selectedRol = this;
        alert("grab data successfully!");
    $('#editDetail').modal('show');

});

	function show_modal() {
            $('#myModal').modal('show');
            document.getElementById("bookID").value = temp;
        }
	
	$(window).ready(function(){
		Chart.defaults.global.legend = {
					enabled: false
				};
		if ($('#canvasDoughnut').length ){
		      var array=[];
		      array.push(<%=male%>);
		      array.push(<%=female%>);
			  var ctx = document.getElementById("canvasDoughnut");
			  var data = {
				labels: [
				  "男",
				  "女"
				],
				datasets: [{
				  data: array,
				  backgroundColor: [
				  	"#3498DB",
					"#455C73",
					"#9B59B6",
					"#BDC3C7",
					"#26B99A"
					
				  ],
				  hoverBackgroundColor: [
				  	"#49A9EA",
					"#34495E",
					"#B370CF",
					"#CFD4D8",
					"#36CAAB"
				  ]
				}]
			 };
			  var canvasDoughnut = new Chart(ctx, {
				type: 'doughnut',
				tooltipFillColor: "rgba(51, 51, 51, 0.55)",
				data: data
			  });
			};
		});


    $(document).on('show.bs.modal', '.modal', function(event) {
        $(this).appendTo($('body'));
    }).on('shown.bs.modal', '.modal.in', function(event) {
        setModalsAndBackdropsOrder();
    }).on('hidden.bs.modal', '.modal', function(event) {
        setModalsAndBackdropsOrder();
    });


    function setModalsAndBackdropsOrder() {
        var modalZIndex = 1040;
        $('.modal.in').each(function(index) {
            var $modal = $(this);
            modalZIndex++;
            $modal.css('zIndex', modalZIndex);
            $modal.next('.modal-backdrop.in').addClass('hidden').css('zIndex', modalZIndex - 1);
        });
        $('.modal.in:visible:last').focus().next('.modal-backdrop.in').removeClass('hidden');
    }




    $('.reply').click(function(){
    $('.compose').slideToggle();
});
	
	
	
</script>

<!--照片上传裁剪工具-->
<script type="text/javascript">
    var initCropperInModal = function(img, input, modal){
        var $image = img;
        var $inputImage = input;
        var $modal = modal;
        var options = {
            aspectRatio: 1, // 纵横比
            viewMode: 2,
            dragMode:'move',
            preview: '.img-preview', // 预览图的class名
            guides:true,
            modal:true,
            background:true,
            crop: function (e) {
                console.log(e);
            }
        };
        // 模态框隐藏后需要保存的数据对象

        var saveData = {};
        var URL = window.URL || window.webkitURL;
        var blobURL;
        $modal.on('show.bs.modal',function () {
            // 如果打开模态框时没有选择文件就点击“打开图片”按钮
            if(!$inputImage.val()){
                $inputImage.click();
            }
        }).on('shown.bs.modal', function () {
            // 重新创建
            $image.cropper( $.extend(options, {
                ready: function () {
                    // 当剪切界面就绪后，恢复数据
                    if(saveData.canvasData){
                        $image.cropper('setCanvasData', saveData.canvasData);
                        // $image.cropper('setCropBoxData', saveData.cropBoxData);
                    }
                }
            }));
        }).on('hidden.bs.modal', function () {
            // 保存相关数据
            saveData.cropBoxData = $image.cropper('getCropBoxData');
            saveData.canvasData = $image.cropper('getCanvasData');
            // 销毁并将图片保存在img标签
            $image.cropper('destroy').attr('src',blobURL);
        });
        if (URL) {
            $inputImage.change(function() {
                var files = this.files;
                var file;
                if (!$image.data('cropper')) {
                    return;
                }
                if (files && files.length) {
                    file = files[0];
                    if (/^image\/\w+$/.test(file.type)) {

                        if(blobURL) {
                            URL.revokeObjectURL(blobURL);
                        }
                        blobURL = URL.createObjectURL(file);

                        // 重置cropper，将图像替换
                        $image.cropper('reset').cropper('replace', blobURL);

                        // 选择文件后，显示和隐藏相关内容
                        $('.img-container').removeClass('hidden');
                        $('.img-preview-box').removeClass('hidden');
                        $('#changePortraitModal .disabled').removeAttr('disabled').removeClass('disabled');
                        $('#changePortraitModal .tip-info').addClass('hidden');

                    } else {
                        window.alert('请选择一个图像文件！');
                    }
                }
            });
        } else {
            $inputImage.prop('disabled', true).addClass('disabled');
        }
    }

    var sendPhoto = function(){
        $('#photo').cropper('getCroppedCanvas',{
            width:300,
            height:300
        }).toBlob(function(blob){
            // 转化为blob后更改src属性，隐藏模态框
            $('#user-photo').attr('src',URL.createObjectURL(blob));
            $('#changePortraitModal').modal('hide');
        });
    }


    var sendPhotoToServer = function () {
        $.ajax({
            type:'POST',
            url:"/ClubInfoChange",
            data:{
                "Club_id":<%=ClubNo%>,
                "Club_name":$('#newClubName').val(),
                "Club_type": $('#newClubType').val(),
                "Club_info":$('#newClubInfo').val()
            },
            success:function() {
               // alert("修改信息成功")
                $('#clubName').html($('#newClubName').val());
                $('#clubType').html($('#newClubType').val());
                $('#clubInfo').html($('#newClubInfo').val());

            },async:false,
            error:function () {
                alert('error!!')
            }
        });



        var image = new Image();
        image.src = $('#user-photo').attr('src').toString();
        image.onload = function () {
            var canvas = document.createElement("canvas");
            canvas.width = image.width;
            canvas.height = image.height;
            // 坐标(0,0) 表示从此处开始绘制，相当于偏移。
            canvas.getContext("2d").drawImage(image, 0, 0);
            var photo = canvas.toDataURL('image/png');
            $.ajax({
                url: '/saveImg', // 要上传的地址
                type: 'post',
                data: {
                    'imgData': photo,
                    "name":<%=ClubNo%>
                },
                success: function () {
                        // 将上传的头像的地址填入，为保证不载入缓存加个随机数
                        $('.user-photo').attr('src', '/images/<%=ClubNo%>.jpg'+'?t=' + Math.random());
                        $('#changePortraitModal').modal('hide');
                },
                error:function () {
                    alert("error")
                }

            });
            $('#ClubImg').attr('src',image.src.toString());

        }

        $('#changePortraitModal').modal("hide");
        $('#changeClubInfo').modal("hide");
    }

    $(function(){
        initCropperInModal($('#photo'),$('#photoInput'),$('#changePortraitModal'));
    });

</script>

<%--获取成员表--%>
<script>
    var remarkShowLength = 3;//默认现实的字符串长度

    function manageClubMemberEnter()
    {
        // var dataset = [
        //     [ "123","345","Tiger Nixon", "System Architect", "Edinburgh"],
        //     [ "123","345","Garrett Winters", "Accountant", "Tokyo"],
        //     [ "123","345","Ashton Cox", "Junior Technical Author", "San Francisco"],
        //     [ "123","345","Cedric Kelly", "Senior Javascript Developer", "Edinburgh"],
        //     [ "123","345","Airi Satou", "Accountant", "Tokyo"]];
        // reloadClubMemberTableData(dataset);
        getMembers();
        $('#manageClubMember').modal('show');
    }

    function getMembers() {
        $.ajax({
            type:'POST',
            url:"/getMemberInfo",
            data:{
                "ClubNo":<%=ClubNo%>
            },
            success:function(data) {
                var dataset = new Array();
                order = [
                    "StuNo",
                    "StuName",
                    "college",
                    "Sex",
                    "Tel",
                    "self_introduce"
                ];
                var UsedJson = eval("" + data + "");
                for (var i = 0; i < UsedJson.length; i++) {
                    var eachItem = new Array();
                    eachItem.push(UsedJson[i].StuNo.toString());
                    eachItem.push(<%=ClubNo%>);
                    eachItem.push(UsedJson[i].StuName.toString());
                    eachItem.push(UsedJson[i].Job.toString());
                   // var m=UsedJson[i].Department;
                    if(UsedJson[i].hasOwnProperty("Department")) eachItem.push(UsedJson[i].Department.toString());
                    else eachItem.push("");
                    dataset.push(eachItem);
                }
                reloadClubMemberTableData(dataset);
            },async:false,
            error:function () {
                alert('error!!')
            }
        });
    }

    function reloadClubMemberTableData(newDataSet) {
        var currentPage = manageClubMemberTable.page();
        manageClubMemberTable.clear();
        manageClubMemberTable.rows.add(newDataSet);
        manageClubMemberTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageClubMemberTable;

    var editingID;

    function initManageClubMemberTable(status, dataSet) {
        manageClubMemberTable = $("#manageClubMember-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            // "sProcessing": "<img src='./loading.gif' />",加载中的动画效果
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "学号"
                },
                {
                    "sTitle": "社团ID",
                    "sClass": "hiddenCol"
                },
                {
                    title: "姓名"
                },
                {
                    title: "职务"
                },
                {
                    title: "部门"
                }],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },
                {
                    type : "string",
                    targets : [1],

                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3]
                    // "render": function (data, type, row, meta) {
                    //     if (row[1].length > remarkShowLength) {
                    //         return row[1].substring(0,remarkShowLength)+"...";//显示部分信息
                    //     } else {
                    //         return row[1];//显示原始全部信息 }
                    //     }
                    // }
                },
                {
                    type: "string",
                    targets: [4],
                }
            ],
            "order": [[2, 'asc']],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });

        $('#manageClubMember-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            selectedRol = manageClubMemberTable.row( $(this).parents('tr') );
           // alert(this.cells[0].innerText);
            $('#editCreateApplyTableDetail').modal('show');
            editingID = this.cells[1].innerText;//利用selectedRol向弹出的模态框提交数据，修改结果
            $("#stuNoInClubMemberTable").val(this.cells[0].innerText);
            $("#stuNameInClubMemberTable").val(this.cells[2].innerText);
            $("#jobInClubMemberTable").val(this.cells[3].innerText);
            $("#apartmentInClubMemberTable").val(this.cells[4].innerText);
        });
    }

    $(window).ready(function () {
        initManageClubMemberTable();
        initManageClubMemberApplyTable();
        initManageMemberExitApplyTable();
    })
</script>

<%--获取加入社团的申请表--%>
<script>
    var remarkShowLength = 3;//默认现实的字符串长度

    function manageClubMemberApplyEnter()
    {
        // var dataset = [
        //     [ "123","345","Tiger Nixon", "System Architect","345","Tiger Nixon", "System Architect","345","Tiger Nixon"],
        //     [ "123","345","Garrett Winters", "Accountant","345","Garrett Winters", "Accountant","345","Garrett Winters"],
        //     [ "123","345","Ashton Cox", "Junior Technical Author","123","345","Ashton Cox", "Junior Technical Author",'1223']
        //     ];
        $('#manageClubMemberApply').modal('show');
        getJoinList();

    }
    function getJoinList() {
        $.ajax({
            type:'POST',
            url:"/getJoinList",
            data:{
                "ClubNo":<%=ClubNo%>
            },
            success:function(data) {
                var dataset = new Array();
                order = [
                    "StuNo",
                    "StuName",
                    "college",
                    "Sex",
                    "Tel",
                    "self_introduce"
                ];
                var UsedJson = eval("" + data + "");
                for (var i = 0; i < UsedJson.length; i++) {
                    var eachItem = new Array();
                    eachItem.push(UsedJson[i].ApplyNo.toString());
                    eachItem.push(UsedJson[i].StuNo.toString());
                    eachItem.push(UsedJson[i].StuName.toString());
                    eachItem.push(UsedJson[i].college.toString());
                    eachItem.push(UsedJson[i].Sex.toString());
                    eachItem.push(UsedJson[i].Tel.toString());
                    eachItem.push(UsedJson[i].self_introduce.toString());
                    eachItem.push(UsedJson[i].JoinReason.toString());
                    dataset.push(eachItem);
                }
                console.log(dataset);
                //alert("您的操作成功");
                reloadClubMemberApplyTableData(dataset);


                //self.location.reload();

            },async:false,
            error:function () {
                alert('error!!')
            }
        });
    }

    function reloadClubMemberApplyTableData(newDataSet) {
        var currentPage = manageClubMemberApplyTable.page();
        manageClubMemberApplyTable.clear();
        manageClubMemberApplyTable.rows.add(newDataSet);
        manageClubMemberApplyTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageClubMemberApplyTable;

    var editingID;

    function initManageClubMemberApplyTable(status, dataSet) {
        manageClubMemberApplyTable = $("#manageClubMemberApply-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            // "sProcessing": "<img src='./loading.gif' />",加载中的动画效果
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "申请ID",
                    "sClass": "hiddenCol"
                },
                {
                    "sTitle": "学号",
                },
                {
                    title: "姓名"
                },
                {
                    title: "院系"
                },
                {
                    title: "性别"
                },
                {
                    title: "电话"
                },
                {
                    title: "个人简介",

                },
                {
                    title: "理由",
                    "sClass": "hiddenCol"
                }],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },
                {
                    type : "string",
                    targets : [1],

                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3]
                    // "render": function (data, type, row, meta) {
                    //     if (row[1].length > remarkShowLength) {
                    //         return row[1].substring(0,remarkShowLength)+"...";//显示部分信息
                    //     } else {
                    //         return row[1];//显示原始全部信息 }
                    //     }
                    // }
                },
                {
                    type : "string",
                    targets : [4],

                },
                {
                    type : "string",
                    targets : [5],

                },
                {
                    type : "string",
                    targets : [6],

                },
                {
                    type : "string",
                    targets : [7],

                }
            ],
            "order": [[1, 'asc']],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });

        $('#manageClubMemberApply-table tbody').on('click', 'tr', function () {

        });

        $('#manageClubMemberApply-table tbody').on('click', 'tr', function () {
            selectedRol = this;
           // alert(this.cells[0].innerText);
            $('#editClubMemberApplyTableDetail').modal('show');
            editingID = this.cells[0].innerText;//利用selectedRol向弹出的模态框提交数据，修改结果
           // $('#ApplyNo').val(this.cell[0].innerText);
            $("#stuNoInClubMemberApplyTable").val(this.cells[1].innerText);
            $("#stuNameInClubMemberApplyTable").val(this.cells[2].innerText);
            $("#personalInClubMemberApplyTable").val(this.cells[6].innerText);
            $("#joinReasonInClubMemberApplyTable").val(this.cells[7].innerText);
        });
    }
</script>

<%--获取退出社团的申请表--%>
<script>

    var remarkShowLength = 3;//默认现实的字符串长度

    function manageMemberExitApplyEnter()
    {
        // var dataset = [
        //     [ "123","345","Tiger Nixon", "System Architect","345","Tiger Nixon", "System Architect","345","Tiger Nixon"],
        //     [ "123","345","Garrett Winters", "Accountant","345","Garrett Winters", "Accountant","345","Garrett Winters"],
        //     [ "123","345","Ashton Cox", "Junior Technical Author","123","345","Ashton Cox", "Junior Technical Author",'1223']
        //     ];
        getExitList();
        $('#manageMemberExitApply').modal('show');
    }

    function getJoinList() {
        $.ajax({
            type:'POST',
            url:"/getJoinList",
            data:{
                "ClubNo":<%=ClubNo%>
            },
            success:function(data) {
                var dataset = new Array();
                order = [
                    "StuNo",
                    "StuName",
                    "college",
                    "Sex",
                    "Tel",
                    "self_introduce"
                ];
                var UsedJson = eval("" + data + "");
                for (var i = 0; i < UsedJson.length; i++) {
                    var eachItem = new Array();
                    eachItem.push(UsedJson[i].ApplyNo.toString());
                    eachItem.push(UsedJson[i].StuNo.toString());
                    eachItem.push(UsedJson[i].StuName.toString());
                    eachItem.push(UsedJson[i].college.toString());
                    eachItem.push(UsedJson[i].Sex.toString());
                    eachItem.push(UsedJson[i].Tel.toString());
                    eachItem.push(UsedJson[i].self_introduce.toString());
                    eachItem.push(UsedJson[i].JoinReason.toString());
                    dataset.push(eachItem);
                }
                console.log(dataset);
                //alert("您的操作成功");
                reloadClubMemberApplyTableData(dataset);


                //self.location.reload();

            },async:false,
            error:function () {
                alert('error!!')
            }
        });
    }


    function getExitList(){
        $.ajax({
            type:'POST',
            url:"/getExitList",
            data:{
                "ClubNo":<%=ClubNo%>
            },
            success:function(data) {
                var dataset = new Array();
                order = [
                    "StuNo",
                    "StuName",
                    "Job",
                    "Tel"
                ];
                var UsedJson = eval("" + data + "");
                for (var i = 0; i < UsedJson.length; i++) {
                    var eachItem = new Array();
                    eachItem.push(UsedJson[i].ApplyNo.toString());
                    eachItem.push(UsedJson[i].StuNo.toString());
                    eachItem.push(UsedJson[i].StuName.toString());
                    eachItem.push(UsedJson[i].Job.toString());
                    eachItem.push(UsedJson[i].Tel.toString());
                    eachItem.push(UsedJson[i].Reason.toString());
                    dataset.push(eachItem);
                }
                console.log(dataset);
                //alert("您的操作成功");
                reloadMemberExitApplyTableData(dataset);


                //self.location.reload();

            },async:false,
            error:function () {
                alert('error!!')
            }
        });
    }

    function reloadMemberExitApplyTableData(newDataSet) {
        var currentPage = manageMemberExitApplyTable.page();
        manageMemberExitApplyTable.clear();
        manageMemberExitApplyTable.rows.add(newDataSet);
        manageMemberExitApplyTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageMemberExitApplyTable;

    var editingID;

    function initManageMemberExitApplyTable(status, dataSet) {
        manageMemberExitApplyTable = $("#manageMemberExitApply-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            // "sProcessing": "<img src='./loading.gif' />",加载中的动画效果
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "申请ID",
                    "sClass": "hiddenCol"
                },
                {
                    "sTitle": "学号",
                },
                {
                    title: "姓名"
                },
                {
                    title: "职位"
                },
                {
                    title: "电话"
                },
                {
                    title: "理由",
                    "sClass": "hiddenCol"
                }],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },
                {
                    type : "string",
                    targets : [1],

                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3]
                    // "render": function (data, type, row, meta) {
                    //     if (row[1].length > remarkShowLength) {
                    //         return row[1].substring(0,remarkShowLength)+"...";//显示部分信息
                    //     } else {
                    //         return row[1];//显示原始全部信息 }
                    //     }
                    // }
                },
                {
                    type : "string",
                    targets : [4],

                },
                {
                    type : "string",
                    targets : [5],

                }
            ],
            "order": [[1, 'asc']],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });


        $('#manageMemberExitApply-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            // alert(this.cells[0].innerText);
            $('#editMemberExitApplyTableDetail').modal('show');
            editingID = this.cells[0].innerText;//利用selectedRol向弹出的模态框提交数据，修改结果
            $("#stuNoInMemberExitApplyTable").val(this.cells[1].innerText);
            $("#stuNameInMemberExitApplyTable").val(this.cells[2].innerText);
            $("#jobInMemberExitApplyTable").val(this.cells[3].innerText);
            $("#exitReasonlInMemberExitApplyTable").val(this.cells[5].innerText);
        });
    }
</script>



<script>



    function Article(outerId,innerId,outerPageId,innerPageId) {
            this.outerID = outerId;
            this.innerID = innerId;
            this.outerPageID = outerPageId;
            this.innerPageID = innerPageId;
            this.allNodes;
            this.allNum;
            this.showNodes;
            this.nowNum = 4;//一页的个数
            this.allPages;
            this.currentPage;
            this.pageRange;
    }

        Article.prototype.initFunctionTemp = function()
        {
            var temp = document.getElementById(this.outerID);
            this.allNodes = temp.getElementsByClassName(this.innerID);
            this.allNum = this.allNodes.length;
            if(!isNaN(this.allNum))
            {
                this.allPages = Math.ceil(this.allNum*1.0/this.nowNum);
                for(var i = 0; i<this.allNum; i++)
                {
                    this.allNodes[i].style.display="none";
                }
                this.goToPage(1);
            }else
            {

            }
        }

        Article.prototype.getIndexPages = function () {
            if(this.currentPage<=3&&this.currentPage>0||this.allPages<=5)
            {
                return [1,2,3,4,5];
            }
            if(this.currentPage>3&&this.currentPage<this.allPages-2)
            {
                return [this.currentPage-2,this.currentPage-1,this.currentPage,this.currentPage+1,this.currentPage+2];
            }
            if(this.currentPage>=this.allPages-2&&this.currentPage<=this.allPages)
            {
                return [this.allPages-4,this.allPages-3,this.allPages-2,this.allPages-1,this.allPages];
            }
        }
    Article.prototype.getCurrentPage = function()
    {
        return this.currentPage;
    }


    Article.prototype.goToPageOption = function (pageNum) {
            // if($('#searchInfo').val()!=='')
            // {
            //     // this.searchForGroup(pageNum);
            // }else{
                this.goToPage(pageNum,this.allNodes,this.allNum);
            // }
            // var height = $("#allGroupsPage").offset().top;
            // height = height + 30 + $("#allGroupsPage").height();
            var height = $(window).height();
            height = height.toString();
            $("#searchSize").css("min-height",height+"px");
//		$("#allGroups").css("display","inline");
        }

        Article.prototype.goToPage = function(pageNum,originNodes,allNumber) {
            if (pageNum > this.allPages) {
                return;
            }
            if (pageNum <= 0) {
                return;
            }
            for (var i = 0; i < allNumber; i++) {
                originNodes[i].style.display = "none";
            }
            this.currentPage = pageNum;
            var nodes = new Array();
            var init = (pageNum - 1) * this.nowNum;
            for (var i = 0; i < (this.nowNum >= (this.allNum - init) ? (this.allNum - init) : this.nowNum); i++) {
                nodes.push(this.allNodes[i + init]);
                this.allNodes[i + init].style.display = "flex";
            }
            this.showNodes = nodes;
            this.pageRange = this.getIndexPages();

            for (var temp = 0; temp < 5; temp++) {
                document.getElementById(this.innerPageID + (temp + 1)).innerText = '?';
                document.getElementById(this.outerPageID + (temp + 1)).style.display = "inline";
                document.getElementById(this.innerPageID + (temp + 1)).style.display = "inline";
            }

            for (temp = 0; temp < (5 >= this.allPages ? this.allPages : 5); temp++) {
                document.getElementById(this.innerPageID + (temp + 1)).innerText = this.pageRange[temp];
                document.getElementById(this.outerPageID + (temp + 1)).className = "paginate_button";
                if (document.getElementById(this.innerPageID + (temp + 1)).innerText === pageNum.toString()) {
                    document.getElementById(this.outerPageID + (temp + 1)).className = "paginate_button active";
                }
            }

            if (this.allPages < 5) {
                for (temp = 0; temp < 5; temp++) {
                    if (document.getElementById(this.innerPageID + (temp + 1)).innerText === '?') {
                        document.getElementById(this.outerPageID + (temp + 1)).style.display = "none";
                        document.getElementById(this.innerPageID + (temp + 1)).style.display = "none";
                    }
                }
            }
        }

    var articlePageDivider = new Article('articles','innerArticle','outerPage','Page');
    articlePageDivider.initFunctionTemp();
    articlePageDivider.goToPageOption(1);
    var messageDivider = new Article('messagesAll','innerMessage','outerMessagePage','messagePage');
    var messageDividerGlobal = messageDivider;
    messageDivider.initFunctionTemp();
    messageDivider.goToPageOption(1);




    function joinClubApply(){
        var joinReason;
        if(document.getElementById('joinReason').innerText) joinReason=document.getElementById('joinReason').innerText;
        else joinReason=$('#joinReason').val();
        $.ajax({
            type:'POST',
            url:"/joinApply",
            data:{
               "ClubNo":<%=ClubNo%>,
                "JoinReason":joinReason
            },
            success:function() {
                alert("发送申请成功，请耐心等待社团管理员审核！");
            },
            error:function () {
                alert('error!!')
            }
        });
        $('#applymentTable').modal('hide');
        $('#joinReason').val('');
    }

    function priceApply(){
        $.ajax({
            type:'POST',
            url:"/priceApply",
            data:{
                "ActiveNo":document.getElementById("clubActivity").value,
                "price":$('#fondAmount').val(),
                "Reason":$('#applyForFondReason').val()
            },
            success:function() {
                alert("发送申请成功，请耐心等待后台管理员审核！");
            },
            error:function () {
                alert('error!!')
            }


        });
        $('#clubActivityApplyForm').modal('hide');
        $('#fondAmount').val('');
        $('#applyForFondReason').val('');

    }


    function exitClub() {
        if(del("确认退出社团吗？")==true) {
            var dropoutReason;
            if (document.getElementById('dropoutReason').innerText) dropoutReason = document.getElementById('dropoutReason').innerText;
            else dropoutReason = $('#dropoutReason').val();
            $.ajax({
                type: 'POST',
                url: "/leaveApply",
                data: {
                    "ClubNo":<%=ClubNo%>,
                    "Reason": dropoutReason
                },
                success: function () {
                    alert("发送申请成功，请耐心等待后台管理员审核！");
                },
                error: function () {
                    alert('error!!')
                }


            });
        }

        $('#dropoutTable').modal('hide');
        $('#dropoutReason').val('');
    }

    function del(m) {
        var msg =m;
        if (confirm(msg)==true){
            return true;
        }else{
            return false;
        }
    }


    function dissolveClub() {
        var job="<%=job%>";
        if(job=="社长") {
            if (del("您确认要解散社团吗？请慎重确认！") == true) {
                var dissolveReason;
                if (document.getElementById('dissolveReason').innerText) dissolveReason = document.getElementById('dissolveReason').innerText;
                else dissolveReason = $('#dissolveReason').val();
                $.ajax({
                    type: 'POST',
                    url: "/dissolveClub",
                    data: {
                        "ClubNo":<%=ClubNo%>,
                        "Reason": dissolveReason
                    },
                    success: function () {
                        alert("发送申请成功，请耐心等待后台管理员审核！");
                    },
                    error: function () {
                        alert('error!!')
                    }


                });
            }
        }
        else alert("权限不足！只有社长才能删除社团！");

        $('#dissolveTable').modal('hide');
        $('#dissolveReason').val('');
    }


    function passJoinApply(m) {
        $.ajax({
            type:'POST',
            url:"/passJoinApply",
            data:{
                "ApplyNo":editingID,
                "ClubNo":<%=ClubNo%>,
                "StuNo":$('#stuNoInClubMemberApplyTable').val(),
                "Action":m
            },
            success:function() {
              //  alert('操作成功');
              //  initManageClubMemberTable();
                getJoinList();
            },
            error:function () {
                alert('error!!')
            }


        });
        $('#editClubMemberApplyTableDetail').modal('hide');


    }


    function passExitApply(m) {
        $.ajax({
            type:'POST',
            url:"/passLeaveApply",
            data:{
                "ApplyNo":editingID,
                "ClubNo":<%=ClubNo%>,
                "StuNo":$('#stuNoInMemberExitApplyTable').val(),
                "Action":m
            },
            success:function() {
                getExitList();
            },
            error:function () {
                alert('error!!')
            }
        });
        $('#editMemberExitApplyTableDetail').modal('hide');
    }


    function changeJobAndDepartment() {
        $.ajax({
            type:'POST',
            url:"/memberManage",
            data:{
                "StuNo":$('#stuNoInClubMemberTable').val(),
                "ClubNo":<%=ClubNo%>,
                "Job":$('#jobInClubMemberTable').val(),
                "Department":$('#apartmentInClubMemberTable').val()
            },
            success:function() {
                getMembers();
            },
            error:function () {
                alert('error!!')
            }
        });
        $('#editCreateApplyTableDetail').modal('hide');
    }



    function postMessage() {
        var Message;
        if(document.getElementById('Message').innerText) Message=document.getElementById('Message').innerText;
        else Message=$('#Message').val();
        $.ajax({
            type:'POST',
            url:"/addMessage",
            data:{
                "ClubNo":<%=ClubNo%>,
                "Message":Message
            },
            success:function() {
                location.reload();
            },
            error:function () {
                alert('error!!')
            }
        });
        $('#newMessage').modal('hide');
    }

    $('.removeReply').click(function () {
        var page = messageDividerGlobal.getCurrentPage();
        var MessageNo=$(this).attr("id");
       // alert($(this).attr("id"));
        var fatherNode = $(this).parents(".replyFather");
        $.ajax({
            type:'POST',
            url:"/delMessage",
            data:{
                "MessageNo":MessageNo
            },
            success:function() {
              //  alert("成功删除留言");
                fatherNode.fadeOut('slow',function () {
                    fatherNode.remove();
                    var messageDivider = new Article('messagesAll','innerMessage','outerMessagePage','messagePage');
                    messageDivider.initFunctionTemp();
                    if(page<messageDivider.allPages)
                        messageDivider.goToPageOption(page-1);
                    else
                        messageDivider.goToPageOption(page);
                });
            },
            error:function () {
                alert('error!!')
            }
        });


    });
</script>
<script src="mobile.js"></script>

