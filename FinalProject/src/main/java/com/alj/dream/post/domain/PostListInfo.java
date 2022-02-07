package com.alj.dream.post.domain;

public class PostListInfo {
	
	private int post_idx;
	private String post_nm;
	private int cat_idx;
	private String cat_nm;
	private String match_yn;
	
	public PostListInfo() {}

	public PostListInfo(int post_idx, String post_nm, int cat_idx, String cat_nm, String match_yn) {
		this.post_idx = post_idx;
		this.post_nm = post_nm;
		this.cat_idx = cat_idx;
		this.cat_nm = cat_nm;
		this.match_yn = match_yn;
	}

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

	public String getMatch_yn() {
		return match_yn;
	}

	public void setMatch_yn(String match_yn) {
		this.match_yn = match_yn;
	}

}
