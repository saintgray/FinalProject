package com.alj.dream.admin.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.alj.dream.admin.dao.AdminDao;
import com.alj.dream.member.domain.EditInfos;

import security.AccountDetails;
@Service
public class AdminEditService {
	
	private SqlSessionTemplate sst;
	private BCryptPasswordEncoder encoder;
	
	
	public AdminEditService() {

	}
	
	
	
	
	@Autowired
	public AdminEditService(SqlSessionTemplate sst, BCryptPasswordEncoder encoder) {
		this.sst = sst;
		this.encoder = encoder;
	}





	@Transactional
	public int editInfos(EditInfos info, Authentication auth, HttpServletRequest req) throws IllegalStateException, IOException {
		
		AccountDetails logininfo = (AccountDetails)auth.getPrincipal();
		
		
		
		int result=0;
		
		File file=null;
		MultipartFile photo=info.getPhoto();
		String originPhotoName=null;
		String path=null;
		String newPhotoName=null;
		
		info.setM_idx(logininfo.getAdmin_idx());
				
		
		
		if(photo!=null) {
			originPhotoName=logininfo.getPhoto();
			newPhotoName=String.valueOf(System.nanoTime());
			path=req.getSession().getServletContext().getRealPath("/resources/files/member");
			
			info.setM_photo(newPhotoName);
			
			
			file=new File(path, newPhotoName);
			photo.transferTo(file);
			
			
		}
		if(info.getM_password()!=null) {
			info.setM_password(encoder.encode(info.getM_password()));
		}
		
		
		try {
			result=sst.getMapper(AdminDao.class).editAdmin(info);
			
			
			
			if(photo!=null) {
				logininfo.setPhoto(newPhotoName);
				
				File lastFile= new File(path,originPhotoName);
				if(!originPhotoName.equals("defaultprofile.png")) {
					System.out.println(lastFile.delete());
				
				}
			}
			

			if(info.getM_nm()!=null) {
				logininfo.setName(info.getM_nm());
			}
			
			
			
		}catch(Exception e){
			e.printStackTrace();
			
			if(photo!=null) {
				
				file.delete();
				
			}
			
		}
		
		
	
		
		return result;
	}
	

	

}
