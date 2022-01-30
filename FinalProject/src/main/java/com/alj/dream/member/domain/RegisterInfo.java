package com.alj.dream.member.domain;

import java.util.List;

public class RegisterInfo {
	
	private Emailinfos email;
    private String m_password;
	private String m_nm;
	private String m_adyn;
	private String m_photo;
	private List<String> interest;
	
	public RegisterInfo() {
		
		
	}

	public RegisterInfo(Emailinfos email, String m_password, String m_nm, String m_adyn, String m_photo,
			List<String> interest) {
		
		this.email = email;
		this.m_password = m_password;
		this.m_nm = m_nm;
		this.m_adyn = m_adyn;
		this.m_photo = m_photo;
		this.interest = interest;
	}

	public Emailinfos getEmail() {
		return email;
	}

	public void setEmail(Emailinfos email) {
		this.email = email;
	}

	public String getM_password() {
		return m_password;
	}

	public void setM_password(String m_password) {
		this.m_password = m_password;
	}

	public String getM_nm() {
		return m_nm;
	}

	public void setM_nm(String m_nm) {
		this.m_nm = m_nm;
	}

	public String getM_adyn() {
		return m_adyn;
	}

	public void setM_adyn(String m_adyn) {
		this.m_adyn = m_adyn;
	}

	public String getM_photo() {
		return m_photo;
	}

	public void setM_photo(String m_photo) {
		this.m_photo = m_photo;
	}

	public List<String> getInterest() {
		return interest;
	}

	public void setInterest(List<String> interest) {
		this.interest = interest;
	}
	
	
	
	


	
	
	
	

	
	
	

}
