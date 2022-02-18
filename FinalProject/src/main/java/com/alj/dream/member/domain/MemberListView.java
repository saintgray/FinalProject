package com.alj.dream.member.domain;

import java.util.List;


public class MemberListView {
	
	private int totalPage;
	private int numOfMemberPerPage;
	private int selectPage;
	private String searchType;
	private List<MemberInfo> list;
	
	
	public MemberListView() {
	
	}


	public MemberListView(int totalPage, int numOfMemberPerPage, int selectPage, String searchType,
			List<MemberInfo> list) {
		this.totalPage = totalPage;
		this.numOfMemberPerPage = numOfMemberPerPage;
		this.selectPage = selectPage;
		this.searchType = searchType;
		this.list = list;
	}


	public int getTotalPage() {
		return totalPage;
	}


	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}


	public int getNumOfMemberPerPage() {
		return numOfMemberPerPage;
	}


	public void setNumOfMemberPerPage(int numOfMemberPerPage) {
		this.numOfMemberPerPage = numOfMemberPerPage;
	}


	public int getSelectPage() {
		return selectPage;
	}


	public void setSelectPage(int selectPage) {
		this.selectPage = selectPage;
	}


	public String getSearchType() {
		return searchType;
	}


	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}


	public List<MemberInfo> getList() {
		return list;
	}


	public void setList(List<MemberInfo> list) {
		this.list = list;
	}

	
	
	
	
	
	
	

}
