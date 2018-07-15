<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Club" %>
<%@ page import="controller.ClubDetail" %>
<%@ page import="controller.applyClubServlet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<%
  Integer userNo= (Integer) session.getAttribute("UserNo");
  String status= (String) session.getAttribute("Status");
  String userName="";
  request.setCharacterEncoding("UTF-8");
  response.setCharacterEncoding("UTF-8");
  SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) request.getServletContext().getAttribute("SqlSessionFactory");
  List<Club> clubs = ClubDetail.getAllClubs(sqlSessionFactory);
  userName=applyClubServlet.getStudentName(sqlSessionFactory,userNo);
  request.setAttribute("Clubs",clubs);


%>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

	<style>
		/*居中代码*/
			.groupNameCSS
			{
				position: absolute;
				top: 75%;
				left: 50%;
				text-align:center;
				transform: translate(-50%, -50%); 
			}
	</style>

    <title> Uclub | </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- jQuery custom content scroller -->
    <link href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
    <!-- Custom styling plus plugins -->
    <link href="build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md" onload="initFunctionTemp()">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>Uclub!</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="images/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>欢迎,</span>
                <h2><%=userName%></h2>
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
                    	  <li><a href="index2.html">趋势</a></li>
                      <li><a href="index2.html">所有社团</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-edit"></i> 申请 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="form.html">申请创建社团</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-desktop"></i> 社团中心 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="my_group.html">加入的社团</a></li>
                      <li><a href="inbox.html">收到的消息</a></li>
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
                        <a href="inbox.html">
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
                <h3> 大本营 <small> 有想要拔草的咩~</small> </h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" id="searchInfo" placeholder="键入关键字寻找社团吧...">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="goToPageOption(1);">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>所有社团信息</h2>
                    <div class="clearfix"></div>
                    </div>

                  <div id="allGroups">
                    <c:forEach items="${requestScope.Clubs}" var="keyword">

                      <div class="col-md-55">
                        <div class="thumbnail">
                          <div class="image view view-first">
                            <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                            <div class="mask">
                              <p>Your Text</p>
                              <div class="tools tools-bottom">
                                <a href="#"><i class="fa fa-link"></i></a>
                                <a href="#"><i class="fa fa-pencil"></i></a>
                                <a href="#"><i class="fa fa-times"></i></a>
                              </div>
                            </div>
                          </div>
                          <div  class="groupNameCSS">
                            ${keyword.clubName}
                          </div>
                        </div>
                      </div>



                    </c:forEach>
                  </div>


                    </div>
                    <div class="row" id="pageDivide">
                    	<div class="col-sm-5">
                    		<div class="dataTables_info" id="datatable_info" role="status" aria-live="polite">
                    			<!--Showing 1 to 10 of 57 entries-->
                    		</div>
                    	</div>
                    	<div class="col-sm-7">
                    		<div class="dataTables_paginate paging_simple_numbers" id="datatable_paginate">
                    			<ul class="pagination" id="choosePage">
                    				<li class="paginate_button previous" id="datatable_previous" onclick="goToPageOption(currentPage-1);">
                    					<a  aria-controls="datatable" data-dt-idx="0" tabindex="0">
                    						Previous
                    					</a>
                    				</li>
                    				<li id="outerPage1" class="paginate_button " onclick="goToPageOption(pageRange[0])" >
                    					<a id="Page1" aria-controls="datatable" data-dt-idx="1" tabindex="0">
                    						1
                    					</a>
                    				</li>
                    				<li id="outerPage2" class="paginate_button " onclick="goToPageOption(pageRange[1])" >
                    					<a id="Page2" aria-controls="datatable" data-dt-idx="2" tabindex="0">
                    						2
                    					</a>
                    				</li>
                    				<li id="outerPage3" class="paginate_button " onclick="goToPageOption(pageRange[2])" >
                                        <a id="Page3" aria-controls="datatable" data-dt-idx="3" tabindex="0">
                    					    3
                                        </a>
                    				</li>
                    				<li id="outerPage4" class="paginate_button " onclick="goToPageOption(pageRange[3])">
                    					<a id="Page4"  aria-controls="datatable" data-dt-idx="4" tabindex="0">
                                            4
                                        </a>
                                    </li>
                                    <li id="outerPage5" class="paginate_button " onclick="goToPageOption(pageRange[4])">
                                        <a id="Page5"  aria-controls="datatable" data-dt-idx="5" tabindex="0">
                                            5
                                        </a>
                                    </li>
                                    <li class="paginate_button next" id="datatable_next" onclick="goToPageOption(currentPage+1);">
                                        <a  aria-controls="datatable" data-dt-idx="7" tabindex="0">
                                            Next
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



    <!-- jQuery -->
    <script src="vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="vendors/nprogress/nprogress.js"></script>
<!-- jQuery custom content scroller -->
    <script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>


  </body>
</html>



<script>
    // 默认一页15个
    var allNodes;
    var allNum;
    var showNodes;
    var nowNum = 7;//一页的个数
    var allPages;
    var currentPage;
    var pageRange;


    var initFunctionTemp = function()
    {
        var temp = document.getElementById('allGroups');
        allNodes = temp.getElementsByClassName("col-md-55");
        allNum = allNodes.length;
        // allNodes = deepCopy(allNodes);
        allPages = Math.ceil(allNum*1.0/nowNum);
        for(var i = 0; i<allNum; i++)
        {
            allNodes[i].style.display="none";
        }
        goToPage(1);
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

        // if(pageNum===2)
        //     document.getElementById("outerPage2").className = "paginate_button active";
        // else if(pageNum===1)
        //     document.getElementById("outerPage1").className = "paginate_button active";
        // else if(pageNum===allPages)
        //     document.getElementById("outerPage5").className = "paginate_button active";
        // else if(pageNum===allPages-1)
        //     document.getElementById("outerPage4").className = "paginate_button active";
        // else
        //     document.getElementById("outerPage3").className = "paginate_button active";
        if(allPages<=5){
            for(temp = 0; temp<5; temp++)
            {
                if(document.getElementById("Page"+(temp+1)).innerText==='?') {
                    document.getElementById("outerPage" + (temp + 1)).style.display = "none";
                    document.getElementById("Page"+(temp+1)).style.display="none";
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
        for(var i = 0; i<allNum; i++)
        {
            if(allNodes[i].getElementsByClassName('groupNameCSS')[0].innerText.search(searchInfo)!==-1)
            {
                showNodes.push(allNodes[i]);
            }
        }
        allNodes=showNodes;
        allNum=allNodes.length;
        allPages = Math.ceil(allNum*1.0/nowNum);
        goToPage(pageNum,tempNodes,tempAllNum);
        allNodes=tempNodes;
        allNum=tempAllNum;
        allPages=tempAllPages;
    }
</script>



<%--<div class="x_content">--%>
<%--<div class="row" id="allGroups">--%>
<%--<div class="col-md-55">--%>
<%--<div class="thumbnail flex">--%>
<%--<div class="image view view-first">--%>
<%--<img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />--%>
<%--<!--<div class="mask">--%>
<%--<p>跆拳道社团</p>--%>
<%--<div class="tools tools-bottom">--%>
<%--<p>欢迎加入</p>--%>
<%--</div>--%>
<%--</div>-->--%>
<%--</div>--%>
<%--<div style="height: 35%;">--%>
<%--<div  class="groupNameCSS">--%>
<%--口琴社--%>
<%--</div>--%>
<%--</div>--%>
<%----%>
<%----%>
<%--</div>--%>
<%--</div>--%>