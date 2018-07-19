<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="static operations.DAO.getStudentName" %>
<%@ page import="static operations.DAO.getCollege" %><%--
  Created by IntelliJ IDEA.
  User: 22847
  Date: 2018/7/14
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //把ClubCreate里面的一部分功能放到了jsp
    response.setContentType("text/html;charset=\"utf-8\"");
    //消除接受乱码的问题
    request.setCharacterEncoding("UTF-8");
    Integer userID = (Integer) session.getAttribute("UserNo");
    //获取从页面上传递来的数据
    int userNo = userID;

    String stuName=null;
    String college=null;
    String resource = "mybatis.xml";

    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

    stuName = getStudentName(sqlSessionFactory,userID);
    college =getCollege(sqlSessionFactory,userID);

    session.setAttribute("userNo",userNo);
    request.setAttribute("userNo",userNo);

    session.setAttribute("stuName",stuName);
    request.setAttribute("stuName",stuName);

    session.setAttribute("college",college);
    request.setAttribute("college",college);
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- jQuery custom content scroller -->
    <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
    <!-- Custom Theme Style -->
    <link href="build/css/custom.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>




    <title>社团申请提交 | </title>
    <style>
        .hiddenCol{
            display: none;
        }
        .overflowContent
        {
            width:60px;
            overflow: hidden;
            /*white-space: nowrap;*/
            text-overflow: ellipsis;
        }
        .modal-body{
            height:500px;
            overflow:scroll;
        }
        body {
            padding-right: 0 !important;
            overflow-y: scroll;
        }
        .modal.fade.bs-example-modal-lg.in
        {
            padding-right: 0 !important;
            overflow: scroll;
            opacity: 1;
        }
    </style>


    <%--<script>--%>
    <%--$(window).ready(function() {--%>
    <%--$.ajax({--%>
    <%--type:'POST',--%>
    <%--url:"/ClubCreate",--%>
    <%--success:function(data) {--%>
    <%--alert("success");--%>
    <%--},--%>
    <%--async:false});--%>

    <%--});--%>

    <%--</script>--%>
