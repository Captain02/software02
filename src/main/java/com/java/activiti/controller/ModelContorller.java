package com.java.activiti.controller;

import java.util.List;

import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.java.activiti.model.PageInfo;

@Controller
@RequestMapping("/admin/model")
public class ModelContorller {

	@Autowired
	RepositoryService repositoryService;

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createModel(@RequestParam("modelName") String modelName, @RequestParam("modelKey") String modelKey, @RequestParam("modelDescription") String description) {

		try {

			ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();

			RepositoryService repositoryService = processEngine.getRepositoryService();

			ObjectMapper objectMapper = new ObjectMapper();
			ObjectNode editorNode = objectMapper.createObjectNode();
			editorNode.put("id", "canvas");
			editorNode.put("resourceId", "canvas");
			ObjectNode stencilSetNode = objectMapper.createObjectNode();
			stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
			editorNode.put("stencilset", stencilSetNode);
			Model modelData = repositoryService.newModel();

			ObjectNode modelObjectNode = objectMapper.createObjectNode();
			modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, modelName);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);
			modelData.setMetaInfo(modelObjectNode.toString());
			modelData.setName(modelName);
			modelData.setKey(modelKey);

			// ±£´æÄ£ÐÍ
			repositoryService.saveModel(modelData);
			repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));
			// response.sendRedirect(request.getContextPath() + "/modeler.html?modelId=" +
			// modelData.getId());
			return "redirect:/process-editor/modeler.html?modelId=" + modelData.getId();
		} catch (Exception e) {
		}
		return "";
	}

	@RequestMapping(value = "/getModel", method = RequestMethod.GET)
	public String getModel(org.springframework.ui.Model model,@RequestParam(value="pn",defaultValue="1")Integer pn) {
		List<Model> list = repositoryService.createModelQuery().listPage((pn-1)*8, 8);
		long count = repositoryService.createModelQuery().count();
		
		if (pn == 0) {
			pn = 1;
		}
		
		PageInfo<Model> pageInfo = new PageInfo<>(pn);
		pageInfo.setList(list);
		pageInfo.setTotalItemNumber(count);
		model.addAttribute("pageInfo", pageInfo);
		return "modelManagement";
	}

	@RequestMapping(value = "/save", method = RequestMethod.GET)
	public String savePage() {
		return "modelAdd";
	}

}
