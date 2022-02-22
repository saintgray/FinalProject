package com.alj.dream.file_profile.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alj.dream.file_profile.dao.ProfileFilesDao;
import com.alj.dream.file_profile.domain.FileInfo;
import com.alj.dream.profile.domain.ProfileRegisterData;

@Service
public class FileProfileRegisterService {
	
	
	
	private SqlSessionTemplate sst;
	
	
	
	
	public FileProfileRegisterService() {
	
	}



	@Autowired
	public FileProfileRegisterService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	
	
	// 첨부파일을 DB 에 등록, 서버에 첨부파일 저장
	public int insertAttachFile(HttpServletRequest req, ProfileRegisterData data) throws IllegalStateException, IOException {
		
		String profile_idx=String.valueOf(data.getProfile_idx());
		String savePath= req.getSession().getServletContext().getRealPath("/resources/files/member/profile_attachfiles");
		
		System.out.println(savePath);
		List<FileInfo> list = new LinkedList<FileInfo>();
		
		for(MultipartFile file: data.getFiles()) {
			
			String file_nm=String.valueOf(System.nanoTime());
			
			File dir=new File(savePath);
			File newfile = new File(savePath, file_nm);
			System.out.println(newfile.exists());
			if(!dir.exists()) {
				dir.mkdir();
			}
			System.out.println(newfile.getAbsolutePath());
			file.transferTo(newfile);
			
			
			list.add(new FileInfo(file_nm,
								   profile_idx, 
								   String.valueOf(file.getSize()/(1024)).concat("KB"),
								   file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')),
								   file.getOriginalFilename().replaceAll(" ","_")));
			
			
		}
		
	    int result=0;
	    
	    try{
	    	result=sst.getMapper(ProfileFilesDao.class).insertProfileFiles(list);
	    }catch(Exception e) {
	    	e.printStackTrace();
	    	for(FileInfo info : list) {
	    		File delfile=new File(savePath,info.getFile_nm());
	    		if(delfile.exists()) {
	    			delfile.delete();
	    		}
	    	}
	    
	    }
		
		
		
		
		
		
		
		
		
		
		return result;
	}
	
	
	

}
