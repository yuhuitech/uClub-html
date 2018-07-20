<%@ page import="java.io.InputStream" %>
<%@ page import="Test.Test"%>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="operations.DAO" %>
<%@ page import="java.util.List" %>
<%@ page import="operations.ClubOperations" %>
<%@ page import="java.io.File" %>
<%@ page import="static operations.ArticleOperations.getArticleByStuNo" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>
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

            width: 2000px；
        }
        .modal-body{
            height:500px;
            overflow:scroll;


        }
        /*.modal.in .modal-dialog{-webkit-transform:translate(0,-50%);-ms-transform:translate(0,-50%);-o-transform:translate(0,-50%);transform:translate(0,-50%)}
        .modal-dialog{position:absolute;width:auto;margin:0px auto;left:10px;right:0;top:10%}
        @media (min-width:1000px){.modal-dialog{width:600px}*/
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
    <link href="https://cdn.bootcss.com/cropper/4.0.0/cropper.css" rel="stylesheet">

    <%
        Integer StuNo= (Integer) session.getAttribute("UserNo");
        String resource = "mybatis.xml";
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        Student student=DAO.getStudentInfo(sqlSessionFactory,StuNo);
        List<Club> adminClubs=ClubOperations.getAllJoinClubs(sqlSessionFactory,StuNo);
        List<Club> joinClubs = DAO.getStudentClubs(sqlSessionFactory,StuNo,"成员");
        String StuName=DAO.getStudentName(sqlSessionFactory,StuNo);
        //  for(int i=0)
        if(adminClubs.size()!=0) {
            for (int i = 0; i < adminClubs.size(); i++) {
                for(int j=0;j< joinClubs.size();j++){
                    if(adminClubs.get(i).getClubNo()==joinClubs.get(j).getClubNo())adminClubs.remove(i);
                }
            }
        }
        List<Activity> acts=DAO.getJoinActivity(sqlSessionFactory,StuNo);
        String headImg="images/"+StuNo+".jpg";
        File dir = new File(request.getContextPath()+"images/"+StuNo+".jpg");
        if(dir.exists()) System.out.println("The file exist");
        else System.out.println("The file is not exist");



        List<Article> myArticle = getArticleByStuNo(sqlSessionFactory,StuNo);
        List<Message> messages = (List<Message>)session.getAttribute("messages");
        session.setAttribute("articles",myArticle);
        request.setAttribute("articles",myArticle);

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
                        <img id="userImg"  src="images/<%=StuNo%>.jpg" onerror="javascript:this.src='images/user.png'" alt="..." class="img-circle profile_img">
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
                                <img id="userImg2" src="images/<%=StuNo%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/user.png'" alt="">
                                <%=student.getStuName()%>
                                <span class=" fa fa-angle-down">
                                        </span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu pull-right">
                                <li>
                                    <a href="../login.jsp">
                                        <i class="fa fa-sign-out pull-right">
                                        </i>
                                        返回登录
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li role="presentation" class="dropdown" id="messageDropDown">
                            <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown"
                               aria-expanded="false">
                                <i class="fa fa-envelope-o" style=" line-height: 32px;"></i>
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
                <div class="page-title">

                </div>
                <div class="title_left">
                    <h3>我的简历</h3>
                </div>

                <div class="title_right">
                    <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                        </div>
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>用户小报</h2>
                                <ul class="nav navbar-right panel_toolbox">

                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="col-md-3 col-sm-3 col-xs-12 profile_left">
                                    <div class="profile_img">
                                        <div id="crop-avatar">
                                            <!-- Current avatar -->
                                            <img class="img-responsive avatar-view" id="originalPhoto" src="images/<%=StuNo%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/user.png'" alt="Avatar" title="Change the avatar">
                                        </div>
                                    </div>
                                    <h3><%=student.getStuName()%></h3>

                                    <ul class="list-unstyled user_data" id="StuInfo">
                                        <li><i class="fa fa-map-marker user-profile-icon">&nbsp; 学校:</i> <span>武汉大学</span>
                                        </li>

                                        <li>
                                            <i class="fa fa-child user-profile-icon">&nbsp; 性别:</i> <span><%=student.getSex()%></span>
                                        </li>

                                        <li>
                                            <i class="fa fa-graduation-cap user-profile-icon">年级:</i><span> <%=student.getGrade()%></span>
                                        </li>
                                        <li>
                                            <i class="fa fa-star user-profile-icon">&nbsp; 院系:</i><span> <%=student.getCollege()%></span>
                                        </li>

                                        <li>
                                            <i class="fa fa-phone user-profile-icon">&nbsp; 电话:</i> <span><%=student.getTel()%></span>
                                        </li>
                                        <li>
                                            <i class="fa  fa-envelope user-profile-icon">&nbsp;邮箱: </i><span> <%=student.getEmail()%></span>
                                        </li>
                                        <li>
                                            <i class="fa fa-smile-o user-profile-icon">&nbsp; 个人介绍:</i> <span><%=student.getSelf_introduce()%></span>
                                        </li>
                                    </ul>

                                    <a class="btn btn-success" data-target="#changeMyInfo" data-toggle="modal"><i class="fa fa-edit m-right-xs" onclick="origianlPhoto = $('#originalPhoto').attr('src');"></i>修改信息</a>
                                    <br />
                                    <br />

                                    <!-- start skills -->
                                    <div class="col-md-12 col-sm-12 col-xs-12" style="padding: 0;">
                                        <div class="profile_title" style="text-align:  center;">
                                            <div class="col-md-19" style="margin: auto;">
                                                <h2 style="">数据快览</h2>
                                            </div>
                                        </div>
                                        <div id="chartOfUser" style="margin-top: 20px;margin-bottom: 20px;margin-left: 10px;">
                                            <canvas id="canvasDoughnut" height="160" width="322" style="width: 161px; height: 80px;"></canvas>
                                        </div>
                                    </div>
                                    <!-- end of skills -->
                                </div>
                                <div class="col-md-9 col-sm-9 col-xs-12">

                                    <div class="x_content ">
                                        <!-- start accordion -->
                                        <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                                            <div class="panel">
                                                <a class="panel-heading" role="tab" id="headingOne" data-toggle="collapse"
                                                   data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                    <h4 class="panel-title">
                                                        加入社团
                                                    </h4>
                                                </a>
                                                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel"
                                                     aria-labelledby="headingOne" aria-expanded="false">
                                                    <div class="panel-body col-md-12 col-sm-12 col-xs-12">
                                                        <table class="table table-striped ">
                                                            <thead>
                                                            <tr>
                                                                <th></th>
                                                                <th>社团名称</th>
                                                                <th>职务</th>

                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <%
                                                                int i=1;
                                                                for(Club admin:adminClubs){ %>
                                                            <tr>
                                                                <th scope="row"><%=i++%></th>
                                                                <td><%=admin.getClubName()%></td>
                                                                <td><%=DAO.getStudentJob(sqlSessionFactory,StuNo,admin.getClubNo())%></td>
                                                            </tr>
                                                            <%   }
                                                                for(Club join:joinClubs){ %>
                                                            <tr>
                                                                <th scope="row"><%=i++%></th>
                                                                <td><%=join.getClubName()%></td>
                                                                <td>成员</td>
                                                            </tr>
                                                            <%   }
                                                            %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel">
                                                <a class="panel-heading collapsed" role="tab" id="headingTwo" data-toggle="collapse"
                                                   data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                    <h4 class="panel-title">
                                                        最近文章
                                                    </h4>
                                                </a>
                                                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel"
                                                     aria-labelledby="headingTwo" aria-expanded="false">
                                                    <div class="panel-body">
                                                        <ul class="list-unstyled timeline">

                                                            <%
                                                                int count=0;
                                                                for (Article article:myArticle){
                                                            %>
                                                            <li>
                                                                <div class="newStyle">
                                                                    <div class="block_content">
                                                                        <h2 class="title">
                                                                            <a>
                                                                                <h3>
                                                                                   <%=article.getTitle()%>
                                                                                </h3>
                                                                            </a>
                                                                        </h2>
                                                                        <div class="byline">
                                                                            <span>
                                                                                 <%
                                                                                     String formatDate = null;
                                                                                     //格式 24小时制：2016-07-06 09:39:58
                                                                                     DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                                                                                     formatDate = dFormat.format( article.getDate());
                                                                                 %>
                                                                                 <%=formatDate%>
                                                                            </span>
                                                                            by
                                                                            <a>
                                                                              <%=StuName%>
                                                                            </a>
                                                                        </div>
                                                                        <p class="excerpt">
                                                                            <%String path = (String)session.getAttribute("Path");%>
                                                                            <%=article.getStandardText(path)%>
                                                                            <%
                                                                                //String a= String.valueOf(articles.get(i).getArticleNo());
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

                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel">
                                                <a class="panel-heading" role="tab" id="headingOne" data-toggle="collapse"
                                                   data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseOne">
                                                    <h4 class="panel-title">
                                                        参与活动
                                                    </h4>
                                                </a>
                                                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel"
                                                     aria-labelledby="headingOne" aria-expanded="false">
                                                    <div class="panel-body col-md-12 col-sm-12 col-xs-12">
                                                        <table class="table table-striped ">
                                                            <thead>
                                                            <tr>
                                                                <th></th>
                                                                <th>社团名称</th>
                                                                <th>活动名称</th>

                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%
                                                                int j=1;
                                                                for(Activity act:acts){ %>
                                                            <tr>
                                                                <th scope="row"><%=j++%></th>
                                                                <td><%=DAO.getClubById(sqlSessionFactory,act.getClubNo()).getClubName()%></td>
                                                                <td><%=act.getActive_name()%></td>
                                                            </tr>
                                                                <%   }%>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!-- end of accordion -->
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
            <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
    </div>
</div>

<!--
    作者：offline
    时间：2018-07-11
    描述：修改用户信息的模态框
-->

<div class="modal fade" id="changeMyInfo" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetInfo()"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改个人信息</h4>
            </div>
            <div class="modal-body">
                <label  class="form-group" for="grade">年级:</label>
                <div>
                    <input type="text" contenteditable="false" class="form-control" id="grade" name="grade" placeholder="请输入您现在的年级D" value="<%=student.getGrade()%>">
                </div>
                <label class="form-group" for="Tel">电话:</label>
                <div>
                    <input type="text" class="form-control"  id="Tel" name="Tel" placeholder="请输入您的电话" value="<%=student.getTel()%>">
                </div>
                <label class="form-group" for="Email" >邮箱:</label>
                <div>
                    <input type="text" class="form-control"  id="Email" name="Email" placeholder="请输入您的邮箱" value="<%=student.getEmail()%>">
                </div>
                <label class="form-group" for="self_introduce">个人简介:</label>
                <div>
                    <textarea type="text" class="form-control" id="self_introduce"  name="self_introduce" placeholder="请输入个人简介"><%=student.getSelf_introduce()%></textarea>
                </div>
                <label class="form-group" for="self_introduce">头像预览:</label>
                <div>
                    <div class="user-photo-box">
                        <img id="user-photo" src="images/<%=StuNo%>.jpg?<%=Math.random()%>" onerror="javascript:this.src='images/user.png'">
                    </div>
                    <br>
                    <button type="reset"  class="btn btn-default btn-round" data-target="#changeModal" data-toggle="modal"><span class="glyphicon " aria-hidden="true"></span>选择头像</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="reset"  class="btn btn-default btn-round" onclick="resetInfo()"><span class="glyphicon " aria-hidden="true" ></span>重置</button>
                <button  class="btn btn-round btn-success" onclick="sendPhotoToServer();">提交</button>
            </div>
        </div>

    </div>
</div>



<!--修改头像的模态框-->
<div class="modal fade" id="changeModal"  role="dialog" aria-hidden="true" style="z-index: 1060">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title text-primary">
                    <i class="fa fa-pencil"></i>
                    更换头像
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






<!-- jQuery -->
<script src="vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="vendors/fastclick/lib/fastclick.js"></script>
<!-- NProgress -->
<script src="vendors/nprogress/nprogress.js"></script>
<!-- morris.js -->
<script src="vendors/raphael/raphael.min.js"></script>
<script src="vendors/morris.js/morris.min.js"></script>
<!-- bootstrap-progressbar -->
<script src="vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
<!-- bootstrap-daterangepicker -->
<script src="vendors/moment/min/moment.min.js"></script>
<script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- jQuery custom content scroller -->
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
<!-- Custom Theme Scripts -->
<script src="build/js/custom.min.js"></script>
<!-- Chart.js -->
<script src="vendors/Chart.js/dist/Chart.min.js"></script>
<!--
    作者：offline
    时间：2018-07-10
    描述：手机初步适配
-->
<script src="mobile.js"></script>
<script src="vendors/cropper/dist/cropper.min.js"></script>

<!--甜甜圈数据显示-->
<!--甜甜圈数据显示-->
<script>
    <%--var array=[];--%>
    <%--var canvasDoughnut;--%>
    <%--$(window).ready(function(){--%>
        <%--Chart.defaults.global.legend = {--%>
            <%--enabled: false--%>
        <%--};--%>
        <%--array.push(<%=acts.size()%>);--%>
        <%--array.push(<%=joinClubs.size()%>);--%>
        <%--array.push(<%=acts.size()%>);//文章数我可到哪里获取喔--%>
        <%--array.push(<%=adminClubs.size()%>);--%>
        <%--var ctx = document.getElementById("canvasDoughnut");--%>
        <%--var data = {--%>
            <%--labels: [--%>
                <%--"加入的活动",--%>
                <%--"加入社团数",--%>
                <%--"发表文章数",--%>
                <%--"管理社团数"--%>
            <%--],--%>
            <%--datasets: [{--%>
                <%--data: array,--%>
                <%--backgroundColor: [--%>
                    <%--"#3498DB",--%>
                    <%--"#455C73",--%>
                    <%--"#9B59B6",--%>
                    <%--"#BDC3C7",--%>
                    <%--"#26B99A"--%>

                <%--],--%>
                <%--hoverBackgroundColor: [--%>
                    <%--"#49A9EA",--%>
                    <%--"#34495E",--%>
                    <%--"#B370CF",--%>
                    <%--"#CFD4D8",--%>
                    <%--"#36CAAB"--%>
                <%--]--%>
            <%--}]--%>
        <%--};--%>
        <%--canvasDoughnut = new Chart(ctx, {--%>
            <%--type: 'doughnut',--%>
            <%--tooltipFillColor: "rgba(51, 51, 51, 0.55)",--%>
            <%--data: data,--%>
        <%--});--%>
    <%--})--%>
    <%--$(window).scroll(function () {--%>
        <%--var temp = document.getElementById('canvasDoughnut').getBoundingClientRect();--%>
        <%--if((temp.top<0&&temp.bottom>0||temp.top<$(window).height()&&temp.bottom>$(window).height())&&status==='out')--%>
        <%--{--%>
            <%--for(var i = 0 ;i<canvasDoughnut.data.datasets.length;i++) {--%>
                <%--canvasDoughnut.data.datasets[i].data.pop();--%>
            <%--}--%>
            <%--canvasDoughnut.update();--%>
            <%--for(var i = 0 ;i<canvasDoughnut.data.datasets.length;i++) {--%>
                <%--canvasDoughnut.data.datasets[i].data.push(data[i]);--%>
            <%--}--%>
            <%--canvasDoughnut.update();--%>
            <%--console.log("I'm in");--%>
            <%--status = "in";--%>
        <%--}else if((temp.top>$(window).height()||temp.bottom<0)&&status==='in'){--%>
            <%--console.log("I'm not");--%>
            <%--status = "out";--%>
        <%--}--%>
    <%--});--%>



    var status = 'in';
    var data =[<%=acts.size()%>, <%=joinClubs.size()%>,<%=acts.size()%>,<%=adminClubs.size()%>];
    var canvasDoughnut;
    var dataset = [{
        data: [<%=acts.size()%>, <%=joinClubs.size()%>,<%=acts.size()%>,<%=adminClubs.size()%>],
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
    }];
    $(window).ready(function(){
        Chart.defaults.global.legend = {
            enabled: false
        };
        if ($('#canvasDoughnut').length ){
            var ctx = document.getElementById("canvasDoughnut");
            var data = {
                labels: [
                    "加入的活动",
                    "加入社团数",
                    "发表文章数",
                    "管理社团数"
                ],
                datasets: dataset
            };
            canvasDoughnut = new Chart(ctx, {
                type: 'doughnut',
                tooltipFillColor: "rgba(51, 51, 51, 0.55)",
                data: data
            });



        };
    });

    $(window).scroll(function () {
        var temp = document.getElementById('canvasDoughnut').getBoundingClientRect();
        if((temp.top<0&&temp.bottom>0||temp.top<$(window).height()&&temp.bottom>$(window).height())&&status==='out')
        {
            for(var i = 0 ;i<canvasDoughnut.data.datasets.length;i++) {
                canvasDoughnut.data.datasets[i].data.pop();
            }
            canvasDoughnut.update();
            for(var i = 0 ;i<canvasDoughnut.data.datasets.length;i++) {
                canvasDoughnut.data.datasets[i].data.push(data[i]);
            }
            canvasDoughnut.update();
            console.log("I'm in");
            status = "in";
        }else if((temp.top>$(window).height()||temp.bottom<0)&&status==='in'){
            console.log("I'm not");
            status = "out";
        }
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
                        $('#changeModal .disabled').removeAttr('disabled').removeClass('disabled');
                        $('#changeModal .tip-info').addClass('hidden');

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
            $('#changeModal').modal('hide');
        });
    }


    var sendPhotoToServer = function () {
        // 得到PNG格式的dataURL
        // var photo = $('#user-photo').cropper('getCroppedCanvas', {
        //     width: 300,
        //     height: 300
        // }).toDataURL('image/png');
        var self_introduce;
        if(document.getElementById('self_introduce').innerText) self_introduce=document.getElementById('self_introduce').innerText;
        else self_introduce=$('#self_introduce').val();
        $.ajax({
            type:'POST',
            url:"/changeStuInfo",
            data:{
                "grade":$('#grade').val(),
                "Tel":$('#Tel').val(),
                "Email": $('#Email').val(),
                "self_introduce":self_introduce
            },
            success:function() {
                // $('#StuInfo li:eq(2) span').text($('#grade').val());
                $('#StuInfo li:eq(4) span').text($('#Tel').val());
                $('#StuInfo li:eq(5) span').text($('#Email').val());
                $('#StuInfo li:eq(6) span').text($('#self_introduce').val());

                // .innerText=$('#Tel').val();
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
                    "name":<%=StuNo%>
                },
                success: function () {
                        // 将上传的头像的地址填入，为保证不载入缓存加个随机数
                        $('.user-photo').attr('src', '/images/<%=StuNo%>.jpg'+'?t=' + Math.random());
                        $('#changeModal').modal('hide');

                },
                error:function () {
                    alert("error")
                }

            });
            $('#originalPhoto').attr('src',image.src.toString());
            $('#userImg').attr('src',image.src.toString());
            $('#userImg2').attr('src',image.src.toString());
            $('#changeMyInfo').modal("hide");
        }



        // var photo;
        // $.ajax({
        //     url: '上传地址', // 要上传的地址
        //     type: 'post',
        //     data: {
        //         'imgData': photo
        //     },
        //     dataType: 'json',
        //     success: function (data) {
        //         if (data.status == 0) {
        //             // 将上传的头像的地址填入，为保证不载入缓存加个随机数
        //             $('.user-photo').attr('src', '头像地址?t=' + Math.random());
        //             $('#changeModal').modal('hide');
        //         } else {
        //             alert(data.info);
        //         }
        //     }
        // });
    }

    $(function(){
        initCropperInModal($('#photo'),$('#photoInput'),$('#changeModal'));
    });



    //重置数据
    function resetInfo() {
        $('#grade').val($('#StuInfo li:eq(2) span').text());
        $('#Tel').val($('#StuInfo li:eq(4) span').text());
        $('#Email').val($('#StuInfo li:eq(5) span').text());
        document.getElementById('self_introduce').innerText=$('#StuInfo li:eq(6) span').text();
    }
</script>
<!--关键逻辑-->
<script>
    var originalPhoto;


</script>


</body>
</html>


