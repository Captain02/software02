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

<title>组管理</title>

<jsp:include page="../initCssHref.jsp"></jsp:include>

<script type="text/javascript">
function dele(ele){
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
        
        if(confirm('确定要删除所选组吗？')){
    		var ids = $(ele).attr('data-id');
    		alert(ids);
    		 $.ajax({
    			url:"${APP_PATH}/admin/group/deleteGroup",
    			data:{
    				'ids':ids
    			},
    			type:"POST",
    			success:function(result){
    				if (result.code==100) {
	    				window.location.href='${APP_PATH}/admin/group/groupPage';
					}else{
						alert("该组存在人员");
					}
    			}
    		}) 
    	}
	}
}
	function update(){
		$.ajax({
			url:'${APP_PATH}/admin/group/updateGroup',
			data:$('#updateGroupForm').serialize(),
			type:"POST",
			success:function(result){
				window.location.href='${APP_PATH}/admin/group/groupPage';
			}
		})
	}
	
	function save(){
		$.ajax({
			url:'${APP_PATH}/admin/group/groupSave',
			data:$('#saveGroupForm').serialize(),
			type:"POST",
			success:function(result){
				window.location.href='${APP_PATH}/admin/group/groupPage';
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
								<div class="panel-heading">
									组管理
									
									<div class="pull-right" style="margin-top: 2px;">
										<a href="" data-toggle="modal" data-target="#add-myModal"><i class="glyphicon glyphicon-plus" style="color: #5cb85c;"></i>添加</a>
										<a href="" style="display: inline-block; margin: 0 15px;">|</a>
										<a onclick="dele(this);"><i class="glyphicon glyphicon-minus" style="color: #ac2925"></i>删除</a>
									</div>
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
									  		<th>组ID</th>
									  		<th>组名</th>
									  		<th>操作</th>
									  	</tr>
									  </thead>
									  <tbody>
									  <c:forEach items="${pageInfo.list}" var="group">
										  	<tr>
										  		<td>
										  			<label>
												      <input type="checkbox" name="selectItem">
												    </label>
										  		</td>
										  		<td class="userInfo">${group.id}</td>
										  		<td class="userInfo">${group.name}</td>
										  		<td>
										  			<div class="btn-group">
								                          <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 操作<span class="caret"></span> </button>
								                          <ul class="dropdown-menu">
								                          
								                            <li>
									                            <a href="javascript:;" class="js-editor-user" 
									                            data-userid="${group.id}"
									                            data-groupName="${group.name}"
									                            data-toggle="modal" 
									                            data-target="#editor-myModal"
									                            >修改组
									                            </a>
								                            </li>
								                            
								                          </ul>
								                        </div>
										  		</td>
										  	</tr>
									  </c:forEach>
									  </tbody>
									</table>
								</div>
								
						<!-- 分页  start -->
						<nav aria-label="Page navigation" style="position: fixed; right: 15px; bottom: 30px;">
							  <ul class="pagination pagination-sm">
							    <li>
	                         <a href="${APP_PATH}/admin/group/groupPage?pn=1&name=${name}">首页</a>
	                     </li>
	                     <c:if test="${pageInfo.hasPreviousPage}">
	                         <li>
	                             <a href="${APP_PATH}/admin/group/groupPage?pn=${pageInfo.pageNum-1}&name=${name}" aria-label="Previous">
	                                 <span aria-hidden="true">&laquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
	                     
                        <li class="active">
                            <a href="#">${pageInfo.pageNum}</a>
                        </li>
	
	                     <c:if test="${pageInfo.hasNextPage }">
	                         <li>
	                             <a href="${APP_PATH}/admin/group/groupPage?pn=${pageInfo.pageNum+1}&name=${name}" aria-label="Next">
	                                 <span aria-hidden="true">&raquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
	
	                     <li>
	                         <a href="${APP_PATH}/admin/group/groupPage?pn=${pageInfo.navigatepageNums}&name=${name}" aria-label="Next">
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
				
						
			<!--添加组信息 -->
			<div class="modal" id="add-myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">添加用户信息</h4>
			      </div>
			      <form id="saveGroupForm" method="post">
				      <div class="modal-body">
				      
				       <div class="form-group clearfix">
						    <label for="" class="col-md-2">组ID:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="id" placeholder="输入用户名">
						    </div>
					  	 </div>
					  	 
					  	   <div class="form-group clearfix">
						    <label for="" class="col-md-2">组名:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="name" placeholder="输入密码">
						    </div>
					  	 </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" onclick="save()" class="btn btn-primary js-add">添加</button>
				      </div>
			      </form>
			    </div>
			  </div>
		</div>
			
			<!--修改组-->
			<div class="modal" id="editor-myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">修改组</h4>
			      </div>
			      <form method="post" id="updateGroupForm">
				      <div class="modal-body">
				      
				       <div class="form-group clearfix">
						    <label for="" class="col-md-2">组ID:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="id" placeholder="输入用户名">
						    </div>
					  	 </div>
					  	 
					  	   <div class="form-group clearfix">
						    <label for="" class="col-md-2">组名:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="name" placeholder="输入组名">
						    </div>
					  	 </div>
					  	 
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" onclick="update()" class="btn btn-primary js-editor">保存</button>
				      </div>
			      </form>
			    </div>
			  </div>
		</div>
			
</body>
</html>