package com.alj.dream.file_profile.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.file_profile.domain.FileInfo;

@Service
public class FileListService {
	
	
	
	
	
	private SqlSessionTemplate sst;
	
	public FileListService() {

	}
	@Autowired
	public FileListService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	
	
	public List<FileInfo> getFileList(String profile_idx){
		
		
		return null;
	}

}
