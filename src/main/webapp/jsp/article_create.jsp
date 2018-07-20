<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="Test.Test" %>
<%@ page import="operations.DAO" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/18
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link href="editor.md/css/editormd.css" rel="stylesheet">
    <link href="editor.md/lib/codemirror/codemirror.min.css" rel="stylesheet">

    <link rel="stylesheet" href="editor.md/css/editormd.css">
    <link type="text/css" rel="stylesheet" href="editor.md/lib/codemirror/codemirror.min.css">
    <link type="text/css" rel="stylesheet" href="editor.md/lib/codemirror/addon/dialog/dialog.css">
    <link type="text/css" rel="stylesheet" href="editor.md/lib/codemirror/addon/search/matchesonscrollbar.css">
    <script type="text/javascript" src="editor.md/lib/codemirror/codemirror.min.js"></script>
    <script  type="text/javascript" src="editor.md/lib/codemirror/modes.min.js"></script>
    <script type="text/javascript" src="editor.md/lib/codemirror/addons.min.js"></script>
    <script  type="text/javascript" src="editor.md/lib/marked.min.js"></script>
    <script  type="text/javascript" src="editor.md/lib/prettify.min.js"></script>
    <!--<script type="text/javascript" src="editor.md/plugins/image-dialog/image-dialog.js"></script>-->










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
            margin-right: 2%;
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

