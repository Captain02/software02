package com.java.activiti.util;

import java.util.HashMap;
import java.util.Map;

//������Ϣ
public class Msg {

	// ״̬��100�ɹ�200ʧ��
	private int code;
	// ��ʾ��Ϣ
	private String msg;
	// �û����ظ������������
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
		result.setMsg("����ɹ�");
		return result;
	}

	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("����ʧ��");
		return result;
	}
	
	public Msg add(String key,Object val) {
		this.getExtend().put(key, val);
		return this;
	}
}
