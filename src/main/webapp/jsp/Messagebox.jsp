<%@ page import="model.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="operations.DAO" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/16
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>  U社团  </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- bootstrap-wysiwyg -->
    <link href="vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
    <!-- jQuery custom content scroller -->
    <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
    <!-- Custom styling plus plugins -->
    <link href="build/css/custom.min.css" rel="stylesheet">
    <style>
        .element::-webkit-scrollbar {display:none}
    </style>
</head>

<body class="nav-md">
<%
    List<Message> messages =(List<Message>) request.getSession().getAttribute("messages");
    Integer StuNo= (Integer) session.getAttribute("UserNo");
    String resource = "mybatis.xml";
    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
    List<HashMap> createReply=DAO.getCreateReply(sqlSessionFactory,StuNo);
    List<HashMap> dissolveReply=DAO.getDissolveReply(sqlSessionFactory,StuNo);
    List<HashMap> joinReply=DAO.getJoinReply(sqlSessionFactory,StuNo);
    List<HashMap> leaveReply=DAO.getLeaveReply(sqlSessionFactory,StuNo);
    List<HashMap> priceReply=DAO.getPriceReply(sqlSessionFactory,StuNo);




%>
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
                <div class="profile_info">
                    <span>欢迎,</span>
                    <h2><%
