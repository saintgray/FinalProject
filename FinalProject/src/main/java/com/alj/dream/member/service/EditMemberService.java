package com.alj.dream.member.service;

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

import com.alj.dream.member.dao.MemberDao;
import com.alj.dream.member.domain.EditInfos;

import security.AccountDetails;

@Service
public class EditMemberService {

	private SqlSessionTemplate sst;
	private BCryptPasswordEncoder encoder;
	
	
	public EditMemberService() {
		
	}

	@Autowired
	public EditMemberService(SqlSessionTemplate sst, BCryptPasswordEncoder encoder) {
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
		
		info.setM_idx(logininfo.getM_idx());
				
		
		
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
			result=sst.getMapper(MemberDao.class).editMember(info);
			
			logininfo.setPhoto(newPhotoName);
			
			if(photo!=null) {
				File lastFile= new File(path,originPhotoName);
				if(!originPhotoName.equals("defaultprofile.png")) {
					System.out.println(lastFile.delete());
				
				}
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
