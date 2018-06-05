<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>模型管理</title>

<jsp:include page="../initCssHref.jsp"></jsp:include>

</head>

<body>
			<div id="container">
			
			
				<header class="clearfix">

				<nav id="navbar" class="navbar-default nav-main navbar-inverse">
					    <div class="navbar-header">
					      <a class="navbar-brand" href="#">
					      	<i class="glyphicon glyphicon-th-large" style="margin-right: 5px;"></i>
					      	Activiti
					      </a>
					    </div>
						<div class="navbar-content clearfix">
						    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						      <ul class="nav navbar-nav navbar-left pull-left navbar-links">
						      	<li class="tgl-menyu-btn">
						      		<a href="">
						      			<i class="glyphicon glyphicon-th-list"></i>
						      		</a>
						      	</li>
						      	<li class="btn-message">
						      		<a href="">
						      			<i class="glyphicon glyphicon-bell"></i>
						      		</a>
						      	</li>
						      	<li class="btn-task">
						      		<a href="">
						      			<i class="glyphicon glyphicon-tasks"></i>
						      		</a>
						      	</li>
						      </ul>
						      
						      <ul class="nav navbar-nav navbar-right">
						        <li><a href="#">Link</a></li>
						        <li class="dropdown">
						          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
						          <ul class="dropdown-menu">
						            <li><a href="#">Action</a></li>
						            <li><a href="#">Another action</a></li>
						            <li><a href="#">Something else here</a></li>
						            <li role="separator" class="divider"></li>
						            <li><a href="#">Separated link</a></li>
						          </ul>
						        </li>
						      </ul>
						    
						    </div>
					  </div>
				</nav>
				
			</header>




	
			<div class="wrapper">
			
			<jsp:include page="../iniLeftHref.jsp"></jsp:include>
					
						<div id="content-container">
							<div class="content-title">
								<h3 >模型管理</h3>
							</div>
							<div class="content-body">
								<div class="panel panel-default">
					  <div class="panel-heading">
					  	添加新模型
					  </div>
					  <div class="panel-body">
					  	<form action="${APP_PATH}/admin/model/create" method="post">
						  <div class="form-group">
						    <label for="modelName">模型名称</label>
						    <input type="text" class="form-control" name="modelName" placeholder="请输入模型名称">
						  </div>
						  <div class="form-group">
						    <label for="modelId">模型唯一标识</label>
						    <input type="text" class="form-control" name="modelKey" placeholder="请输入模型唯一标识">
						  </div>
						  <div class="form-group">
						    <label for="modelId">描述</label>
						    <input type="text" class="form-control" name="modelDescription" placeholder="请输入模型唯一标识">
						  </div>
						  
						  <button type="reset" class="btn btn-default btn-warning">重置</button>
						  <button type="submit" class="btn btn-default btn-success">保存</button>
						</form>
					  </div>
					  
					
					</div>
					
					
							</div>
						</div>
						
						
					
					
					
			</div>
			</div>
				
			
			
</body>
</html>
