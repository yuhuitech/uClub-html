<%--
  Created by IntelliJ IDEA.
  User: 22847
  Date: 2018/7/9
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Foundation 实例</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.bootcss.com/foundation/5.5.3/css/foundation.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/foundation/5.5.3/js/foundation.min.js"></script>
    <script src="https://cdn.bootcss.com/foundation/5.5.3/js/vendor/modernizr.js"></script>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="top-bar" data-topbar>
    <ul class="title-area">
        <li class="name">
            <!-- 如果你不需要标题或图标可以删掉它 -->
            <h1><a href="#">UClub社团广场</a></h1>
        </li>
        <!-- 小屏幕上折叠按钮: 去掉 .menu-icon 类，可以去除图标。
        如果需要只显示图片，可以删除 "Menu" 文本 -->
        <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
    </ul>

    <section class="top-bar-section">
        <ul class="left">
            <li class="active"><a href="#">广场</a></li>
            <li><a href="#">音乐</a></li>
            <li><a href="#">体育</a></li>
            <li><a href="#">电子竞技</a></li>
        </ul>
    </section>
</nav>

<div id="myCarousel" class="carousel slide" style="width: 500px ;height: 300px" align="center">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner">
        <div class="item active">
            <img src="/images/square1.jpg" alt="First slide">
        </div>
        <div class="item">
            <img src="/images/square2.jpg" alt="Second slide">
        </div>
        <div class="item">
            <img src="/images/square3.jpg" alt="Third slide">
        </div>
    </div>
    <!-- 轮播（Carousel）导航 -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<div align="center"  >
<div style="padding:20px; width: 1000px; height: 50px" >
    <div class="panel radius" align="left">
        <h4>体育嘉年华</h4>
        <li style="list-style:none;"><a href="/jsp/articleDetail.jsp">一年一度的体育嘉年华将会在5月24日在桂圆操场举行..</a></li>
    </div>
</div>
</div>
<br><br><br>

<div align="center"  >
    <div style="padding:20px; width: 1000px; height: 50px" >
        <div class="panel radius" align="left">
            <h4>珞珈山环跑</h4>
            <li style="list-style:none;"><a href="/jsp/messageBoard.jsp">珞珈山环跑将会在5月27日从梅园小操场出发..</a></li>
        </div>
    </div>
</div>
<br><br><br>

<div align="center"  >
    <div style="padding:20px; width: 1000px; height: 50px" >
        <div class="panel radius" align="left">
            <h4>曲艺荟萃</h4>
            <li style="list-style:none;"><a href="#">由艺术协会举办的“曲艺荟萃”将会在5月25日在大学生活动中心举行..</a></li>
        </div>
    </div>
</div>
<br><br><br>

<div align="center"  >
    <div style="padding:20px; width: 1000px; height: 50px" >
        <div class="panel radius" align="left">
            <h4>爱心集市</h4>
            <li style="list-style:none;"><a href="#">爱心社举办的关爱自闭症儿童爱心集市活动将会在5月28日在桂圆操场举行..</a></li>
        </div>
    </div>
</div>
<br><br><br>
<!-- 初始化 Foundation JS -->
<script>
    $(document).ready(function() {
        $(document).foundation();
    })
</script>

</body>
</html>
