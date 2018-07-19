<%--
  Created by IntelliJ IDEA.
  User: 22847
  Date: 2018/7/17
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Test.Test" %>
<%@ page import="operations.DAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="model.Article" %>
<%@ page import="java.util.List" %>
<%@ page import="static operations.ClubOperations.getClubName" %>
<%@ page import="static operations.ManageApplyOperations.getStuName" %>
<%@ page import="static operations.ArticleOperations.getAllArticle" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="model.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //消除接受乱码的问题
    request.setCharacterEncoding("UTF-8");
    String resource = "mybatis.xml";
    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);


    List<Article> articles = getAllArticle();

    session.setAttribute("articles",articles);
    request.setAttribute("articles",articles);

    List<Message> messages = (List<Message>) session.getAttribute("messages");

%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
        plaza
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
    </style>
    <!-- Custom Theme Style -->
    <link href="build/css/custom.min.css" rel="stylesheet">
</head>
<body class="nav-md" onload="initFunctionTemp()">
<div class="container body">
    <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
            <div class="col-md-3 left_col menu_fixed">
                <div class="left_col scroll-view">
                    <div class="navbar nav_title" style="border: 0;">
                        <a href="Recommend.jsp" class="site_title"><img src="images/logo8.png"/><span>&nbsp;</span></a>
                    </div>

                    <div class="clearfix"></div>

                    <!-- menu profile quick info -->
                    <div class="profile clearfix">
                        <div class="profile_pic">
                            <img src="images/img.jpg" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                            <span>欢迎,</span>
                            <h2><%String name = DAO.getStudentName(sqlSessionFactory,(Integer) request.getSession().getAttribute("UserNo"));
                                out.println(name);
                            %> 同学</h2>
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
                                <li><a><i class="fa fa-edge"></i> 广场 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu">
                                        <li><a href="#">进入广场</a></li>
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
                                        <li><a href="#">收到的消息</a></li>
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
                                <%out.println(name);%>
                                <span class=" fa fa-angle-down">
                                        </span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu pull-right">
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
                                            <%out.println(messages.size());%>
                                        </span>
                            </a>
                            <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                                <%for(Message message:messages){%>
                                <li>
                                    <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                        <span>
                                                    <span>
                                                         teacher
                                                    </span>
                                                    <span class="time">
                                                        <%out.println(message.getTime());%>
                                                    </span>
                                                </span>
                                        <span class="message">
                                                    <%out.println(message.getMessageInfo());%>
                                                </span>
                                    </a>
                                </li>
                                <%}%>
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
                            广场
                        </h3>
                    </div>
                </div>
                <div class="title_right">
                    <div class="col-md-4 col-sm-4 col-xs-12 form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" id="searchInfo" class="form-control" placeholder="随便搜">
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
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>
                            广场文章
                        </h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="x_content">
                        <ul class="list-unstyled timeline" id="allGroups">
                            <% for (int i=0;i<articles.size();i++){%>
                            <li class="groupList">
                                <div class="block">
                                    <div class="tags">
                                        <%
                                            //String articleNo= String.valueOf(articles.get(i).getArticleNo());
                                            out.print("    <a href=\"articleDetail.jsp?url="+i+"\" class=\"tag\">");
                                        %>
                                        <span style="text-align: center;" class="clubName">
                                                        <%=getClubName(sqlSessionFactory,articles.get(i).getClubNo())%>
                                                    </span>
                                        </a>
                                    </div>
                                    <div class="block_content">
                                        <h2 class="title ArticleTitle">
                                            <a class="articleTitle">
                                                <%=articles.get(i).getTitle()%>
                                            </a>
                                        </h2>
                                        <div class="byline">
                                                    <span class="publishTime">
                                                        <%
                                                            String formatDate = null;
                                                            //格式 24小时制：2016-07-06 09:39:58
                                                            DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                                                            formatDate = dFormat.format( articles.get(i).getDate());
                                                        %>
                                                         <%=formatDate%>
                                                    </span>
                                            via
                                            <a class="author">
                                                <%=getStuName(sqlSessionFactory,articles.get(i).getStuNo())%>
                                            </a>
                                        </div>
                                        <p class="excerpt">
                                                    <span class="articleContent">
                                                     <%String path = (String)session.getAttribute("Path");%>
                                                        <%=articles.get(i).getStandardText(path)%>
                                                    </span>
                                            <%
                                                //String a= String.valueOf(articles.get(i).getArticleNo());
                                                out.print("<a href=\"articleDetail.jsp?url="+i+"\">");
                                            %>

                                            Read&nbsp;More
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </li>

                            <%}%>



                        </ul>
                    </div>
                    <div class="row" id="pageDivide">
                        <div class="col-sm-5">
                            <div class="dataTables_info" id="datatable_info" role="status" aria-live="polite">
                                <!--Showing 1 to 10 of 57 entries-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" >
                <div class="col-sm-5">
                    <div class="dataTables_info"  role="status" aria-live="polite">
                        <!--Showing 1 to 10 of 57 entries-->
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="dataTables_paginate paging_simple_numbers" id="datatable_paginate">
                        <ul class="pagination" id="choosePage">
                            <li class="paginate_button previous" id="datatable_previous" onclick="goToPageOption(currentPage-1);">
                                <a aria-controls="datatable" data-dt-idx="0" tabindex="0">
                                    Previous
                                </a>
                            </li>
                            <li id="outerPage1" class="paginate_button " onclick="goToPageOption(pageRange[0])">
                                <a id="Page1" aria-controls="datatable" data-dt-idx="1" tabindex="0">
                                    1
                                </a>
                            </li>
                            <li id="outerPage2" class="paginate_button " onclick="goToPageOption(pageRange[1])">
                                <a id="Page2" aria-controls="datatable" data-dt-idx="2" tabindex="0">
                                    2
                                </a>
                            </li>
                            <li id="outerPage3" class="paginate_button " onclick="goToPageOption(pageRange[2])">
                                <a id="Page3" aria-controls="datatable" data-dt-idx="3" tabindex="0">
                                    3
                                </a>
                            </li>
                            <li id="outerPage4" class="paginate_button " onclick="goToPageOption(pageRange[3])">
                                <a id="Page4" aria-controls="datatable" data-dt-idx="4" tabindex="0">
                                    4
                                </a>
                            </li>
                            <li id="outerPage5" class="paginate_button " onclick="goToPageOption(pageRange[4])">
                                <a id="Page5" aria-controls="datatable" data-dt-idx="5" tabindex="0">
                                    5
                                </a>
                            </li>
                            <li class="paginate_button next" id="datatable_next" onclick="goToPageOption(currentPage+1);">
                                <a aria-controls="datatable" data-dt-idx="7" tabindex="0">
                                    Next
                                </a>
                            </li>
                        </ul>
                    </div>
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
<script src="vendors/showdown/dist/showdown.js"></script>
<script>
    // 默认一页15个
    var allNodes;
    var allNum;
    var showNodes;
    var nowNum = 5; //一页的个数
    var allPages;
    var currentPage;
    var pageRange;
    var articles = new Array();
    var searchSentence;

    var getArticle = function() {
        var clubs = document.getElementsByClassName('clubName');
        var titles = document.getElementsByClassName('articleTitle');
        var authors = document.getElementsByClassName('author');
        var contents = document.getElementsByClassName('articleContent');
        var times = document.getElementsByClassName('publishTime');
        allNum = clubs.length;
        var converter = new showdown.Converter();
        for (var i = 0; i < allNum; i++) {
            contents[i].innerHTML = contents[i].innerHTML.trim();
            var html = converter.makeHtml(contents[i].innerHTML);
            html = html.replace(/<[^>]+>/g,'');
            contents[i].innerHTML = html;
            var article = clubs[i].innerHTML + " " + titles[i].innerHTML + " " + authors[i].innerHTML + " " + html + " " + times[i].innerHTML;
            articles.push(article);
            if (contents[i].innerHTML.trim().length > 200) {
                contents[i].innerHTML = contents[i].innerHTML.trim().substring(0, 200) + "....";
            } else {
                contents[i].innerHTML = contents[i].innerHTML.trim();
            }
        }
    }

    var initFunctionTemp = function() {
        getArticle();
        var temp = document.getElementById('allGroups');
        allNodes = temp.getElementsByClassName("groupList");
        allNum = allNodes.length;
        // allNodes = deepCopy(allNodes);
        allPages = Math.ceil(allNum * 1.0 / nowNum);
        for (var i = 0; i < allNum; i++) {
            allNodes[i].style.display = "none";
        }
        goToPage(1);
    }

    var getIndexPages = function() {
        if (currentPage <= 3 && currentPage > 0 || allPages <= 5) {
            return [1, 2, 3, 4, 5];
        }
        if (currentPage > 3 && currentPage < allPages - 2) {
            return [currentPage - 2, currentPage - 1, currentPage, currentPage + 1, currentPage + 2];
        }
        if (currentPage >= allPages - 2 && currentPage <= allPages) {
            return [allPages - 4, allPages - 3, allPages - 2, allPages - 1, allPages];
        }
    }

    var goToPageOption = function(pageNum) {
        if ($('#searchInfo').val() !== '' || searchSentence !== '') {
            searchForGroup(pageNum);
        } else {
            goToPage(pageNum, allNodes, allNum);
        }
    }

    var goToPage = function(pageNum, originNodes, allNumber) {
        if (pageNum > allPages) {
            return;
        }
        if (pageNum <= 0) {
            return;
        }
        for (var i = 0; i < allNumber; i++) {
            originNodes[i].style.display = "none";
        }
        currentPage = pageNum;
        var nodes = new Array();
        var init = (pageNum - 1) * nowNum;
        for (var i = 0; i < (nowNum >= (allNum - init) ? (allNum - init) : nowNum); i++) {
            nodes.push(allNodes[i + init]);
            allNodes[i + init].style.display = "inline";
        }
        showNodes = nodes;
        pageRange = getIndexPages();

        for (var temp = 0; temp < 5; temp++) {
            document.getElementById("Page" + (temp + 1)).innerText = '?';
            document.getElementById("outerPage" + (temp + 1)).style.display = "inline";
            document.getElementById("Page" + (temp + 1)).style.display = "inline";
        }

        for (temp = 0; temp < (5 >= allPages ? allPages: 5); temp++) {
            document.getElementById("Page" + (temp + 1)).innerText = pageRange[temp];
            document.getElementById("outerPage" + (temp + 1)).className = "paginate_button";
            if (document.getElementById("Page" + (temp + 1)).innerText === pageNum.toString()) {
                document.getElementById("outerPage" + (temp + 1)).className = "paginate_button active";
            }
        }
        if (allPages < 5) {
            for (temp = 0; temp < 5; temp++) {
                if (document.getElementById("Page" + (temp + 1)).innerText === '?') {
                    document.getElementById("outerPage" + (temp + 1)).style.display = "none";
                    document.getElementById("Page" + (temp + 1)).style.display = "none";
                }
            }
        }
    }

    function searchForGroup(pageNum) {
        var searchInfo = $('#searchInfo').val();
        var tempNodes = allNodes;
        var tempAllNum = allNum;
        var tempAllPages = allPages;
        var showNodes = new Array();
        for (var i = 0; i < allNum; i++) {
            if (articles[i].indexOf(searchInfo) !== -1) {
                showNodes.push(allNodes[i]);
            }
        }
        allNodes = showNodes;
        allNum = allNodes.length;
        allPages = Math.ceil(allNum * 1.0 / nowNum);
        goToPage(pageNum, tempNodes, tempAllNum);
        allNodes = tempNodes;
        allNum = tempAllNum;
        allPages = tempAllPages;
    }
</script>
<!--
作者：offline
时间：2018-07-10
描述：手机初步适配
-->
<script src="mobile.js"></script>
<!-- jQuery custom content scroller -->
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>