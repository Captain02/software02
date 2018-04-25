package com.java.activiti.util;

import java.util.HashMap;
import java.util.Map;

//返回信息
public class Msg {

	// 状态码100成功200失败
	private int code;
	// 提示信息
	private String msg;
	// 用户返回给浏览器的数据
	private Map<String, Object> extend = new HashMap<>();

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("处理成功");
		return result;
	}

	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("处理失败");
		return result;
	}
	
	public Msg add(String key,Object val) {
		this.getExtend().put(key, val);
		return this;
	}
}
