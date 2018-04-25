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
					
					<div class="panel-group" id="systemSetting" role="tablist"
						aria-multiselectable="true">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingTwo">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse"
										data-parent="#systemSetting" href="#collapseTwo"
										aria-expanded="true" aria-controls="collapseOne">
										系统设置<i class="glyphicon glyphicon-chevron-down pull-right"></i></a>
								</h4>
							</div>
							<div id="collapseTwo" class="panel-collapse collapse"
								role="tabpanel" aria-labelledby="headingTwo">
								<div class="panel-body">
									<ul>
										<li><a><i class="glyphicon glyphicon-edit"></i>修改密码</a></li>
									</ul>
								</div>
							</div>
						</div>
						
						
					</div>