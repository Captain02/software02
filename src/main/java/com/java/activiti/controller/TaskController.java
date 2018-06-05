package com.java.activiti.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.java.activiti.model.Leave;
import com.java.activiti.model.PageInfo;
import com.java.activiti.service.LeaveService;
import com.java.activiti.util.Msg;

/**
 * 历史流程批注管理
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/task")
public class TaskController {

	// 引入activiti自带的Service接口
	@Resource
	private TaskService taskService;

	@Resource
	private RepositoryService repositoryService;

	@Resource
	private RuntimeService runtimeService;

	@Resource
	private FormService formService;

	@Resource
	private LeaveService leaveService;

	@Resource
	private HistoryService historyService;

	@Autowired
	private IdentityService identityService;

	/**
	 * 查询历史流程批注
	 * 
	 * @param response
	 * @param processInstanceId
	 *            流程ID
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/listHistoryCommentWithProcessInstanceId", method = RequestMethod.GET)
	public Msg listHistoryCommentWithProcessInstanceId(HttpServletResponse response, String processInstanceId)
			throws Exception {
		List<Comment> commentList = null;
		commentList = taskService.getProcessInstanceComments(processInstanceId);
		// 集合元素反转
		Collections.reverse(commentList);
		System.out.println(commentList);
		return Msg.success().add("commens", commentList);
	}

	/**
	 * 待办流程分页查询
	 * 
	 * @param response
	 * @param page
	 *            当前页数
	 * @param rows
	 *            每页显示页数
	 * @param s_name
	 *            流程名称
	 * @param userId
	 *            流程ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskPage", method = RequestMethod.GET)
	public String taskPage(HttpServletRequest request, @RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) throws Exception {
		String userId = (String) request.getSession().getAttribute("userId");
		List<Task> list = null;
		if (pn == 0) {
			pn = 1;
		}
		long count = 0;
		if ("".equals(name)) {
			count = taskService.createTaskQuery().taskCandidateUser(userId).count();
			list = taskService.createTaskQuery().taskCandidateUser(userId).listPage((pn - 1) * 8, 8);

		} else {
			count = taskService.createTaskQuery().taskCandidateUser(userId).taskName(name).count();
			list = taskService.createTaskQuery().taskCandidateUser(userId).taskName(name).listPage((pn - 1) * 8, 8);
		}
		PageInfo<Task> pageInfo = new PageInfo<>(pn);
		;
		pageInfo.setList(list);
		pageInfo.setTotalItemNumber(count);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);
		return "task/agencyTask";
	}

	/**
	 * 查询当前流程图
	 * 
	 * @return
	 */
	@RequestMapping(value = "/showCurrentView", method = RequestMethod.GET)
	public ModelAndView showCurrentView(HttpServletResponse response, @RequestParam(value = "taskId") String taskId) {
		// 视图
		ModelAndView mav = new ModelAndView();

		Task task = taskService.createTaskQuery() // 创建任务查询
				.taskId(taskId) // 根据任务id查询
				.singleResult();
		// 获取流程定义id
		String processDefinitionId = task.getProcessDefinitionId();
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery() // 创建流程定义查询
				// 根据流程定义id查询
				.processDefinitionId(processDefinitionId).singleResult();
		// 部署id
		mav.addObject("deploymentId", processDefinition.getDeploymentId());
		mav.addObject("diagramResourceName", processDefinition.getDiagramResourceName()); // 图片资源文件名称

		ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService
				.getProcessDefinition(processDefinitionId);
		// 获取流程实例id
		String processInstanceId = task.getProcessInstanceId();
		// 根据流程实例id获取流程实例
		ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult();

		// 根据活动id获取活动实例
		ActivityImpl activityImpl = processDefinitionEntity.findActivity(pi.getActivityId());
		// 整理好View视图返回到显示页面
		mav.addObject("x", activityImpl.getX()); // x坐标
		mav.addObject("y", activityImpl.getY()); // y坐标
		mav.addObject("width", activityImpl.getWidth()); // 宽度
		mav.addObject("height", activityImpl.getHeight()); // 高度
		mav.setViewName("task/currentView");
		return mav;
	}

	/**
	 * 查询历史批注
	 * 
	 * @param response
	 * @param taskId
	 *            流程ID
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/listHistoryComment", method = RequestMethod.GET)
	public Msg listHistoryComment(HttpServletResponse response, @RequestParam(value = "taskId") String taskId)
			throws Exception {
		List<Comment> comments = null;
		HistoricTaskInstance taskInstance = historyService.createHistoricTaskInstanceQuery().taskId(taskId)
				.singleResult();
		if (taskInstance != null) {
			comments = taskService.getProcessInstanceComments(taskInstance.getProcessInstanceId());
			Collections.reverse(comments);
		}
		return Msg.success().add("commens", comments);
	}

	/**
	 * 审批
	 * 
	 * @param taskId
	 *            任务id
	 * @param leaveDays
	 *            请假天数
	 * @param comment
	 *            批注信息
	 * @param state
	 *            审核状态 1 通过 2 驳回
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyLeave", method = RequestMethod.POST)
	public Msg applyLeave(@RequestParam("taskId") String taskId, @RequestParam("leaveDays") Integer leaveDays,
			@RequestParam("comment") String comment, Integer state, HttpServletResponse response, HttpSession session)
			throws Exception {
		// 首先根据ID查询任务
		Task task = taskService.createTaskQuery() // 创建任务查询
				.taskId(taskId) // 根据任务id查询
				.singleResult();
		Map<String, Object> variables = new HashMap<String, Object>();

		String groupId = (String) session.getAttribute("groupId");
		String userId = (String) session.getAttribute("userId");
		Group group = identityService.createGroupQuery().groupId(groupId).singleResult();

		if (group.getName().equals("总裁") || group.getName().equals("副总裁")) {
			if (state == 1) {
				String leaveId = (String) taskService.getVariable(taskId, "leaveId");
				Leave leave = leaveService.findById(leaveId);
				leave.setState("已通过");
				// 更新审核信息
				leaveService.updateLeave(leave);
				variables.put("msg", "已通过");
			} else {
				String leaveId = (String) taskService.getVariable(taskId, "leaveId");
				Leave leave = leaveService.findById(leaveId);
				leave.setState("未通过");
				// 更新审核信息
				leaveService.updateLeave(leave);
				variables.put("msg", "未通过");
			}

		}
		if (state == 1) {
			variables.put("msg", "已通过");
		} else {
			String leaveId = (String) taskService.getVariable(taskId, "leaveId");
			Leave leave = leaveService.findById(leaveId);
			leave.setState("审核未通过");
			// 更新审核信息
			leaveService.updateLeave(leave);
			variables.put("msg", "未通过");
		}
		// 设置流程变量
		variables.put("dasy", leaveDays);
		// 获取流程实例id
		String processInstanceId = task.getProcessInstanceId();

		// 设置用户id
		User user = identityService.createUserQuery().userId(userId).singleResult();
		Authentication.setAuthenticatedUserId(user.getFirstName() + user.getLastName() + "[" + group.getName() + "]");
		// 添加批注信息
		taskService.addComment(taskId, processInstanceId, comment);
		// 完成任务
		taskService.complete(taskId, variables);
		return Msg.success();
	}

	/**
	 * 查詢流程正常走完的历史流程表 : act_hi_actinst
	 * 
	 * @param response
	 * @param rows
	 * @param page
	 * @param s_name
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/finishedList",method=RequestMethod.GET)
	public String finishedList(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, HttpServletRequest request, Model model)
			throws Exception {
		String userId = (String) request.getSession().getAttribute("userId");
		String groupId = (String) request.getSession().getAttribute("groupId");
		if (pn == 0) {
			pn = 1;
		}
		long count = 0;
		List<HistoricTaskInstance> list = null;

		if ("".equals(name)) {
			count = historyService.createHistoricTaskInstanceQuery().taskCandidateUser(userId)
					.taskCandidateGroup(groupId).count();
			// 创建流程历史实例查询
			list = historyService.createHistoricTaskInstanceQuery().taskCandidateUser(userId)
					.taskCandidateGroup(groupId).listPage((pn - 1) * 8, 8);
		} else {
			count = historyService.createHistoricTaskInstanceQuery().taskCandidateUser(userId).taskName(name)
					.taskCandidateGroup(groupId).count();
			// 创建流程历史实例查询
			list = historyService.createHistoricTaskInstanceQuery().taskCandidateUser(userId).taskName(name)
					.taskCandidateGroup(groupId).listPage((pn - 1) * 8, 8);
		}

		PageInfo<HistoricTaskInstance> pageInfo = new PageInfo<>(pn);
		pageInfo.setList(list);
		pageInfo.setTotalItemNumber(count);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);

		return "task/finishedTask";
	}

	/**
	 * 根据任务id查询流程实例的具体执行过程
	 * 
	 * @param taskId
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/listAction")
	public Msg listAction(@RequestParam("taskId") String taskId, Model model) throws Exception {
		HistoricTaskInstance hti = historyService.createHistoricTaskInstanceQuery().taskId(taskId).singleResult();
		String processInstanceId = hti.getProcessInstanceId(); // 获取流程实例id

		List<HistoricActivityInstance> list = historyService.createHistoricActivityInstanceQuery()
				.processInstanceId(processInstanceId).list();
		return Msg.success().add("list", list);
	}
}
