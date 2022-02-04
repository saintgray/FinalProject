package com.alj.dream.profile.domain;

import java.util.List;

import com.alj.dream.file_profile.domain.MyFiles;

public class MyProfileInfo {
	// 회원의 프로필에 필요한 정보는 다음과 같다.
	// 회원의 평균 별점, 회원의 리뷰 리스트, 프로필 작성시 첨부한 첨부파일들
	
	// 수정에 필요한 프로필 인덱스, 회원의 m_idx....

	private String profile_idx;
	private String m_idx;
	private String line;
	private String calltime;
	private String career;
	private String qna;
	private String profile_regdate;
	private List<MyFiles> files;
	private String avgStars;
	
	public MyProfileInfo() {
	
	}

	public MyProfileInfo(String profile_idx, String m_idx, String line, String calltime, String career, String qna,
			String profile_regdate, List<MyFiles> files, String avgStars) {
		this.profile_idx = profile_idx;
		this.m_idx = m_idx;
		this.line = line;
		this.calltime = calltime;
		this.career = career;
		this.qna = qna;
		this.profile_regdate = profile_regdate;
		this.files = files;
		this.avgStars = avgStars;
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

	public String getQna() {
		return qna;
	}

	public void setQna(String qna) {
		this.qna = qna;
	}

	public String getProfile_regdate() {
		return profile_regdate;
	}

	public void setProfile_regdate(String profile_regdate) {
		this.profile_regdate = profile_regdate;
	}

	public List<MyFiles> getFiles() {
		return files;
	}

	public void setFiles(List<MyFiles> files) {
		this.files = files;
	}

	public String getAvgStars() {
		return avgStars;
	}

	public void setAvgStars(String avgStars) {
		this.avgStars = avgStars;
	}
	
	
	
	
	
	
	
	
	
	
}
