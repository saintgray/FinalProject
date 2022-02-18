package com.alj.dream.member.domain;

public class PageRequest {

	private int selectPage;
	private int numOfMemberPerPage;
	private String blacklisted;
	private int firstMemberIndexOfSelectedPage;
	private String onlyId;
	private String onlyName;
	private String searched;
	
	public PageRequest() {
	}

	public PageRequest(int selectPage, int numOfMemberPerPage, String blacklisted, int firstMemberIndexOfSelectedPage,
			String onlyId, String onlyName, String searched) {
		this.selectPage = selectPage;
		this.numOfMemberPerPage = numOfMemberPerPage;
		this.blacklisted = blacklisted;
		this.firstMemberIndexOfSelectedPage = firstMemberIndexOfSelectedPage;
		this.onlyId = onlyId;
		this.onlyName = onlyName;
		this.searched = searched;
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

	public String getOnlyId() {
		return onlyId;
	}

	public void setOnlyId(String onlyId) {
		this.onlyId = onlyId;
	}

	public String getOnlyName() {
		return onlyName;
	}

	public void setOnlyName(String onlyName) {
		this.onlyName = onlyName;
	}

	public String getSearched() {
		return searched;
	}

	public void setSearched(String searched) {
		this.searched = searched;
	}

	
	
	
	
	
	



	
	
	
}
