package com.alj.dream.qna.domain;

public class QnaListContent {

	private String m_idx;
	private String qna_idx;
	private String qna_title;
    private String qna_content;
	private String qna_regdate;
	private String qna_editdate;
	private String qna_deldate;
	
	public QnaListContent() {
		
	}

	public QnaListContent(String m_idx, String qna_idx, String qna_title, String qna_content, String qna_regdate,
			String qna_editdate, String qna_deldate) {
		this.m_idx = m_idx;
		this.qna_idx = qna_idx;
		this.qna_title = qna_title;
		this.qna_content = qna_content;
		this.qna_regdate = qna_regdate;
		this.qna_editdate = qna_editdate;
		this.qna_deldate = qna_deldate;
	}

	public String getM_idx() {
		return m_idx;
	}

	public void setM_idx(String m_idx) {
		this.m_idx = m_idx;
	}

	public String getQna_idx() {
		return qna_idx;
	}

	public void setQna_idx(String qna_idx) {
		this.qna_idx = qna_idx;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public String getQna_regdate() {
		return qna_regdate;
	}

	public void setQna_regdate(String qna_regdate) {
		this.qna_regdate = qna_regdate;
	}

	public String getQna_editdate() {
		return qna_editdate;
	}

	public void setQna_editdate(String qna_editdate) {
		this.qna_editdate = qna_editdate;
	}

	public String getQna_deldate() {
		return qna_deldate;
	}

	public void setQna_deldate(String qna_deldate) {
		this.qna_deldate = qna_deldate;
	}
	
	
	
}