<body class="nav-md" >
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
                        String resource = "mybatis.xml";
                        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
                        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
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
                            <i class="fa fa-bars" onclick="
                            resize()">

                            </i>
                        </a>
                    </div>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="" id="miniMenu">
                            <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown"
                               aria-expanded="false">
                                <img src="images/img.jpg" alt="">
                                John Doe
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
                                <i class="fa fa-envelope-o" style=" line-height: 32px;"></i>
                                <span class="badge bg-green">
                                            6
                                        </span>
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
                        <h2>
                            文章编辑器
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
            <div class="row" style=" z-index: -1;overflow:hidden">
                <!--下面的div是文章的显示div-->
                <!--<div class="col-md-12 col-sm-12 col-xs-12">-->
                <div id="markdownOuterArea">
                    <div class="am-g am-padding-top" style="height:80px;width:100%">
                        <div class="am-u-lg-11" style="height:70%">
                            <input type="hidden" id="userExperienceId" value="">
                            <input class="title-input" maxlength="128" required="required" id="articleTitle" type="text" style="height:100%;width:100%" placeholder="请输入文章标题" value="">
                        </div>

                        <div class="am-u-lg-1" style="height:80%">
                            <button id="publishBtn" class="am-btn am-btn-danger am-btn-xl" style="float: right;" onclick="postArticleToServer(); ">发表文章</button>
                        </div>
                    </div>
                    <div id="test-editormd">
                        <textarea id="editingContents" style="display:none;">### Hello Editor.md !</textarea>
                    </div>
                </div>

                <!--</div>-->
            </div>
            <div class="clearfix">
            </div>
        </div>
        <!-- /page content -->
        <!-- footer content -->
        <footer>
            <div class="pull-right">
                Create by Uclub Team.
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
<!--
作者：offline
时间：2018-07-10
描述：手机初步适配
-->
<script src="mobile.js"></script>
<script src="vendors/showdown/dist/showdown.js"></script>
<script src="editor.md/editormd.js"></script>
<script src="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="editor.md/lib/codemirror/codemirror.min.js"></script>
<script>



    var testEditor;
    var content = $('#editingContents').val();
    $(function() {


        testEditor = editormd("test-editormd", {
            width: "100%",
            height: 740,
            path : 'editor.md/lib/',
            theme : "light",
            previewTheme : "light",
            editorTheme : "paraiso-light",
            // markdown : md,
            codeFold : true,
            // syncScrolling : false,
            saveHTMLToTextarea : true,    // 保存 HTML 到 Textarea
            searchReplace : true,
            // watch : false,                // 关闭实时预览
            htmlDecode : "style,script,iframe|on*",            // 开启 HTML 标签解析，为了安全性，默认不开启
            // toolbar  : false,             //关闭工具栏
            // previewCodeHighlight : false, // 关闭预览 HTML 的代码块高亮，默认开启
            emoji : true,
            taskList : true,
            tocm            : true,         // Using [TOCM]
            // tex : true,                   // 开启科学公式TeX语言支持，默认关闭
            // flowChart : true,             // 开启流程图支持，默认关闭
            // sequenceDiagram : true,       // 开启时序/序列图支持，默认关闭,
            // dialogLockScreen : false,   // 设置弹出层对话框不锁屏，全局通用，默认为true
            // dialogShowMask : false,     // 设置弹出层对话框显示透明遮罩层，全局通用，默认为true
            // dialogDraggable : false,    // 设置弹出层对话框不可拖动，全局通用，默认为true
            // dialogMaskOpacity : 0.4,    // 设置透明遮罩层的透明度，全局通用，默认值为0.1
            // dialogMaskBgColor : "#000", // 设置透明遮罩层的背景颜色，全局通用，默认为#fff
            imageUpload : true,
            imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL : "./php/upload.php",
            onload : function() {
                console.log('onload', this);
                //this.fullscreen();
                //this.unwatch();
                //this.watch().fullscreen();

                // this.setMarkdown("#PHP");
                this.width("100%");
                this.height(480);
                this.resize("100%", 640);
            }
        });


        $("#goto-line-btn").bind("click", function(){
            testEditor.gotoLine(90);
        });

        $("#show-btn").bind('click', function(){
            testEditor.show();
        });

        $("#hide-btn").bind('click', function(){
            testEditor.hide();
        });

        $("#get-md-btn").bind('click', function(){
            alert(testEditor.getMarkdown());
        });

        $("#get-html-btn").bind('click', function() {
            alert(testEditor.getHTML());
        });

        $("#watch-btn").bind('click', function() {
            testEditor.watch();
        });

        $("#unwatch-btn").bind('click', function() {
            testEditor.unwatch();
        });

        $("#preview-btn").bind('click', function() {
            testEditor.previewing();
        });

        $("#fullscreen-btn").bind('click', function() {
            testEditor.fullscreen();
        });

        $("#show-toolbar-btn").bind('click', function() {
            testEditor.showToolbar();
        });

        $("#close-toolbar-btn").bind('click', function() {
            testEditor.hideToolbar();
        });

        $("#toc-menu-btn").click(function(){
            testEditor.config({
                tocDropdown   : true,
                tocTitle      : "目录 Table of Contents",
            });
        });

        $("#toc-default-btn").click(function() {
            testEditor.config("tocDropdown", false);
        });

        testEditor.setToolbarAutoFixed(true);
    });


    function init() {
        $("#markdownOuterArea").append("<div id=\"test-editormd\" style=\"display: none\"></div>");
        testEditor = editormd("test-editormd", {
            width: "100%",
            height: 740,
            path : 'editor.md/lib/',
            theme : "light",
            previewTheme : "light",
            editorTheme : "paraiso-light",
            markdown : content,
            codeFold : true,
            // syncScrolling : false,
            saveHTMLToTextarea : true,    // 保存 HTML 到 Textarea
            searchReplace : true,
            // watch : false,                // 关闭实时预览
            htmlDecode : "style,script,iframe|on*",            // 开启 HTML 标签解析，为了安全性，默认不开启
            // toolbar  : false,             //关闭工具栏
            // previewCodeHighlight : false, // 关闭预览 HTML 的代码块高亮，默认开启
            emoji : true,
            taskList : true,
            tocm            : true,         // Using [TOCM]
            // tex : true,                   // 开启科学公式TeX语言支持，默认关闭
            // flowChart : true,             // 开启流程图支持，默认关闭
            // sequenceDiagram : true,       // 开启时序/序列图支持，默认关闭,
            // dialogLockScreen : false,   // 设置弹出层对话框不锁屏，全局通用，默认为true
            // dialogShowMask : false,     // 设置弹出层对话框显示透明遮罩层，全局通用，默认为true
            // dialogDraggable : false,    // 设置弹出层对话框不可拖动，全局通用，默认为true
            // dialogMaskOpacity : 0.4,    // 设置透明遮罩层的透明度，全局通用，默认值为0.1
            // dialogMaskBgColor : "#000", // 设置透明遮罩层的背景颜色，全局通用，默认为#fff
            imageUpload : true,
            imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL : "./php/upload.php",
            onload : function() {
                console.log('onload', this);
                //this.fullscreen();
                //this.unwatch();
                //this.watch().fullscreen();

                // this.setMarkdown("#PHP");
                this.width("100%");
                this.height(480);
                this.resize("100%", 640);
            }
        });


        $("#goto-line-btn").bind("click", function(){
            testEditor.gotoLine(90);
        });

        $("#show-btn").bind('click', function(){
            testEditor.show();
        });

        $("#hide-btn").bind('click', function(){
            testEditor.hide();
        });

        $("#get-md-btn").bind('click', function(){
            alert(testEditor.getMarkdown());
        });

        $("#get-html-btn").bind('click', function() {
            alert(testEditor.getHTML());
        });

        $("#watch-btn").bind('click', function() {
            testEditor.watch();
        });

        $("#unwatch-btn").bind('click', function() {
            testEditor.unwatch();
        });

        $("#preview-btn").bind('click', function() {
            testEditor.previewing();
        });

        $("#fullscreen-btn").bind('click', function() {
            testEditor.fullscreen();
        });

        $("#show-toolbar-btn").bind('click', function() {
            testEditor.showToolbar();
        });

        $("#close-toolbar-btn").bind('click', function() {
            testEditor.hideToolbar();
        });

        $("#toc-menu-btn").click(function(){
            testEditor.config({
                tocDropdown   : true,
                tocTitle      : "目录 Table of Contents",
            });
        });

        $("#toc-default-btn").click(function() {
            testEditor.config("tocDropdown", false);
        });

        testEditor.setToolbarAutoFixed(true);
    }


    function resize() {
        $('body').css('pointer-events', 'none');
        $('#test-editormd').fadeOut('slow');
        testEditor.editor.remove();
        setTimeout(function()
        {
            init();
            $('#test-editormd').fadeIn('slow');
            $('body').css('pointer-events', 'auto');
            $('.CodeMirror.cm-s-paraiso-light.CodeMirror-wrap').css('width','50% !important');
            $('.editormd-preview.editormd-preview-theme-light').css('width','50% !important');
        },200);

    }


    function postArticleToServer() {
        var title = $('#articleTitle').val();
        var content = testEditor.getMarkdown();
        alert(content);
        $.ajax({
            type:'POST',
            url:"/ArticleCreate",
            data:{
                "title":title,
                "author":'julia',
                "passage":content
            }
        })
    }

</script>