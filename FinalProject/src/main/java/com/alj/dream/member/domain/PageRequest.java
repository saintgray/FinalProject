package com.alj.dream.member.domain;

public class PageRequest {

	private int selectPage;
	private int numOfMemberPerPage;
	private String blacklisted;
	private int firstMemberIndexOfSelectedPage;

	public PageRequest() {
	}

	public PageRequest(int selectPage, int numOfMemberPerPage, String blacklisted, int firstMemberIndexOfSelectedPage) {
		this.selectPage = selectPage;
		this.numOfMemberPerPage = numOfMemberPerPage;
		this.blacklisted = blacklisted;
		this.firstMemberIndexOfSelectedPage = firstMemberIndexOfSelectedPage;
	}

	public int getSelectPage() {
		return selectPage;
	}

	public void setSelectPage(int selectPage) {
		this.selectPage = selectPage;
	}

	public int getNumOfMemberPerPage() {
		return numOfMemberPerPage;
	}

	public void setNumOfMemberPerPage(int numOfMemberPerPage) {
		this.numOfMemberPerPage = numOfMemberPerPage;
	}

	public String getBlacklisted() {
		return blacklisted;
	}

	public void setBlacklisted(String blacklisted) {
		this.blacklisted = blacklisted;
	}

	public int getFirstMemberIndexOfSelectedPage() {
		return firstMemberIndexOfSelectedPage;
	}

	public void setFirstMemberIndexOfSelectedPage(int firstMemberIndexOfSelectedPage) {
		this.firstMemberIndexOfSelectedPage = firstMemberIndexOfSelectedPage;
	}
	
	
	
	
	



	
	
	
}
