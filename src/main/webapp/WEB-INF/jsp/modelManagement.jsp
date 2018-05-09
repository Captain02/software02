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

<jsp:include page="initCssHref.jsp"></jsp:include>
<script type="text/javascript">
	function updateModel(ele){
		var id = $(ele).attr('data-modelId');
		window.location.href='${APP_PATH}/process-editor/modeler.html?modelId=' + id;
	}
	function save(){
		window.location.href='${APP_PATH}/admin/model/save';
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
								<h3 >模型管理</h3>
							</div>
							<div class="content-body">
								<div class="panel panel-default">
					  <div class="panel-heading">
					  	<button class="btn btn-info" onclick="save()">
					  		<i class="glyphicon glyphicon-plus" style="margin-right: 5px;"></i>
					  		添加
					  	</button>
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
									<th>模型标识</th>
									<th>模型名称</th>
									<th>模型版本</th>
									<th>创建时间</th>
									<th>最后更新日期</th>
									<th>操作 </th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${pageInfo.list}" var="model">
								<tr>
									<td> 
										<label>
									      <input type="checkbox" class="selectItem">
									    </label>
									</td>
									<td>${model.key}</td>
									<td>${model.name}</td>
									<td>${model.version}</td>
									<td>
										<fmt:formatDate value="${model.createTime}" pattern="yyyy-mm-dd hh:dd:ss" />
									</td>
									<td>
										<fmt:formatDate value="${model.lastUpdateTime}" pattern="yyyy-mm-dd hh:dd:ss" />
									</td>
									<td>
										<button onclick="updateModel(this);" class="btn btn-sm btn-success" data-modelId="${model.id }">编辑</button>
										<button onclick="showView(this);" class="btn btn-sm btn-success" data-taskId="">部署</button>
										<button onclick="showView(this);" class="btn btn-sm btn-danger" data-taskId="">删除</button>
									</td>
								</tr>
							</c:forEach>
							
							</tbody>
						</table>
					  
					  
					  
					  </div>
					  
						<!-- 分页 start -->
							<nav aria-label="Page navigation" style="position: fixed; right: 15px; bottom: 30px;">
							  <ul class="pagination pagination-sm">
							    <li>
	                         <a href="${APP_PATH}/admin/model/getModel?pn=1">首页</a>
	                     </li>
	                     <c:if test="${pageInfo.hasPreviousPage}">
	                         <li>
	                             <a href="${APP_PATH}/admin/model/getModel?pn=${pageInfo.pageNum-1}" aria-label="Previous">
	                                 <span aria-hidden="true">&laquo;</span>	
	                             </a>
	                         </li>
	                     </c:if>
                        <li class="active">
                            <a href="#">${pageInfo.pageNum}</a>
                        </li>
	
	                     <c:if test="${pageInfo.hasNextPage }">
	                         <li>
	                             <a href="${APP_PATH}/admin/model/getModel?pn=${pageInfo.pageNum+1}" aria-label="Next">
	                                 <span aria-hidden="true">&raquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
	
	                     <li>
	                         <a href="${APP_PATH}/admin/model/getModel?pn=${pageInfo.navigatepageNums}" aria-label="Next">
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
			</div>
				
			
			
</body>
</html>
