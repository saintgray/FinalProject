package com.alj.dream.notice.domain;

public class Notice{
	
	private String notice_idx;
	private String notice_title;
	private String notice_regdate;
	
	public Notice() {
	
	}
	
	public Notice(String notice_idx, String notice_title, String notice_regdate) {
		
		this.notice_idx = notice_idx;
		this.notice_title = notice_title;
		this.notice_regdate = notice_regdate;
	}

	public String getNotice_idx() {
		return notice_idx;
	}

	public void setNotice_idx(String notice_idx) {
		this.notice_idx = notice_idx;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_regdate() {
		return notice_regdate;
	}

	public void setNotice_regdate(String notice_regdate) {
		this.notice_regdate = notice_regdate;
	}
	
	
	
	
	
	
	

}
