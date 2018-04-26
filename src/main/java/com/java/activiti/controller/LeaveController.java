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
 * ҵ����
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
	 * ��ҳ��ѯҵ��
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
	 * �����ٵ�
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
		// ����û�����
		leave.setUser(user);
		leave.setState("δ�ύ");
		leaveService.addLeave(leave);
		return Msg.success();
	}

	/**
	 * �ύՈ��������Ո
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/startApply")
	public Msg startApply(HttpServletResponse response, @RequestParam(value="id") String leaveId) throws Exception {
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("leaveId", leaveId);
		// ��������
		ProcessInstance pi = runtimeService.startProcessInstanceByKey("activitiemployeeProcess", variables);
		// ��������ʵ��Id��ѯ����
		Task task = taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
		// ��� ѧ����д��ٵ�����
		taskService.complete(task.getId());
		Leave leave = leaveService.findById(leaveId);
		// �޸�״̬
		leave.setState("�����");
		leave.setProcessInstanceId(pi.getProcessInstanceId());
		// �޸���ٵ�״̬
		leaveService.updateLeave(leave);
		return Msg.success();
	}

	/**
	 * ��ѯ������Ϣ
	 * 
	 * @param response
	 * @param taskId
	 *            ����ʵ��ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getLeaveByTaskId")
	public String getLeaveByTaskId(HttpServletResponse response, @RequestParam("taskId")String taskId,Model model) throws Exception {
		// �ȸ�������ID��ѯ
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
