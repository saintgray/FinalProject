package com.alj.dream.post.domain;

public class PostViewRequest {
	
	private int post_idx;
	private String post_nm;
	private String post_content;
	private String post_regdate;
	private String post_editdate;
	private int cat_idx;
	private String cat_nm;
	private int m_idx;
	// private String match_yn;
	
	public PostViewRequest() {}

	public int getPost_idx() {
		return post_idx;
	}

	public void setPost_idx(int post_idx) {
		this.post_idx = post_idx;
	}

	public String getPost_nm() {
		return post_nm;
	}

	public void setPost_nm(String post_nm) {
		this.post_nm = post_nm;
	}

	public String getPost_content() {
		return post_content;
	}

	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}

	public String getPost_regdate() {
		return post_regdate;
	}

	public void setPost_regdate(String post_regdate) {
		this.post_regdate = post_regdate;
	}

	public String getPost_editdate() {
		return post_editdate;
	}

	public void setPost_editdate(String post_editdate) {
		this.post_editdate = post_editdate;
	}

	public int getCat_idx() {
		return cat_idx;
	}

	public void setCat_idx(int cat_idx) {
		this.cat_idx = cat_idx;
	}

	public String getCat_nm() {
		return cat_nm;
	}

	public void setCat_nm(String cat_nm) {
		this.cat_nm = cat_nm;
	}

	public int getM_idx() {
		return m_idx;
	}

	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}

}
