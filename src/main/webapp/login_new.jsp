<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>测试</title>
<%
	request.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- Bootstrap core CSS -->
<script src="${APP_PATH}/static/bootstrap-3.3.7/js/jquery.min.js"></script>
<script src="${APP_PATH}/static/bootstrap-3.3.7/js/script.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/login.css" rel="stylesheet">
<script type="text/javascript">
$(function() {
	$.ajax({
		url:"${APP_PATH}/admin/group/findGroup",
		type:"GET",
		data:"",
		success:function(result){
			addGroup(result);
		}
	})
	
	
})
</script>
</head>

<body>
	
	<!-- background-->
	<div id="login-bg" class="bg-img" style="background-image: url(${APP_PATH}/static/images/login_bg.png)"></div>
	
	<div class="container" style="padding-top: 50px;">
		
		<!-- 登录表单 -->
		<form class="form-signin" action="${APP_PATH}/admin/user/userLogin">
			<h4 class="form-signin-heading text-center">Activiti  样例测试
				<p style="color: #afb9c3; font-size: 0.8em">使用账户名和密码进行登录</p>
			</h4>
			<label for="inputUserName" class="sr-only">用户名</label> 
			<input name="userName" type="text" class="form-control" placeholder="用户名" required autofocus> 
			<label for="inputPassword" class="sr-only">密码</label> 
			<input name="password" type="password" id="inputPassword" class="form-control" placeholder="密码" required>
			<select name="groupId" id="js-group" class="form-control" required></select>
			<div class="checkbox"></div>
			<button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
		</form>

	</div>
	<!-- /container -->

</body>
</html>
