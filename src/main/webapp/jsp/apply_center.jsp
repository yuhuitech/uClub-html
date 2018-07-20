<%@ page import="net.sf.json.JSONArray" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Club" %>
<%@ page import="model.Apply" %>
<%@ page import="java.util.List" %>
<%@ page import="operations.ClubOperations" %>
<%@ page import="operations.ManageApplyOperations" %>
<%@ page import="operations.MoneyOperations" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.util.EnumMap" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.lang.String" %>
<%@ page import="Test.Test" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="model.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String resource = "mybatis.xml";
    InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
    int c1 = ManageApplyOperations.getUncheckCounts(sqlSessionFactory);
    int c2 = ClubOperations.getClubCounts(sqlSessionFactory);
    int c3 = MoneyOperations.getMAcount(sqlSessionFactory);
    int c4 = ManageApplyOperations.getcheckedCounts(sqlSessionFactory);
    int c5 = ManageApplyOperations.getDisCounts(sqlSessionFactory);
    int c6 = MoneyOperations.getMAcountHis(sqlSessionFactory);
    List<Message> messages = (List<Message>)session.getAttribute("messages");
//    session.setAttribute("c1",c1);
//    request.setAttribute("c1",c1);
//    session.setAttribute("c2",c2);
//    request.setAttribute("c2",c2);
//    session.setAttribute("c3",c3);
//    request.setAttribute("c3",c3);
//    session.setAttribute("c4",c4);
//    request.setAttribute("c4",c4);
//    session.setAttribute("c5",c5);
//    request.setAttribute("c5",c5);
//    session.setAttribute("c6",c6);
//    request.setAttribute("c6",c6);

