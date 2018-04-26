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
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/login.css" rel="stylesheet">

</head>

<body>

	<div class="container">
		<form class="form-signin" action="${APP_PATH}/admin/user/userLogin">
			<h3 class="form-signin-heading text-center">样例测试</h3>
			<label for="inputUserName" class="sr-only">用户名</label> 
			<input name="userName" type="text" class="form-control" placeholder="用户名" required autofocus> 
			<label for="inputPassword" class="sr-only">密码</label> 
			<input name="password" type="password" id="inputPassword" class="form-control" placeholder="密码" required>
			<select name="groupId" id="inputPassword" class="form-control" required>
				<option value="emp">员工</option>
				<option value="zuz">组长</option>
				<option value="zc">总裁</option>
				<option value="jl">经理</option>
			</select>
			<div class="checkbox">
			</div>
			<button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
		</form>

	</div>
	<!-- /container -->

</body>
</html>
