package com.java.activiti.controller;

import javax.annotation.Resource;

import org.activiti.engine.IdentityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.activiti.service.MemberShipService;
import com.java.activiti.util.Msg;
import com.java.activiti.util.StringUtil;

@Controller
@RequestMapping("/admin/memberShip")
public class MenberShipController {
		@Resource
		private MemberShipService memberShipService;
		
		@Autowired
		private IdentityService identityService;
		
		@ResponseBody
		@RequestMapping(value="/updateMemberShip",method=RequestMethod.POST)
		public Msg updateMemberShip(@RequestParam("userId")String userId,@RequestParam("groupsIds")String groupsIds) throws Exception{
			//刪除全部角色
			memberShipService.deleteAllGroupsByUserId(userId);
			System.out.println(userId+"+++++++++++++"+groupsIds);
			if(StringUtil.isNotEmpty(groupsIds)){
				//分割字符串，以，分割
				String idsArr[]=groupsIds.split("-");
				for(String groupId:idsArr){
					
					identityService.createMembership(userId, groupId);
				}
			}
			return Msg.success();
		}
}