%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>申请管理</title>

    <style>
      .hiddenCol{
        display: none;
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
                        <img id="userImg" src="images/user.jpg" onerror="javascript:this.src='images/user.png'" alt="..." class="img-circle profile_img">
                    </div>
                    <div class="profile_info">
                        <span>欢迎,</span>
                        <h2>管理员</h2>
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
                    <a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
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
                    <img src="images/img.jpg" alt=""><%out.println(session.getAttribute("name"));%>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
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
                <h3>申请管理中心</h3>
              </div>
            </div>
            <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="搜索社团">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            <div class="clearfix"></div>

            <div class="row">

              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="row">
                  <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="tile-stats" onclick="manageCreateApplyEnter();">
                      <div class="icon"><i class="fa fa-caret-square-o-right"></i>
                      </div>
                      <div class="count"><%out.print(c1);%></div>
                      <h3>创建申请</h3>
                      <p>您可在此处管理创建社团的申请</p>
                    </div>
                  </div>
                  <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="tile-stats" onclick="manageAllClubsEnter();">
                      <div class="icon"><i class="fa fa-comments-o"></i>
                      </div>
                      <div class="count"><%out.print(c2);%></div>

                      <h3>所有社团</h3>
                      <p>您可在此管理所有社团及相关信息</p>
                    </div>
                  </div>
                  <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="tile-stats" onclick="manageMoneyApplyEnter();">
                      <div class="icon"><i class="fa fa-sort-amount-desc"></i>
                      </div>
                      <div class="count"><%out.print(c3);%></div>
                      <h3>资金需求</h3>
                      <p>查看社团的资金请求</p>
                    </div>
                  </div>
                  <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="tile-stats" onclick="manageCreationHistoryEnter();">
                        <div class="icon"><i class="fa fa-comments-o"></i>
                        </div>
                        <div class="count"><%out.print(c4);%></div>
                        <h3>创建历史</h3>
                        <p>您可在此管理创建社团的历史记录</p>
                    </div>
                </div>
                    <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                        <div class="tile-stats" onclick="manageClubDissolveApplyEnter();">
                            <div class="icon"><i class="fa fa-comments-o"></i>
                            </div>
                            <div class="count"><%out.print(c5);%></div>
                            <h3>解散申请</h3>
                            <p>您可在此管理社团的解散请求</p>
                        </div>
                    </div>
                  <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="tile-stats" onclick="manageHistoryFundApplyEnter();">
                      <div class="icon"><i class="fa fa-comments-o"></i>
                      </div>
                      <div class="count"><%out.print(c6);%></div>

                      <h3>资金历史</h3>
                      <p>您可在此管理审批资金历史</p>
                    </div>
                  </div>
                  <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="tile-stats">
                      <div class="icon"><i class="fa fa-comments-o"></i>
                      </div>
                      <div class="count">？</div>

                      <h3>活动管理</h3>
                      <p>请您前往活动日历完成操作</p>
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
                        <h4 class="modal-title" id="myModalLabel">组建社团批准单</h4>
                    </div>
                    <div class="modal-body">
                     <div>
					   <table id="manageCreateApply-table" class="table table-striped table-bordered"cellpadding="0" cellspacing="0" border="0" >

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
            <h4 class="modal-title" >申请阅览</h4>
          </div>
          <div class="modal-body">
            <label  class="form-group" for="clubNameInCreateApplyTable">社团名称</label>
            <div>
              <input type="text" contenteditable="false" class="form-control" id="clubNameInCreateApplyTable" name="clubNameInCreateApplyTable" placeholder="">
            </div>
            <label class="form-group" for="clubTypeInCreateApplyTable">社团类型</label>
            <div>
              <input type="text" class="form-control"  id="clubTypeInCreateApplyTable" name="clubTypeInCreateApplyTable" placeholder="">
            </div>
            <label class="form-group" for="clubInfoInCreateApplyTable">社团简介</label>
            <div>
              <input type="text" class="form-control"  id="clubInfoInCreateApplyTable" name="clubInfoInCreateApplyTable" placeholder="">
            </div>
            <label class="form-group" for="stuNoInCreateApplyTable">申请人学号</label>
            <div>
              <input type="text" class="form-control" id="stuNoInCreateApplyTable"  name="stuNoInCreateApplyTable" placeholder="">
            </div>
              <label class="form-group" for="stuNameInCreateApplyTable">申请人姓名</label>
              <div>
                  <input type="text" class="form-control" id="stuNameInCreateApplyTable"  name="stuNameInCreateApplyTable" placeholder="">
              </div>
              <label class="form-group" for="clubSizeInCreateApplyTable">社团规模</label>
              <div>
                  <input type="text" class="form-control" id="clubSizeInCreateApplyTable"  name="clubSizeInCreateApplyTable" placeholder="">
              </div>
              <label class="form-group" for="applyTimeInCreateApplyTable">申请时间</label>
              <div>
                  <input type="text" class="form-control" id="applyTimeInCreateApplyTable"  name="applyTimeInCreateApplyTable" placeholder="">
              </div>
          </div>
          <div class="modal-footer">
            <button type="button"  class="btn btn-primary" id="btn_create_club_pass"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 批准</button>
            <button type="button" id="btn_create_club_refuse" class="btn btn-default"  ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 拒绝</button>
          </div>
        </div>
      </div>
    </div>

<!--
	作者：offline
	时间：2018-07-13
	描述：所有社团表的展示
-->
          
    <div class="modal fade bs-example-modal-lg" id="manageAllClub" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
        <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >所有社团展示表</h4>
                    </div>
                    <div class="modal-body">
                     <div>
					   <table id="manageAllClub-table" class="table table-striped table-bordered">
                   </table>
                     </div>
                    </div>
                </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" id="editAllClubTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
      <div class="modal-dialog modal-lg" role="document">
          <form>
        <div class="modal-content">
          <div class="modal-header" >
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
            <h4 class="modal-title" id="editDetailTitle">社团详情查看</h4>
          </div>
          <div class="modal-body">
            <label class="form-group" for="clubNameInAllClubTable">社团名称:</label>
            <div>
              <input type="text" class="form-control"  id="clubNameInAllClubTable" name="clubNameInAllClubTable" placeholder="请输入社团名称">
            </div>
            <label class="form-group" for="TypeInAllClubTable">社团类型:</label>
            <div>
              <input type="text" class="form-control"  id="TypeInAllClubTable" name="TypeInAllClubTable" placeholder="请输入社团类型">
            </div>
            <label class="form-group" for="ClubInfoInAllClubTable">社团描述:</label>
            <div>
              <input type="text" class="form-control" id="ClubInfoInAllClubTable"  name="ClubInfoInAllClubTable" placeholder="请输入社团描述">
            </div>
          </div>
          <div class="modal-footer">
            <button type="reset"  class="btn btn-default" ><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 重置</button>
            <button type="submit" id="btn_edit_club_info" class="btn btn-primary" ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 提交</button>
          </div>
        </div>
          </form>
      </div>
    </div>


    <!--
        作者：offline
        时间：2018-07-13
        描述：所有资金申请的展示
    -->

    <div class="modal fade bs-example-modal-lg" id="manageFundApply" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" >资金申请一览</h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table id="manageFundApply-table" class="table table-striped table-bordered">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" id="editFundApplyTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                    <h4 class="modal-title" >资金申请详情</h4>
                </div>
                <div class="modal-body">
                    <label class="form-group" for="clubNameInAllClubTable">社团名称:</label>
                    <div>
                        <input type="text" class="form-control"  id="clubNameInFundApplyTable" name="clubNameInAllClubTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="clubNameInAllClubTable">相关活动:</label>
                    <div>
                        <input type="text" class="form-control"  id="activityNameInFundApplyTable" name="clubNameInAllClubTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="clubNameInAllClubTable">申请金额:</label>
                    <div>
                        <input type="text" class="form-control"  id="amountInFundApplyTable" name="clubNameInAllClubTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="clubNameInAllClubTable">申请理由:</label>
                    <div>
                        <input type="text" class="form-control"  id="applyReasonInFundApplyTable" name="clubNameInAllClubTable" disabled="disabled">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button"  class="btn btn-primary" id="btn_money_apply_pass"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 批准</button>
                    <button type="button" id="btn_money_apply_refuse" class="btn btn-default" ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 拒绝</button>
                </div>
            </div>
        </div>
    </div>

    <!--
           作者：offline
           时间：2018-07-13
           描述：所有创建社团历史记录的展示
    -->

    <div class="modal fade bs-example-modal-lg" id="manageCreationHistory" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" >历史通过申请一览</h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table id="manageCreationHistory-table" class="table table-striped table-bordered">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" id="editCreationHistoryTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                    <h4 class="modal-title" >历史通过申请详情</h4>
                </div>
                <div class="modal-body">
                    <label  class="form-group" for="clubNameInCreationHistoryTable">社团名称</label>
                    <div>
                        <input type="text" contenteditable="false" class="form-control" id="clubNameInCreationHistoryTable" name="clubNameInCreationHistoryTable" placeholder="">
                    </div>
                    <label class="form-group" for="clubTypeInCreationHistoryTable">社团类型</label>
                    <div>
                        <input type="text" class="form-control"  id="clubTypeInCreationHistoryTable" name="clubTypeInCreationHistoryTable" placeholder="">
                    </div>
                    <label class="form-group" for="clubInfoInCreationHistoryTable">社团简介</label>
                    <div>
                        <input type="text" class="form-control"  id="clubInfoInCreationHistoryTable" name="clubInfoInCreationHistoryTable" placeholder="">
                    </div>
                    <label class="form-group" for="stuNoInCreationHistoryTable">申请人学号</label>
                    <div>
                        <input type="text" class="form-control" id="stuNoInCreationHistoryTable"  name="stuNoInCreationHistoryTable" placeholder="">
                    </div>
                    <label class="form-group" for="stuNameInCreationHistoryTable">申请人姓名</label>
                    <div>
                        <input type="text" class="form-control" id="stuNameInCreationHistoryTable"  name="stuNameInCreationHistoryTable" placeholder="">
                    </div>
                    <label class="form-group" for="clubSizeInCreationHistoryTable">社团规模</label>
                    <div>
                        <input type="text" class="form-control" id="clubSizeInCreationHistoryTable"  name="clubSizeInCreationHistoryTable" placeholder="">
                    </div>
                    <label class="form-group" for="applyTimeInCreationHistoryTable">申请时间</label>
                    <div>
                        <input type="text" class="form-control" id="applyTimeInCreationHistoryTable"  name="applyTimeInCreationHistoryTable" placeholder="">
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!--
           作者：offline
           时间：2018-07-13
           描述：所有社团解散请求的展示
    -->

    <div class="modal fade bs-example-modal-lg" id="manageClubDissolveApply" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" >资金申请一览</h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table id="manageClubDissolveApply-table" class="table table-striped table-bordered">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" id="editClubDissolveApplyTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                    <h4 class="modal-title" >资金申请详情</h4>
                </div>
                <div class="modal-body">
                    <label class="form-group" for="clubNameInClubDissolveApplyTable">社团名称:</label>
                    <div>
                        <input type="text" class="form-control"  id="clubNameInClubDissolveApplyTable" name="clubNameInAllClubTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="stuNameInClubDissolveApplyTable">负责人姓名:</label>
                    <div>
                        <input type="text" class="form-control"  id="stuNameInClubDissolveApplyTable" name="stuNameInClubDissolveApplyTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="stuIDInClubDissolveApplyTable">负责人学号:</label>
                    <div>
                        <input type="text" class="form-control"  id="stuIDInClubDissolveApplyTable" name="stuIDInClubDissolveApplyTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="reasonInClubDissolveApplyTable">解散理由:</label>
                    <div>
                        <input type="text" class="form-control"  id="reasonInClubDissolveApplyTable" name="reasonInClubDissolveApplyTable" disabled="disabled">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button"  class="btn btn-primary" id="btn_dissolve_apply_pass"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 批准</button>
                    <button type="button" id="btn_dissolve_apply_refuse" class="btn btn-default" ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 拒绝</button>
                </div>
            </div>
        </div>
    </div>

    <!--
               作者：offline
               时间：2018-07-13
               描述：所有资金历史请求的展示
        -->

    <div class="modal fade bs-example-modal-lg" id="manageHistoryFundApply" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1060">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" >资金申请一览</h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table id="manageHistoryFundApply-table" class="table table-striped table-bordered">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" id="editHistoryFundApplyTableDetail" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 1070">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true" >&times;</span></button>
                    <h4 class="modal-title" >资金申请详情</h4>
                </div>
                <div class="modal-body">
                    <label class="form-group" for="clubNameInHistoryFundApplyTable">社团名称:</label>
                    <div>
                        <input type="text" class="form-control"  id="clubNameInHistoryFundApplyTable" name="clubNameInHistoryFundApplyTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="activityNameInHistoryFundApplyTable">活动名称:</label>
                    <div>
                        <input type="text" class="form-control"  id="activityNameInHistoryFundApplyTable" name="activityNameInHistoryFundApplyTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="amountInHistoryFundApplyTable">申请金额:</label>
                    <div>
                        <input type="text" class="form-control"  id="amountInHistoryFundApplyTable" name="amountInHistoryFundApplyTable" disabled="disabled">
                    </div>
                    <label class="form-group" for="applyReasonInHistoryFundApplyTable">申请理由:</label>
                    <div>
                        <input type="text" class="form-control"  id="applyReasonInHistoryFundApplyTable" name="applyReasonInHistoryFundApplyTable" disabled="disabled">
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
	<script src="mobile.js"></script>
	<script src="apply_center_js.js"></script>


    <script>
      //创建社团的script代码
      var order;
      function manageCreateApplyEnter() {

          $.ajax(
              {
                  url:'/CreateApplyManagement',
                  method: 'POST',
                  async: false,
                  success: function (data) {
                      //alert(data);
                      var dataset = new Array();
                      order = [
                          "applyNo",
                          "clubName",
                          "ClubType",
                          "clubInfo",
                          "stuNo",
                          "stuName",
                          "clubSize",
                          "applyTime"
                      ];
                      var UsedJson = eval("" + data + "");
                      for (var i = 0; i < UsedJson.length; i++) {
                          var eachItem = new Array();
                          eachItem.push(UsedJson[i].applyNo.toString());
                          eachItem.push(UsedJson[i].clubName.toString());
                          eachItem.push(UsedJson[i].clubType.toString());
                          eachItem.push(UsedJson[i].clubInfo.toString());
                          eachItem.push(UsedJson[i].stuNo.toString());
                          eachItem.push(UsedJson[i].stuName.toString());
                          eachItem.push(UsedJson[i].clubSize.toString());
                          eachItem.push(UsedJson[i].applyTime.toString());
                          dataset.push(eachItem);
                      }
                      //alert("您的操作成功");
                      reloadCreateApplyTableData(dataset);
                      $('#manageCreateApply').modal('show');

                      //self.location.reload();
                  }, error: function (data) {
                      alert("fail");
                  }
              }
          );
      }

      $("#btn_create_club_pass").click(function(){
          var ret = window.confirm("确定通过吗?");
          if(ret){
              $.ajax(
                  {
                      url:"CreateApplyManagement",
                      method:"POST",
                      data:{
                          clubNo : editingID,
                          "clubName":$("#clubNameInCreateApplyTable").val(),
                          "type":$("#clubTypeInCreateApplyTable").val(),
                          "clubInfo":$("#clubInfoInCreateApplyTable").val(),
                          "status":1
                      },
                      success:function (data) {

                          $.ajax(
                              {
                                  url:'/CreateApplyManagement',
                                  method: 'POST',
                                  async: false,
                                  success: function (data) {
                                      //alert(data);
                                      var dataset = new Array();
                                      order = [
                                          "applyNo",
                                          "clubName",
                                          "ClubType",
                                          "clubInfo",
                                          "stuNo",
                                          "stuName",
                                          "clubSize",
                                          "applyTime"
                                      ];
                                      var UsedJson = eval("" + data + "");
                                      for (var i = 0; i < UsedJson.length; i++) {
                                          var eachItem = new Array();
                                          eachItem.push(UsedJson[i].applyNo.toString());
                                          eachItem.push(UsedJson[i].clubName.toString());
                                          eachItem.push(UsedJson[i].clubType.toString());
                                          eachItem.push(UsedJson[i].clubInfo.toString());
                                          eachItem.push(UsedJson[i].stuNo.toString());
                                          eachItem.push(UsedJson[i].stuName.toString());
                                          eachItem.push(UsedJson[i].clubSize.toString());
                                          eachItem.push(UsedJson[i].applyTime.toString());
                                          dataset.push(eachItem);
                                      }
                                      //alert("您的操作成功");
                                      reloadCreateApplyTableData(dataset);
                                      $('#manageCreateApply').modal('show');

                                      //self.location.reload();
                                  }, error: function (data) {
                                      alert("fail");
                                  }
                              }
                          );

                          alert("您的操作成功");

                      },
                      error:function (data) {
                          alert("您的操作失败");
                      }

                  }
              );
              $('#editCreateApplyTableDetail').modal('hide');
          }
          else {
              var judge = prompt("随便输入点什么？");
              if (judge) {
                  document.write("输入的内容为："+judge+"。");
              } else {
                  document.write("取消就没了哦。");
              }
          }
      });


      $("#btn_create_club_refuse").click(function() {
          var ret = window.confirm("确定拒绝吗?");
          if (ret){
              $.ajax(
                  {
                      url:"CreateApplyManagement",
                      method:"POST",
                      data:{
                          clubNo : editingID,
                          "clubName":$("#clubNameInCreateApplyTable").val(),
                          "type":$("#clubTypeInCreateApplyTable").val(),
                          "clubInfo":$("#clubInfoInCreateApplyTable").val(),
                          "status":2
                      },
                      success:function (data) {

                          $.ajax(
                              {
                                  url:'/CreateApplyManagement',
                                  method: 'POST',
                                  async: false,
                                  success: function (data) {
                                      //alert(data);
                                      var dataset = new Array();
                                      order = [
                                          "applyNo",
                                          "clubName",
                                          "ClubType",
                                          "clubInfo",
                                          "stuNo",
                                          "stuName",
                                          "clubSize",
                                          "applyTime"
                                      ];
                                      var UsedJson = eval("" + data + "");
                                      for (var i = 0; i < UsedJson.length; i++) {
                                          var eachItem = new Array();
                                          eachItem.push(UsedJson[i].applyNo.toString());
                                          eachItem.push(UsedJson[i].clubName.toString());
                                          eachItem.push(UsedJson[i].clubType.toString());
                                          eachItem.push(UsedJson[i].clubInfo.toString());
                                          eachItem.push(UsedJson[i].stuNo.toString());
                                          eachItem.push(UsedJson[i].stuName.toString());
                                          eachItem.push(UsedJson[i].clubSize.toString());
                                          eachItem.push(UsedJson[i].applyTime.toString());
                                          dataset.push(eachItem);
                                      }
                                      //alert("您的操作成功");
                                      reloadCreateApplyTableData(dataset);
                                      $('#manageCreateApply').modal('show');

                                      //self.location.reload();
                                  }, error: function (data) {
                                      alert("fail");
                                  }
                              }
                          );

                          alert("您的操作成功");

                      },
                      error:function (data) {
                          alert("您的操作失败");
                      }

                  }
              );
              $('#editCreateApplyTableDetail').modal('hide');
          }
          else {
              var judge = prompt("随便输入点什么？");
              if (judge) {
                  document.write("输入的内容为："+judge+"。");
              } else {
                  document.write("取消就没了哦。");
              }
          }
              });


</script>

    <script>
        //管理所有社团信息的script代码
        var order;
function manageAllClubsEnter() {

    $.ajax(
        {
            url:'/ClubManagement',
            method:'POST',
            async:false,
            success:function(data) {
                //alert(data);
                var dataset = new Array();
                order = [
                    "clubNo",
                    "clubName",
                    "type",
                    "clubInfo"
                ];
                var UsedJson = eval(""+data+"");
                for (var i = 0; i < UsedJson.length; i++) {
                    var eachItem = new Array();
                    eachItem.push(UsedJson[i].clubNo.toString());
                    eachItem.push(UsedJson[i].clubName.toString());
                    eachItem.push(UsedJson[i].type.toString());
                    eachItem.push(UsedJson[i].clubInfo.toString());
                    dataset.push(eachItem);
                }
                //alert("您的操作成功");
                reloadAllClubTableData(dataset);
                $('#manageAllClub').modal('show');

                //self.location.reload();
            },error:function(data) {
                alert("fail");
            }
        }
    );
}

        $("#btn_edit_club_info").click(function(){
            var ret = window.confirm("确定修改社团的信息吗?");
            if(ret) {
                $.ajax(
                    {
                        url: "ClubManagement",
                        method: 'POST',
                        data: {
                            clubNo: editingID,
                            'status': 1,
                            'clubName': $("#clubNameInAllClubTable").val(),
                            'type': $("#TypeInAllClubTable").val(),
                            'clubInfo': $("#ClubInfoInAllClubTable").val()
                        },
                        success: function (data) {
                            $.ajax(
                                {
                                    url: '/ClubManagement',
                                    method: 'POST',
                                    async: false,
                                    success: function (data) {
                                        //alert(data);
                                        var dataset = new Array();
                                        order = [
                                            "clubNo",
                                            "clubName",
                                            "type",
                                            "clubInfo"
                                        ];
                                        var UsedJson = eval("" + data + "");
                                        for (var i = 0; i < UsedJson.length; i++) {
                                            var eachItem = new Array();
                                            eachItem.push(UsedJson[i].clubNo.toString());
                                            eachItem.push(UsedJson[i].clubName.toString());
                                            eachItem.push(UsedJson[i].type.toString());
                                            eachItem.push(UsedJson[i].clubInfo.toString());
                                            dataset.push(eachItem);
                                        }
                                        //alert("您的操作成功");
                                        reloadAllClubTableData(dataset);
                                        $('#editAllClubTableDetail').modal('hide');

                                        //self.location.reload();
                                    }, error: function (data) {
                                        alert("fail");
                                    }
                                }
                            );


                            alert("您的操作成功");
                            //reloadAllClubTableData(dataset);

                        },
                        error: function (data) {
                            alert("您的操作失败");
                        }

                    }
                );


                    $.ajax(
                        {
                            url: '/ClubManagement',
                            method: 'POST',
                            async: false,
                            success: function (data) {
                                //alert(data);
                                var dataset = new Array();
                                order = [
                                    "clubNo",
                                    "clubName",
                                    "type",
                                    "clubInfo"
                                ];
                                var UsedJson = eval("" + data + "");
                                for (var i = 0; i < UsedJson.length; i++) {
                                    var eachItem = new Array();
                                    eachItem.push(UsedJson[i].clubNo.toString());
                                    eachItem.push(UsedJson[i].clubName.toString());
                                    eachItem.push(UsedJson[i].type.toString());
                                    eachItem.push(UsedJson[i].clubInfo.toString());
                                    dataset.push(eachItem);
                                }
                                //alert("您的操作成功");
                                reloadAllClubTableData(dataset);
                                $('#editAllClubTableDetail').modal('hide');

                                //self.location.reload();
                            }, error: function (data) {
                                alert("fail");
                            }
                        }
                    );
                }

            else {
                var judge = prompt("随便输入点什么？");
                if (judge) {
                    document.write("输入的内容为："+judge+"。");
                } else {
                    document.write("取消就没了哦。");
                }
            }
        });

</script>

    <script>

      //管理资金申请的script代码
      var order;
      function manageMoneyApplyEnter()
      {
          $.ajax(
              {
                  url:'/FundManagement',
                  method: 'POST',
                  async: false,
                  success: function (data) {
                      //alert(data);
                      var dataset = new Array();
                      order = [
                          "applyNo",
                          "active_name",
                          "clubName",
                          "price",
                          "reason",
                      ];
                      var UsedJson = eval("" + data + "");
                      for (var i = 0; i < UsedJson.length; i++) {
                          var eachItem = new Array();
                          eachItem.push(UsedJson[i].applyNo.toString());
                          eachItem.push(UsedJson[i].active_name.toString());
                          eachItem.push(UsedJson[i].clubName.toString());
                          eachItem.push(UsedJson[i].price.toString());
                          eachItem.push(UsedJson[i].reason.toString());
                          dataset.push(eachItem);
                      }
                      //alert("您的操作成功");
                      reloadMoneyApplyTableData(dataset);
                      $('#manageFundApply').modal('show');

                      //self.location.reload();
                  }, error: function (data) {
                      alert("fail");
                  }
              }
          );
      }


      $("#btn_money_apply_pass").click(function(){
          var ret = window.confirm("确定通过申请吗?");
          if(ret){
              $.ajax(
                  {
                      url:"/FundManagement",
                      method:'POST',
                      data:{
                          clubNo : editingID,
                          "status":1

                      },
                      success:function (data) {
                          $.ajax(
                              {
                                  url:'/FundManagement',
                                  method: 'POST',
                                  async: false,
                                  success: function (data) {
                                      //alert(data);
                                      var dataset = new Array();
                                      order = [
                                          "applyNo",
                                          "active_name",
                                          "clubName",
                                          "price",
                                          "reason",
                                      ];
                                      var UsedJson = eval("" + data + "");
                                      for (var i = 0; i < UsedJson.length; i++) {
                                          var eachItem = new Array();
                                          eachItem.push(UsedJson[i].applyNo.toString());
                                          eachItem.push(UsedJson[i].active_name.toString());
                                          eachItem.push(UsedJson[i].clubName.toString());
                                          eachItem.push(UsedJson[i].price.toString());
                                          eachItem.push(UsedJson[i].reason.toString());
                                          dataset.push(eachItem);
                                      }
                                      //alert("您的操作成功");
                                      reloadMoneyApplyTableData(dataset);
                                      $('#manageFundApply').modal('show');

                                      //self.location.reload();
                                  }, error: function (data) {
                                      alert("fail");
                                  }
                              }
                          );
                      },
                      error:function (data) {
                          alert("您的操作失败");
                      }

                  }
              );

              alert("您的操作成功");
              $('#editFundApplyTableDetail').modal('hide');
          }
          else {
              var judge = prompt("随便输入点什么？");
              if (judge) {
                  document.write("输入的内容为："+judge+"。");
              } else {
                  document.write("取消就没了哦。");
              }
          }
      });

      $("#btn_money_apply_refuse").click(function(){
          var ret = window.confirm("确定拒绝申请吗?");
          if(ret){
              $.ajax(
                  {
                      url:"/FundManagement",
                      method:'POST',
                      data:{
                          clubNo : editingID,
                          "status":2

                      },
                      success:function (data) {
                          $.ajax(
                              {
                                  url:'/FundManagement',
                                  method: 'POST',
                                  async: false,
                                  success: function (data) {
                                      //alert(data);
                                      var dataset = new Array();
                                      order = [
                                          "applyNo",
                                          "active_name",
                                          "clubName",
                                          "price",
                                          "reason",
                                      ];
                                      var UsedJson = eval("" + data + "");
                                      for (var i = 0; i < UsedJson.length; i++) {
                                          var eachItem = new Array();
                                          eachItem.push(UsedJson[i].applyNo.toString());
                                          eachItem.push(UsedJson[i].active_name.toString());
                                          eachItem.push(UsedJson[i].clubName.toString());
                                          eachItem.push(UsedJson[i].price.toString());
                                          eachItem.push(UsedJson[i].reason.toString());
                                          dataset.push(eachItem);
                                      }
                                      //alert("您的操作成功");
                                      reloadMoneyApplyTableData(dataset);
                                      $('#manageFundApply').modal('show');

                                      //self.location.reload();
                                  }, error: function (data) {
                                      alert("fail");
                                  }
                              }
                          );
                      },
                      error:function (data) {
                          alert("您的操作失败");
                      }
                  }
              );
              $('#editFundApplyTableDetail').modal('hide');
              // var judge = prompt("请简短输入拒绝理由");
              // if (judge) {
              //     document.write("输入的内容为："+judge+"。");
              // } else {
              //     document.write("取消就没了哦。");
              // }
          }
          else {
          }
      });

    </script>

    <script>
      //管理创建社团申请历史的script代码
      var order;
      function manageCreationHistoryEnter()
      {
          $.ajax(
              {
                  url:'/CreateHis',
                  method: 'POST',
                  async: false,
                  success: function (data) {
                      //alert(data);
                      var dataset = new Array();
                      order = [
                          "applyNo",
                          "clubName",
                          "ClubType",
                          "clubInfo",
                          "stuNo",
                          "stuName",
                          "clubSize",
                          "applyTime"
                      ];
                      var UsedJson = eval("" + data + "");
                      for (var i = 0; i < UsedJson.length; i++) {
                          var eachItem = new Array();
                          eachItem.push(UsedJson[i].applyNo.toString());
                          eachItem.push(UsedJson[i].clubName.toString());
                          eachItem.push(UsedJson[i].clubType.toString());
                          eachItem.push(UsedJson[i].clubInfo.toString());
                          eachItem.push(UsedJson[i].stuNo.toString());
                          eachItem.push(UsedJson[i].stuName.toString());
                          eachItem.push(UsedJson[i].clubSize.toString());
                          eachItem.push(UsedJson[i].applyTime.toString());
                          dataset.push(eachItem);
                      }
                      //alert("您的操作成功");
                      reloadCreationHistoryTableData(dataset);
                      $('#manageCreationHistory').modal('show');

                      //self.location.reload();
                  }, error: function (data) {
                      alert("fail");
                  }
              }
          );
      }





    </script>

    <script>
        //解散社团的script代码
        var order;
        function manageClubDissolveApplyEnter()
        {
            // var dataset = [
            //     [ "123","345","Tiger Nixon", "System Architect", "Edinburgh"],
            //     [ "123","345","Garrett Winters", "Accountant", "Tokyo"],
            //     [ "123","345","Ashton Cox", "Junior Technical Author", "San Francisco"],
            //     [ "123","345","Cedric Kelly", "Senior Javascript Developer", "Edinburgh"],
            //     [ "123","345","Airi Satou", "Accountant", "Tokyo"]];

            $.ajax(
                {
                    url:'/DisolveManagement',
                    method: 'POST',
                    async: false,
                    success: function (data) {
                        //alert(data);
                        var dataset = new Array();
                        order = [
                            "applyNo",
                            "clubNo",
                            "clubName",
                            "stuNo",
                            "stuName",
                            "reason"
                        ];
                        var UsedJson = eval("" + data + "");
                        for (var i = 0; i < UsedJson.length; i++) {
                            var eachItem = new Array();
                            eachItem.push(UsedJson[i].applyNo.toString());
                            eachItem.push(UsedJson[i].clubNo.toString());
                            eachItem.push(UsedJson[i].clubName.toString());
                            eachItem.push(UsedJson[i].stuNo.toString());
                            eachItem.push(UsedJson[i].stuName.toString());
                            eachItem.push(UsedJson[i].reason.toString());
                            dataset.push(eachItem);
                        }
                        //alert("您的操作成功");
                        reloadClubDissolveApplyTableData(dataset);
                        $('#manageClubDissolveApply').modal('show');

                        //self.location.reload();
                    }, error: function (data) {
                        alert("fail");
                    }
                }
            );


            // reloadClubDissolveApplyTableData(dataset);
            // $('#manageClubDissolveApply').modal('show');
        }



        // var testData={
        //     "item1":['item41','item42'],
        //     "item2":['item41','item42'],
        //     "item3":['item41','item42'],
        //     "item4":['item41','item42'],
        //     "item5":['item41','item42'],
        //     "item6":['item41','item42'],
        //     "item7":['item41','item42']
        // }
        // //输出
        // $(window).ready(function () {
        //     jojo(testData);
        // })
        //
        //
        //
        // var jojo=function(data){
        //     //技巧：用constructor 去判断数据类型比typeof 和instanceof 更好使
        //     if(data.constructor==Object){
        //         for(var i in data){
        //             if(data[i].constructor==String|| data[i].constructor==Number){
        //                 console.log('对象值的输出：'+data[i]);
        //             }else{
        //                 //递归调用
        //                 jojo(data[i]);
        //             }
        //         }
        //     }else if(data.constructor==Array){
        //         for(var i= 0,max=data.length;i<max;i++){
        //             if(data[i].constructor==String|| data[i].constructor==Number){
        //                 console.log('数组值的输出:'+JSON.stringify(data[i]));
        //             }else{
        //                 //递归调用
        //                 jojo(data[i]);
        //             }
        //         }
        //     }
        // }



        $("#btn_dissolve_apply_pass").click(function(){
            var ret = window.confirm("确定通过吗?");
            // if(ret){
            //     $.ajax(
            //         {
            //             url: "/DisolveManagement",
            //             method: 'POST',
            //             data: {
            //                 clubNo: editingID,
            //                 "status": 1
            //
            //             },
            //             success: function (data) {
            //                 $.ajax(
            //                     {
            //                         url: '/FundManagement',
            //                         method: 'POST',
            //                         async: false,
            //                         success: function (data) {
            //                             $.ajax(
            //                                 {
            //                                     url: '/DisolveManagement',
            //                                     method: 'POST',
            //                                     async: false,
            //                                     success: function (data) {
            //                                         //alert(data);
            //                                         var dataset = new Array();
            //                                         order = [
            //                                             "applyNo",
            //                                             "clubName",
            //                                             "stuNo",
            //                                             "stuName",
            //                                             "reason"
            //                                         ];
            //                                         var UsedJson = eval("" + data + "");
            //                                         for (var i = 0; i < UsedJson.length; i++) {
            //                                             var eachItem = new Array();
            //                                             eachItem.push(UsedJson[i].applyNo.toString());
            //                                             eachItem.push(UsedJson[i].clubName.toString());
            //                                             eachItem.push(UsedJson[i].stuNo.toString());
            //                                             eachItem.push(UsedJson[i].stuName.toString());
            //                                             eachItem.push(UsedJson[i].reason.toString());
            //                                             dataset.push(eachItem);
            //                                         }
            //                                         //alert("您的操作成功");
            //                                         reloadClubDissolveApplyTableData(dataset);
            //                                         $('#manageClubDissolveApply').modal('show');
            //
            //                                         //self.location.reload();
            //                                     }, error: function (data) {
            //                                         alert("fail");
            //                                     }
            //                                 }
            //                             );
            //                         },
            //                         error: function (data) {
            //                             alert("您的操作失败");
            //                         }
            //                     }
            //                 );
            //                 alert("您的操作成功");
            //                 reloadClubDissolveApplyTableData(dataset);
            //                 // reloadCreateApplyTableData(dataset);
            //                 $('#editClubDissolveApplyTableDetail').modal('hide');
            //
            //
            // else {
            //     var judge = prompt("随便输入点什么？");
            //     if (judge) {
            //         document.write("输入的内容为："+judge+"。");
            //     } else {
            //         document.write("取消就没了哦。");
            //     }
            // }
            if(ret){
                $.ajax(
                    {
                        url:"/DisolveManagement",
                        method:'POST',
                        data:{
                            applyNo : editingID,
                            clubNo :tempid,
                            "status":1

                        },
                        success:function (data) {
                            $.ajax(
                                {
                                    url:'/DisolveManagement',
                                    method: 'POST',
                                    async: false,
                                    success: function (data) {
                                        //alert(data);
                                        var dataset = new Array();
                                        order = [
                                            "applyNo",
                                            "clubNo",
                                            "clubName",
                                            "stuNo",
                                            "stuName",
                                            "reason"
                                        ];
                                        var UsedJson = eval("" + data + "");
                                        for (var i = 0; i < UsedJson.length; i++) {
                                            var eachItem = new Array();
                                            eachItem.push(UsedJson[i].applyNo.toString());
                                            eachItem.push(UsedJson[i].clubNo.toString());
                                            eachItem.push(UsedJson[i].clubName.toString());
                                            eachItem.push(UsedJson[i].stuNo.toString());
                                            eachItem.push(UsedJson[i].stuName.toString());
                                            eachItem.push(UsedJson[i].reason.toString());
                                            dataset.push(eachItem);
                                        }
                                        //alert("您的操作成功");
                                        reloadClubDissolveApplyTableData(dataset);
                                        $('#manageClubDissolveApply').modal('show');

                                        //self.location.reload();
                                    }, error: function (data) {
                                        alert("fail");
                                    }
                                }
                            );
                        },
                        error:function (data) {
                            alert("您的操作失败");
                        }

                    }
                );

                alert("您的操作成功");
                $('#editClubDissolveApplyTableDetail').modal('hide');
            }
            else {
                var judge = prompt("随便输入点什么？");
                if (judge) {
                    document.write("输入的内容为："+judge+"。");
                } else {
                    document.write("取消就没了哦。");
                }
            }
        });

        $("#btn_dissolve_apply_refuse").click(function(){
            var ret = window.confirm("确定拒绝吗?");
            if(ret){
                $.ajax(
                    {
                        url:"/DisolveManagement",
                        method:'POST',
                        data:{
                            applyNo : editingID,
                            clubNo :tempid,
                            "status":2

                        },
                        success:function (data) {
                            $.ajax(
                                {
                                    url:'/DisolveManagement',
                                    method: 'POST',
                                    async: false,
                                    success: function (data) {
                                        //alert(data);
                                        var dataset = new Array();
                                        order = [
                                            "applyNo",
                                            "clubNo",
                                            "clubName",
                                            "stuNo",
                                            "stuName",
                                            "reason"
                                        ];
                                        var UsedJson = eval("" + data + "");
                                        for (var i = 0; i < UsedJson.length; i++) {
                                            var eachItem = new Array();
                                            eachItem.push(UsedJson[i].applyNo.toString());
                                            eachItem.push(UsedJson[i].clubNo.toString());
                                            eachItem.push(UsedJson[i].clubName.toString());
                                            eachItem.push(UsedJson[i].stuNo.toString());
                                            eachItem.push(UsedJson[i].stuName.toString());
                                            eachItem.push(UsedJson[i].reason.toString());
                                            dataset.push(eachItem);
                                        }
                                        //alert("您的操作成功");
                                        reloadClubDissolveApplyTableData(dataset);
                                        $('#manageClubDissolveApply').modal('show');

                                        //self.location.reload();
                                    }, error: function (data) {
                                        alert("fail");
                                    }
                                }
                            );
                        },
                        error:function (data) {
                            alert("您的操作失败");
                        }

                    }
                );

                alert("您的操作成功");
                $('#editClubDissolveApplyTableDetail').modal('hide');
            }
            else {
                var judge = prompt("随便输入点什么？");
                if (judge) {
                    document.write("输入的内容为："+judge+"。");
                } else {
                    document.write("取消就没了哦。");
                }
            }
        });


    </script>

    <script>
        //管理社团资金申请历史的script代码
        var order;
        function manageHistoryFundApplyEnter()
        {
            $.ajax(
                {
                    url:'/FundHis',
                    method: 'POST',
                    async: false,
                    success: function (data) {
                        //alert(data);
                        var dataset = new Array();
                        order = [
                            "applyNo",
                            "active_name",
                            "clubName",
                            "price",
                            "reason",
                        ];
                        var UsedJson = eval("" + data + "");
                        for (var i = 0; i < UsedJson.length; i++) {
                            var eachItem = new Array();
                            eachItem.push(UsedJson[i].applyNo.toString());
                            eachItem.push(UsedJson[i].active_name.toString());
                            eachItem.push(UsedJson[i].clubName.toString());
                            eachItem.push(UsedJson[i].price.toString());
                            eachItem.push(UsedJson[i].reason.toString());
                            dataset.push(eachItem);
                        }
                        //alert("您的操作成功");
                        reloadHistoryFundApplyTableData(dataset);
                        $('#manageHistoryFundApply').modal('show');

                        //self.location.reload();
                    }, error: function (data) {
                        alert("fail");
                    }
                }
            );
        }



    </script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>



  </body>
</html>
