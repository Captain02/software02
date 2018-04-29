package com.java.activiti.model;

import java.util.List;

public class PageInfo<T> {

	//当前第几页
	private int pageNum;
	
	//当前页的 List
	private List<T> list;
	
	//每页显示多少条记录
	private int pageSize = 8;
	
	//共有多少条记录
	private long totalItemNumber;

	//构造器中需要对 pageNo 进行初始化
	public PageInfo(int pageNo) {
		super();
		this.pageNum = pageNo;
	}
	
	//需要校验一下
	public int getPageNum() {
		if(pageNum < 0)
			pageNum = 1;
		
		if(pageNum > getNavigatepageNums()){
			pageNum = getNavigatepageNums();
		}
		
		return pageNum;
	}
	
	public int getPageSize() {
		return pageSize;
	}
	
	public void setList(List<T> list) {
		this.list = list;
	}
	
	public List<T> getList() {
		return list;
	}
	
	//获取总页数
	public int getNavigatepageNums(){
		
		int totalPageNumber = (int)totalItemNumber / pageSize;
		
		if(totalItemNumber % pageSize != 0){
			totalPageNumber++;
		}
		
		return totalPageNumber;
	}
	
	public void setTotalItemNumber(long totalItemNumber) {
		this.totalItemNumber = totalItemNumber;
	}
	
	public boolean getHasNextPage(){
		if(getPageNum() < getNavigatepageNums()){
			return true;
		}
		
		return false;
	}
	
	public boolean getHasPreviousPage(){
		if(getPageNum() > 1){
			return true;
		}
		
		return false;
	}
	
	public int getPrevPage(){
		if(getHasPreviousPage()){
			return getPageNum() - 1;
		}
		
		return getPageNum();
	}
	
	public int getNextPage(){
		if(getHasNextPage()){
			return getPageNum() + 1;
		}
		
		return getPageNum();
	}
}