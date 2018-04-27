package com.java.activiti.controller;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.java.activiti.util.Msg;

/**
 * 流程部署管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/deploy")
public class DeployController {
		
	//注入activitiService服务
	@Resource
	private RepositoryService repositoryService;
	
	/**
	 * 分页查询流程
	 * @param rows
	 * @param page
	 * @param s_name
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deployPage",method=RequestMethod.GET)
	public String deployPage(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) throws Exception{
		PageInfo<Deployment> pageInfo = null;
		PageHelper.startPage(pn,8);
		List<Deployment> list=repositoryService.createDeploymentQuery()//创建流程查询实例
				.orderByDeploymenTime().desc()  //降序
				.list();
		pageInfo = new PageInfo<>(list,5);
		
		model.addAttribute("pageInfo", pageInfo);
		return "deployManage";
	}
	/**
	 * 添上传流程部署ZIP文件
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/addDeploy",method = RequestMethod.POST)
	public String addDeploy(MultipartFile file) throws Exception{
		System.out.println("+++++++++++++++++++++++++++++++++++++++++"+file.getOriginalFilename());
		repositoryService.createDeployment() //创建部署
		.name(file.getOriginalFilename())	//需要部署流程名称
		.addZipInputStream(new ZipInputStream(file.getInputStream()))//添加ZIP输入流
		.deploy();//开始部署
		return "redirect:deployPage";
	}

	/**
	 * 批量删除流程
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/delDeploy")
	public Msg delDeploy(HttpServletResponse response,String ids) throws Exception{
//		//拆分字符串
		String[] idsStr=ids.split("-");
		for(String str:idsStr){
			repositoryService.deleteDeployment(str, true);
		}
		return Msg.success();
	}
}
