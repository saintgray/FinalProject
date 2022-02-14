package com.alj.dream.qna.domain;

public class PageRequest {
	
	private String selectPage;		//클릭한 현재페이지
	private String numOfQnaPerPage;	//한 페이지당 보여줄 qna 갯수
//	private String numOfPagePerPage;
//	private String curPageIndex;
	
	public PageRequest() {
		
	}

	public PageRequest(String selectPage, String numOfQnaPerPage) {
		this.selectPage = selectPage;
		this.numOfQnaPerPage = numOfQnaPerPage;
	}

	public String getSelectPage() {
		return selectPage;
	}

	public void setSelectPage(String selectPage) {
		this.selectPage = selectPage;
	}

	public String getNumOfQnaPerPage() {
		return numOfQnaPerPage;
	}

	public void setNumOfQnaPerPage(String numOfQnaPerPage) {
		this.numOfQnaPerPage = numOfQnaPerPage;
	}

	@Override
	public String toString() {
		return "PageRequest [selectPage=" + selectPage + ", numOfQnaPerPage=" + numOfQnaPerPage + "]";
	}
	
	

	
	
}
