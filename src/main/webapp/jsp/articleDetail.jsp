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
<%@ page import="static operations.DAO.getStudentName" %>
<%@ page import="model.Article" %>
<%@ page import="model.Message" %>
<%@ page import="operations.DAO" %>
<%@ page import="static operations.ManageApplyOperations.getStuName" %>
<%@ page import="static operations.ArticleOperations.getStuNoByArticleNo" %><%--
  Created by IntelliJ IDEA.
  User: 22847
  Date: 2018/7/11
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    int artcle_num = Integer.parseInt( request.getParameter("url"));
    List<Article> articles = ( List<Article>)session.getAttribute("articles");
    Article article = articles.get(artcle_num);
    String articleNo = article.getArticleNo()+"";
    response.setContentType("text/html;charset=\"utf-8\"");

    //消除接受乱码的问题
    request.setCharacterEncoding("UTF-8");
    String articleNum = request.getParameter("url");
    Integer userID = (Integer) session.getAttribute("UserNo");
    String resource = "mybatis.xml";//mybatis资源

    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

    //获取学生的名字
    int StuNo = (Integer) session.getAttribute("UserNo");
    String name = DAO.getStudentName(sqlSessionFactory,StuNo);
    String author = DAO.getStudentName(sqlSessionFactory,article.getStuNo());

    //获取该学生的信息数组
    List<Message> messages = ( List<Message>)session.getAttribute("messages");


    //获取所有评论
    List<Comment> Comments = getAllComments(sqlSessionFactory,articleNum);

    String path = (String) session.getAttribute("Path");
    Integer stuNo = (Integer)request.getSession().getAttribute("UserNo");
    String text = article.getText(path);
    int a = 0;
