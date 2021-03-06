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

<title>请假申请</title>

<jsp:include page="initCssHref.jsp"></jsp:include>

<script type="text/javascript">
	function save(){
		$.ajax({
			url:"${APP_PATH}/admin/leave/save",
			data:$("#leaveForm").serialize(),
			type:"post",
			success:function(result){
				window.location.href='${APP_PATH}/admin/leave/list';
			}
		})
	}
	function startApply(ele) {
		var id = $(ele).attr("data-id");
		$.ajax({
			url:"${APP_PATH}/admin/leave/startApply",
			data:{
				"id":id,
			},
			type:"post",
			success:function(result){
				window.location.href='${APP_PATH}/admin/leave/list';
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
				console.log(result);
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
			
			<jsp:include page="iniLeftHref.jsp"></jsp:include>
					
						<div id="content-container">
							<div class="content-title">
								<h3 >工作台</h3>
							</div>
							<div class="content-body">
								<div class="panel panel-default">
					  <div class="panel-heading">请假申请  
						  <a class="pull-right oprate" data-toggle="modal" data-target="#addHolidayNote">
						  	<i class="glyphicon glyphicon-plus"></i>
						  	新增请假单
						  </a>
					  </div>
					  <div class="panel-body">
					   	<table class="table table-striped">
							<thead>
								<tr>
									<th> 
										
									    <label>
									      <input type="checkbox" class="selectAll">
									    </label>
  									</th>
									<th>编号</th>
									<th>请假日期</th>
									<th>请假天数</th>
									<th>请假原因</th>
									<th>审核状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${pageInfo.list}" var="leave">
								<tr>
									<td> <label>
									      <input type="checkbox" class="selectItem">
									    </label></td>
									<td>${leave.id}</td>
									<td>
										<fmt:formatDate value="${leave.leaveDate}" pattern="yyyy-mm-dd hh:dd:ss" />
									</td>
									<td>${leave.leaveDays}</td>
									<td>${leave.leaveReason}</td>
									<td>${leave.state}</td>
									<td>
										<c:if test="${leave.state == '未提交'}">
											<button onclick="startApply(this);" class="btn btn-sm btn-info" data-id="${leave.id}">提交申请</button>
										</c:if>
										<c:if test="${leave.state == '已通过' || leave.state == '未通过'}">
											<button onclick="listComment(this);" class="btn btn-sm btn-info" data-prcessInstanceId="${leave.processInstanceId }" data-toggle="modal" data-target="#showHistoryComment">查看历史批注</button>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					  
					  </div>
					  		 
					  		<nav aria-label="Page navigation" style="position: absolute; right: 15px; bottom: 30px;">
							  <ul class="pagination pagination-sm">
							    <li>
	                         <a href="${APP_PATH}/admin/leave/list?pn=1&id=${id}">首页</a>
	                     </li>
	                     <c:if test="${pageInfo.hasPreviousPage}">
	                         <li>
	                             <a href="${APP_PATH}/admin/leave/list?pn=${pageInfo.pageNum-1}&id=${id}" aria-label="Previous">
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
	                                 <a href="${APP_PATH}/admin/leave/list?pn=${pageNum}&id=${id}">${pageNum}</a>
	                             </li>
	                         </c:if>
	                     </c:forEach>
	
	                     <c:if test="${pageInfo.hasNextPage }">
	                         <li>
	                             <a href="${APP_PATH}/admin/leave/list?pn=${pageInfo.pageNum+1}&id=${id}" aria-label="Next">
	                                 <span aria-hidden="true">&raquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
	
	                     <li>
	                         <a href="${APP_PATH}/admin/leave/list?pn=${pageInfo.pages}&id=${id}" aria-label="Next">
	                             <span aria-hidden="true">末页</span>
	                         </a>
	                     </li>
							  </ul>
							</nav>
					  			</div>
					  		 	
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
			        		<table class="table table-striped table-condensed">
							<thead>
								<tr>
									<th>批注时间</th>
									<th>批注人</th>
									<th>批注信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>1</td>
									<td>1</td>
								</tr>
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
