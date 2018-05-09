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
 * ��ʷ������ע����
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/task")
public class TaskController {

	// ����activiti�Դ���Service�ӿ�
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
	 * ��ѯ��ʷ������ע
	 * 
	 * @param response
	 * @param processInstanceId
	 *            ����ID
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/listHistoryCommentWithProcessInstanceId", method = RequestMethod.GET)
	public Msg listHistoryCommentWithProcessInstanceId(HttpServletResponse response, String processInstanceId)
			throws Exception {
		List<Comment> commentList = null;
		commentList = taskService.getProcessInstanceComments(processInstanceId);
		// ����Ԫ�ط�ת
		Collections.reverse(commentList);
		System.out.println(commentList);
		return Msg.success().add("commens", commentList);
	}

	/**
	 * �������̷�ҳ��ѯ
	 * 
	 * @param response
	 * @param page
	 *            ��ǰҳ��
	 * @param rows
	 *            ÿҳ��ʾҳ��
	 * @param s_name
	 *            ��������
	 * @param userId
	 *            ����ID
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
	 * ��ѯ��ǰ����ͼ
	 * 
	 * @return
	 */
	@RequestMapping(value = "/showCurrentView", method = RequestMethod.GET)
	public ModelAndView showCurrentView(HttpServletResponse response, @RequestParam(value = "taskId") String taskId) {
		// ��ͼ
		ModelAndView mav = new ModelAndView();

		Task task = taskService.createTaskQuery() // ���������ѯ
				.taskId(taskId) // ��������id��ѯ
				.singleResult();
		// ��ȡ���̶���id
		String processDefinitionId = task.getProcessDefinitionId();
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery() // �������̶����ѯ
				// �������̶���id��ѯ
				.processDefinitionId(processDefinitionId).singleResult();
		// ����id
		mav.addObject("deploymentId", processDefinition.getDeploymentId());
		mav.addObject("diagramResourceName", processDefinition.getDiagramResourceName()); // ͼƬ��Դ�ļ�����

		ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService
				.getProcessDefinition(processDefinitionId);
		// ��ȡ����ʵ��id
		String processInstanceId = task.getProcessInstanceId();
		// ��������ʵ��id��ȡ����ʵ��
		ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult();

		// ���ݻid��ȡ�ʵ��
		ActivityImpl activityImpl = processDefinitionEntity.findActivity(pi.getActivityId());
		// �����View��ͼ���ص���ʾҳ��
		mav.addObject("x", activityImpl.getX()); // x����
		mav.addObject("y", activityImpl.getY()); // y����
		mav.addObject("width", activityImpl.getWidth()); // ���
		mav.addObject("height", activityImpl.getHeight()); // �߶�
		mav.setViewName("task/currentView");
		return mav;
	}

	/**
	 * ��ѯ��ʷ��ע
	 * 
	 * @param response
	 * @param taskId
	 *            ����ID
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
	 * ����
	 * 
	 * @param taskId
	 *            ����id
	 * @param leaveDays
	 *            �������
	 * @param comment
	 *            ��ע��Ϣ
	 * @param state
	 *            ���״̬ 1 ͨ�� 2 ����
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
		// ���ȸ���ID��ѯ����
		Task task = taskService.createTaskQuery() // ���������ѯ
				.taskId(taskId) // ��������id��ѯ
				.singleResult();
		Map<String, Object> variables = new HashMap<String, Object>();

		String groupId = (String) session.getAttribute("groupId");
		String userId = (String) session.getAttribute("userId");
		Group group = identityService.createGroupQuery().groupId(groupId).singleResult();

		if (group.getName().equals("�ܲ�") || group.getName().equals("���ܲ�")) {
			if (state == 1) {
				String leaveId = (String) taskService.getVariable(taskId, "leaveId");
				Leave leave = leaveService.findById(leaveId);
				leave.setState("��ͨ��");
				// ���������Ϣ
				leaveService.updateLeave(leave);
				variables.put("msg", "��ͨ��");
			} else {
				String leaveId = (String) taskService.getVariable(taskId, "leaveId");
				Leave leave = leaveService.findById(leaveId);
				leave.setState("δͨ��");
				// ���������Ϣ
				leaveService.updateLeave(leave);
				variables.put("msg", "δͨ��");
			}

		}
		if (state == 1) {
			variables.put("msg", "��ͨ��");
		} else {
			String leaveId = (String) taskService.getVariable(taskId, "leaveId");
			Leave leave = leaveService.findById(leaveId);
			leave.setState("���δͨ��");
			// ���������Ϣ
			leaveService.updateLeave(leave);
			variables.put("msg", "δͨ��");
		}
		// �������̱���
		variables.put("dasy", leaveDays);
		// ��ȡ����ʵ��id
		String processInstanceId = task.getProcessInstanceId();

		// �����û�id
		User user = identityService.createUserQuery().userId(userId).singleResult();
		Authentication.setAuthenticatedUserId(user.getFirstName() + user.getLastName() + "[" + group.getName() + "]");
		// �����ע��Ϣ
		taskService.addComment(taskId, processInstanceId, comment);
		// �������
		taskService.complete(taskId, variables);
		return Msg.success();
	}

	/**
	 * ��ԃ���������������ʷ���̱� : act_hi_actinst
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
			// ����������ʷʵ����ѯ
			list = historyService.createHistoricTaskInstanceQuery().taskCandidateUser(userId)
					.taskCandidateGroup(groupId).listPage((pn - 1) * 8, 8);
		} else {
			count = historyService.createHistoricTaskInstanceQuery().taskCandidateUser(userId).taskName(name)
					.taskCandidateGroup(groupId).count();
			// ����������ʷʵ����ѯ
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
	 * ��������id��ѯ����ʵ���ľ���ִ�й���
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
		String processInstanceId = hti.getProcessInstanceId(); // ��ȡ����ʵ��id

		List<HistoricActivityInstance> list = historyService.createHistoricActivityInstanceQuery()
				.processInstanceId(processInstanceId).list();
		return Msg.success().add("list", list);
	}
}
