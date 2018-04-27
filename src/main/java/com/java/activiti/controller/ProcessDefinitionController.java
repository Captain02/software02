package com.java.activiti.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/processDefinition")
public class ProcessDefinitionController {
		
	@Resource
	private RepositoryService repositoryService;
	
	@Resource
	private HistoryService historyService;
	
	/**
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/processDefinitionPage")
	public String processDefinitionPage(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) throws Exception{
		PageInfo<ProcessDefinition> pageInfo = null;
		PageHelper.startPage(pn,8);
		List<ProcessDefinition> list=repositoryService.createProcessDefinitionQuery()
				.orderByDeploymentId().desc()
				.list();
		pageInfo = new PageInfo<>(list,5);
		
		model.addAttribute("pageInfo", pageInfo);
		return "processDefinitionManage";
	}
	/**
	 * @param diagramResourceName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/showView")
	public String showView(@RequestParam("deploymentId")String deploymentId,@RequestParam("diagramResourceName")String diagramResourceName,HttpServletResponse response)throws Exception{
		InputStream inputStream=repositoryService.getResourceAsStream(deploymentId, diagramResourceName);
		System.out.println(diagramResourceName);
		OutputStream out=response.getOutputStream();
		for(int b=-1;(b=inputStream.read())!=-1;){
			out.write(b);
		}
		out.close();
		inputStream.close();
		return null;
	}
	
}