</head>
<body class="nav-md">
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
                        <img id="userImg" src="images/<%=userNo%>.jpg" onerror="javascript:this.src='images/user.png'" alt="..." class="img-circle profile_img">
                    </div>
                    <div class="profile_info">
                        <span>欢迎,</span>
                        <h2><%=stuName%> 同学</h2>
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
                                    <li><a href="#">所有社团</a></li>
                                </ul>
                            </li>
                            <li><a><i class="fa fa-edge"></i> 广场 <span class="fa fa-chevron-down"></span></a>
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
                                <img src="images/img.jpg" alt="">John Doe
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
                                <li><a href="login.html"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                            </ul>
                        </li>

                        <li role="presentation" class="dropdown">
                            <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-envelope-o"></i>
                                <span class="badge bg-green">6</span>
                            </a>
                            <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                                <li>
                                    <a>
                                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a>
                                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a>
                                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a>
                                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                                    </a>
                                </li>
                                <li>
                                    <div class="text-center">
                                        <a>
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
                    <div class="title_left">
                        <h3>社团申请提交</h3>
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
                </div>
                <div class="clearfix"></div>

                <div class="row">

                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>社团申请提交 <small> </small></h2>
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


                                <!-- Smart Wizard -->
                                <p>请开始你的社团申请提交，该提交将会被管理员审核。</p>
                                <div id="wizard" class="form_wizard wizard_horizontal">
                                    <ul class="wizard_steps">
                                        <li>
                                            <a href="#step-1">
                                                <span class="step_no">1</span>
                                                <span class="step_descr">
                                                                                                                                                                  第一步<br />
                                              <small>提交个人信息</small>
                                          </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#step-2">
                                                <span class="step_no">2</span>
                                                <span class="step_descr">
                                                                                                                                                                  第二步<br />
                                              <small>提交社团信息</small>
                                          </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#step-3">
                                                <span class="step_no">3</span>
                                                <span class="step_descr">
                                                                                                                                                                  第三步<br />
                                              <small>检查信息无误后提交</small>
                                          </span>
                                            </a>
                                        </li>
                                    </ul>
                                    <h2 class="StepTitle">提交个人信息</h2>
                                    <form action="/ClubCreate" method="post" id="applyClubForm" class="form-horizontal form-label-left">

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="stuName">姓名
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="stuName"  readonly  unselectable="on" required="required" class="form-control col-md-7 col-xs-12" value=<c:out value="${stuName}"/>>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="userNo">学号</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="userNo"  readonly  unselectable="on" name="userNo" required="required" class="form-control col-md-7 col-xs-12" value=<c:out value="${userNo}"/>>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="college" class="control-label col-md-3 col-sm-3 col-xs-12">学院</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input id="college"  readonly  unselectable="on" class="form-control col-md-7 col-xs-12" type="text" name="appercol" value=<c:out value="${college}"/>>
                                            </div>
                                        </div>


                                        <h2 class="StepTitle">提交社团信息</h2>
                                        <div class="form-group">
                                            <label for="clubName" class="control-label col-md-3 col-sm-3 col-xs-12">社团名称</label>

                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="clubName" name="clubName" required="required" class="form-control col-md-7 col-xs-12">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">社团类型</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select name="clubType" id="clubType" style="height: 35px">
                                                    <option value ="舞蹈">舞蹈</option>
                                                    <option value ="体育">体育</option>
                                                    <option value ="音乐">音乐</option>
                                                    <option value ="绘画">绘画</option>
                                                    <option value ="文学">文学</option>
                                                    <option value ="棋牌">棋牌</option>
                                                    <option value ="户外">户外</option>
                                                    <option value ="电子竞技">电子竞技</option>
                                                    <option value ="其他">其他</option>
                                                </select>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">社团规模（包含人数）
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select name="clubSize" id="clubSize" style="height: 35px">
                                                    <option value ="0-50人">0-50人</option>
                                                    <option value ="50-100人">50-100人</option>
                                                    <option value="100人以上">100人以上</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="clubInfo" class="control-label col-md-3 col-sm-3 col-xs-12">社团简介</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <textarea id="clubInfo" name="clubInfo"style="width: 500px;height: 100px;"required="required"  class="form-control col-md-7 col-xs-12" type="text" ></textarea>
                                            </div>
                                        </div>
                                        <div id="step-3">
                                            <h2 class="StepTitle">请检查你的信息</h2>
                                            <p>请检查您的信息，确认无误后，你可以提交你的信息，并等待审核。
                                            </p>
                                        </div>

                                        <div align="center">
                                            <label>
                                                <div class="button_container" style="align-content: center">
                                                    <input id="btn_send_create_club"  style="width: 80px;height: 30px;align-content: center" type="submit" class="btn btn-default submit" value="提交申请" />
                                                </div>
                                            </label>
                                            <label>
                                                <div class="button_container" style="align-content: center">
                                                    <input   style="width: 80px;height: 30px;align-content: center" type="button" class="btn btn-default submit" onclick=" manageCreateApplyEnter()" value="申请历史" />
                                                </div>
                                            </label>
                                        </div>
                                    </form>


                                </div>
                                <!-- End SmartWizard Content -->

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
                Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
            </div>
            <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
    </div>
</div>

<!--manageCreateApply表的展示-->

<div class="modal fade bs-example-modal-lg" id="manageCreateApply" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" >
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">创建社团申请记录</h4>
            </div>
            <div class="modal-body">
                <div>
                    <table id="manageCreateApply-table" class="table table-striped table-bordered"cellpadding="0" cellspacing="0" border="0" >

                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 关闭</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade bs-example-modal-lg" id="editCreateApplyTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" >
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                <h4 class="modal-title" >申请阅览</h4>
            </div>
            <div class="modal-body">
                <label  class="form-group" for="clubNameInCreateApplyTable">社团名称</label>
                <div>
                    <input type="text" contenteditable="false" class="form-control" id="clubNameInCreateApplyTable" name="clubNameInCreateApplyTable" placeholder="请输入书的ID" disabled>
                </div>
                <label class="form-group" for="clubTypeInCreateApplyTable">社团类型</label>
                <div>
                    <input type="text" class="form-control"  id="clubTypeInCreateApplyTable" name="clubTypeInCreateApplyTable" placeholder="请输入书名" disabled>
                </div>
                <label class="form-group" for="clubInfoInCreateApplyTable">社团简介</label>
                <div>
                    <input type="text" class="form-control"  id="clubInfoInCreateApplyTable" name="clubInfoInCreateApplyTable" placeholder="请输入价格" disabled>
                </div>
                <label class="form-group" for="clubSizeInCreateApplyTable">社团规模</label>
                <div>
                    <input type="text" class="form-control" id="clubSizeInCreateApplyTable"  name="clubSizeInCreateApplyTable" placeholder="请输入出版日期" disabled>
                </div>
                <label class="form-group" for="applyTimeInCreateApplyTable">申请时间</label>
                <div>
                    <input type="text" class="form-control" id="applyTimeInCreateApplyTable"  name="applyTimeInCreateApplyTable" placeholder="请输入出版日期" disabled>
                </div>
                <label class="form-group" for="applyStatusInCreateApplyTable">申请状态</label>
                <div>
                    <input type="text" class="form-control" id="applyStatusInCreateApplyTable"  name="applyStatusInCreateApplyTable" placeholder="请输入出版日期" disabled>
                </div>
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
<!-- jQuery Smart Wizard -->
<script src="vendors/jQuery-Smart-Wizard/js/jquery.smartWizard.js"></script>
<!-- Custom Theme Scripts -->
<script src="build/js/custom.min.js"></script>
<!-- jQuery custom content scroller -->
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>

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


