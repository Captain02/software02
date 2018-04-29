package com.java.activiti.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.persistence.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.java.activiti.model.MemberShip;
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
	public String userPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) throws Exception {

		PageInfo<User> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<User> list = identityService.createUserQuery().list();
		pageInfo = new PageInfo<>(list, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "userManage";
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
		String[] strs = id.split(",");
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
	@RequestMapping("/userSave")
	public String userSave(HttpServletResponse response, com.java.activiti.model.User user) throws Exception {
		userService.addUser(user);
		return "redirect:userPage";
	}
	
	@ResponseBody
	@RequestMapping(value="/findUserById",method=RequestMethod.GET)
	public Msg findUserById(@RequestParam("userId")String userId) {
		User user = identityService.createUserQuery().userId(userId).singleResult();
		return Msg.success().add("user", user);
	}

	@RequestMapping("/listWithGroups")
	public String listWithGroups(HttpServletResponse response, String rows, String page, User user) throws Exception {
		// PageInfo<User> userPage=new PageInfo<User>();
		// Map<String,Object> userMap=new HashMap<String, Object>();
		// userMap.put("id", user.getId());
		// Integer pageSize=Integer.parseInt(rows);
		// userPage.setPageSize(pageSize);
		//
		// // 第几页
		// String pageIndex = page;
		// if (pageIndex == null || pageIndex == "") {
		// pageIndex = "1";
		// }
		// userPage.setPageIndex((Integer.parseInt(pageIndex) - 1)
		// * pageSize);
		// // 取得总页数
		// int userCount=userService.userCount(userMap);
		// userPage.setCount(userCount);
		// userMap.put("pageIndex", userPage.getPageIndex());
		// userMap.put("pageSize", userPage.getPageSize());
		//
		// List<User> userList = userService.userPage(userMap);
		// for(User users:userList){
		// StringBuffer buffer=new StringBuffer();
		// List<Group> groupList=groupService.findByUserId(users.getId());
		// for(Group g:groupList){
		// buffer.append(g.getName()+",");
		// }
		// if(buffer.length()>0){
		// //deleteCharAt 删除最后一个元素
		// users.setGroups(buffer.deleteCharAt(buffer.length()-1).toString());
		// }else{
		// user.setGroups(buffer.toString());
		// }
		// }
		// JSONArray jsonArray=JSONArray.fromObject(userList);
		// JSONObject result=new JSONObject();
		// result.put("rows", jsonArray);
		// result.put("total", userCount);
		// ResponseUtil.write(response, result);
		return null;
	}

}
