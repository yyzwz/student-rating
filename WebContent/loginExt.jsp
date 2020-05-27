<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
//    request.getSchema()可以返回当前页面使用的协议:  http
//    request.getServerName()可以返回当前页面所在的服务器的名字:  localhost
//    request.getServerPort()可以返回当前页面所在的服务器使用的端口: 8080;
//    request.getContextPath()可以返回当前页面所在的应用的名字: ZwzTelSystem

    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;

//    时间
    Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String nowDate = sdf.format(date);
%>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <%-- 网页标题  --%>
        <title>ZWZ通讯录管理系统登入</title>

        <%-- 外部CSS样式、JS文件  --%>
        <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="<%=basePath%>/static/css/layui.css"/>
        <link rel="stylesheet" href="<%=basePath%>/static/css/login.css"/>
        <script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
			<script type="text/javascript">
		       function refresh(){
		         //使用new Date()参数实现路径更换，预防缓存图片重新加载
		         document.getElementById("codeimage").src="/ZwzTelSystem/code/createcode?"+new Date();
		       }
		    </script>
        <%-- 内部CSS样式  --%>
        <style type="text/css">
            /*头部背景图片*/
            .header{
                background-image: url("<%=basePath%>/static/img/login_back.jpeg");
            }
            /* 注册页面表格间距 */
            td{
            	padding : 10px;
            }
            /* 输入栏文本和提示文本的字体颜色和大小 */
            input{color:#BBB;font-size:18px;}
			input::-webkit-input-placeholder{color:#666;font-size:18px;}
        </style>
        
    </head>
    

    <body>

        <%-- 头部背景图片 --%>
        <div class="header"></div>


        <%--container部分 用于显示登入注册表单 占整个界面的大多数--%>
        <div class="container">

            <div id="content">

                <%--主界面标题--%>
                <h2 class="text-nowrap" style="color: #F8F8F8;text-align:center;padding-top:10%;font-family: Menlo">ZWZ&nbsp;通讯录管理系统</h2><br><br>

                <%--该div存放两个登入、注册按钮--%>
                <div style="text-align: center;">

                    <%-- 登入按钮 点击后注册表单隐藏--%>
                    <label style="font-size:20px;color:white;padding-right:8%;">
                        <a href="#" id="login" style="text-decoration: none;border-bottom:2px solid #009688;color:#009688">登录</a>
                    </label>

                    <%--  注册按钮 点击后登入表单隐藏--%>
                    <label style="font-size:20px;color:white;padding-left:8%;">
                        <a href="#" id="register" style="text-decoration:none;">注册</a>
                    </label>
                </div>
                
                <hr style="color: #484848;text-align:center;"/>

                 <%-- 登入的表单 开始--%>
                <form action="<%=basePath%>/sys/sysuser/login" id="loginform" method="post" class="layui-form" style="text-align: center;margin-right:12%;margin-top:10%;">

                    <%-- 0 数据库的账号id属性 无需输入--%>
                    <input name="a_id" hidden="hidden" value="${a_id}"/>

                    <div>
                        <%--  1 用户名 输入框--%>
                        <div class="layui-form-item layui-inline">
                            <label class="layui-form-label" style="font-size:20px;">
                                <span class="fa fa-user fa-fw" style="color:#CCC">账&nbsp;&nbsp;&nbsp;&nbsp;号</span>
                            </label>
                            <div class="layui-input-inline">
                                <input type="text" name="a_name" class="layui-input" style="color: #FFFFFF;background:none;border: none;border-bottom:1px solid white;" placeholder="username"/>
                            </div>
                        </div>
                        <br/>

                        <%--  2 密码 输入框--%>
                        <div class="layui-form-item layui-inline">
                            <label class="layui-form-label" style="font-size:20px;">
                                <span class="fa fa-lock fa-fw" style="color:#CCC">密&nbsp;&nbsp;&nbsp;&nbsp;码</span>
                            </label>
                            <div class="layui-input-inline">
                                <input type="password" name="a_password" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="password"/>
                            </div>
                        </div>
                        <br/>
                        <%-- 验证码 --%>
                        <div class="layui-form-item layui-inline">
                            <label class="layui-form-label" style="font-size:20px;">
                            <img alt="*" src="/ZwzTelSystem/code/createcode" onclick="refresh()" id="codeimage" title="点击更换图片">
                                <%--<span class="fa fa-lock fa-fw" style="color:#CCC">验证码</span>
                                <input id="loginCode" onclick="createCode()" type="button" style="color:#333333;display:inline;background:none;border: none;"/>
                            --%>
                            </label>
                            <div class="layui-input-inline">
                                <input type="text" name="code" id="loginCheck" class="layui-input" style="display:inline;background:none;border: none;border-bottom:1px solid white;" placeholder="左侧验证码"/>
                            </div>
                        </div>
                        

                        <%--  3 登入 按钮--%>
                        <div style="text-align:center;color: #009688;background-color: #01AAED;width:48%;margin-left:138px;">
                            <input type="button" class="layui-btn layui-btn-lg" style="background: none;" value="Sing in" onclick="loginValidate()"/>
                        </div>

                    </div>

                </form>
                <%--  登入的表单 结尾--%>


                <%-- 注册的表单 开始--%>
                <form action="<%=basePath%>/sys/sysuser/register" id="registerform" method="post" class="layui-form" hidden="hidden" style="text-align: center;margin-right:12%;margin-top:10%;">
					<table width="500" class="ta" border="0"  cellpadding="0" cellspacing="0" align="center">
						 <%-- 1 账号--%>
					    <tr>
					    	<%-- 第一个td : 显示输入框输入的是什么东西 --%>
						    <td class="layui-form-item layui-inline" style="font-size:20px;margin:0px;">
					          <span class="fa fa-user fa-fw" style="color:#CCC">登入账号</span>
					        </td>
					        <%-- 第二个td : 显示输入框 --%>
					        <td colspan="1" class="layui-input-inline">
					        	<input type="text" name="a_name" id="a_name" onblur="return checkName();" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="5-10位字母数字下划线"/>
					        </td>
					        <%-- 第三个td : 显示输入框是否规范的提示信息  下同--%>
					        <td>
					        	<span id="info"></span>
					        </td>
					    </tr> 		 

						 <%-- 2 密码--%>
						<tr>
						    <td class="layui-form-item layui-inline" style="font-size:20px;margin:0px;">
					          <span class="fa fa-user fa-fw" style="color:#CCC">登入密码</span>
					        </td>
					        <td colspan="1" class="layui-input-inline">
					        	<input type="password" name="a_password" id="a_password" onblur="return checkPassword();" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="6-16位字母数字下划线"/>
                            </td>
					        <td>
					        	<span id="infopassword"></span>
					        </td>
					    </tr> 

                        <%-- 3 手机号码--%>
                        <tr>
						    <td class="layui-form-item layui-inline" style="font-size:20px;margin:0px;">
					          <span class="fa fa-user fa-fw" style="color:#CCC">手机号码</span>
					        </td>
					        <td colspan="1" class="layui-input-inline">
					        	<input type="text" name="a_telnum" id="a_telnum" onblur="return checkTel();" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="请输入电话号码"/>
                            </td>
					        <td>
					        	<span id="infotel"></span>
					        </td>
					    </tr> 
                        
                        <%-- 4 真实姓名--%>
                        <tr>
						    <td class="layui-form-item layui-inline" style="font-size:20px;margin:0px;">
					          <span class="fa fa-user fa-fw" style="color:#CCC">真实姓名</span>
					        </td>
					        <td colspan="1" class="layui-input-inline">
					        	<input type="text" name="a_realname" id="a_realname" onblur="return checkRealName();" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="请输入真实姓名"/>
                            </td>
					        <td>
					        	<span id="inforealname"></span>
					        </td>
					    </tr> 

                        <%-- 5 邮箱--%>
                        <tr>
						    <td class="layui-form-item layui-inline" style="font-size:20px;margin:0px;">
					          <span class="fa fa-user fa-fw" style="color:#CCC">电子邮箱</span>
					        </td>
					        <td colspan="1" class="layui-input-inline">
					        	<input type="text" name="a_email" id="a_email" onblur="return checkEmail();" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="请输入电子邮箱"/>
                            </td>
					        <td>
					        	<span id="infoemail"></span>
					        </td>
					    </tr> 

                        <%-- 6 验证码--%>
                        <tr>
						    <td class="layui-form-item layui-inline" style="font-size:20px;margin:0px;">
					          <span class="fa fa-envelope fa-fw" style="color:#CCC;margin:0px 0px 5px 0px;">验证码-></span>
					        </td>
					        <td colspan="1" class="layui-input-inline" >
					        	<input type="text" id="check" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="请输入右侧的验证码"/>
                            </td>
					        <td>
					        	<input id="code" onclick="createCode()" type="button" style="color:#333333;background:none;border: none;"/>
                            </td>
					    </tr> 

                        <%-- 4 提交按钮--%>
                        <tr style="text-align:center;">
                        	<td colspan="1" class="layui-input-inline">
                        		<input type="button" class="layui-btn layui-btn-lg" style="width:200px;background-color: #01AAED;" value="注册" onclick="validate()"/>
                        	</td>
                        </tr>
                        
                        <%-- 5 给底部留一点空白 美化界面 --%>
						<tr>
							<td></td>
						</tr>
  
					</table>
                </form>
               <%-- 注册的表单 结尾--%>

           </div>
        </div>

    </body>

    <script type="text/javascript">
    
		// 用户名 失去焦点
    	//$("#a_name").blur(function(){
    		//if($("#info").html() != "可以注册"){
    		//	$("#a_name").focus();
    		//}
    		//if(checkName()==false){
    		//	$("#a_name").focus();
    		//}
		//}) 
		
		// 不规范的密码 失去焦点
    	$("#a_password").blur(function(){
    		if(checkName()==false){
        		$("#a_password").focus();
    		}
		}) 
    	
        // 当点击注册按钮的时候 登入按钮高亮 登入表单隐藏 注册表单显示
        $("#register").click(function(){
            $("#login").css({'border':'none','color':'#393D49'});
            $(this).css({'border-bottom':'2px solid #009688','color':'#009688'});
            $("#loginform").hide();
            $("#registerform").show();
        });


        // 当点击登入按钮的时候 注册按钮高亮 注册表单隐藏 登入表单显示
        $("#login").click(function(){
            $("#register").css({'border':'none','color':'#393D49'});
            $(this).css({'border-bottom':'2px solid #009688','color':'#009688'});
            $("#registerform").hide();
            $("#loginform").show();
        });

        
        // 该方法用于注册时,检测输入的名字是否已经被注册
        // 可以注册返回ture
        // 已存在无法注册返回false
        function checkName(){
            var a_name = $("#a_name").val(); //先获取 输入框的用户名
            var reg= /^[a-zA-Z][a-zA-Z0-9_]{4,9}$/;  //大小写字母 数字 下划线 4到9位
            var result= reg.test(a_name); // 测试 是否符合要求

            if(a_name == null || a_name.length==0){ // 不规范颜色为红色 表示警告
            	$("#info").text("账号不能为空").css({'color':'red','font-size':'14px'});
            	$("#a_name").focus();
            	return false;
            }
			if(!result){
				$("#info").text("账号不规范").css({'color':'red','font-size':'14px'});
				$("#a_name").focus();
            	return false;
			}
            $.ajax({
                url: '<%=basePath%>/sys/sysuser/findByName?name=' + a_name,
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                success: function(data){
                	// alert(data);
                    if(data != "aaa"){
                        $("#info").text("可以注册").css({'color':'green','font-size':'14px'});
                        $("#a_password").focus();
                        return true;
                    }
                    else{
                        $("#info").text("该用户名已注册").css({'color':'red','font-size':'14px'});
                        return false;
                    }
                },
                error: function(){
                    alert("数据请求失败，请检查数据库连接");
                    return false;
                },
                complete: function(){
                	
                }
            });
            if($("#info").html() != "可以注册"){
                $("#a_name").focus();
            }
        }
        
        // 检测密码
        function checkPassword(){
			var a_password = $("#a_password").val(); 
			
			var reg= /^[a-zA-Z0-9_]{6,16}$/; 
            var result= reg.test(a_password); 
            if(a_password == null || a_password.length==0){
            	$("#infopassword").text("密码不能为空").css({'color':'red','font-size':'14px'});
            	$("#a_password").focus();
            	return false;
            }
            else if(!result){
            	$("#infopassword").text("密码不规范").css({'color':'red','font-size':'14px'});
            	$("#a_password").focus();
            	return false;
            }
            else{
            	$("#infopassword").text("密码可用").css({'color':'green','font-size':'14px'});
            	return true;
            }
            
        }
        
        // 检测电话
        function checkTel(){
			var a_telnum = $("#a_telnum").val(); 
			var reg= /^1[3,5,7,8,9][0-9]{9}$/; 
            var result= reg.test(a_telnum); 
            
            if(a_telnum == null || a_telnum.length==0){
            	$("#infotel").text("电话不能为空").css({'color':'red','font-size':'14px'});
            	$("#a_telnum").focus();
            	return false;
            }
            else if(!result){
            	$("#infotel").text("电话不规范").css({'color':'red','font-size':'14px'});
            	$("#a_telnum").focus();
            	return false;
            }
            else{
            	$("#infotel").text("电话可注册").css({'color':'green','font-size':'14px'});
            	return true;
            }
            
        }
        
        //检测真实姓名
        function checkRealName(){
			var a_realname = $("#a_realname").val(); 
			var reg= /^[\u4e00-\u9fa5]{1,5}$/; 
            var result= reg.test(a_realname); 
			
            if(a_realname == null || a_realname.length==0){
            	$("#inforealname").text("姓名不能为空").css({'color':'red','font-size':'14px'});
            	$("#a_realname").focus();
            	return false;
            }
            else if(!result){
            	$("#inforealname").text("请输入中文").css({'color':'red','font-size':'14px'});
            	$("#a_realname").focus();
            	return false;
            }
            else{
            	$("#inforealname").text("姓名正确").css({'color':'green','font-size':'14px'});
            	return true;
            }
            
        }
        
        // 检测邮箱
        function checkEmail(){
			var a_email = $("#a_email").val(); 
			var reg= /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/; 
            var result= reg.test(a_email); 
			
            if(a_email == null || a_email.length==0){
            	$("#infoemail").text("邮箱不能为空").css({'color':'red','font-size':'14px'});
            	$("#a_email").focus();
            	return false;
            }
            else if(!result){
            	$("#infoemail").text("邮箱错误").css({'color':'red','font-size':'14px'});
            	$("#a_email").focus();
            	return false;
            }
            else{
            	$("#infoemail").text("邮箱正确").css({'color':'green','font-size':'14px'});
            	return true;
            }
        }

        
        <%--createCode() 方法用于处理四位验证码的生成、验证--%>
        //设置一个全局的变量code，便于保存验证码
        var code = '';
        function createCode(){
            //首先默认code为空字符串
            code = '';

            //设置验证码长度，设置了4位
            var codeLength = 4;

            //获取 注册表单中 验证码对象
            var codeV = document.getElementById('code');

            //设置随机字符范围
            var random = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R', 'S','T','U','V','W','X','Y','Z');

            //生成N位随机验证码
            for(var i = 0; i < codeLength; i++){
                //设置随机数范围,这设置为0 ~ 36
                var index = Math.floor(Math.random()*36);
                //字符串拼接 将每次随机的字符 进行拼接
                code += random[index];
            }
            //将拼接好的字符串赋值给表单
            codeV.value = code;
            ///////////////////////////////////////////////////////
            code = '';
            var logincode = document.getElementById('loginCode');
          	//生成N位随机验证码
            for(var i = 0; i < codeLength; i++){
                //设置随机数范围,这设置为0 ~ 36
                var index = Math.floor(Math.random()*36);
                //字符串拼接 将每次随机的字符 进行拼接
                code += random[index];
            }
            //将拼接好的字符串赋值给表单
            logincode.value = code;
            
        }


        //validate() 方法用于判断用户输入的验证码是否正确
        // 输入正确 返回 true
        // 输入错误 返回 false
        function validate(){
            var oValue = document.getElementById('check').value.toUpperCase();

            //如果验证码为空
            if(oValue == 0){
            	alert("请输入验证码");
                //layer.open({
                //    title: '警告信息',
                //    content: '请输入验证码'
                //});
            }else if(oValue != code){
                //如果验证码不正确
                // $("#check").val("");
                alert("验证码错误");
                //layer.open({
                //    title: '警告信息',
                //    content: '您输入的验证码不正确，请重新输入'
                //});
                createCode();
            }else if(checkName() == false){
                //如果输入用户名不符合
                alert("用户名填写错误");
                //layer.open({
                //    title: '警告信息',
                //    content: '您输入的用户名有误，请重新输入'
                //});
            }else if(checkPassword() == false){
            	alert("密码填写错误");
            }
            else if(checkTel() == false){
            	alert("电话号码填写错误");
            }
            else if(checkRealName() == false){
            	alert("请填写真实的姓名");
            }
            else if(checkEmail() == false){
            	alert("邮箱格式错误");
            }
            else{
                //没问题就提交注册信息
                $("#registerform").submit();
            }
        }
        
        //登入表单 验证码核验
        function loginValidate(){
        	
            var lValue = document.getElementById('loginCheck').value.toUpperCase();
            //如果验证码为空
            if(lValue == 0){
            	alert("请输入验证码");
            }
            //else if(lValue != code){
            //    alert("验证码错误");
            //    createCode();
            //}
            else{
                //没问题就提交
                $("#loginform").submit();
            }
        }

        //用于页面加载的时候,生成一个初始验证码
        window.onload = function (){
            createCode();
        }

    </script>

</html>
