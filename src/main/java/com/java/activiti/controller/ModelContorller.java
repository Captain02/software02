package com.java.activiti.controller;

import java.util.List;

import org.activiti.engine.RepositoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.activiti.util.Msg;

@Controller
@RequestMapping("/admin/ModelContorller")
public class ModelContorller {
	
	@Autowired
	RepositoryService repositoryService;

	@RequestMapping(value="/getModel",method=RequestMethod.GET)
	public String getModel(Model model) {
		List<org.activiti.engine.repository.Model> list = repositoryService.createModelQuery().list();
		model.addAttribute("list",list);
		return "model";
	}
}
