package com.alj.dream.notice.domain;

import java.util.List;

public class NoticePageView {
	// 표현해야 할 정보들
	// 총 페이지 수
	// 한 페이지당 보여줄 공지사항의 갯수
	// 클릭한 페이지
	//..
	//....
	private int totalPage;
	private int numOfNoticesPerPage;
	private int selectPage;
	private List<Notice> noticeList;
	
	public NoticePageView() {
		
	}

	public NoticePageView(int totalPage, int numOfNoticesPerPage, int selectPage, List<Notice> noticeList) {
		this.totalPage = totalPage;
		this.numOfNoticesPerPage = numOfNoticesPerPage;
		this.selectPage = selectPage;
		this.noticeList = noticeList;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getNumOfNoticesPerPage() {
		return numOfNoticesPerPage;
	}

	public void setNumOfNoticesPerPage(int numOfNoticesPerPage) {
		this.numOfNoticesPerPage = numOfNoticesPerPage;
	}

	public int getSelectPage() {
		return selectPage;
	}

	public void setSelectPage(int selectPage) {
		this.selectPage = selectPage;
	}

	public List<Notice> getNoticeList() {
		return noticeList;
	}

	public void setNoticeList(List<Notice> noticeList) {
		this.noticeList = noticeList;
	}

	
	
	
	
	
	

}
