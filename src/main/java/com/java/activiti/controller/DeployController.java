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
 * ���̲������
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/deploy")
public class DeployController {
		
	//ע��activitiService����
	@Resource
	private RepositoryService repositoryService;
	
	/**
	 * ��ҳ��ѯ����
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
		List<Deployment> list=repositoryService.createDeploymentQuery()//�������̲�ѯʵ��
				.orderByDeploymenTime().desc()  //����
				.list();
		pageInfo = new PageInfo<>(list,5);
		
		model.addAttribute("pageInfo", pageInfo);
		return "deployManage";
	}
	/**
	 * ���ϴ����̲���ZIP�ļ�
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/addDeploy",method = RequestMethod.POST)
	public String addDeploy(MultipartFile file) throws Exception{
		System.out.println("+++++++++++++++++++++++++++++++++++++++++"+file.getOriginalFilename());
		repositoryService.createDeployment() //��������
		.name(file.getOriginalFilename())	//��Ҫ������������
		.addZipInputStream(new ZipInputStream(file.getInputStream()))//���ZIP������
		.deploy();//��ʼ����
		return "redirect:deployPage";
	}

	/**
	 * ����ɾ������
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("/delDeploy")
	public Msg delDeploy(HttpServletResponse response,String ids) throws Exception{
//		//����ַ���
		String[] idsStr=ids.split("-");
		for(String str:idsStr){
			repositoryService.deleteDeployment(str, true);
		}
		return Msg.success();
	}
}
