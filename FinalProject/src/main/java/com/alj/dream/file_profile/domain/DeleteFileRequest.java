package com.alj.dream.file_profile.domain;

public class DeleteFileRequest {
	
	private String profile_idx;
	private String file_nm;
	
	
	public DeleteFileRequest() {
		
	}


	public DeleteFileRequest(String profile_idx, String file_nm) {
		this.profile_idx = profile_idx;
		this.file_nm = file_nm;
	}


	public String getProfile_idx() {
		return profile_idx;
	}


	public void setProfile_idx(String profile_idx) {
		this.profile_idx = profile_idx;
	}


	public String getFile_nm() {
		return file_nm;
	}


	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	
	
	
	
	

}
