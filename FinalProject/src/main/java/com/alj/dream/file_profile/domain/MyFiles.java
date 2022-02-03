package com.alj.dream.file_profile.domain;

public class MyFiles {
	
	private String file_nm;
	private String profile_idx;
	private String file_regdate;
	private String file_size;
	private String file_exet;
	
	public MyFiles(String file_nm, String profile_idx, String file_regdate, String file_size, String file_exet) {
		this.file_nm = file_nm;
		this.profile_idx = profile_idx;
		this.file_regdate = file_regdate;
		this.file_size = file_size;
		this.file_exet = file_exet;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getProfile_idx() {
		return profile_idx;
	}
	public void setProfile_idx(String profile_idx) {
		this.profile_idx = profile_idx;
	}
	public String getFile_regdate() {
		return file_regdate;
	}
	public void setFile_regdate(String file_regdate) {
		this.file_regdate = file_regdate;
	}
	public String getFile_size() {
		return file_size;
	}
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	public String getFile_exet() {
		return file_exet;
	}
	public void setFile_exet(String file_exet) {
		this.file_exet = file_exet;
	}
	
	
	
	
	
	

}
