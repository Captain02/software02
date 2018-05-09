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

<title>已办任务管理</title>

<jsp:include page="../initCssHref.jsp"></jsp:include>
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
				addProcess(result);
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
			type:"GET",
			success:function(result){
				addComment(result);
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
											<button onclick="executionProcess(this);" class="btn btn-sm btn-info" data-taskId="${historicTaskInstance.id }" data-toggle="modal" data-target="#showProcess">流程执行过程</button>
											<button onclick="listComment(this);" class="btn btn-sm btn-info" data-prcessInstanceId="${historicTaskInstance.processInstanceId }" data-toggle="modal" data-target="#showHistoryComment">历史批注</button>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					  
					  </div>
					  
					   <nav aria-label="Page navigation" style="position: fixed; right: 15px; bottom: 30px;">
							  <ul class="pagination pagination-sm">
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
			</div>
			
			
			
			
			<!-- 查看流程执行过程 -->
			<div class="modal" id="showProcess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">流程执行过程</h4>
			      </div>
					
			      <div class="modal-body">
			      	
			      	<table class="table table-striped table-condensed" id="js-showProcess">
							<thead>
								<tr>
									<th>节点ID</th>
									<th>节点名称</th>
									<th>开始时间</th>
									<th>结束时间</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
			      	
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">确定</button>
			      </div>
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
			
</body>
</html>
