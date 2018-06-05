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

<title>待办任务管理</title>

<jsp:include page="../initCssHref.jsp"></jsp:include>

<script type="text/javascript">
	function apply(ele) {
		var isAgree = $(ele).attr("data-isAgree");
		var taskId = $(ele).attr("data-taskId");
		var days = $('#days').val();
		var comment = $('#comment').val();
		
		$.ajax({
			url:"${APP_PATH}/admin/task/applyLeave",
			data:{
				'state':isAgree,
				'taskId':taskId,
				'comment':comment,
				'leaveDays':days
			},
			type:"POST",
			success:function(result){
				window.location.href='${APP_PATH}/admin/task/taskPage';
			}
		})
	}
</script>
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
								<h3 >工作台</h3>
							</div>
							<div class="content-body">
									<div class="panel panel-default">
								<div class="panel-heading">项目组长审批</div>
								<div class="panel-body">
									
									
										<div class="form-group">
											<div class="row">
												<div class="col-md-12">
													<label for="" class="col-md-1">请假人:</label>
													<div class="col-md-11">
														<input class="form-control" type="text" name="userName" value="${leave.user.firstName}${leave.user.lastName}" />
													</div>
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-12">
													<label for="" class="col-md-1">请假天数:</label>
													<div class="col-md-11">
														<input id="days" class="form-control" type="text" name="days" value="${leave.leaveDays}" />
													</div>
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-12">
													<label for="" class="col-md-1">请假原因:</label>
													<div class="col-md-11">
														<textarea id="leaveReason" class="form-control">${leave.leaveReason}</textarea>
													</div>
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-12">
													<label for="" class="col-md-1">批注:</label>
													<div class="col-md-11">
														<textarea id="comment" name="comment" rows="" cols="" class="form-control"></textarea>
													</div>
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-12">
													<label for="" class="col-md-1">操作:</label>
													<div class="col-md-11">
														<button onclick="apply(this);" data-taskId="${taskId}" data-isAgree="1" class="btn btn-success btn-sm agree-btn">同意</button>
														<button onclick="apply(this);" data-taskId="${taskId}" data-isAgree="0" class="btn btn-danger btn-sm disagree-btn">驳回</button>
													</div>
												</div>
											</div>
										</div>
								</div>
								
							</div>
							<div class="panel panel-default panel-notation">
								<div class="panel-heading">
									批注列表
								</div>
								<div class="panel-body">
									<table class="table table-bordered">
									  <thead>
									  	<tr>
									  		<th>批注时间</th>
									  		<th>批注人</th>
									  		<th>批注信息</th>
									  	</tr>
									  </thead>
									  <tbody>
									  <c:forEach items="${comments}" var="comment">
										  	<tr>
										  		<td>
													<fmt:formatDate value="${comment.time}" pattern="yyyy-mm-dd hh:dd:ss" />
												</td>
										  		<td>${comment.userId}</td>
										  		<td>${comment.fullMessage}</td>
										  	</tr>
									  </c:forEach>
									  </tbody>
									</table>
								</div>
							</div>
							
							</div>
						</div>
						
						
					
					
					
			</div>
			</div>
							
			
			
			
</body>
</html>