
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/3
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>  Login  </title>

<!-- Bootstrap -->
<link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"/>
<!-- Font Awesome -->
<link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
<!-- NProgress -->
<link href="vendors/nprogress/nprogress.css" rel="stylesheet"/>
<!-- Animate.css -->
<link href="vendors/animate.css/animate.min.css" rel="stylesheet"/>

<!-- Custom Theme Style -->
<link href="build/css/custom.min.css" rel="stylesheet"/>
</head>

<body class="login">
<div>
    <a class="hiddenanchor" id="signup"></a>
    <a class="hiddenanchor" id="signin"></a>

    <script>
        function login(userNo,passwd,status) {
            $.ajax({
                type:'POST',
                url:"/login",
                data:{
                    "userNo":userNo,
                    "passwd":passwd,
                    "status": status,
                },
                success:function(data) {
                    var objs=eval("("+data+")");
                    if(objs.success==="true") {
                        window.location.href = "jsp/index.jsp";
                    }
                    else {
                        document.getElementById("remind").innerText = "密码错误/帐号不存在";
                    }
                },
                    async:false});

        }
    </script>

    <div class="login_wrapper">
        <div class="animate form login_form">
            <section class="login_content">
                <form action="login" method="post">
                    <h1>学生登录</h1>
                    <div>
                        <input type="text" class="form-control" id="Sno" placeholder="帐号/学号" required="" />
                    </div>
                    <div>
                        <input type="password" class="form-control" id="Spasswd" placeholder="密码" required="" />
                    </div>
                    <div>
                        <span id="remind"></span>
                    </div>
                    <br />
                    <div>
                    <!--    <span>选择登录模式 :</span>
                        <select id="status" name="status"  value="${Status}">
                            <option value="student" >学生模式</option>
                            <option value="admin">管理员模式</option>
                        </select>   -->
                        <!--     <a class="btn btn-default submit" href="index2.html">Log in</a>  -->
                       <!-- <input type="submit"  class="btn btn-default submit" value="登录" />  -->
                        <input type="button" class="btn btn-default submit" value="登录"  onclick="login($('#Sno').val(),$('#Spasswd').val(),'student')" />
                        <!--      <a class="reset_pass" href="#">Lost your password?</a>  -->
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator">
                        <p class="change_link">切换模式：
                            <a href="#signup" class="to_register"> 管理员登录 </a>
                        </p>

                        <div class="clearfix"></div>
                        <br />

                        <div>
                            <h1><i class="fa fa-paw"></i> Uclub!</h1>
                            <p>©2016 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                        </div>
                    </div>
                </form>
            </section>
        </div>

        <div id="register" class="animate form registration_form">
            <section class="login_content">
                <form>
                    <h1>管理员登录</h1>
                    <div>
                        <input type="text" class="form-control" id="Ano" placeholder="Username" required="" />
                    </div>
                    <div>
                        <input type="password" class="form-control" id="Apasswd" placeholder="Password" required="" />
                    </div>
                    <div>
                        <span id="remind"></span>
                    </div>
                    <br />
                    <div>
                        <input type="button" class="btn btn-default submit" value="登录"  onclick="login($('#Ano').val(),$('#Apasswd').val(),'admin')" />
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator">
                        <p class="change_link">切换模式：
                            <a href="#signin" class="to_register"> 学生登录 </a>
                        </p>

                        <div class="clearfix"></div>
                        <br />

                        <div>
                            <h1><i class="fa fa-paw"></i> Uclub!</h1>
                            <p>©2016 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                        </div>
                    </div>
                </form>
            </section>
        </div>
    </div>
</div>

<%
    String userNo=request.getParameter("userNo");
    String status= request.getParameter("status");
    //<用户帐号,类型>
    session.setAttribute("UserNo",userNo);
    session.setAttribute("Status",status);
%>


</body>

</html>

