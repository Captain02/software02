<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
								<div class="panel-heading">
									部署管理
									<form action="" method="post" style="display: inline-block; margin-left: 15px;">
										<div class="form-group" style=" margin-bottom: 0;">
											<input type="text" name="name"/>
											<input type="submit" value="搜索" />
										</div>
									</form>
									
									<div class="pull-right" style="margin-top: 2px;">
										<a href="" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-plus" style="color: #5cb85c;"></i>添加</a>
										<a href="" style="display: inline-block; margin: 0 15px;">|</a>
										<a href=""><i class="glyphicon glyphicon-minus" style="color: #ac2925"></i>删除</a>
									</div>
								</div>
								<div class="panel-body">
									<table class="table table-bordered table-hover">
									  <thead>
									  	<tr>
									  		<th>
											    <label>
											      <input type="checkbox">
											    </label>
										    </th>
									  		<th>编号</th>
									  		<th>流程名称</th>
									  		<th>部署时间</th>
									  	</tr>
									  </thead>
									  <tbody>
									  	<tr>
									  		<td>
									  			<label>
											      <input type="checkbox">
											    </label>
									  		</td>
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
			
			
			<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">添加流程部署</h4>
			      </div>
			      <div class="modal-body">
			       <div class="form-group">
				    <input type="file" id="exampleInputFile">
				    <p class="help-block"></p>
				  </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" class="btn btn-primary">上传</button>
			      </div>
			    </div>
			  </div>
		</div>
			
</body>
</html>