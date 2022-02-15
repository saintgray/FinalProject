package com.alj.dream.report.domain;

public class Report {
	
	private int report_idx;
	private int match_idx;
	private String report_content;
	private int m_report;
	private int m_reported;
	
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public int getMatch_idx() {
		return match_idx;
	}
	public void setMatch_idx(int match_idx) {
		this.match_idx = match_idx;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public int getM_report() {
		return m_report;
	}
	public void setM_report(int m_report) {
		this.m_report = m_report;
	}
	public int getM_reported() {
		return m_reported;
	}
	public void setM_reported(int m_reported) {
		this.m_reported = m_reported;
	}
	
	public Report(int report_idx, int match_idx, String report_content, int m_report, int m_reported) {
		
		this.report_idx = report_idx;
		this.match_idx = match_idx;
		this.report_content = report_content;
		this.m_report = m_report;
		this.m_reported = m_reported;
	}
	
	public Report() {}
	
	@Override
	public String toString() {
		return "Report [report_idx=" + report_idx + ", match_idx=" + match_idx + ", report_content=" + report_content
				+ ", m_report=" + m_report + ", m_reported=" + m_reported + "]";
	}
	
	
	
}
