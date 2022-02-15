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
	private String match_yn;
	
	public PostViewRequest() {}

	public int getPost_idx() {
		return post_idx;
	}

	public String getPost_nm() {
		return post_nm;
	}

	public String getPost_content() {
		return post_content;
	}

	public String getPost_regdate() {
		return post_regdate;
	}

	public String getPost_editdate() {
		return post_editdate;
	}

	public int getCat_idx() {
		return cat_idx;
	}

	public String getCat_nm() {
		return cat_nm;
	}

	public int getM_idx() {
		return m_idx;
	}

	public String getMatch_yn() {
		return match_yn;
	}

}
