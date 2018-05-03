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

<title>测试</title>

<!-- Bootstrap core CSS -->
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">

<!-- User reset CSS -->
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/reset.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/main.css" rel="stylesheet">

<!-- Bootstrap core JS -->
<script src="${APP_PATH}/static/bootstrap-3.3.7/js/jquery.min.js"></script>
<script src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<!-- Project core JS -->
<script src="${APP_PATH}/static/bootstrap-3.3.7/js/activiti.js"></script>

<!-- Page styles for this template -->
<link href="${APP_PATH}/static/bootstrap-3.3.7/css/approval_holiday.css" rel="stylesheet">

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
	<nav class="navbar navbar-default nav-main">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="#">Activiti</a>
	    </div>
	
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <form class="navbar-form navbar-left">
	        <div class="form-group">
	          <input type="text" class="form-control" placeholder="Search">
	        </div>
	        <button type="submit" class="btn btn-default">Submit</button>
	      </form>
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
	
			<div class="wrapper">
						<div class="row">
						<div class="col-md-2 left-slide">
						
					
					<jsp:include page="iniLeftHref.jsp"></jsp:include>
					
				</div>
						<div class="col-md-10">
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
			
			
			
			
</body>
</html>