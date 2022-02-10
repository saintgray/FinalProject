package com.alj.dream.post.domain;

public class SearchParams {

	private int m_idx;
	private String wanted;
	private int cat_idx;
	private int loc_idx;
	
	public SearchParams() {}

	public SearchParams(int m_idx, String wanted, int cat_idx, int loc_idx) {
		this.m_idx = m_idx;
		this.wanted = wanted;
		this.cat_idx = cat_idx;
		this.loc_idx = loc_idx;
	}

	public int getM_idx() {
		return m_idx;
	}

	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}

	public String getWanted() {
		return wanted;
	}

	public void setWanted(String wanted) {
		this.wanted = wanted;
	}

	public int getCat_idx() {
		return cat_idx;
	}

	public void setCat_idx(int cat_idx) {
		this.cat_idx = cat_idx;
	}

	public int getLoc_idx() {
		return loc_idx;
	}

	public void setLoc_idx(int loc_idx) {
		this.loc_idx = loc_idx;
	}
	
}
