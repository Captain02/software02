				<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<!DOCTYPE html>
				<html lang="en">
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				
				<nav id="mainnav-container">
						
						<div id="mainnav">
						
							<div class="mai-info">
								<div class="person-info">
									
									<div class="person-info-list">
										<span class="label label-success pull-right">管理员</span>
										<img class="img-circle img-person img-border" src="${APP_PATH}/static/images/personImg.png" alt="" />
									</div>
									
									<div class="panel-group person-info-group" role="tablist">
									    <div class="panel panel-default">
									      <div class="panel-heading" role="tab" id="personHeading">
									        <h4 class="panel-title">
									          <a class="clearfix" role="button" data-toggle="collapse" href="#person" aria-expanded="true" aria-controls="person">
								            	<p class="person-name">管理员<span class="caret" style="color: #fff;"></span></p>
								            	<span>1318961003@qq.com</span>
									          </a>
									        </h4>
									      </div>
									    </div>
  									</div>
								</div>
								
								<div id="person" class="panel-collapse collapse" role="tabpanel" aria-labelledby="personHeading" aria-expanded="true" style="">
							        <ul class="list-group">
							          <li class="list-group-item"><a href=""><i class="glyphicon glyphicon-user"></i>我的主页</a></li>
							          <li class="list-group-item"><a href=""><i class="glyphicon glyphicon-cog "></i>设置</a></li>
							          <li class="list-group-item"><a href=""><i class="glyphicon glyphicon-info-sign"></i>帮助</a></li>
							          <li class="list-group-item"><a href="${APP_PATH}/admin/user/logout"><i class="glyphicon glyphicon-log-out"></i>退出</a></li>
							        </ul>
								</div>
								
							
							</div>
							
								<div id="menulist">
									<ul class="menulist-item">
										<li><a href=""><i class="glyphicon glyphicon-home"></i>首页</a></li>
										<li class="item-name">
											<a>
												<span class="pull-right"><i class="caret"></i></span>
												<p><i class="glyphicon glyphicon-phone-alt"></i>业务管理</p>
											</a>
											 <ul class="list-group">
									          <li class="list-group-item"><a href="${APP_PATH}/admin/leave/list"><i class="glyphicon glyphicon-calendar"></i>请假申请</a></li>
									          <li class="list-group-item"><a href="${APP_PATH}/admin/task/taskPage"><i class="glyphicon glyphicon-tasks"></i>代办任务管理</a></li>
									          <li class="list-group-item"><a href="${APP_PATH}/admin/task/finishedList"><i class="glyphicon glyphicon-folder-close"></i>已办任务管理</a></li>
							        		</ul>
										</li>
										<li class="item-name">
											<a>
												<span class="pull-right"><i class="caret"></i></span>
												<p><i class="glyphicon glyphicon-retweet"></i>流程管理</p>
											</a>
											 <ul class="list-group">
									          <li class="list-group-item"><a href="${APP_PATH}/admin/deploy/deployPage"><i class="glyphicon glyphicon-cloud-upload"></i>流程部署管理</a></li>
									          <li class="list-group-item"><a href="${APP_PATH}/admin/processDefinition/processDefinitionPage"><i class="glyphicon glyphicon-cloud-download"></i>流程定义管理</a></li>
							        		</ul>
										</li>
										<li class="item-name">
											<a>
												<span class="pull-right"><i class="caret"></i></span>
												<p><i class="glyphicon glyphicon-user"></i>用户管理</p>
											</a>
											 <ul class="list-group">
									          <li class="list-group-item"><a href="${APP_PATH}/admin/user/userPage"><i class="glyphicon glyphicon-eye-open"></i>用户管理</a></li>
									          <li class="list-group-item"><a href="${APP_PATH}/admin/group/groupPage"><i class="glyphicon glyphicon-heart"></i>组管理</a></li>
							        		</ul>
										</li>
									</ul>
									
									
								</div>
								
								
								
				
							
						</div>
						
						
					</nav>	
					
				