package com.alj.dream.profile.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class TestFiles {

	private List<MultipartFile> files;

	public TestFiles(List<MultipartFile> files) {
		this.files = files;
	}
	
	
	public TestFiles() {
		// TODO Auto-generated constructor stub
	}


	public List<MultipartFile> getFiles() {
		return files;
	}


	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	
	
}
