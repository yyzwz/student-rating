<%--
  Created by IntelliJ IDEA.
  User: zwz
  Date: 2020/2/10 0010
  Time: 9:08
  To change this template use File | Settings | File Templates.
--%>

<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<%--

        登入失败返回页面

        在index.jsp中,用户提交输入的账号密码,则该表单会提交到后端 AdminController.java的login()方法

        如果账号密码错误,返回view/login/info模型，即返回到此页面

        此页面可以通过按钮事件返回到登入界面:login.jsp

--%>
<html>

    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>登入失败</title>

        <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="<%=basePath%>/static/layui/css/layui.css"/>

        <style type="text/css">
            .header{
                background-image: url("<%=basePath%>/static/img/login_back.jpeg");                background-size: 100%;
                height: 240px;
            }
            body{
                background-color: #0C0C0C;
            }
        </style>

    </head>

<body>
    <%--上方部分--%>
    <div class="header">

        <div style="margin: 0 45% 0 45%;padding-top:5%;text-align:center;">

            <div style="height:39px;width:167px;background:black;text-align:center;">
                <h3 style="font-family: Menlo;color:white;padding-top:6px;"><strong>登入失败</strong></h3>
            </div>

            <h4 style="margin-top:45px;">&nbsp;

                <span style="font-size:20px;" class="fa fa-github fa-fw"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <span style="font-size:20px;" class="fa fa-home fa-fw"></span><br/>

                <label><a href="https://github.com/yuyaozwz">GitHub</a></label>&nbsp;&nbsp;&nbsp;

                <label><a href="https://blog.csdn.net/qq_41464123">CSDN</a></label>

            </h4>
        </div>

    </div>


    <%--下方主界面部分--%>
    <div class="container">

        <div class="text-center">

            <br/><br/><br/><br/>

            <h1 style="color:#009688">错误信息</h1>

            <hr/><br/>

            <%--传过来的错误信息--%>
            <h3 style="color:#FF5722">${message}</h3>

            <br/><br/>

            <button class="btn btn-primary btn-lg" type="button">
                <a href="<%=basePath%>/users/outLogin.do" style="text-decoration: none;color:white;">点击我返回登录页面</a>
            </button>
        </div>

    </div>

</body>
</html>
