package com.java.activiti.controller;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.java.activiti.model.Leave;
import com.java.activiti.model.User;
import com.java.activiti.service.LeaveService;
import com.java.activiti.util.Msg;

/**
 * 业务处理
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/leave")
public class LeaveController {

	@Resource
	private LeaveService leaveService;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;

	/**
	 * 分页查询业务
	 * @param response
	 * @param rows
	 * @param page
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String leavePage(@RequestParam(value="pn",defaultValue="1")Integer pn,
			@RequestParam(value="name",defaultValue="")String name,Model model,
			HttpServletRequest request) throws Exception {
		String userId = (String) request.getSession().getAttribute("userId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		
		PageInfo<Leave> pageInfo = null;
		PageHelper.startPage(pn,8);
		List<Leave> list = leaveService.leavePage(map);
		pageInfo = new PageInfo<>(list,5);
		
		model.addAttribute("pn", pn);
		model.addAttribute("pageInfo", pageInfo);
		
		return "requestTask";
	}

	/**
	 * 添加请假单
	 * 
	 * @param leave
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Msg save(Leave leave,HttpServletRequest request) throws Exception {
		String userId = (String) request.getSession().getAttribute("userId");
		
		User user = new User();
		user.setId(userId);
		leave.setLeaveDate(new Date());
		// 添加用户对象
		leave.setUser(user);
		leave.setState("未提交");
		leaveService.addLeave(leave);
		return Msg.success();
	}

	/**
	 * 提交請假流程申請
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/startApply")
	public Msg startApply(HttpServletResponse response, @RequestParam(value="id") String leaveId) throws Exception {
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("leaveId", leaveId);
		// 启动流程
		ProcessInstance pi = runtimeService.startProcessInstanceByKey("activitiemployeeProcess", variables);
		// 根据流程实例Id查询任务
		Task task = taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
		// 完成 学生填写请假单任务
		taskService.complete(task.getId());
		Leave leave = leaveService.findById(leaveId);
		// 修改状态
		leave.setState("审核中");
		leave.setProcessInstanceId(pi.getProcessInstanceId());
		// 修改请假单状态
		leaveService.updateLeave(leave);
		return Msg.success();
	}

	/**
	 * 查询流程信息
	 * 
	 * @param response
	 * @param taskId
	 *            流程实例ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getLeaveByTaskId")
	public String getLeaveByTaskId(HttpServletResponse response, @RequestParam("taskId")String taskId,Model model) throws Exception {
		// 先根据流程ID查询
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		Leave leave = leaveService.getLeaveByTaskId(task.getProcessInstanceId());
		
		List<Comment> comments = null;
		if (task.getProcessInstanceId() != null) {
			comments = taskService.getProcessInstanceComments(task.getProcessInstanceId());
			Collections.reverse(comments);
		}
		
		model.addAttribute("taskId", taskId);
		model.addAttribute("leave", leave);
		model.addAttribute("comments", comments);
		return "approvalLeave";
	}
}
