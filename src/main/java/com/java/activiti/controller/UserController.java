package com.java.activiti.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.persistence.entity.UserEntity;
import org.apache.log4j.chainsaw.Main;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.activiti.model.MemberShip;
import com.java.activiti.model.PageInfo;
import com.java.activiti.service.GroupService;
import com.java.activiti.service.MemberShipService;
import com.java.activiti.service.UserService;
import com.java.activiti.util.Msg;

/**
 * 用户管理
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/user")
public class UserController {

	@Resource
	private UserService userService;

	@Resource
	private MemberShipService menberShipService;

	@Resource
	private GroupService groupService;

	@Autowired
	private IdentityService identityService;

	/**
	 * 
	 * 登入
	 * 
	 * @param response
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/main",method=RequestMethod.GET)
	public String requestMain() {
		
		return "main";
	}
	
	@RequestMapping("/userLogin")
	public String userLogin(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userName", request.getParameter("userName"));
		map.put("password", request.getParameter("password"));
		map.put("groupId", request.getParameter("groupId"));
		MemberShip memberShip = menberShipService.userLogin(map);
		if (memberShip != null) {
			request.getSession().setAttribute("userId", memberShip.getUserId());
			request.getSession().setAttribute("groupId", request.getParameter("groupId"));
			return "main";
		} else {
			return "redirect:/login_new.jsp";
		}
	}

	/*
	 * 注销
	 */
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout() {

		return "redirect:/login_new.jsp";
	}

	/**
	 * 分页查询用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userPage")
	public String userPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) throws Exception {
		long count = 0;
		List<User> list = null;

		if (pn == 0) {
			pn = 1;
		}
		
		if ("".equals(name)) {
			count = identityService.createUserQuery().count();
			list = identityService.createUserQuery().listPage((pn - 1) * 8, 8);
		}else {
			count = identityService.createUserQuery().userId(name).count();
			list = identityService.createUserQuery().userId(name).listPage((pn - 1) * 8, 8);
		}
		
		PageInfo<User> pageInfo = new PageInfo<>(pn);
		pageInfo.setList(list);
		pageInfo.setTotalItemNumber(count);
		
		model.addAttribute("name", name);
		model.addAttribute("pageInfo", pageInfo);

		return "user/userManage";
	}

	/**
	 * 修改用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	public Msg updateUser(UserEntity user) throws Exception {
		identityService.deleteUser(user.getId());
		identityService.saveUser(user);
		return Msg.success();
	}

	/**
	 * 批量刪除用戶
	 * 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/deleteUser")
	public Msg deleteUser(HttpServletResponse response, HttpServletRequest request) throws Exception {
		String id = request.getParameter("ids");
		List<String> list = new ArrayList<String>();
		String[] strs = id.split("-");
		for (String str : strs) {
			list.add(str);
		}
		userService.deleteUser(list);
		return Msg.success();
	}

	/**
	 * 新增用戶
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/userSave", method = RequestMethod.POST)
	public Msg userSave(UserEntity user) {
		identityService.saveUser(user);

		// userService.addUser(user);
		return Msg.success();
	}

	// 根据用户名查找用户
	@ResponseBody
	@RequestMapping(value = "/findUserById", method = RequestMethod.GET)
	public Msg findUserById(@RequestParam("userId") String userId) {
		User user = identityService.createUserQuery().userId(userId).singleResult();
		return Msg.success().add("user", user);
	}

	// 查找用户所拥有那些组
	@ResponseBody
	@RequestMapping(value = "/listWithGroups", method = RequestMethod.GET)
	public Msg listWithGroups(@RequestParam("userId") String userId, Model model) throws Exception {
		List<Group> groupByUserId = identityService.createGroupQuery().groupMember(userId).list();
		List<Group> allGroup = identityService.createGroupQuery().list();
		return Msg.success().add("groupByUserId", groupByUserId).add("allGroup", allGroup);
	}

}
