<%@ page import="model.Record" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Club" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="Test.Test" %>
<%@ page import="model.Activity" %>
<%@ page import="model.Message" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static operations.ClubOperations.getActiveDetail" %>
<%@ page import="operations.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<% //c试着把整个servlet搬过来
    String resource = "mybatis.xml";
    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);


    // 获取Session连接
    SqlSession session1 = sqlSessionFactory.openSession();

    //调用数据库操作，获得与学号绑定的两个数组
    List<Record> clubRecord = RecordOperations.getClubTimes(session1);
    List<Record> activeRecord = RecordOperations.getActiveTimes(session1);

    //获取与学号绑定的参加活动数
    List<Record> joinAcitiveRecord = RecordOperations.getAllStudentActive(session1);
    //获取与学号绑定的参加社团数（分为成员和管理员两种）
    List<Record> joinClubRecordLow = RecordOperations.getAllStudentClub(session1, "成员");
    List<Record> joinClubRecordHeigh = RecordOperations.getAllStudentClub(session1, "社长");
    joinClubRecordHeigh.addAll(RecordOperations.getAllStudentClub(session1, "部长"));
    //temp数组是两者的集合，用于在求相似度时可以直接使用两种的集合

    List<Record> temp = new ArrayList<Record>();
    temp.addAll(joinClubRecordLow);
    temp.addAll(joinClubRecordHeigh);
    //用嵌套List二维数组来存放不同的社团或是活动间的相似度
    Map<Integer, Map<Integer, Double>> SimliarMatrix;
    Record recordTemp = new Record();

    //活动推荐

    //获取活动相似度矩阵
    SimliarMatrix = recordTemp.getSimilarList(joinAcitiveRecord);
    //下面创建每一个活动对该用户的推荐度map表
    Map<Integer, Double> recommendNum = recordTemp.getActiveRecommendNum(activeRecord, joinAcitiveRecord, SimliarMatrix, (Integer) request.getSession().getAttribute("UserNo"));
    //最后进行排序，得到排序的活动号排名并且剔除已经参加的活动
    List<Integer> activeRecommend = recordTemp.getSort(recommendNum, (Integer) request.getSession().getAttribute("UserNo"));
    List<Activity> active_Recommend = new ArrayList<Activity>();

    for (int i : activeRecommend)
    {
        active_Recommend.add(getActiveDetail(sqlSessionFactory, i));
    }

    //活动推荐结束

    //社团推荐
    //获取社团相似度矩阵
    Record recordTemp2 = new Record();
    SimliarMatrix = recordTemp2.getSimilarList(temp);
    //创建每一个社团对该用户的推荐map表
    Map<Integer, Double> recommendNum2 = recordTemp2.getActiveRecommendNum(clubRecord, joinClubRecordLow, joinClubRecordHeigh, SimliarMatrix, (Integer) request.getSession().getAttribute("UserNo"));
    //最后进行排序，并剔除已经参加的社团
    List<Integer> clubRecommend = recordTemp2.getSort(recommendNum2, (Integer) request.getSession().getAttribute("UserNo"));
    List<Club> club_Recommend = new ArrayList<Club>();

    for (int i : clubRecommend)
    {
        club_Recommend.add(DAO.getClubById(sqlSessionFactory, i));
    }


    List<Club> club_randoms = RandomOperations.getRandomClub(sqlSessionFactory,8);


    //把session提出来以提高效率
    session1.commit();
    session1.close();
    Integer StuNo= (Integer) session.getAttribute("UserNo");


%>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/9
  Time: 18:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>U社团! | </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- jQuery custom content scroller -->
    <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
    <!-- Custom Theme Style -->
    <link href="build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
<%

    List<Club> Clubs = ClubOperations.getClubsALL(sqlSessionFactory);
    List<Message> messages = MessageOperations.getMyMessage(sqlSessionFactory,(Integer) request.getSession().getAttribute("UserNo"));
    session.setAttribute("messages",messages);
