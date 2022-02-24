package com.alj.dream.chat.domain;

public class ChatRoom {

	// 채팅방에 필요한  데이터들
	
	private int match_idx;
	private String match_yn;
	private int m_idx;
	private String m_nm;
	private String m_photo;
	private String cat_nm;
	private String cat_type;
	
	public ChatRoom(int match_idx, String match_yn, int m_idx, String m_nm, String m_photo, String cat_nm,
			String cat_type) {
		this.match_idx = match_idx;
		this.match_yn = match_yn;
		this.m_idx = m_idx;
		this.m_nm = m_nm;
		this.m_photo = m_photo;
		this.cat_nm = cat_nm;
		this.cat_type = cat_type;
	}

	public ChatRoom() {}

	public int getMatch_idx() {
		return match_idx;
	}

	public void setMatch_idx(int match_idx) {
		this.match_idx = match_idx;
	}

	public int getM_idx() {
		return m_idx;
	}

	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}

	public String getMatch_yn() {
		return match_yn;
	}

	public void setMatch_yn(String match_yn) {
		this.match_yn = match_yn;
	}

	public String getM_nm() {
		return m_nm;
	}

	public void setM_nm(String m_nm) {
		this.m_nm = m_nm;
	}

	public String getM_photo() {
		return m_photo;
	}

	public void setM_photo(String m_photo) {
		this.m_photo = m_photo;
	}

	public String getCat_nm() {
		return cat_nm;
	}

	public void setCat_nm(String cat_nm) {
		this.cat_nm = cat_nm;
	}

	public String getCat_type() {
		return cat_type;
	}

	public void setCat_type(String cat_type) {
		this.cat_type = cat_type;
	}

	@Override
	public String toString() {
		return "ChatList [match_idx=" + match_idx + ", m_idx=" + m_idx + ", match_yn=" + match_yn + ", m_nm="
				+ m_nm + ", m_photo=" + m_photo + ", cat_nm=" + cat_nm + ", cat_type=" + cat_type + "]";
	}
	
	
	
	
}
