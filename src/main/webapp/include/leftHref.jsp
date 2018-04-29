				<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<!DOCTYPE html>
				<html lang="en">
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				
					<div class="panel-group" id="businessManagement" role="tablist" aria-multiselectable="true">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingOne">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse"
										data-parent="#businessManagement" href="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										业务管理<i class="glyphicon glyphicon-chevron-down pull-right"></i></a>
								</h4>
							</div>
							<div id="collapseOne" class="panel-collapse collapse in"
								role="tabpanel" aria-labelledby="headingOne">
								<div class="panel-body">
									<ul>
										<li><a href="${APP_PATH}/admin/leave/list" ><i class="glyphicon glyphicon-calendar"></i>请假申请</a></li>
										<li><a href="${APP_PATH}/admin/task/taskPage" ><i class="glyphicon glyphicon-tasks"></i>代办任务管理</a></li>
										<li><a href="${APP_PATH}/admin/task/finishedList"><i class="glyphicon glyphicon-folder-close"></i>已办任务管理</a></li>
									</ul>
								</div>
							</div>
						</div>
						
						
					</div>
					
						<div class="panel-group" id="processManagement" role="tablist"
						aria-multiselectable="true">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingTwo">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse"
										data-parent="#processManagement" href="#collapseTwo"
										aria-expanded="true" aria-controls="collapseTwo">
										流程管理<i class="glyphicon glyphicon-chevron-down pull-right"></i></a>
								</h4>
							</div>
							<div id="collapseTwo" class="panel-collapse collapse in"
								role="tabpanel" aria-labelledby="headingTwo">
								<div class="panel-body">
									<ul>
										<li><a href="${APP_PATH}/admin/deploy/deployPage"><i class="glyphicon glyphicon-retweet"></i>流程部署管理</a></li>
										<li><a href="${APP_PATH}/admin/processDefinition/processDefinitionPage"><i class="glyphicon glyphicon-repeat"></i>流程定义管理</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					<div class="panel-group" id="userManagement" role="tablist"
						aria-multiselectable="true">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingThree">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse"
										data-parent="#userManagement" href="#collapseThree"
										aria-expanded="true" aria-controls="collapseThree">
										用户管理<i class="glyphicon glyphicon-chevron-down pull-right"></i></a>
								</h4>
							</div>
							<div id="collapseThree" class="panel-collapse collapse in"
								role="tabpanel" aria-labelledby="headingThree">
								<div class="panel-body">
									<ul>
										<li><a href="${APP_PATH}/admin/user/userPage"><i class="glyphicon glyphicon-user"></i>用户管理</a></li>
										<li><a href=""><i class="glyphicon glyphicon-home"></i>组管理</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="panel-group" id="systemSetting" role="tablist"
						aria-multiselectable="true">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingFour">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse"
										data-parent="#systemSetting" href="#collapseFour"
										aria-expanded="true" aria-controls="collapseFour">
										系统设置<i class="glyphicon glyphicon-chevron-down pull-right"></i></a>
								</h4>
							</div>
							<div id="collapseFour" class="panel-collapse collapse in"
								role="tabpanel" aria-labelledby="headingFour">
								<div class="panel-body">
									<ul>
										<li><a><i class="glyphicon glyphicon-edit"></i>修改密码</a></li>
										<li><a href="${APP_PATH}/admin/user/logout"><i class="glyphicon glyphicon-remove-sign"></i>注销用户</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
				