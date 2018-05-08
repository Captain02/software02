package com.java.activiti.controller;

import java.util.List;

import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Controller
@RequestMapping("/admin/model")
public class ModelContorller {
	
	@Autowired
	RepositoryService repositoryService;
	
	@RequestMapping("/create")
	public String createModel() {

		try {
			String modelName = "modelName";
			String modelKey = "modelKey";
			String description = "description";

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

	@RequestMapping(value="/getModel",method=RequestMethod.GET)
	public String getModel(org.springframework.ui.Model model) {
		List<org.activiti.engine.repository.Model> list = repositoryService.createModelQuery().list();
		model.addAttribute("list",list);
		return "modelManagement";
	}
	
	
}
