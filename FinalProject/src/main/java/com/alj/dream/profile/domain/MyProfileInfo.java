package com.alj.dream.profile.domain;

import java.util.List;

import com.alj.dream.file_profile.domain.MyFiles;

public class MyProfileInfo {

	private String profile_idx;
	private String m_idx;
	private String line;
	private String calltime;
	private String career;
	private List<MyFiles> files;
	
	
	public MyProfileInfo(String profile_idx, String m_idx, String line, String calltime, String career,
			List<MyFiles> files) {
		this.profile_idx = profile_idx;
		this.m_idx = m_idx;
		this.line = line;
		this.calltime = calltime;
		this.career = career;
		this.files = files;
	}
	public String getProfile_idx() {
		return profile_idx;
	}
	public void setProfile_idx(String profile_idx) {
		this.profile_idx = profile_idx;
	}
	public String getM_idx() {
		return m_idx;
	}
	public void setM_idx(String m_idx) {
		this.m_idx = m_idx;
	}
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getCalltime() {
		return calltime;
	}
	public void setCalltime(String calltime) {
		this.calltime = calltime;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public List<MyFiles> getFiles() {
		return files;
	}
	public void setFiles(List<MyFiles> files) {
		this.files = files;
	}
	
	
	
	
	
	
}
