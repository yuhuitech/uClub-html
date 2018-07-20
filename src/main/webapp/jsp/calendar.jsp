<%@ page import="Test.Test" %>
<%@ page import="model.Club" %>
<%@ page import="model.Student" %>
<%@ page import="operations.ClubOperations" %>
<%@ page import="operations.DAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%><%--
Created by IntelliJ IDEA.
User: Administrator
Date: 2018/7/5
Time: 10:59
To change this template use File | Settings | File Templates.
--%>
<html lang="en">
  <head>


      <script>


          <%
        //  String basePath =request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
          Integer StuNo=(Integer) session.getAttribute("UserNo");
          String event= (String) session.getAttribute("events");
          String resource = "mybatis.xml";
          InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
          SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
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
    List<Message> messages = (List<Message>)session.getAttribute("messages");
//          System.out.println(basePath);
        //  System.out.println(event);
      %>
      </script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>U社团 | </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- FullCalendar -->
    <link href="vendors/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet">
    <link href="vendors/fullcalendar/dist/fullcalendar.print.css" rel="stylesheet" media="print">
      <link href="spin.css" rel="stylesheet">
      <link href="vendors/select2/dist/css/select2.min.css" rel="stylesheet">
      <link href="vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- Custom styling plus plugins -->
    <link href="build/css/custom.min.css" rel="stylesheet">
	<!-- jQuery custom content scroller -->
    <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>


    <style>
      td.fc-list-item-title.fc-widget-content {
        text-align: right;
        white-space: normal;
    word-break: break-all;
    word-wrap: break-word;
      }
      ::-webkit-scrollbar{
display:none;
}
.fc .fc-list-table {
    table-layout: fixed;
    
}
td.fc-list-item-marker.fc-widget-content {
	text-align: center;
	white-space: normal;
    word-break: break-all;
    word-wrap: break-word;
}
td.fc-list-item-time.fc-widget-content {
    white-space: normal;
    word-break: break-all;
    word-wrap: break-word;
}
      .right_col {
          min-height:800px !important;
      }
    </style>





    <!-- bootstrap-daterangepicker -->
    <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- bootstrap-datetimepicker -->
    <link href="vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <!-- Ion.RangeSlider -->
    <link href="vendors/normalize-css/normalize.css" rel="stylesheet">
    <link href="vendors/ion.rangeSlider/css/ion.rangeSlider.css" rel="stylesheet">
    <link href="vendors/ion.rangeSlider/css/ion.rangeSlider.skinFlat.css" rel="stylesheet">
    <!-- Bootstrap Colorpicker -->
    <link href="vendors/mjolnic-bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css" rel="stylesheet">

    <link href="vendors/cropper/dist/cropper.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="vendors/select2/dist/css/select2.min.css" rel="stylesheet">

    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">

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
                  <img id="userImg" src="images/<%=StuNo%>.jpg" onerror="javascript:this.src='images/user.png'" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>欢迎,</span>
                <h2><%=StuName%> 同学</h2>
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
                                        <img src="images/<%=StuNo%>.jpg" onerror="javascript:this.src='images/user.png'" alt="">
                                        <%=StuName%>
                                        <span class=" fa fa-angle-down">
                                        </span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-usermenu pull-right">
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
            <div class="">
                        <div class="page-title">
                            <div class="title_left">
                                <h3>
                                    日历
                                </h3>
                            </div>
                        </div>

                        <div class="title_right">
                            <div class="col-md-4 col-sm-4 col-xs-12 form-group pull-right top_search">
                                <div class="input-group">
                                    <input type="text" id="searchInfo" class="form-control" placeholder="找找活动">
                                    <span class="input-group-btn">
                                        <button id="searchbutton" class="btn btn-default" onclick="searchSentence=$('#searchInfo').val();goToPageOption(1);"
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
              <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>活动日历</h2>
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

                    <div id='calendar'></div>

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
    
    

    <!-- calendar modal -->
    <div id="CalenderModalNew" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="myModalLabel">创建新活动</h4>
          </div>
          <div class="modal-body">
            <div id="testmodal" style="padding: 5px 20px;">
              <form id="antoform" class="form-horizontal calender" role="form">
                  <div class="form-group">
                      <label class="col-sm-2 col-sm-3 control-label">社团名称</label>
                      <div class="col-sm-9">
                          <select class="select2_multiple form-control" multiple="multiple" name="adminClubName" id="adminClubName" >
                          <%
                              for(Club club:adminClubs){
                                  %>   <option value="<%=club.getClubNo()%>" ><%=club.getClubName()%></option><%
                              }
                          %>
                          </select>
                      </div>
                  </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-3 control-label">活动标题</label>
                  <div class="col-sm-9">
                    <input type="text" class="form-control" id="title" name="title">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-3 control-label">活动描述</label>
                  <div class="col-sm-9">
                    <textarea class="form-control" style="height:55px;" id="descr" name="descr"></textarea>
                  </div>
                </div>
                  <div class="form-group">
                      <label class="col-sm-2 col-sm-3 col-xs-15 control-label">开始时间</label>
                      <div class="col-sm-10 col-sm-9 col-xs-20">
                          <div class="input-group date" id="myDatepickerStartNew">
                              <input type="text" class="form-control" readonly="readonly" id="createStartTime" name="createStartTime">
                              <span class="input-group-addon">
                      <span class="glyphicon glyphicon-calendar"></span>

                    </span>
                          </div>

                      </div>
                  </div>

                  <div class="form-group">
                      <label class="col-sm-2 control-label">结束时间</label>
                      <div class="col-sm-10">
                          <div class="input-group date" id="myDatepickerEndNew">
                              <input type="text" class="form-control" readonly="readonly" id="createEndTime" name="createEndTime">
                              <span class="input-group-addon">
                          <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                          </div>
                      </div>
                  </div>

              </form>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default antoclose"
                    data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-primary antosubmit" id="createSubmit">保存</button>
          </div>

        </div>

      </div>
    </div>
    <div id="CalenderModalEdit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="$('#join').click();">×</button>
            <h4 class="modal-title" id="myModalLabel2">查看以及编辑事件</h4>
          </div>
          <div class="modal-body">
            <div id="testmodal2" >
                <!--  修改  -->
              <form id="antoform2" class="form-horizontal calender" role="form" action="/changeActiveStatus" method="post">
                <div class="form-group">
                  <label class="col-sm-2 col-sm-3 col-xs-12 control-label">活动标题</label>
                  <div class="col-sm-10 col-sm-9 col-xs-12">
                    <input type="text" class="form-control" id="title2" name="title2">
                  </div>
                </div>
                  <input type="hidden" name="ActiveNo" id="ActiveNo" value=""/>
                  <input type="hidden" name="status" id="status" value="" />
                  <input type="hidden" name="clubName" id="clubName" value="" />
                <div class="form-group">
                  <label class="col-sm-2 col-sm-3 col-xs-12 control-label">活动描述</label>
                  <div class="col-sm-10 col-sm-9 col-xs-12">
                    <textarea class="form-control" style="height:55px;" id="descr2" name="descr2"></textarea>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 col-sm-3 col-xs-15 control-label">开始时间</label>
                  <div class="col-sm-10 col-sm-9 col-xs-20">
                  <div class="input-group date" id="myDatepickerStart">
                    <input type="text" class="form-control" readonly="readonly" id="startTime" name="startTime">
                    <span class="input-group-addon">
                      <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                  </div>

                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 col-sm-3 col-xs-15 control-label">结束时间</label>
                    <div class="col-sm-10 col-sm-9 col-xs-20">
                      <div class="input-group date" id="myDatepickerEnd">
                        <input type="text" class="form-control" readonly="readonly" id="endTime" name="endTime">
                        <span class="input-group-addon">
                          <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                      </div>
                    </div>
                </div>


                <div class="form-group">
                  <label class="col-sm-2 col-sm-3 col-xs-15 control-label">是否参与</label>
                  <div class="col-sm-9">
                      <label>
                          <input class="js-switch" type="checkbox" data-switchery="true" id="join" onclick="checkboxChange()"/>
                      </label>
                  </div>
                </div>
                  <div class="modal-footer">
                      <button type="button" class="btn btn-default antoclose2" data-dismiss="modal" >关闭</button>
                      <button type="button" class="btn btn-primary antosubmit2" onclick="changeActivity();">保存修改</button>
                  </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>


    <div class="form-horizontal">
        <div class="modal fade" id="modalsearch">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                        </button>
                        <h3 class="modal-title" id="attachtitle">事件搜索结果</h3>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body-content">
                            <!-- <table id="searchtable"没有data-toggle="table"就不行
                                  data-query-params="queryParams"
                                  data-page-size="5"
                                  data-page-list="[5, 25, 50, All]"
                                  data-unique-id="id"
                                  data-toolbar="#searchbar"
                                  data-pagination="true"
                                  data-side-pagination="client"
                                  data-show-refresh="true"
                                  data-click-to-select="true">
                              <tr>
                                <th data-formatter="index1">#</th>
                                <th data-field="Title" data-formatter="setTtile">名称</th>
                                <th data-field="Content">内容</th>
                                <th data-field="Starttime" data-formatter="localDateFormatter">开始时间</th>
                                <th data-field="Endtime" data-formatter="localDateFormatter">结束时间</th>
                              </tr>
                            </table> -->
                            <div id="attachtoolbar" class="btn-group">
                                <button type="button" data-name="deleteAttachButton" id="deleteAttachButton" class="btn btn-default">
                                    <i class="fa fa-trash">删除</i>
                                </button>
                            </div>
                            <table id="searchtable"
                                   data-toggle="table"
                                   data-toolbar="#attachtoolbar"
                                   data-page-size="5"
                                   data-page-list="[5, 25, 50, All]"
                                   data-unique-id="id"
                                   data-pagination="true"
                                   data-side-pagination="client"
                                   data-click-to-select="true">
                                <thead>
                                <tr>
                                    <th data-formatter="index1">#</th>
                                    <th data-field="title" data-formatter="settile" data-events="actionEvents">名称</th>
                                    <th data-field="content">内容</th>
                                    <th data-field="start" data-formatter="localDateFormatter">开始时间</th>
                                    <th data-field="end" data-formatter="localDateFormatter">结束时间</th>
                                </tr>
                                </thead>
                            </table>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>





    <div id="fc_create" data-toggle="modal" data-target="#CalenderModalNew"></div>
    <div id="fc_edit" data-toggle="modal" data-target="#CalenderModalEdit"></div>
    <!-- /calendar modal -->
        
    <!-- jQuery -->
    <script src="vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="vendors/nprogress/nprogress.js"></script>
    <!-- FullCalendar -->
    <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/fullcalendar/dist/fullcalendar.min.js"></script>
    <script src='vendors/fullcalendar/dist/lang/zh-cn.js'></script>
	<!-- jQuery custom content scroller -->
    <script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>

    <script src="spin.js"></script>
    <script>


       var opts = {
           lines: 13, // The number of lines to draw
           length: 38, // The length of each line
           width: 17, // The line thickness
           radius: 45, // The radius of the inner circle
           scale: 1, // Scales overall size of the spinner
           corners: 1, // Corner roundness (0..1)
           color: '#008080', // CSS color or array of colors
           fadeColor: 'transparent', // CSS color or array of colors
           speed: 1, // Rounds per second
           rotate: 0, // The rotation offset
           animation: 'spinner-line-fade-quick', // The CSS animation name for the lines
           direction: 1, // 1: clockwise, -1: counterclockwise
           zIndex: 2e9, // The z-index (defaults to 2000000000)
           className: 'spinner', // The CSS class to assign to the spinner
           top: '50%', // Top position relative to parent
           left: '50%', // Left position relative to parent
           shadow: '0 0 1px transparent', // Box-shadow for the lines
           position: 'absolute' // Element positioning
       };



       var events=[];
      function convertDateFromString(dateString) {
            if (dateString) {
                var arr1 = dateString.split(" ");
                var sdate = arr1[0].split('-');
                var stime=arr1[1].split(":")
                var date = new Date(sdate[0], sdate[1]-1, sdate[2], stime[0],stime[1]);
                return date;
            }
        }

	 $(window).ready(function() {
          var temp = $('#pageSize').width();
          if (temp <= 342) {
              $('.fc-listMonth-button').click();
              $('.fc-agendaDay-button').css('display', 'none');
              $('.fc-agendaWeek-button').css('display', 'none');
              $('.fc-month-button').css('display', 'none');
              $('.fc-today-button').css('display', 'none');
              $('h2').css('font-size', '15px');
              $('h3').css('font-size', '20px');
              $('h1').css('font-size', '25px');
          } else {
              $('.fc-agendaDay-button').css('display', 'inline');
              $('.fc-agendaWeek-button').css('display', 'inline');
              $('.fc-month-button').css('display', 'inline');
              $('.fc-today-button').css('display', 'inline');
              $('#calendar').css('font-size', '1em');
              $('h2').css('font-size', '');
              $('h3').css('font-size', '');
              $('h1').css('font-size', '');
          }

         setCalendar();

     });



      $(window).resize(function() {
          var temp = $('#pageSize').width();
          if (temp <= 342) {
              $('.fc-listMonth-button').click();
              $('.fc-agendaDay-button').css('display', 'none');
              $('.fc-agendaWeek-button').css('display', 'none');
              $('.fc-month-button').css('display', 'none');
              $('.fc-today-button').css('display', 'none');
              $('#calendar').css('font-size', '9px');
             $('h4').css('font-size', '10px');
              $('h2').css('font-size', '15px');
              $('h3').css('font-size', '20px');
              $('h1').css('font-size', '25px');
          } else {
              $('.fc-agendaDay-button').css('display', 'inline');
              $('.fc-agendaWeek-button').css('display', 'inline');
              $('.fc-month-button').css('display', 'inline');
              $('.fc-today-button').css('display', 'inline');
              $('#calendar').css('font-size', '1em');
              $('h2').css('font-size', '');
              $('h3').css('font-size', '');
              $('h1').css('font-size', '');
          }
      });




        $('body').on('hidden.bs.modal', '.modal', function () {
            $(this).removeData('bs.modal');
        });
        var status = 0;
        var selectedEvent;
        var selectedEventID;
        function  setCalendar() {
            var date = new Date(),
                d = date.getDate(),
                m = date.getMonth(),
                y = date.getFullYear(),
                started,
                categoryClass;

            var calendar = $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay,listMonth'
                },
                allDayText:'全天',
                height:600,
                locale: 'zh-cn',
                selectable: true,
                selectHelper: true,
                eventStartEditable:false,
                noEventsMessage:'没有活动可显示',
                buttonText:{
                    prev:     '上',
                    next:     '下',
                    prevYear: '去年',
                    nextYear: '明年',
                    today:    '今天',
                    month:    '月',
                    week:     '周',
                    day:      '日',
                    listMonth:  '列'
                },
                select: function(start, end,jsEvent,view) { //点击空白区域/选择区域内容触发
                    $('#fc_create').click();
                    $('#createStartTime').val(start.format("YYYY-MM-DD HH:mm"));
                    $('#createEndTime').val(end.format("YYYY-MM-DD HH:mm"));
                   // $("#adminClubName").val("0");
                    $("#adminClubName option:first").prop("selected", 'selected');
                },
                eventClick: function(calEvent, jsEvent, view) {
                    $('#fc_edit').click();
                    status = 1;
                    document.getElementById("myModalLabel2").innerText=calEvent.clubName;
                    $('#ActiveNo').val(calEvent.id);
                    $('#title2').val(calEvent.title);
                    $('#descr2').val(calEvent.info);
                    $('#startTime').val(calEvent.start.format("YYYY-MM-DD HH:mm"));
                    $('#endTime').val(calEvent.end.format("YYYY-MM-DD HH:mm"));
                    $('#status').val(calEvent.status);
                    $('#clubName').val(calEvent.clubName);
                    if(calEvent.isJoin=="0"){
                        if($('#join').attr('checked')=="checked") $('#join').click();
                    }
                    else {
                        if($('#join').attr('checked')==undefined)$('#join').click();
                    }
                    categoryClass = $("#event_type").val();
                    selectedEvent = calEvent;

                },
                dayClick: function(date, jsEvent, view) {
                    $('#ActiveNo').val('');
                    $('#title2').val('');
                    $('#descr2').val('');
                    $('#startTime').val('');
                    $('#endTime').val('');
                    $('#status').val('');
                    $('#clubName').val('');
                },
                editable: true,
                events:
                    function(start, end ,timezone, callback){
                        var temp = $('#pageSize').width();
                        var target = document.getElementById('calendar');
                        var spinner = new Spinner(opts).spin(target);
                        target.appendChild(spinner.el);
                    // $('.fc-view-container').css('display', 'none');
                    //     $('.fc-toolbar.fc-header-toolbar').css('display', 'none');
                    $.ajax({
                        type:'Post',
                        url:"/getJoinClubActivity",
                        success : function(data) {
                           // var events=[];
                            var objs = eval(data);
                            if(events.length==0) {
                                for (var i = 0; i < objs.length; i++) {

                                    objs[i].id = parseInt(objs[i].id);
                                    objs[i].start = convertDateFromString(objs[i].start);
                                    objs[i].end = convertDateFromString(objs[i].end);
                                    if (objs[i].isJoin == "0") objs[i].color = "#666666";
                                    // $("#calendar").fullCalendar('renderEvent', objs[i], true);
                                    events.push(objs[i]);
                                }
                            }
                            else {
                                var bool=false;
                                for (var i = 0; i < objs.length; i++) {
                                    for (var j = 0; j < events.length; j++) {
                                        if (events[j].id == objs[i].id) bool=true;
                                            }
                                        if(bool==false){
                                            objs[i].id = parseInt(objs[i].id);
                                            objs[i].start = convertDateFromString(objs[i].start);
                                            objs[i].end = convertDateFromString(objs[i].end);
                                            if (objs[i].isJoin == "0") objs[i].color = "#666666";
                                            // $("#calendar").fullCalendar('renderEvent', objs[i], true);
                                            events.push(objs[i]);
                                        }

                                }
                                }

                            console.log(events);
                            spinner.stop();
                            callback(events);
                            temp = $('#pageSize').width();
                            if (temp <= 266) {
                                $('#messageDropDown').css('display', 'none');
                            } else {
                                $('#messageDropDown').css('display', 'inline');
                            }
                            if (temp <= 234) {
                                $('#miniMenu').css('display', 'none');
                            } else {
                                $('#miniMenu').css('display', 'inline');
                            }
                            temp = $('#pageSize').width();
                            if (temp <= 342) {
                                $('.fc-listMonth-button').click();
                                $('.fc-agendaDay-button').css('display', 'none');
                                $('.fc-agendaWeek-button').css('display', 'none');
                                $('.fc-month-button').css('display', 'none');
                                $('.fc-today-button').css('display', 'none');
                                $('h2').css('font-size', '15px');
                                $('h3').css('font-size', '20px');
                                $('h1').css('font-size', '25px');
                            } else {
                                $('.fc-agendaDay-button').css('display', 'inline');
                                $('.fc-agendaWeek-button').css('display', 'inline');
                                $('.fc-month-button').css('display', 'inline');
                                $('.fc-today-button').css('display', 'inline');
                                $('#calendar').css('font-size', '1em');
                                $('h2').css('font-size', '');
                                $('h3').css('font-size', '');
                                $('h1').css('font-size', '');
                            }
                            // $('.fc-view-container').fadeIn(1500);
                            // $('.fc-toolbar.fc-header-toolbar').fadeIn(1500);

                        }
                    });
                },
            });

            windowResize();

        };


        var stringToDate = function(dateStr,separator){
            if(!separator){
                separator="-";
            }
            var dateParts = dateStr.split(" ");
            var dateArr = dateParts[0].split(separator);
            var dayBehind = dateParts[1].split(":");
            var hour = parseInt(dayBehind[0]);
            var minute = parseInt(dayBehind[1]);
            var year = parseInt(dateArr[0]);
            var month;
            //处理月份为04这样的情况
            if(dateArr[1].indexOf("0") == 0){
                month = parseInt(dateArr[1].substring(1));
            }else{
                month = parseInt(dateArr[1]);
            }
            var day = parseInt(dateArr[2]);
            var date = new Date(year,month,day,hour,minute);
            return date;
        }

      function changeActivity() {
          $.ajax({
              type:'POST',
              url:"/changeActiveStatus",
              data:{
                  "ActiveNo":$('#ActiveNo').val(),
                  "title":$('#title2').val(),
                  "descr": $('#descr2').val(),
                  "startTime":$('#startTime').val() ,
                  "endTime" :$('#endTime').val(),
                  "status" :$('#status').val(),
                  "join":$('#join').attr('checked')=="checked"?"true":"false",
              },
              success:function() {//alert( "ActiveNo "+$('#ActiveNo').val()+"  ");
                  selectedEvent.title=$('#title2').val();
                  selectedEvent.info=$('#descr2').val();
                  selectedEvent.start=$('#startTime').val();
                  selectedEvent.end=$('#endTime').val();
                  selectedEvent.isJoin=$('#join').attr('checked')=="checked"?"1":"0";
                  selectedEvent.color= selectedEvent.isJoin=="1"?"#008080":"#666666";
                  $('#calendar').fullCalendar('updateEvent', selectedEvent);
              },async:false
              });
            $('#fc_edit').click();


      }

        function checkboxChange() {
            if($('#join').attr('checked')=="checked") {
                $('#join').attr("checked",false);
            }
            else {
                $('#join').attr('checked',true);
            }

        }


       function createActivity() {

           $('#fc_create').click();

       }
       Date.prototype.format = function(fmt) {
           var o = {
               "M+" : this.getMonth()+1,                 //月份
               "d+" : this.getDate(),                    //日
               "h+" : this.getHours(),                   //小时
               "m+" : this.getMinutes(),                 //分
               "s+" : this.getSeconds(),                 //秒
               "q+" : Math.floor((this.getMonth()+3)/3), //季度
               "S"  : this.getMilliseconds()             //毫秒
           };
           if(/(y+)/.test(fmt)) {
               fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
           }
           for(var k in o) {
               if(new RegExp("("+ k +")").test(fmt)){
                   fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
               }
           }
           return fmt;
       }

       $("#createSubmit").on("click", function() {
           var title = $("#title").val();
           if(!(title && $('#createStartTime').val()&& $('#createEndTime').val()))alert("标题和时间不可为空！");
           else if(!$('#adminClubName').val()) alert("没有创建活动的权限，请先成为社团管理员！");
           else {
           $.ajax({
               type:'POST',
               url:"/ActCreateApply",
               data:{
                   "adminClubName":document.getElementById("adminClubName").value,
                   "title":$('#title').val(),
                   "descr": $('#descr').val(),
                   "createStartTime":$('#createStartTime').val() ,
                   "createEndTime" :$('#createEndTime').val(),
               },
               datatype:'text',
               success:function(ActiveNo) {
                   if (title) {
                       // alert(ActiveNo);
                       var newAct={
                           id:ActiveNo,
                           title: $('#title').val(),
                           start: $('#createStartTime').val(),
                           end: $('#createEndTime').val(),
                           color:"#666666",
                           info: $('#descr').val(),
                           isJoin:"0",
                           clubName:$('#adminClubName').find("option:selected").text(),
                       }
                       events.push(newAct);
                       $('#calendar').fullCalendar( 'renderEvent',newAct, true);
                   }
                   $('#title').val('');
                   $('#descr').val('');
                   $('#createStartTime').val('');
                   $('#createEndTime').val('');
                   $('#fc_create').click();
                 //  $('#calendar').fullCalendar('unselect');
               },async:false
           });
           }
       })








    </script>



  </body>
