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
<script src="${APP_PATH}/static/bootstrap-3.3.7/js/script.js"></script>

<!-- Project core JS -->
<script src="${APP_PATH}/static/bootstrap-3.3.7/js/activiti.js"></script>
<script type="text/javascript">
	function executionProcess(ele){
		var taskId = $(ele).attr("data-taskId");
		$.ajax({
			url:"${APP_PATH}/admin/task/listAction",
			data:{
				'taskId':taskId
			},
			type:"GET",
			success:function(result){
				console.log(result);
			}
		})
	}
	
	function listComment(ele) {
		var processInstanceId = $(ele).attr("data-prcessInstanceId");
		$.ajax({
			url:"${APP_PATH}/admin/task/listHistoryCommentWithProcessInstanceId",
			data:{
				"processInstanceId":processInstanceId
			},
			type:"get",
			success:function(result){
				addComment(result);
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
	      <form action="${APP_PATH}/admin/task/finishedList" class="navbar-form navbar-left">
	        <div class="form-group">
	          <input name="name" value="${name}" type="text" class="form-control" placeholder="任务名称">
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
					  <div class="panel-heading">已办任务管理
					  </div>
					  <div class="panel-body">
					   	<table class="table table-striped">
							<thead>
								<tr>
									<th> 
										
									    <label>
									      <input type="checkbox" id="selectAll">
									    </label>
  									</th>
									<th>任务ID</th>
									<th>任务名称</th>
									<th>创建时间</th>
									<th>结束时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${pageInfo.list}" var="historicTaskInstance">
								<tr>
									<td> <label>
									      <input type="checkbox" name="selectItem">
									    </label></td>
									<td>${historicTaskInstance.id}</td>
									<td>${historicTaskInstance.name}</td>
									<td>
										<fmt:formatDate value="${historicTaskInstance.startTime}" pattern="yyyy-mm-dd hh:dd:ss" />
									</td>
																		<td>
										<fmt:formatDate value="${historicTaskInstance.endTime}" pattern="yyyy-mm-dd hh:dd:ss" />
									</td>
									<td>
											<button onclick="executionProcess(this);" class="btn btn-sm btn-info" data-taskId="${historicTaskInstance.id }" data-toggle="modal" data-target="#showHistoryComment">流程执行过程</button>
											<button onclick="listComment(this);" class="btn btn-sm btn-info" data-prcessInstanceId="${historicTaskInstance.processInstanceId }" data-toggle="modal" data-target="#showHistoryComment">历史批注</button>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					  
					  </div>
					  <nav aria-label="Page navigation" style="position: fixed; right: 15px; bottom: 30px;">
							  <ul class="pagination ">
							    <li>
	                         <a href="${APP_PATH}/admin/task/finishedList?pn=1&name=${name}">首页</a>
	                     </li>
	                     <c:if test="${pageInfo.hasPreviousPage}">
	                         <li>
	                             <a href="${APP_PATH}/admin/task/finishedList?pn=${pageInfo.pageNum-1}&name=${name}" aria-label="Previous">
	                                 <span aria-hidden="true">&laquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
                        <li class="active">
                            <a href="#">${pageInfo.pageNum}</a>
                        </li>
	
	                     <c:if test="${pageInfo.hasNextPage }">
	                         <li>
	                             <a href="${APP_PATH}/admin/task/finishedList?pn=${pageInfo.pageNum+1}&name=${name}" aria-label="Next">
	                                 <span aria-hidden="true">&raquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
	
	                     <li>
	                         <a href="${APP_PATH}/admin/task/finishedList?pn=${pageInfo.navigatepageNums}&name=${name}" aria-label="Next">
	                             <span aria-hidden="true">末页</span>
	                         </a>
	                     </li>
							  </ul>
							</nav>
					</div>

				</div>
					</div>
			
					</div>
			
			
			
			<!-- 新建请假单 -->
			<div class="modal" id="addHolidayNote" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">新建请假单</h4>
			      </div>
					<form id="leaveForm" action="${APP_PATH}/admin/leave/save" method="post">
			      <div class="modal-body">
					  <div class="form-group clearfix">
					    <label class="col-md-2" for="day">请假天数</label>
					    <div class="col-md-10">
					    	<input type="number" class="form-control" id="day" name="leaveDays" placeholder="请假天数">
					    </div>
					  </div>
					  <div class="form-group clearfix">
					    <label class="col-md-2" for="reason">请假原因</label>
					    <div class="col-md-10">
					    	<textarea class="form-control" id="reason" name="leaveReason"></textarea>
					    </div>
					  </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">取消</button>
			        <button type="button" onclick="save()" class="btn btn-info btn-sm">提交</button>
			      </div>
					</form>
			    </div>
			  </div>
			</div>
			
			<!-- 查看历史批注 -->
			<div class="modal" id="showHistoryComment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">查看历史批注</h4>
			      </div>
			      <div class="modal-body">
			        <div class="panel panel-default">
			        	<div class="panel-heading" role="tab" id="headingTwo">
			        		<h4 class="panel-title">批注列表</h4>
			        	</div>
			        	
			        	<div class="panel-body">
			        		<table class="table table-striped table-condensed" id="js-historyComment">
							<thead>
								<tr>
									<th>批注时间</th>
									<th>批注人</th>
									<th>批注信息</th>
								</tr>
							</thead>
							<tbody>
								
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
