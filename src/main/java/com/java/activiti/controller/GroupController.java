package com.java.activiti.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
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

import com.java.activiti.model.PageInfo;
import com.java.activiti.service.GroupService;
import com.java.activiti.util.Msg;

/**
 * 角色管理
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
	 * 填充角色下拉框
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
	 * 分页查询组
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/groupPage", method = RequestMethod.GET)
	public String groupPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,@RequestParam(value = "name", defaultValue = "") String name, Model model) throws Exception {
		long count = 0;
		List<Group> list = null;
		if (pn == 0) {
			pn = 1;
		}
		if ("".equals(name)) {
			count = identityService.createGroupQuery().count();
			list = identityService.createGroupQuery().listPage((pn-1)*8, 8);
		}else {
			count = identityService.createGroupQuery().groupName(name).count();
			list = identityService.createGroupQuery().groupName(name).listPage((pn-1)*8, 8);
		}
		PageInfo<Group> pageInfo = new PageInfo<>(pn);
		pageInfo.setList(list);
		pageInfo.setTotalItemNumber(count);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);
		return "groupManage";
	}

	/**
	 * 修改用户
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
	 * 批量刪除组
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
	 * 新增组
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
