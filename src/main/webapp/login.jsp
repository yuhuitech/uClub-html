
<%@ page import="java.util.HashMap" %>
<%@ page import="operations.DAO" %><%--
  Created by IntelliJ IDEA.
  User: Haess
  Date: 2018/7/3
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
    body {
        background-image:  url(jsp/images/b4.jpg) !important;
    }
    .login_content h1:before {
        background: unset !important;
        background: linear-gradient(right,#7e7e7e 0,#fff 100%);
        left: 0;
    }
    .login_content h1:after {
        background: unset !important;
        background: linear-gradient(left,#7e7e7e 0,#fff 100%);
        right: 0;
    }
</style>
<head>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>  Login  </title>

    <!-- Bootstrap -->
    <link href="jsp/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Font Awesome -->
    <link href="jsp/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
    <!-- NProgress -->
    <link href="jsp/vendors/nprogress/nprogress.css" rel="stylesheet"/>
    <!-- Animate.css -->
    <link href="jsp/vendors/animate.css/animate.min.css" rel="stylesheet"/>

    <!-- Custom Theme Style -->
    <link href="jsp/build/css/custom.min.css" rel="stylesheet"/>
</head>

<body class="login" style=" background-size:  cover;">
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
                    if(objs.success=="true") {
                        if(status=="student") {
                            window.location.href = "jsp/Recommend.jsp";
                        }
                        else if(status=="admin"){
                            window.location.href = "jsp/apply_center.jsp";
                        }
                    }
                    else {
                        document.getElementById("reminder").innerText = "密码错误/帐号不存在";
                        document.getElementById("reminder2").innerText = "密码错误/帐号不存在";
                    }
                },
                async:false});

        }
    </script>

    <div class="login_wrapper"  style="margin: 10% auto 0;">
        <div class="animate form login_form">
            <section class="login_content" style=" margin: 0 auto; padding: 25px 0 0; position: relative; display: contents; text-align: center; text-shadow: 0 1px 0 #fff; min-width: 280px;">
                <form action="login" method="post" style="  background: rgba(255,255,255,0.7);  padding: 40px;  box-shadow: 1px 1px 5px #888888;  border-radius: 10px;">
                    <h1  style="color: #659099; text-shadow: none;">学生登录</h1>
                    <div>
                        <input type="text" class="form-control" id="Sno" placeholder="帐号/学号" required="" />
                    </div>
                    <div>
                        <input type="password" class="form-control" id="Spasswd" placeholder="密码" required="" />
                    </div>
                    <div>
                        <span id="reminder"></span>
                    </div>
                    <br />
                    <div>
                        <input type="button" class="btn btn-round btn-success" style="background: darkcyan; width: 200px;" value="登录"  onclick="login($('#Sno').val(),$('#Spasswd').val(),'student')" />
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator" style="color: #659099; text-shadow: none;">
                        <p class="change_link">切换模式：
                            <a href="#signup" class="to_register"> 管理员登录 </a>
                        </p>

                        <div class="clearfix"></div>
                        <br />

                        <div>
                            <%--<i class="fa fa-paw"></i>--%>
                            <%--<h1><img src="jsp/images/logo6.png" /> Uclub!</h1>--%>
                            <p style=" position:  absolute; top: 83%; left: 30%;">Create by Uclub Team.</p>
                        </div>
                    </div>
                </form>
            </section>
        </div>

        <div id="register" class="animate form registration_form">
            <section class="login_content" style=" margin: 0 auto; padding: 25px 0 0; position: relative; display: contents; text-align: center; text-shadow: 0 1px 0 #fff; min-width: 280px;">
                <form style="  background: rgba(255,255,255,0.7);  padding: 40px;  box-shadow: 1px 1px 5px #888888;  border-radius: 10px;">
                    <h1  style="color: #659099; text-shadow: none;">管理员登录</h1>
                    <div>
                        <input type="text" class="form-control" id="Ano" placeholder="帐号" required="" />
                    </div>
                    <div>
                        <input type="password" class="form-control" id="Apasswd" placeholder="密码" required="" />
                    </div>
                    <div>
                        <span id="reminder2"></span>
                    </div>
                    <br />
                    <div>
                        <input type="button" class="btn btn-round btn-success" value="登录"  style="background: darkcyan; width: 200px;"  onclick="login($('#Ano').val(),$('#Apasswd').val(),'admin')" />
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator"  style="color: #659099; text-shadow: none;">
                        <p class="change_link">切换模式：
                            <a href="#signin" class="to_register"> 学生登录 </a>
                        </p>

                        <div class="clearfix"></div>
                        <br />

                        <div>
                            <%--<i class="fa fa-paw"></i>--%>
                            <%--<h1> <img src="jsp/images/logo6.png" />Uclub!</h1>--%>
                            <p style=" position:  absolute; top: 83%; left: 30%;">Create by Uclub Team.</p>
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

