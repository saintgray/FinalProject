package com.alj.dream.request.domain;

import java.util.List;

public class RequestGroup {

	// 그룹(post_idx)별 받은제의
	
	private int post_idx;				// 게시물의 고유번호
	private String post_nm;				// 게시물의 타이틀
	private String post_regdate;		// 게시물의 생성일자
	private String wanted;				// 게시물의 요청대상
	private String cat_nm; 				// 카테고리
	private List<RequestMember> list;	// 게시물에 문의한 회원 리스트
	
	public RequestGroup() {}

	public RequestGroup(int post_idx, String post_nm, String post_regdate, String wanted, String cat_nm,
			List<RequestMember> list) {
		this.post_idx = post_idx;
		this.post_nm = post_nm;
		this.post_regdate = post_regdate;
		this.wanted = wanted;
		this.cat_nm = cat_nm;
		this.list = list;
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

	public String getPost_regdate() {
		return post_regdate;
	}

	public void setPost_regdate(String post_regdate) {
		this.post_regdate = post_regdate;
	}

	public String getWanted() {
		return wanted;
	}

	public void setWanted(String wanted) {
		this.wanted = wanted;
	}

	public String getCat_nm() {
		return cat_nm;
	}

	public void setCat_nm(String cat_nm) {
		this.cat_nm = cat_nm;
	}

	public List<RequestMember> getList() {
		return list;
	}

	public void setList(List<RequestMember> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "RequestingGroup [post_idx=" + post_idx + ", post_nm=" + post_nm + ", post_regdate=" + post_regdate
				+ ", wanted=" + wanted + ", cat_nm=" + cat_nm + ", list=" + list + "]";
	}
	
	
	
}