</html>
<script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="vendors/moment/min/moment.min.js"></script>
<script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="vendors/ion.rangeSlider/js/ion.rangeSlider.min.js"></script>
<script>
    $('#myDatepicker').datetimepicker();

    $('#myDatepickerStart').datetimepicker({
        format: 'YYYY-MM-DD hh:mm',
        ignoreReadonly: true,
        allowInputToggle: true

    });

    $('#myDatepickerEnd').datetimepicker({
    
        format: 'YYYY-MM-DD hh:mm',
        ignoreReadonly: true,
        allowInputToggle: true
    });

    $('#myDatepickerEndNew').datetimepicker({
        format: 'YYYY-MM-DD hh:mm',
        ignoreReadonly: true,
        allowInputToggle: true
    });

    $('#myDatepickerStartNew').datetimepicker({
        format: 'YYYY-MM-DD hh:mm',
        ignoreReadonly: true,
        allowInputToggle: true
    });

    $('#datetimepicker6').datetimepicker();

    $('#datetimepicker7').datetimepicker({
        useCurrent: false
    });

    $("#datetimepicker6").on("dp.change", function(e) {
        $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
    });

    $("#datetimepicker7").on("dp.change", function(e) {
        $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
    });
</script>



<!-- Bootstrap Colorpicker -->
<script src="vendors/mjolnic-bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
<!-- jquery.inputmask -->
<script src="vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
<!-- jQuery Knob -->
<script src="vendors/jquery-knob/dist/jquery.knob.min.js"></script>
<script src="vendors/iCheck/icheck.min.js"></script>
<script src="mobile.js"></script>
<script src="vendors/select2/dist/js/select2.full.min.js"></script>
<script src="vendors/switchery/dist/switchery.min.js"></script>
