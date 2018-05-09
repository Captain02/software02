package com.java.activiti.controller;

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

import com.java.activiti.model.PageInfo;

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
	public String processDefinitionPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) throws Exception {
		if (pn == 0) {
			pn = 1;
		}
		long count = 0;
		List<ProcessDefinition> list = null;
		if ("".equals(name)) {
			count = repositoryService.createProcessDefinitionQuery().count();
			list = repositoryService.createProcessDefinitionQuery().orderByDeploymentId().desc().listPage((pn - 1) * 8, 8);
		}else {
			count = repositoryService.createProcessDefinitionQuery().processDefinitionName(name).count();
			list = repositoryService.createProcessDefinitionQuery().processDefinitionName(name).orderByDeploymentId().desc().listPage((pn - 1) * 8, 8);
		}

		PageInfo<ProcessDefinition> pageInfo = new PageInfo<>(pn);
		pageInfo.setList(list);
		pageInfo.setTotalItemNumber(count);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);
		return "deploye/processDefinitionManage";
	}

	/**
	 * @param diagramResourceName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/showView")
	public String showView(@RequestParam("deploymentId") String deploymentId,
			@RequestParam("diagramResourceName") String diagramResourceName, HttpServletResponse response)
			throws Exception {
		InputStream inputStream = repositoryService.getResourceAsStream(deploymentId, diagramResourceName);
		System.out.println(diagramResourceName);
		OutputStream out = response.getOutputStream();
		for (int b = -1; (b = inputStream.read()) != -1;) {
			out.write(b);
		}
		out.close();
		inputStream.close();
		return null;
	}

}
