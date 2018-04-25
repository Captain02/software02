package com.java.activiti.controller;

import java.io.InputStream;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String processDefinitionPage(String rows,String s_name,String page,HttpServletResponse response) throws Exception{
//		if(s_name==null){
//			s_name="";
//		}
//		PageInfo pageInfo=new PageInfo();
//		Integer sizePage=Integer.parseInt(rows);
//		pageInfo.setPageSize(sizePage);
//		if(page==null||page.equals("")){
//			page="1";
//		}
//		pageInfo.setPageIndex((Integer.parseInt(page) - 1)
//				* sizePage);
//		long count=repositoryService.createProcessDefinitionQuery()
//				.processDefinitionNameLike("%"+s_name+"%")
//				.count();
//		List<ProcessDefinition> processDefinitionList=repositoryService.createProcessDefinitionQuery()
//				.orderByDeploymentId().desc()
//				.processDefinitionNameLike("%"+s_name+"%")
//				.listPage(pageInfo.getPageIndex(), pageInfo.getPageSize());
//		JsonConfig jsonConfig=new JsonConfig();
//		jsonConfig.setExcludes(new String[]{"identityLinks","processDefinition"});
//		JSONObject result=new JSONObject();
//		JSONArray jsonArray=JSONArray.fromObject(processDefinitionList,jsonConfig);
//		result.put("rows", jsonArray);
//		result.put("total", count);
//		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * @param diagramResourceName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/showView")
	public String showView(String deploymentId,String diagramResourceName,HttpServletResponse response)throws Exception{
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
