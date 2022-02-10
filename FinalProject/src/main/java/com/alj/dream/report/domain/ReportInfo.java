package com.alj.dream.report.domain;

public class ReportInfo {
	
	// member 테이블에 있음
	private String m_nm;
	// report 테이블에 있음
	private String report_content;
	// chat 테이블에 있음
	private String message;

	public ReportInfo() {
		// TODO Auto-generated constructor stub
	}

	public ReportInfo(String m_nm, String report_content, String message) {
		this.m_nm = m_nm;
		this.report_content = report_content;
		this.message = message;
	}

	public String getM_nm() {
		return m_nm;
	}

	public void setM_nm(String m_nm) {
		this.m_nm = m_nm;
	}

	public String getReport_content() {
		return report_content;
	}

	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
	
}
