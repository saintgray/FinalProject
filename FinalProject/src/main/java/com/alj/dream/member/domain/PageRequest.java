package com.alj.dream.member.domain;

public class PageRequest {

	private int selectPage;
	private int numOfMemberPerPage;
	private String blacklisted;
	private int firstMemberIndexOfSelectedPage;
	private String searchType;
	private String keyword;
	
	
	
	
	public PageRequest() {
		
		searchType="all";
	}




	public PageRequest(int selectPage, int numOfMemberPerPage, String blacklisted, int firstMemberIndexOfSelectedPage,
			String searchType, String keyword) {
		this.selectPage = selectPage;
		this.numOfMemberPerPage = numOfMemberPerPage;
		this.blacklisted = blacklisted;
		this.firstMemberIndexOfSelectedPage = firstMemberIndexOfSelectedPage;
		this.searchType = searchType;
		this.keyword = keyword;
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




	public String getSearchType() {
		return searchType;
	}




	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}




	public String getKeyword() {
		return keyword;
	}




	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
	
	
	
	



	
	
	
}
