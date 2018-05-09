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

<title>流程定义管理</title>

<jsp:include page="../initCssHref.jsp"></jsp:include>

<script type="text/javascript">
function dele(ele){
	var ids = "";
	var pushArray = [];
	var ifHavechecked = $('tbody tr td input[type="checkbox"]:checked');
	if(ifHavechecked.length == 0){
		alert('请至少选择一行');
	}
	
	else{
		for(var i = 0; i<ifHavechecked.length; i++){
			pushArray.push($(ifHavechecked[i]).parent().parent().next().html());
		}
		
		ids = pushArray.join('-');
        $(ele).attr('data-id',ids);
	}
	
	if(confirm('确定要删除所选流程吗？')){
		//ajax
		alert($(ele).attr('data-id'));
	}
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
								<div class="panel-heading">
									流程定义管理
									
								</div>
								<div class="panel-body">
									<table class="table table-bordered table-hover">
									  <thead>
									  	<tr>
									  		<th>
											    <label>
											      <input type="checkbox" id="selectAll">
											    </label>
										    </th>
									  		<th>编号</th>
									  		<th>流程名称</th>
									  		<th>流程定义的key</th>
									  		<th>版本</th>
									  		<th>流程定义的规则文件名称</th>
									  		<th>流程定义的规则图片名称</th>
									  		<th>流程部署id</th>
									  		<th>操作</th>
									  	</tr>
									  </thead>
									  <tbody>
									  <c:forEach items="${pageInfo.list}" var="processDefnition">
										  	<tr>
										  		<td>
											  		<label>
													      <input type="checkbox" name="selectItem">
													</label>
												</td>
										  		<td>${processDefnition.id}</td>
										  		<td>${processDefnition.name}</td>
										  		<td>${processDefnition.key}</td>
										  		<td>${processDefnition.version}</td>
										  		<td>${processDefnition.resourceName}</td>
										  		<td>${processDefnition.diagramResourceName}</td>
										  		<td>${processDefnition.deploymentId}</td>
										  		<td><a href="${APP_PATH}/admin/processDefinition/showView?deploymentId=${processDefnition.deploymentId}&diagramResourceName=${processDefnition.diagramResourceName}" style="color: blue; text-decoration: underline; font-size: 0.8em;">查看图片</a></td>
										  	</tr>
									  </c:forEach>
									  </tbody>
									</table>
								</div>
								
						<!-- 分页  start -->
						<nav aria-label="Page navigation" style="position: fixed; right: 15px; bottom: 30px;">
							  <ul class="pagination pagination-sm">
							    <li>
	                         <a href="${APP_PATH}/admin/processDefinition/processDefinitionPage?pn=1&name=${name}">首页</a>
	                     </li>
	                     <c:if test="${pageInfo.hasPreviousPage}">
	                         <li>
	                             <a href="${APP_PATH}/admin/processDefinition/processDefinitionPage?pn=${pageInfo.pageNum-1}&name=${name}" aria-label="Previous">
	                                 <span aria-hidden="true">&laquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
                        <li class="active">
                            <a href="#">${pageInfo.pageNum}</a>
                        </li>
	
	                     <c:if test="${pageInfo.hasNextPage }">
	                         <li>
	                             <a href="${APP_PATH}/admin/processDefinition/processDefinitionPage?pn=${pageInfo.pageNum+1}&name=${name}" aria-label="Next">
	                                 <span aria-hidden="true">&raquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
	
	                     <li>
	                         <a href="${APP_PATH}/admin/processDefinition/processDefinitionPage?pn=${pageInfo.navigatepageNums}&name=${name}" aria-label="Next">
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