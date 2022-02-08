package com.alj.dream.member.domain;

public class PageRequest {
	
	private String selectPage;
	private String numOfMemberPerPage;
	
	public PageRequest() {
	}

	public PageRequest(String selectPage, String numOfMemberPerPage) {
		this.selectPage = selectPage;
		this.numOfMemberPerPage = numOfMemberPerPage;
	}

	
	
	public String getSelectPage() {
		return selectPage;
	}

	public void setSelectPage(String selectPage) {
		this.selectPage = selectPage;
	}

	public String getNumOfMemberPerPage() {
		return numOfMemberPerPage;
	}

	public void setNumOfMemberPerPage(String numOfMemberPerPage) {
		this.numOfMemberPerPage = numOfMemberPerPage;
	}

	@Override
	public String toString() {
		return "PageRequest [selectPage=" + selectPage + ", numOfMemberPerPage=" + numOfMemberPerPage + "]";
	}
	
	
	
}