%>
<!DOCTYPE html>
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
    <!--&lt;!&ndash; Bootstrap &ndash;&gt;-->
    <!--<link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">-->
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- bootstrap-progressbar -->
    <link href="vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- jQuery custom content scroller -->
    <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
    <style>
        .right_col {
            min-height:800px !important;
        }
    </style>
    <style>
        .editorClass {
            width: -webkit-fill-available;
            background: white;
        }
        /*custom.min.css:1040*/
        .comment-css {
            background:white;
        }
        code {
            word-wrap: break-word;
        }
        .block_content { margin-top: 50px; }
        span.replyMessage {
            position: relative;
            /* margin-left: 40%; */
            float: right;
            margin-right: 1%;
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
</head>

<body class="nav-md" onload="compile();initFunctionTemp();goToPageOption(1);">
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
                        <img id="userImg"  src="images/<%= request.getSession().getAttribute("UserNo")%>.jpg" onerror="javascript:this.src='images/user.png'" alt="..." class="img-circle profile_img">
                    </div>
                </div>
                <div class="profile_info">
                    <span>欢迎,</span>
                    <h2><%
                        out.println(DAO.getStudentName(sqlSessionFactory,(Integer)request.getSession().getAttribute("UserNo")));%> 同学</h2>
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
                                    <li><a href="Recommend.jsp">推荐</a></li>
                                    <li><a href="media_gallery.jsp">所有社团</a></li>
                                </ul>
                            </li>
                            <li><a><i class="fa fa-cube"></i> 广场 <span class="fa fa-chevron-down"></span></a>
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
                                    <li><a href="my_group.jsp">加入的社团</a></li>
                                    <li><a href="Messagebox.jsp">收到的消息</a></li>
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
                                                        Teacher
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
                <!--下面的div是文章的显示div-->
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title" >
                            <div id="article_head" style="display: inline-grid;">
                                <h2 style="overflow: unset;
    white-space: inherit;
    width: 100%;"><%out.println(article.getTitle());%></h2>

                            </div>
                            <br>
                            <h2 style="position:absolute;">via <span><%out.println(author);%></span></h2>
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


                <!--下面的div是评论的显示的div-->
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>跟帖</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li>
                                    <a data-toggle="collapse" data-target="#firstEditor">
                                        <i class="fa fa-edit">写评论</i>
                                    </a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <!--下面的div是所有评论内容-->
                        <div class="x_content">
                            <ul class="list-unstyled msg_list">
                                <!--文章阅读者评论文章的接口-->
                                <div id="firstEditor" class="collapse demo">
                                    <li style="background:  #FAFAFA;">
                                        <div class="editorClass">
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <textarea class="resizable_textarea form-control" id="firstEditorPlate" placeholder="请输入您的跟帖" style="margin: 0px 210.266px 0px 0px;height: 92px;resize: inherit;"></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-success" style="float: right; margin: 0px; margin-right: 10px; margin-top: 10px; margin-bottom: 10px;" onclick="addReplyToArticle()">确认</button>
                                        </div>
                                    </li>
                                </div>
                                <!--所有评论div盒子-->
                                <div id="allComments">
                                    <!--通过page-divide来分页-->


                                    <%for (Comment comment:Comments){%>
                                    <div class="page-divide" id="mainComment<%=comment.getCommentNo()%>" style="display: none;">
                                        <!--li里面主评论，这里的demo，demo2，要相应换成某条评论的id-->
                                        <li>
                                            <a>
                                        <span class="image">
                                            <img id="userImgComment" src="images/<%=comment.getStuNo()%>.jpg" onerror="javascript:this.src='images/user.png'" alt="">
                                        </span>
                                                <span>
                                                    <span><%=getStuName(sqlSessionFactory,comment.getStuNo())%></span>
                                                    <%if(userID==comment.getStuNo()||userID==getStuNoByArticleNo(sqlSessionFactory,articleNum)){%>
                                                    <span class="replyMessage">
                                                        <i class="fa fa-remove" onclick="removeReplyFromArticle('<%=comment.getCommentNo()%>')"></i>
                                                    </span>
                                                    <%}%>
                                                    <span class="replyMessage" data-toggle="collapse"  onclick="$('#commentOf<%=comment.getCommentNo()%>').collapse('toggle');">
                                                        <i class="fa fa-reorder"></i>
                                                    </span>
                                                    <span class="replyMessage" data-toggle="collapse" data-target="#editorOf<%=comment.getCommentNo()%>">
                                                        <i class="fa fa-edit"></i>
                                                    </span>
                                                    <span class="time">
                                                        <%
                                                            String formatTime1 = null;
                                                            //格式 24小时制：2016-07-06 09:39:58
                                                            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                                                            formatTime1 = dateFormat.format( comment.getSendTime());
                                                        %><%=formatTime1%>
                                                    </span>
                                                </span>
                                                <div class="clearfix"></div>
                                                <span class="message">
                                                   <%=comment.getComment()%>
                                                </span>
                                            </a>
                                        </li>
                                        <div id="editorOf<%=comment.getCommentNo()%>" class="collapse demo">
                                            <li style="background:  white;">
                                                <div class="editorClass">
                                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                                        <textarea id="editorPlateOf<%=comment.getCommentNo()%>" class="resizable_textarea form-control" placeholder="请输入您的回复" style="margin: 0px 210.266px 0px 0px;height: 92px;resize: inherit;"></textarea>
                                                    </div>
                                                    <button type="submit" class="btn btn-success" style="float: right; margin: 0px; margin-right: 10px; margin-top: 10px; margin-bottom: 10px;" onclick="addReplyToSomeone('<%=comment.getCommentNo()%>')">确认</button>
                                                </div>
                                            </li>
                                        </div>
                                        <div id="commentOf<%=comment.getCommentNo()%>" class="collapse demo">
                                            <%
                                                List<Comment> Reply = getAllReply(sqlSessionFactory,comment.getCommentNo());
                                            %>
                                            <%for(Comment reply:Reply){%>
                                            <li id="detailOf<%=reply.getCommentNo()%>" class="comment-css" style="background:white;">
                                                <a>
                                                    <span class="image">
                                                       <img id="userImgReply" src="images/<%=reply.getStuNo()%>.jpg" onerror="javascript:this.src='images/user.png'" alt="">
                                                    </span>
                                                    <span>
                                                        <span><%=getStuName(sqlSessionFactory,reply.getStuNo())%></span>
                                                         <%if(userID==reply.getStuNo()||userID==getStuNoByArticleNo(sqlSessionFactory,articleNum)){%>
                                                        <span class="replyMessage" onclick="removeReplyFromComment('<%=reply.getCommentNo()%>')">
                                                            <i class="fa fa-remove"></i>
                                                        </span>
                                                        <%}%>
                                                        <%
                                                            String formatTime = null;
                                                            //格式 24小时制：2016-07-06 09:39:58
                                                            DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                                                            formatTime = dateFormat2.format( reply.getSendTime());
                                                        %>
                                                        <span class="time"><%=formatTime%></span>
                                                    </span>
                                                    <div class="clearfix"></div>
                                                    <span class="message">
                                                       <%=reply.getComment()%>
                                                    </span>
                                                </a>
                                            </li>
                                            <%}%>
                                        </div>
                                    </div>
                                    <%}%>

                                </div>
                            </ul>
                            <!--下面的div用来分页-->
                            <div class="row" id="pageDivide">
                                <div class="col-sm-7  col-sm-3  col-xs-20" style="display: contents;">
                                    <div class="dataTables_paginate paging_simple_numbers" id="datatable_paginate" style="margin-right: 10px;">
                                        <ul class="pagination" id="choosePage">
                                            <li class="paginate_button previous" id="datatable_previous" onclick="goToPageOption(currentPage-1);">
                                                <a  aria-controls="datatable" data-dt-idx="0" tabindex="0" style="padding: 4px 5px !important;">
                                                    <-
                                                </a>
                                            </li>
                                            <li id="outerPage1" class="paginate_button " onclick="goToPageOption(pageRange[0])" >
                                                <a id="Page1" aria-controls="datatable" data-dt-idx="1" tabindex="0" style="padding: 4px 5px !important;">
                                                    1
                                                </a>
                                            </li>
                                            <li id="outerPage2" class="paginate_button " onclick="goToPageOption(pageRange[1])" >
                                                <a id="Page2" aria-controls="datatable" data-dt-idx="2" tabindex="0" style="padding: 4px 5px !important;">
                                                    2
                                                </a>
                                            </li>
                                            <li id="outerPage3" class="paginate_button " onclick="goToPageOption(pageRange[2])" >
                                                <a id="Page3" aria-controls="datatable" data-dt-idx="3" tabindex="0" style="padding: 4px 5px !important;">
                                                    3
                                                </a>
                                            </li>
                                            <li id="outerPage4" class="paginate_button " onclick="goToPageOption(pageRange[3])">
                                                <a id="Page4"  aria-controls="datatable" data-dt-idx="4" tabindex="0" style="padding: 4px 5px !important;">
                                                    4
                                                </a>
                                            </li>
                                            <li id="outerPage5" class="paginate_button " onclick="goToPageOption(pageRange[4])">
                                                <a id="Page5"  aria-controls="datatable" data-dt-idx="5" tabindex="0" style="padding: 4px 5px !important;">
                                                    5
                                                </a>
                                            </li>
                                            <li class="paginate_button next" id="datatable_next" onclick="goToPageOption(currentPage+1);">
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
<!--<script src="vendors/bootstrap/dist/js/bootstrap.min.js">-->
<!--</script>-->
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
<script src="vendors/showdown/dist/showdown.js"></script>
<script>
    // 默认一页5个
    var allNodes;
    var allNum;
    var showNodes;
    var nowNum = 5;//一页的个数
    var allPages;
    var currentPage;
    var pageRange;


    var initFunctionTemp = function()
    {
        var temp = document.getElementById('allComments');
        allNodes = temp.getElementsByClassName("page-divide");
        allNum = allNodes.length;
        // allNodes = deepCopy(allNodes);
        allPages = Math.ceil(allNum*1.0/nowNum);
        for(var i = 0; i<allNum; i++)
        {
            allNodes[i].style.display="none";
        }
        // goToPage(1);
    }

    var getIndexPages = function () {
        if(currentPage<=3&&currentPage>0||allPages<=5)
        {
            return [1,2,3,4,5];
        }
        if(currentPage>3&&currentPage<allPages-2)
        {
            return [currentPage-2,currentPage-1,currentPage,currentPage+1,currentPage+2];
        }
        if(currentPage>=allPages-2&&currentPage<=allPages)
        {
            return [allPages-4,allPages-3,allPages-2,allPages-1,allPages];
        }
    }

    var goToPageOption = function (pageNum) {
        if($('#searchInfo').val()!=='')
        {
            searchForGroup(pageNum);
        }else{
            goToPage(pageNum,allNodes,allNum);
        }
        // var height = $("#allGroupsPage").offset().top;
        // height = height + 30 + $("#allGroupsPage").height();
        var height = $(window).height();
        height = height.toString();
        $("#searchSize").css("min-height",height+"px");
//		$("#allGroups").css("display","inline");
    }

    var goToPage = function(pageNum,originNodes,allNumber)
    {
        if(pageNum>allPages) {
            return;
        }
        if(pageNum<=0) {
            return;
        }
        for(var i = 0; i<allNumber; i++)
        {
            originNodes[i].style.display="none";
        }
        currentPage = pageNum;
        var nodes = new Array();
        var init = (pageNum-1)*nowNum;
        for(var i = 0; i<(nowNum>=(allNum-init)?(allNum-init):nowNum); i++)
        {
            nodes.push(allNodes[i+init]);
            allNodes[i+init].style.display="inline";
        }
        showNodes=nodes;
        pageRange = getIndexPages();

        for(var temp = 0; temp<5; temp++)
        {
            document.getElementById("Page"+(temp+1)).innerText='?';
            document.getElementById("outerPage"+(temp+1)).style.display = "inline";
            document.getElementById("Page"+(temp+1)).style.display="inline";
        }

        for(temp = 0; temp<(5>=allPages?allPages:5); temp++)
        {
            document.getElementById("Page"+(temp+1)).innerText=pageRange[temp];
            document.getElementById("outerPage"+(temp+1)).className = "paginate_button";
            if(document.getElementById("Page"+(temp+1)).innerText===pageNum.toString())
            {
                document.getElementById("outerPage"+(temp+1)).className = "paginate_button active";
            }
        }

        if(allPages<5){
            for(temp = 0; temp<5; temp++)
            {
                if(document.getElementById("Page"+(temp+1)).innerText==='?') {
                    document.getElementById("outerPage" + (temp + 1)).style.display = "none";
                    document.getElementById("Page"+(temp+1)).style.display="none";
                }
            }
        }
    }
</script>
<!--下面是评论以及文章操作js代码-->
<script>
    var text = '';
    function compile(){
        $.ajax({
            url:'/GetArticleServlet',
            type:'POST',
            data:{
                articleNo:'<%out.print(artcle_num);%>'
            },
            success:function (data) {
                text = data;
                var converter = new showdown.Converter();
                var html = converter.makeHtml(text);
                document.getElementById("markdownArea").innerHTML = html;
                windowResize();
                markdownResize();
            }
        });

    }

    function markdownResize()
    {
        temp = $(window).width();
        if (temp <= 342) {
            <!--$("#markdownArea").find("h1").-->
            $('h6').css('font-size', '10px');
            $('p').css('font-size', '10px');
            $('h5').css('font-size', '10px');
            $('h4').css('font-size', '13px');
//            $('h2').css('font-size', '18px');
            $('h3').css('font-size', '15px');
            $('h1').css('font-size', '20px');
        } else {
            $("#markdownArea").find('p').css('font-size', '');
            $("#markdownArea").find('h6').css('font-size', '');
            $("#markdownArea").find('h5').css('font-size', '');
            $("#markdownArea").find('h4').css('font-size', '');
            $("#markdownArea").find('h2').css('font-size', '15px');
            $("#markdownArea").find('h3').css('font-size', '14px');
            $("#markdownArea").find('h1').css('font-size', '17px');
        }
    }

    $(window).resize(function(){
        windowResize();
        markdownResize();



    });

    $(window).ready(function () {
        compile()
    })
    var temp1 = '2';
    function addReplyToSomeone(id) {
        var judge = confirm("确认添加回复吗？");
        if (judge) {
            if($('#editorPlateOf'+id+'').val().length===0)
            {
                alert("评论不能为空！");
                return undefined;
            }
            var temp3 = temp1;
            temp1 = temp1+'2';
            $('#commentOf'+id+'').collapse('show');
            $.ajax({
                url:'/AddComment',//servlet名字
                type:'POST',
                data:{
                    status:2,
                    content : $('#editorPlateOf'+id+'').val(),
                    articleNo: <%=articleNum%>,
                    relatedCommentNo:id
                },
                success:function (data) {
                    temp3 = data;
                }
            });
            $("div#commentOf" + id + " ").prepend(
                "<li id=\"detailOf"+temp3+"\" class=\"comment-css\" style=\"background: white;\">\n" +
                "                                                <a>\n" +
                "                                                    <span class=\"image\">\n" +
                "                                                        <img id=\"userImg2\" src=\"images/<%=userID%>.jpg\" onerror=\"javascript:this.src='images/user.png'\" alt=\"\">\n" +
                "                                                    </span>\n" +
                "                                                    <span>\n" +
                "                                                        <span><%=getStuName(sqlSessionFactory,userID)%></span>\n" +
                "                                                        <span class=\"replyMessage\" onclick=\"removeReplyFromComment('"+temp3+"')\">\n" +
                "                                                            <i class=\"fa fa-remove\"></i>\n" +
                "                                                        </span>\n" +
                "                                                        <span class=\"time\">刚刚</span>\n" +
                "                                                    </span>\n" +
                "                                                    <div class=\"clearfix\"></div>\n" +
                "                                                    <span class=\"message\">\n" +
                $('#editorPlateOf'+id+'').val() +
                "                                                    </span>\n" +
                "                                                </a>\n" +
                "                                            </li>"
            ).fadeIn(30000,function () {
                $('#editorOf'+id+'').collapse('hide');
                $('#editorPlateOf'+id+'').val("");
            });

        }
    }

    function removeReplyFromArticle(id) {
        var newNowPage = currentPage;
        var judge = confirm("确认移除您的回复吗？");
        if (judge) {
            $.ajax({
                url:'/AddComment',//servlet名字
                type:'POST',
                data:{
                    status:3,
                    commentID:id
                },
                success:function (data) {
                    $('#mainComment'+id+'').remove().fadeOut('slow',function () {
                        $('#firstEditor').collapse('hide');
                        initFunctionTemp();
                        if(allPages<newNowPage)
                            goToPageOption(newNowPage-1);
                        else if (allPages>=newNowPage)
                            goToPageOption(newNowPage);
                    });
                }
            });


        }
    }

    function removeReplyFromComment(id) {
        var newNowPage = currentPage;
        var judge = confirm("确认移除您的回复吗？");
        if (judge) {
            $.ajax({
                url:'/AddComment',//servlet名字
                type:'POST',
                data:{

                    status:4,
                    commentID:id
                },
                success:function (data) {
                    $('#detailOf'+id+'').remove().fadeOut('slow',function () {
                        $('#firstEditor').collapse('hide');
                        initFunctionTemp();
                        goToPageOption(newNowPage);
                    });
                }
            });


        }
    }

    var temp = '1';
    function addReplyToArticle() {
        var judge = confirm("确认添加回复吗？");
        if (judge) {
            var id = temp;
            if($('#firstEditorPlate').val().length===0)
            {
                alert("评论不能为空！");
                return undefined;
            }
            $.ajax({
                url:'/AddComment',//servlet名字
                type:'POST',
                data:{
                    status:1,
                    content : $('#firstEditorPlate').val(),
                    articleNo:<%=articleNum%> ,
                },
                success:function (data) {
                    id = data;
                }
            });

            $("div#allComments").prepend(
                " <div class=\"page-divide\" id=\"mainComment"+id+"\">\n" +
                "                                        <li>\n" +
                "                                            <a>\n" +
                "                                        <span class=\"image\">\n" +
                "                                            <img id=\"userImgAddComment\" src=\"images/<%=userID%>.jpg\" onerror=\"javascript:this.src='images/user.png'\" alt=\"\">\n" +
                "                                        </span>\n" +
                "                                                <span>\n" +
                "                                                    <span><%=getStuName(sqlSessionFactory,userID)%></span>\n" +
                "                                                    <span class=\"replyMessage\">\n" +
                "                                                        <i class=\"fa fa-remove\" onclick=\"removeReplyFromArticle('"+id+"')\"></i>\n" +
                "                                                    </span>\n" +
                "                                                    <span class=\"replyMessage\"   onclick=\";$('#commentOf"+id+"').collapse('toggle');\">\n" +
                "                                                        <i class=\"fa fa-edit\"></i>\n" +
                "                                                    </span>\n" +
                "                                                    <span class=\"replyMessage\" data-toggle=\"collapse\" data-target=\"#editorOf"+id+"\">\n" +
                "                                                        <i class=\"fa fa-reply\"></i>\n" +
                "                                                    </span>\n" +
                "                                                    <span class=\"time\">\n" +
                "                                                      刚刚\n" +
                "                                                    </span>\n" +
                "                                                </span>\n" +
                "                                                <div class=\"clearfix\"></div>\n" +
                "                                                <span class=\"message\">\n" +
                $('#firstEditorPlate').val() +
                "                                                </span>\n" +
                "                                            </a>\n" +
                "                                        </li>\n" +
                "                                        <div id=\"editorOf"+id+"\" class=\"collapse demo\">\n" +
                "                                            <li style=\"background:  white;\">\n" +
                "                                                <div class=\"editorClass\">\n" +
                "                                                    <div class=\"col-md-12 col-sm-12 col-xs-12\">\n" +
                "                                                        <textarea id=\"editorPlateOf"+id+"\" class=\"resizable_textarea form-control\" placeholder=\"请输入您的回复\" style=\"margin: 0px 210.266px 0px 0px;height: 92px;resize: inherit;\"></textarea>\n" +
                "                                                    </div>\n" +
                "                                                    <button type=\"submit\" class=\"btn btn-success\" style=\"float: right; margin: 0px; margin-right: 10px; margin-top: 10px; margin-bottom: 10px;\" onclick=\"addReplyToSomeone('"+id+"')\">确认</button>\n" +
                "                                                </div>\n" +
                "                                            </li>\n" +
                "                                        </div>\n" +
                "                                        <div id=\"commentOf"+id+"\" class=\"collapse demo\">\n" +
                "                                            \n" +
                "                                        </div>\n" +
                "                                    </div>"
            ).fadeIn('slow',function () {
                // $('#commentOf'+id+'').collapse({
                //     toggle: false
                // });
                // $('#commentOf'+id+'').collapse('show');
                initFunctionTemp();
                goToPageOption(1);
            });
            $('#firstEditor').collapse('hide');
            $('#firstEditorPlate').val("");
        }
    }

    //     $(function () {
    // //修复collapse不能正常折叠的问题
    //         $(".collapsed").click(function () {
    //             var itemHref = $(this).attr("href");
    //             var itemClass = $(itemHref).attr("class");
    //             if (itemClass === "panel-collapse collapse") {
    //                 $(itemHref).attr("class", "panel-collapse collapse in").css("height", "auto");
    //             } else {
    //                 $(itemHref).attr("class", "panel-collapse collapse").css("height", "0px");
    //             }
    //             return false;//停止运行bootstrap自带的函数
    //         });
    //     })

</script>
<!-- jQuery custom content scroller -->
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>