//                        String resource = "mybatis.xml";
//                        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
//                        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
                        out.println(DAO.getStudentName(sqlSessionFactory,(Integer)request.getSession().getAttribute("UserNo")));%> 同学</h2>
                </div>
                </div>


            <!-- /menu profile quick info -->
            <br />
            <!-- sidebar menu -->
                <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                    <div class="menu_section">
                        <h3></h3>
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
                <%--<div class="sidebar-footer hidden-small">--%>
                    <%--<a data-toggle="tooltip" data-placement="top" title="Settings">--%>
                        <%--<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>--%>
                    <%--</a>--%>
                    <%--<a data-toggle="tooltip" data-placement="top" title="FullScreen">--%>
                        <%--<span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>--%>
                    <%--</a>--%>
                    <%--<a data-toggle="tooltip" data-placement="top" title="Lock">--%>
                        <%--<span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>--%>
                    <%--</a>--%>
                    <%--<a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">--%>
                        <%--<span class="glyphicon glyphicon-off" aria-hidden="true"></span>--%>
                    <%--</a>--%>
                <%--</div>--%>
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
                                <img src="images/<%=session.getAttribute("UserNo")%>.jpg" onerror="javascript:this.src='images/user.png'" alt="">
                                <%out.println(DAO.getStudentName(sqlSessionFactory,(Integer) session.getAttribute("UserNo")));%>
                                <span class=" fa fa-angle-down"></span>
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

                        <li role="presentation" class="dropdown">
                            <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-envelope-o" style=" line-height: 32px;"></i>
                                <span class="badge bg-green"><%out.println(messages.size());%></span>
                            </a>
                            <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                                <%for(Message message:messages){%>
                                <li>
                                    <a>
                                        <span class="image"><img src="images/admin.jpg" alt="Profile Image" /></span>
                                        <span>
                          <span>管理员</span>
                          <span class="time"> <%
                              String formatDate = null;
                              //格式 24小时制：2016-07-06 09:39:58
                              DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                              formatDate = dFormat.format(message.getTime());
                          %><%out.println(formatDate);%></span>
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
                                            <strong>查看全部消息</strong>
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
            <div class="page-title">
                <div class="title_left">
                    <h3>您的收信</h3>
                </div>


            </div>
            <%--<div class="title_right">--%>
                <%--<div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">--%>
                    <%--<div class="input-group">--%>
                        <%--<input type="text" class="form-control" placeholder="搜索收信...">--%>
                        <%--<span class="input-group-btn">--%>
                      <%--<button class="btn btn-default" type="button">Go!</button>--%>
                    <%--</span>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

            <div class="clearfix"></div>

            <div class="row" >
                <div class="col-md-4 col-sm-4 col-xs-12">
                    <div class="x_panel" >
                        <div class="x_title">
                            <h2>您的收信</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <%--<li class="dropdown">--%>
                                    <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>--%>
                                    <%--&lt;%&ndash;<ul class="dropdown-menu" role="menu">&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;<li><a href="#">Settings 1</a>&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;<li><a href="#">Settings 2</a>&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;</ul>&ndash;%&gt;--%>
                                <%--</li>--%>
                                <%--<li><a class="close-link"><i class="fa fa-close"></i></a>--%>
                                <%--</li>--%>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content" style="width: 100%;height: 400px;overflow: hidden;overflow-y: auto;">
                            <ul class="list-unstyled msg_list">
                                <%
                                    int a=0;
                                    for(Message message:messages){
                                %>
                                <li class="trueLi"  name="messages">
                                    <%--<input type="hidden" class="hiddenType" value="Message"/>--%>
                                    <input type="hidden" class="messages" id="messages" value="<%=a%>"/>
                                    <a>
                                        <span class="image">
                                            <img src="images/admin.jpg" alt="img">
                                        </span>
                                        <span>
                                            <span>管理员</span>
                                            <span class="time"><%
                                                String formatDate1 = null;
                                                //格式 24小时制：2016-07-06 09:39:58
                                                DateFormat dFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //HH表示24小时制；
                                                formatDate1 = dFormat1.format(message.getTime());
                                            %><%out.println(formatDate1);%></span>
                                        </span>
                                        <span class="message">
                                            <%out.println(message.getMessageInfo());%>
                                        </span>
                                    </a>
                                </li>
                                <%
                                    a++;}%>


                                <%
                                    int b=0;
                                    if(createReply.size()>0){
                                    for(HashMap map:createReply){
                                %>
                                <li class="trueLi"  name="createReply">
                                    <%--<input type="hidden" class="hiddenType" value="CreateReply"/>--%>
                                    <input type="hidden" class="messages" id="createReply" value="<%=b%>"/>
                                    <a>
                                        <span class="image">
                                            <img src="images/admin.jpg" alt="img">
                                        </span>
                                        <span>
                                            <span>管理员</span>

                                        </span>
                                        <span class="message">
                                            <%out.println(map.get("reason"));%>
                                        </span>
                                    </a>
                                </li>
                                <%
                                    b++;}}%>


                                <%
                                    int c=0;
                                    if(dissolveReply.size()>0){
                                    for(HashMap map:dissolveReply){
                                %>
                                <li class="trueLi"  name="dissolveReply">
                                    <%--<input type="hidden" class="hiddenType" value="DissolveReply"/>--%>
                                    <input type="hidden" class="messages" id="dissolveReply" value="<%=c%>"/>
                                    <a>
                                        <span class="image">
                                            <img src="images/admin.jpg" alt="img">
                                        </span>
                                        <span>
                                            <span>管理员</span>

                                        </span>
                                        <span class="message">
                                            <%out.println(map.get("reason"));%>
                                        </span>
                                    </a>
                                </li>
                                <%
                                    c++;}}%>


                                <%
                                    int d=0;
                                    if(joinReply.size()>0){
                                    for(HashMap map:joinReply){
                                %>
                                <li class="trueLi"  name="joinReply">
                                    <%--<input type="hidden" class="hiddenType" value="JoinReply"/>--%>
                                    <input type="hidden" class="messages" id="joinReply" value="<%=d%>"/>
                                    <a>
                                        <span class="image">
                                            <img src="images/admin.jpg" alt="img">
                                        </span>
                                        <span>
                                            <span>管理员</span>

                                        </span>
                                        <span class="message">
                                            <%out.println(map.get("reason"));%>
                                        </span>
                                    </a>
                                </li>
                                <%
                                    d++;}}%>

                                <%
                                    int e=0;
                                    if(leaveReply.size()>0){
                                    for(HashMap map:leaveReply){
                                %>
                                <li class="trueLi"  name="leaveReply">
                                    <%--<input type="hidden" class="hiddenType" value="LeaveReply"/>--%>
                                    <input type="hidden" class="messages" id="leaveReply" value="<%=e%>"/>
                                    <a>
                                        <span class="image">
                                            <img src="images/admin.jpg" alt="img">
                                        </span>
                                        <span>
                                            <span>管理员</span>

                                        </span>
                                        <span class="message">
                                            <%out.println(map.get("reason"));%>
                                        </span>
                                    </a>
                                </li>
                                <%
                                    e++;}}%>

                                <%
                                    int f=0;
                                    if(priceReply.size()>0){
                                    for(HashMap map:priceReply){
                                %>
                                <li class="trueLi"  name="priceReply">
                                    <%--<input type="hidden" class="hiddenType" value="PriceReply"/>--%>
                                    <input type="hidden" class="messages" id="priceReply" value="<%=f%>"/>
                                    <a>
                                        <span class="image">
                                            <img src="images/admin.jpg" alt="img">
                                        </span>
                                        <span>
                                            <span>管理员</span>

                                        </span>
                                        <span class="message">
                                            <%out.println(map.get("reason"));%>
                                        </span>
                                    </a>
                                </li>
                                <%
                                    f++;}}%>


                            </ul>
                        </div>
                    </div>
                    <!--</div>-->








                </div>
                <div class="col-md-8 col-sm-8 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>收信详情</h2>
                            <ul class="nav navbar-right panel_toolbox">



                                <!--<li>-->
                                <!--                      	<a class="collapse-link"><i class="fa fa-chevron-up"></i></a>-->
                                <!--</li>-->
                                <%--<li class="dropdown">--%>
                                    <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>--%>
                                    <%--<ul class="dropdown-menu" role="menu">--%>
                                        <%--<li><a href="#">删除此收信</a>--%>
                                        <%--</li>--%>
                                        <%--&lt;%&ndash;<li><a href="#">回复</a>&ndash;%&gt;--%>
                                        <%--</li>--%>
                                    <%--</ul>--%>
                                <%--</li>--%>
                                <!--<li><a class="close-link"><i class="fa fa-close"></i></a>
                                </li>-->
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                               <input type="hidden" id="name" name="name" value="">
                                <input type="hidden" id="index" name="index" value="">
                                <!-- /MAIL LIST -->

                                <!-- CONTENT MAIL -->
                                <div class="col-sm-12 mail_view">
                                    <div class="inbox-body">
                                        <div class="mail_heading row">
                                            <%--<div class="col-md-8 col-sm-4 col-xs-4">--%>
                                                <%--<div class="btn-group">--%>
                                                    <%--&lt;%&ndash;<button id="compose" class="btn btn-sm btn-success btn-block" type="button">回复</button>&ndash;%&gt;--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                            <%--<div class="col-md-4 col-sm-8 col-xs-8 text-right">--%>
                                                <%--<p class="date"> 收信日期 8:02 PM 12 FEB 2014</p>--%>
                                            <%--</div>--%>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <h4 id="msgHead"></h4>
                                            </div>
                                        </div>
                                        <div class="sender-info">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <%--<strong>王老师</strong>--%>
                                                    <%--发给--%>
                                                    <%--<strong>我</strong>--%>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="view-mail" id="msgDetail">

                                        </div>
                                        <div class="btn-group">
                                            <!--<button class="btn btn-sm btn-primary" type="button"><i class="fa fa-reply"></i> Reply</button>
                                            <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="Forward"><i class="fa fa-share"></i></button>
                                            <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="Print"><i class="fa fa-print"></i></button>
                                            <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="Trash"><i class="fa fa-trash-o"></i></button>-->
                                        </div>
                                    </div>

                                </div>
                                <!-- /CONTENT MAIL -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer content -->
        <footer>
            <div class="pull-right">
                Create by Uclub Team.
            </div>
            <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
    </div>
</div>

<!-- compose -->
<div class="compose col-md-6 col-xs-12">
    <div class="compose-header">
        创建回复
        <button type="button" class="close compose-close">
            <span>×</span>
        </button>
    </div>
    <div class="compose-body">
        <div id="alerts"></div>
        <label for="sr-only">标题</label>
        <input type="text" class="form-control" placeholder="请输入标题">

        <label for="sr-only">正文</label>
        <textarea class="form-control" rows="10" placeholder="请输入正文"></textarea>
    </div>

    <div class="compose-footer">
        <button id="send" class="btn btn-sm btn-success" type="button">Send</button>
    </div>
</div>

<script>
    function getDetail(name,index) {

    }
</script>




<!-- jQuery -->
<script src="vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="vendors/fastclick/lib/fastclick.js"></script>
<!-- NProgress -->
<script src="vendors/nprogress/nprogress.js"></script>
<!-- bootstrap-wysiwyg -->
<script src="vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
<script src="vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
<script src="vendors/google-code-prettify/src/prettify.js"></script>
<!-- jQuery custom content scroller -->
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
<!-- Custom Theme Scripts -->
<script src="build/js/custom.min.js"></script>
<script src="mobile.js"></script>
</body>
</html>
<script>
    $('.trueLi').click(function () {
        var name  = $(this).attr('name');
        var  index=$(this).children('.messages').val();
        $('#name').val(name);
        $('#index').val(index);

        $.ajax({
            type:'POST',
            url:"/getMessageDetail",
            data:{
                "name":name,
                "index":index
            },
            success:function(data) {
                var obj=eval('('+data+')');
                if('reason' in obj) document.getElementById("msgHead").innerText=obj.reason;
                if('messageInfo' in obj){
                    document.getElementById("msgHead").innerText=obj.messageInfo;
                    document.getElementById("msgDetail").innerText=obj.messageInfo;
                }
                if('ClubName' in obj) document.getElementById("msgDetail").innerText="社团名称:  "+obj.ClubName;
                if('active_name' in obj) document.getElementById("msgDetail").innerText+="\n活动名称:  "+obj.active_name;
                if('price' in obj) document.getElementById("msgDetail").innerText+="\n申请资金:  "+obj.price;
                if('ApplyTime' in obj) document.getElementById("msgDetail").innerText+="\n申请时间:  "+obj.ApplyTime;
            },
            error:function(data){
                alert(data);
            },
            async:false});

    })

</script>