%>
<div class="container body">
    <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
            <div class="left_col scroll-view">
                <div class="navbar nav_title" style="border: 0;">
                    <a href="Recommend.jsp" class="site_title"><img src="images/logo8.png"/><span>&nbsp;</span></a>
                </div>

                <div class="clearfix"></div>

                <!-- menu profile quick info -->
                <div class="profile clearfix">
                    <div class="profile_pic">
                        <img id="userImg" src="images/<%=StuNo%>.jpg" onerror="javascript:this.src='images/user.png'" alt="..." class="img-circle profile_img">
                    </div>
                    <div class="profile_info">
                        <span>欢迎,</span>
                        <h2><%=DAO.getStudentName(sqlSessionFactory,StuNo)%> 同学</h2>
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
                <div class="sidebar-footer hidden-small">
                    <a data-toggle="tooltip" data-placement="top" title="Settings">
                        <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                        <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="Lock">
                        <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="Logout" href="../login.jsp">
                        <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                    </a>
                </div>
                <!-- /menu footer buttons -->
            </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
            <div class="nav_menu">
                <nav>
                    <div class="nav toggle">
                        <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                    </div>

                    <ul class="nav navbar-nav navbar-right">
                        <li class="">
                            <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                <img src="images/<%=StuNo%>.jpg" onerror="javascript:this.src='images/user.png'" alt="">
                                <%out.println(DAO.getStudentName(sqlSessionFactory,StuNo));%>
                                <span class=" fa fa-angle-down"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu pull-right">
                                <li><a href="javascript:;"> Profile</a></li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="badge bg-red pull-right">50%</span>
                                        <span>Settings</span>
                                    </a>
                                </li>
                                <li><a href="javascript:;">Help</a></li>
                                <li><a href="../login.jsp"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                            </ul>
                        </li>

                        <li role="presentation" class="dropdown">
                            <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-envelope-o"></i>
                                <span class="badge bg-green"><%out.println(messages.size());%></span>
                            </a>
                            <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                                <%for(Message message:messages){%>
                                <li>
                                    <a>
                                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                                        <span>
                          <span>Teacher</span>
                          <span class="time"><%out.println(message.getTime());%></span>
                        </span>
                                        <span class="message">
                          <%out.println(message.getMessageInfo());%>
                        </span>
                                    </a>
                                </li>
                                <%}%>

                                <li>
                                    <div class="text-center">
                                        <a href="Messagebox.jsp">
                                            <strong>See All Alerts</strong>
                                            <i class="fa fa-angle-right"></i>
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
                <div class="row top_tiles">
                    <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                        <div class="tile-stats">
                            <div class="icon"><i class="fa fa-caret-square-o-right"></i></div>
                            <div class="count">179</div>
                            <h3>New Sign ups</h3>
                            <p>Lorem ipsum psdea itgum rixt.</p>
                        </div>
                    </div>
                    <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                        <div class="tile-stats">
                            <div class="icon"><i class="fa fa-comments-o"></i></div>
                            <div class="count">179</div>
                            <h3>New Sign ups</h3>
                            <p>Lorem ipsum psdea itgum rixt.</p>
                        </div>
                    </div>
                    <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                        <div class="tile-stats">
                            <div class="icon"><i class="fa fa-sort-amount-desc"></i></div>
                            <div class="count">179</div>
                            <h3>New Sign ups</h3>
                            <p>Lorem ipsum psdea itgum rixt.</p>
                        </div>
                    </div>
                    <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                        <div class="tile-stats">
                            <div class="icon"><i class="fa fa-check-square-o"></i></div>
                            <div class="count">179</div>
                            <h3>New Sign ups</h3>
                            <p>Lorem ipsum psdea itgum rixt.</p>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>推荐社团 <small>clubs</small></h2>
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

                                <%  int i = 0;
                                    for(Club club:club_Recommend){
                                        i++;//用作计数
                                        if(i>5) break;
                                %>

                                <article class="media event">
                                    <a class="pull-left date">
                                        <p class="month">April</p>
                                        <p class="day">23</p>
                                    </a>
                                    <div class="media-body">
                                        <a class="title" href="#"><%out.println(club.getClubName());%></a>
                                        <p><%out.println(club.getClubInfo());%></p>
                                    </div>
                                </article><%}%>

                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>推荐活动 <small>activities</small></h2>
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

                                <%int m = 0;
                                    for(Activity act:active_Recommend){
                                   m++;
                                   if(m > 5) break;
                                %>

                                <article class="media event">
                                    <a class="pull-left date">
                                        <p class="month">April</p>
                                        <p class="day">23</p>
                                    </a>
                                    <div class="media-body">
                                        <a class="title" href="#"><%out.println(act.getActive_name());%></a>
                                        <p><%out.println(act.getActive_info());%></p>
                                    </div>
                                </article>
                                <%}%>

                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>Top Profiles <small>Sessions</small></h2>
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
                                <article class="media event">
                                    <a class="pull-left date">
                                        <p class="month">April</p>
                                        <p class="day">23</p>
                                    </a>
                                    <div class="media-body">
                                        <a class="title" href="#">Item One Title</a>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                    </div>
                                </article>
                                <article class="media event">
                                    <a class="pull-left date">
                                        <p class="month">April</p>
                                        <p class="day">23</p>
                                    </a>
                                    <div class="media-body">
                                        <a class="title" href="#">Item Two Title</a>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                    </div>
                                </article>
                                <article class="media event">
                                    <a class="pull-left date">
                                        <p class="month">April</p>
                                        <p class="day">23</p>
                                    </a>
                                    <div class="media-body">
                                        <a class="title" href="#">Item Two Title</a>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                    </div>
                                </article>
                                <article class="media event">
                                    <a class="pull-left date">
                                        <p class="month">April</p>
                                        <p class="day">23</p>
                                    </a>
                                    <div class="media-body">
                                        <a class="title" href="#">Item Two Title</a>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                    </div>
                                </article>
                                <article class="media event">
                                    <a class="pull-left date">
                                        <p class="month">April</p>
                                        <p class="day">23</p>
                                    </a>
                                    <div class="media-body">
                                        <a class="title" href="#">Item Three Title</a>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                    </div>
                                </article>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">


                    <%
                        for(Club club:club_randoms)
                        {
                    %>

                    <div class="col-md-3 col-xs-12 widget widget_tally_box">
                        <div class="x_panel fixed_height_390">
                            <div class="x_content">

                                <div class="flex">
                                    <ul class="list-inline  widget_profile_box">
                                        <li>
                                            <a>
                                                <i class="fa fa-facebook"></i>
                                            </a>
                                        </li>
                                        <li>
                                            <img  src="images/user.png" alt="..." class="img-circle profile_img">
                                        </li>
                                        <li>
                                            <a>
                                                <i class="fa fa-twitter"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                                <h3 class="name"><%out.println(club.getClubName());%></h3>

                                <div class="flex">
                                    <ul class="list-inline count2">
                                        <li>
                                            <h3><%out.println(club.getMemberNum());%></h3>
                                            <span>Members</span>
                                        </li>
                                        <li>
                                            <h3><%out.println(club.getActiveNum());%></h3>
                                            <span>Activities</span>
                                        </li>
                                        <li>
                                            <h3><%out.println(club.getArticalNum());%></h3>
                                            <span>Articles</span>
                                        </li>
                                    </ul>
                                </div>
                                <p>
                                   <%out.println(club.getClubInfo());%>
                                </p>
                            </div>
                        </div>
                    </div>
                    <%}%>



                </div>
            </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
            <div class="pull-right">
                Copyright © UClub All Rights Reserved
            </div>
            <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
    </div>
</div>

<!-- jQuery -->
<script src="vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="vendors/fastclick/lib/fastclick.js"></script>
<!-- NProgress -->
<script src="vendors/nprogress/nprogress.js"></script>
<!-- Chart.js -->
<script src="vendors/Chart.js/dist/Chart.min.js"></script>
<!-- jQuery Sparklines -->
<script src="vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
<!-- Flot -->
<script src="vendors/Flot/jquery.flot.js"></script>
<script src="vendors/Flot/jquery.flot.pie.js"></script>
<script src="vendors/Flot/jquery.flot.time.js"></script>
<script src="vendors/Flot/jquery.flot.stack.js"></script>
<script src="vendors/Flot/jquery.flot.resize.js"></script>
<!-- Flot plugins -->
<script src="vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
<script src="vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
<script src="vendors/flot.curvedlines/curvedLines.js"></script>
<!-- DateJS -->
<script src="vendors/DateJS/build/date.js"></script>
<!-- bootstrap-daterangepicker -->
<script src="vendors/moment/min/moment.min.js"></script>
<script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- jQuery custom content scroller -->
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
<!-- Custom Theme Scripts -->
<script src="build/js/custom.min.js"></script>
<script src="mobile.js"></script>
</body>
</html>