package com.alj.dream.file_profile.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.file_profile.dao.ProfileFilesDao;

@Service
public class DeleteFileService {
	private SqlSessionTemplate sst;
	
	
	public DeleteFileService() {}

	@Autowired
	public DeleteFileService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	public int deleteFile(HttpServletRequest req, String file_nm) {
		
		String savedFolder=req.getSession().getServletContext().getRealPath("/resources/files/member/profile_attachfiles");
		
		
		
		// 1. DB에 저장된 이 파일에 대한 행의 삭제 유무 Update
		int resultDeleteProcessDB=sst.getMapper(ProfileFilesDao.class).deleteFile(file_nm);
		
		// 파일 완전 삭제 처리 하지 않음 (추후 Scheduler 를 통하여 삭제한 파일들 중에서 삭제한 날짜로부터 x일이 지났다면 완전삭제할 수 있도록 처리할 것)
		
//		if(resultDeleteProcessDB==1) {
//			File file = new File(savedFolder, file_nm);
//			if(file.exists()) {
//				file.delete();
//			}
//		}
		
		

		
		// 이제 해당 유저가 자신의 프로필을 클릭했을 때 삭제일이 NULL 인 데이터들만 가져오도록 처리해야 한다. (: file_profileMapper.xml 의 getFiles 쿼리)
		
		
		return resultDeleteProcessDB;
		
	}
	
	
}
