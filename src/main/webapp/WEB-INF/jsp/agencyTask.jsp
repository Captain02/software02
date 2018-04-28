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
<script type="text/javascript">
	function save(){
		$.ajax({
			url:"${APP_PATH}/admin/leave/save",
			data:$("#leaveForm").serialize(),
			type:"post",
			success:function(result){
				console.log(result);
			}
		})
	}
	function redirectPage(ele) {
		var taskId = $(ele).attr("data-taskId");
		window.location.href='${APP_PATH}/admin/leave/getLeaveByTaskId?taskId='+taskId;
	}
	function showView(ele) {
		var taskId = $(ele).attr("data-taskId");
		window.location.href='${APP_PATH}/admin/task/showCurrentView?taskId='+taskId;
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
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
			<div class="wrapper">
						<div class="row">
						<div class="col-md-2 left-slide">
						
					<jsp:include page="iniLeftHref.jsp"></jsp:include>
					
					
				</div>
				<div class="col-md-10">
					<div class="panel panel-default">
					  <div class="panel-heading">代办任务管理</div>
					  <div class="panel-body">
					   	<table class="table table-striped">
							<thead>
								<tr>
									<th> 
										
									    <label>
									      <input type="checkbox" class="selectAll">
									    </label>
  									</th>
									<th>任务ID</th>
									<th>任务名称</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${pageInfo.list}" var="task">
								<tr>
									<td> <label>
									      <input type="checkbox" class="selectItem">
									    </label></td>
									<td>${task.id}</td>
									<td>${task.name}</td>
									<td>
										<fmt:formatDate value="${task.createTime}" pattern="yyyy-mm-dd hh:dd:ss" />
									</td>
									<td>
										<button onclick="redirectPage(this);" class="btn btn-sm btn-info" data-taskId="${task.id}">办理任务</button>
										<button onclick="showView(this);" class="btn btn-sm btn-info" data-taskId="${task.id}">查看当前流程图</button>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					  
					  
					  
					  </div>
					  
						<!-- 分页 start -->
						<nav aria-label="Page navigation" style="position: fixed; right: 15px; bottom: 30px;">
						  <ul class="pagination ">
						    <li>
                         <a href="${APP_PATH}/admin/task/taskPage?pn=1">首页</a>
                     </li>
                     <c:if test="${pageInfo.hasPreviousPage}">
                         <li>
                             <a href="${APP_PATH}/admin/task/taskPage?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                 <span aria-hidden="true">&laquo;</span>
                             </a>
                         </li>
                     </c:if>
                     
                     <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                         <c:if test="${pageNum==pageInfo.pageNum}">
                             <li class="active">
                                 <a href="#">${pageNum}</a>
                             </li>
                         </c:if>
                         <c:if test="${pageNum!=pageInfo.pageNum}">
                             <li>
                                 <a href="${APP_PATH}/admin/task/taskPage?pn=${pageNum}">${pageNum}</a>
                             </li>
                         </c:if>
                     </c:forEach>

                     <c:if test="${pageInfo.hasNextPage }">
                         <li>
                             <a href="${APP_PATH}/admin/task/taskPage?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                 <span aria-hidden="true">&raquo;</span>
                             </a>
                         </li>
                     </c:if>

                     <li>
                         <a href="${APP_PATH}/admin/task/taskPage?pn=${pageInfo.pages}" aria-label="Next">
                             <span aria-hidden="true">末页</span>
                         </a>
                     </li>
						  </ul>
						</nav>
						<!-- 分页 end -->
					
					</div>
					
					
					
					
				</div>
					</div>
			
					</div>
			
			
</body>
</html>
