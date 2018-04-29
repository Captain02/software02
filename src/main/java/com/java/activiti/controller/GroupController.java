package com.java.activiti.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.java.activiti.service.GroupService;
import com.java.activiti.util.Msg;

/**
 * ��ɫ����
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/group")
public class GroupController {
	@Resource
	private GroupService groupService;
	@Autowired
	IdentityService identityService;

	/**
	 * ����ɫ������
	 * 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/findGroup", method = RequestMethod.GET)
	public Msg findGroup(HttpServletResponse response, Model model) throws Exception {
		List<Group> groups = identityService.createGroupQuery().list();
		return Msg.success().add("groups", groups);
	}

	/**
	 * ��ҳ��ѯ��
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/groupPage", method = RequestMethod.GET)
	public String groupPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) throws Exception {
		PageInfo<Group> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Group> list = identityService.createGroupQuery().list();
		pageInfo = new PageInfo<>(list, 5);
		model.addAttribute("pageInfo", pageInfo);

		return "groupManage";
	}

	/**
	 * �޸��û�
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/updateGroup",method=RequestMethod.POST)
	public Msg updateGroup(GroupEntity group) throws Exception {
		identityService.deleteGroup(group.getId());
		identityService.saveGroup(group);
		return Msg.success();
	}

	/**
	 * �����h����
	 * 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteGroup", method = RequestMethod.POST)
	public Msg deleteGroup(@RequestParam("ids") String ids) throws Exception {
		
		List<String> list = new ArrayList<String>();
		String[] strs = ids.split("-");
		for (String str : strs) {
			list.add(str);
		}
		try {
			groupService.deleteGroup(list);
		} catch (Exception e) {
			return Msg.fail();
		}
		return Msg.success();
	}

	/**
	 * ������
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/groupSave")
	public Msg groupSave(GroupEntity group) throws Exception {
		identityService.saveGroup(group);
		return Msg.success();
	}


}