</body>
</html>
<script>
    var remarkShowLength = 3;//默认显示的字符串长度


    function manageCreateApplyEnter() {

        $.ajax(
            {
                url:'/ClubCreate',
                method: 'POST',
                data:{
                    searchStatus:"1"
                },
                async: false,
                success: function (data) {
                    //alert(data);
                    var dataset = new Array();
                    order = [
                        "applyNo",
                        "clubName",
                        "ClubType",
                        "clubInfo",
                        "clubSize",
                        "applyTime",
                        'status'
                    ];
                    var UsedJson = eval("" + data + "");
                    for (var i = 0; i < UsedJson.length; i++) {
                        var eachItem = new Array();
                        eachItem.push(UsedJson[i].applyNo.toString());
                        eachItem.push(UsedJson[i].clubName.toString());
                        eachItem.push(UsedJson[i].clubType.toString());
                        eachItem.push(UsedJson[i].clubInfo.toString());
                        eachItem.push(UsedJson[i].clubSize.toString());
                        eachItem.push(UsedJson[i].applyTime.toString());
                        eachItem.push(UsedJson[i].status.toString());
                        dataset.push(eachItem);
                    }
                    //alert("您的操作成功");
                    reloadCreateApplyTableData(dataset);
                    $('#manageCreateApply').modal('show');

                    //lf.location.reload();
                }, error: function (data) {
                    alert("fail");
                }
            }
        );
    }



    function reloadCreateApplyTableData(newDataSet) {
        var currentPage = manageCreateApplyTable.page();
        manageCreateApplyTable.clear();
        manageCreateApplyTable.rows.add(newDataSet);
        manageCreateApplyTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageCreateApplyTable;
    var choosenRow;
    var editingID;

    function initCreateApplyTable(status, dataSet) {
        manageCreateApplyTable = $("#manageCreateApply-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            // "sProcessing": "<img src='./loading.gif' />",加载中的动画效果
            // "bStateSave": true,
            "bInfo": true,//页脚信息
            // "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "申请ID",
                    "sClass": "hiddenCol"
                },
                {
                    title: "社团名称"
                },
                {
                    title: "社团类型"
                },
                {
                    title: "简介",
                    "sClass": "overflowContent"
                },
                {
                    title: "社团规模"
                },
                {
                    title: "申请时间"
                },
                {
                    title: "申请状态"
                },
            ],
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
                    targets : [3],
                    // "render": function (data, type, row, meta) {
                    //     if (row[3].length > remarkShowLength) {
                    //         return row[3].substring(0,remarkShowLength)+"...";//显示部分信息
                    //     } else {
                    //         return row[3];//显示原始全部信息 }
                    //     }
                    // }
                },
                {
                    type : "string",
                    targets : [4],
                },
                {
                    type : "date",
                    targets : [5],
                },
                {
                    type : "string",
                    targets : [6],
                    "render": function (data, type, row, meta) {
                        if (row[6]==='0') {
                            return "待审核";
                        } else if(row[6]==='1') {
                            return "已通过";
                        }else{
                            return "未通过";
                        }
                    }
                }
            ],
            'rowCallback':function (row,data) {
                choosenRow = row;
            },
            "order": [[5, 'asc']],
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

        $('#manageCreateApply-table tbody').on('click', 'tr', function () {

        });

        $('#manageCreateApply-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            alert(this.cells[0].innerText);
            $('#editCreateApplyTableDetail').modal('show');
            // var d = manageCreateApplyTable.row(this).data;
            // alert(manageCreateApplyTable.row("").data)data
            editingID = this.cells[0].innerText;//利用selectedRol向弹出的模态框提交数据，修改结果
            $("#clubNameInCreateApplyTable").val(this.cells[1].innerText);
            $("#clubTypeInCreateApplyTable").val(this.cells[2].innerText);
            $("#clubInfoInCreateApplyTable").val(this.cells[3].innerText);
            $("#clubSizeInCreateApplyTable").val(this.cells[4].innerText);
            $("#applyTimeInCreateApplyTable").val(this.cells[5].innerText);
            $("#applyStatusInCreateApplyTable").val(this.cells[6].innerText);
        });
    }

    $(window).ready(function(){
        initCreateApplyTable();
    });


</script>
