package com.alj.dream.file_profile.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.file_profile.dao.ProfileFilesDao;
import com.alj.dream.file_profile.domain.DeleteFileRequest;

@Service
public class DeleteFileService {
	private SqlSessionTemplate sst;
	
	
	public DeleteFileService() {
		// TODO Auto-generated constructor stub
	}

	@Autowired
	public DeleteFileService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	public int deleteFile(DeleteFileRequest delFileReq) {
		
		return sst.getMapper(ProfileFilesDao.class).deleteFile(delFileReq);
		
	}
	
	
}
