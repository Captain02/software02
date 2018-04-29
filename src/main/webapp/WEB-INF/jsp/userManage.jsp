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
        
        if(confirm('确定要删除所选用户吗？')){
    		var ids = $(ele).attr('data-id');
    		alert(ids);
    		 $.ajax({
    			url:"${APP_PATH}/admin/user/deleteUser",
    			data:{
    				'ids':ids
    			},
    			type:"POST",
    			success:function(result){
    				window.location.href='${APP_PATH}/admin/user/userPage';
    			}
    		}) 
    	}
	}
}
	function update(){
		$.ajax({
			url:'${APP_PATH}/admin/user/updateUser',
			data:$('#updateUserForm').serialize(),
			type:"POST",
			success:function(result){
				window.location.href='${APP_PATH}/admin/user/userPage';
			}
		})
	}
	
	function save(){
		alert($('#saveUserForm').serialize());
		$.ajax({
			url:'${APP_PATH}/admin/user/userSave',
			data:$('#saveUserForm').serialize(),
			type:"POST",
			success:function(result){
				window.location.href='${APP_PATH}/admin/user/userPage';
			}
		})
	}
	
	function findGroupByUserId(ele) {
		var userId = $(ele).attr('data-userId');
		$.ajax({
			url:'${APP_PATH}/admin/user/listWithGroups',
			data:{
				'userId':userId
			},
			type:"GET",
			success:function(result){
				matchingGroup(result);
			}
		})
	}
	
	function updateGroup(){
		var groupId = []; 
		var joinId = '';
		
		$('#group-myModal input.groupid').each(function(){
			if($(this).attr('checked')){
				groupId.push($(this).val());
			}
		})
		
		joinId = groupId.join('-');
		
		alert(joinId);
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
								<div class="panel-heading">
									用户管理
									<form action="" method="post" style="display: inline-block; margin-left: 15px;">
										<div class="form-group" style=" margin-bottom: 0;">
											<input type="text" name="name"/>
											<input type="submit" value="搜索" />
										</div>
									</form>
									
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
									  		<th>用户名</th>
									  		<th>密码</th>
									  		<th>姓名</th>
									  		<th>邮箱</th>
									  		<th>操作</th>
									  	</tr>
									  </thead>
									  <tbody>
									  <c:forEach items="${pageInfo.list}" var="user">
										  	<tr>
										  		<td>
										  			<label>
												      <input type="checkbox" name="selectItem">
												    </label>
										  		</td>
										  		<td class="userInfo">${user.id}</td>
										  		<td class="userInfo">${user.password}</td>
										  		<td class="userInfo">${user.firstName}${user.lastName}</td>
										  		<td class="userInfo">${user.email}</td>
										  		<td>
										  			<div class="btn-group">
								                          <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 操作<span class="caret"></span> </button>
								                          <ul class="dropdown-menu">
								                          
								                            <li>
									                            <a href="javascript:;" class="js-editor-user" 
									                            data-userid="${user.id}"
									                            data-userpassword="${user.password}"
									                            data-lastname="${user.firstName}"
									                            data-firstname="${user.lastName}"
									                            data-email="${user.email}"
									                            data-toggle="modal" 
									                            data-target="#editor-myModal"
									                            >修改用户
									                            </a>
								                            </li>
								                            
								                            <li role="separator" class="divider"></li>
								                            
								                            <li><a onclick="findGroupByUserId(this);" class="js-editor-group" 
								                            data-userId="${user.id}"
								                            data-toggle="modal" 
									                        data-target="#group-myModal"
								                            >修改组</a></li>
								                            
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
							  <ul class="pagination ">
							    <li>
	                         <a href="${APP_PATH}/admin/user/userPage?pn=1">首页</a>
	                     </li>
	                     <c:if test="${pageInfo.hasPreviousPage}">
	                         <li>
	                             <a href="${APP_PATH}/admin/user/userPage?pn=${pageInfo.pageNum-1}" aria-label="Previous">
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
	                                 <a href="${APP_PATH}/admin/user/userPage?pn=${pageNum}">${pageNum}</a>
	                             </li>
	                         </c:if>
	                     </c:forEach>
	
	                     <c:if test="${pageInfo.hasNextPage }">
	                         <li>
	                             <a href="${APP_PATH}/admin/user/userPage?pn=${pageInfo.pageNum+1}" aria-label="Next">
	                                 <span aria-hidden="true">&raquo;</span>
	                             </a>
	                         </li>
	                     </c:if>
	
	                     <li>
	                         <a href="${APP_PATH}/admin/user/userPage?pn=${pageInfo.pages}" aria-label="Next">
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
			
			<!--添加用户信息 -->
			<div class="modal" id="add-myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">添加用户信息</h4>
			      </div>
			      <form id="saveUserForm" method="post">
				      <div class="modal-body">
				      
				       <div class="form-group clearfix">
						    <label for="" class="col-md-2">用户名:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="id" placeholder="输入用户名">
						    </div>
					  	 </div>
					  	 
					  	   <div class="form-group clearfix">
						    <label for="" class="col-md-2">密码:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="password" placeholder="输入密码">
						    </div>
					  	 </div>
					  	 
					  	 
					  	 <div class="form-group clearfix">
						    <label for="" class="col-md-2">姓:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="firstName" placeholder="输入姓氏">
						    </div>
					  	 </div>
					  	 
					  	 <div class="form-group clearfix">
						    <label for="" class="col-md-2">名:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="lastName" placeholder="输入名字">
						    </div>
					  	 </div>
					  	 
					  	 <div class="form-group clearfix">
						    <label for="" class="col-md-2">邮箱:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="email" placeholder="输入邮箱">
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
			
			<!--修改用户-->
			<div class="modal" id="editor-myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
			      </div>
			      <form method="post" id="updateUserForm">
				      <div class="modal-body">
				      
				       <div class="form-group clearfix">
						    <label for="" class="col-md-2">用户名:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="id" placeholder="输入用户名">
						    </div>
					  	 </div>
					  	 
					  	   <div class="form-group clearfix">
						    <label for="" class="col-md-2">密码:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="password" placeholder="输入密码">
						    </div>
					  	 </div>
					  	 
					  	 
					  	  <div class="form-group clearfix">
						    <label for="" class="col-md-2">姓:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="firstName" placeholder="输入姓氏">
						    </div>
					  	 </div>
					  	 
					  	 <div class="form-group clearfix">
						    <label for="" class="col-md-2">名:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="lastName" placeholder="输入名字">
						    </div>
					  	 </div>
					  	 					  	 
					  	 <div class="form-group clearfix">
						    <label for="" class="col-md-2">邮箱:</label>
						    <div class="col-md-10">
						    	<input class="form-control" type="text" name="email" placeholder="输入邮箱">
						    </div>
					  	 </div>
					  	 
					  	  <!-- <div class="form-group clearfix">
						    <label for="" class="col-md-2">组ID:</label>
						    <div class="col-md-10">
						    	<select class="form-control" name="group">
						    		
						    	</select>
						    </div>
					  	 </div> -->
					  	 
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" onclick="update()" class="btn btn-primary js-editor">保存</button>
				      </div>
			      </form>
			    </div>
			  </div>
		</div>
			
			<!-- 修改组 -->
			<div class="modal" id="group-myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
			      </div>
			      <form action="${APP_PATH}/admin/user/userSave" method="post" id="userForm">
				      <div class="modal-body">
				      
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" onclick="updateGroup()" class="btn btn-primary js-editor">保存</button>
				      </div>
			      </form>
			    </div>
			  </div>
		</div>
			
			
			
</body>
</html>