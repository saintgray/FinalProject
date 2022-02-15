package com.alj.dream.qna.domain;

public class PageRequest {
	
	private int selectPage;		//클릭한 현재페이지
	private int numOfQnaPerPage;	//한 페이지당 보여줄 qna 갯수
	private int numOfPagePerPage;
	private int curPageIndex;
	
	public PageRequest() {
		curPageIndex=-1;
		numOfPagePerPage=10;
	}

	public PageRequest(int selectPage, int numOfQnaPerPage, int numOfPagePerPage, int curPageIndex) {
		this.selectPage = selectPage;
		this.numOfQnaPerPage = numOfQnaPerPage;
		this.numOfPagePerPage = numOfPagePerPage;
		this.curPageIndex = curPageIndex;
	
	
	}

	public int getSelectPage() {
		return selectPage;
	}

	public void setSelectPage(int selectPage) {
		this.selectPage = selectPage;
	}

	public int getNumOfQnaPerPage() {
		return numOfQnaPerPage;
	}

	public void setNumOfQnaPerPage(int numOfQnaPerPage) {
		this.numOfQnaPerPage = numOfQnaPerPage;
	}

	public int getNumOfPagePerPage() {
		return numOfPagePerPage;
	}

	public void setNumOfPagePerPage(int numOfPagePerPage) {
		this.numOfPagePerPage = numOfPagePerPage;
	}

	public int getCurPageIndex() {
		return curPageIndex;
	}

	public void setCurPageIndex(int curPageIndex) {
		this.curPageIndex = curPageIndex;
	}

	
	
	
	

	
	
}
