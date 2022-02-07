package com.alj.dream.notice.domain;

public class PageRequest {
	
	private String selectPage;
	private String numOfNoticesPerPage;
	
	public PageRequest() {
		
	}

	public PageRequest(String selectPage, String numOfNoticesPerPage) {
		
		this.selectPage = selectPage;
		this.numOfNoticesPerPage = numOfNoticesPerPage;
	}

	public String getSelectPage() {
		return selectPage;
	}

	public void setSelectPage(String selectPage) {
		this.selectPage = selectPage;
	}

	public String getNumOfNoticesPerPage() {
		return numOfNoticesPerPage;
	}

	public void setNumOfNoticesPerPage(String numOfNoticesPerPage) {
		this.numOfNoticesPerPage = numOfNoticesPerPage;
	}

	@Override
	public String toString() {
		return "PageRequest [selectPage=" + selectPage + ", numOfNoticesPerPage=" + numOfNoticesPerPage + "]";
	}
	
	
	

}
