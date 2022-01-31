package com.alj.dream.member.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.alj.dream.member.dao.MemberDao;
import com.alj.dream.member.domain.Emailinfos;
import com.alj.dream.member.domain.RegisterInfo;
import com.alj.dream.member.exception.MemberExistException;
import com.alj.dream.util.mail.EMailUtil;

@Service
public class RegisterService {
	
	private SqlSessionTemplate sqt;
	private BCryptPasswordEncoder pwEncoder;
	

	public RegisterService() {}
	
	@Autowired
	public RegisterService(SqlSessionTemplate sqt, BCryptPasswordEncoder pwEncoder) {
		this.sqt = sqt;
		this.pwEncoder = pwEncoder;
	}
	
	
	

	public int insertMember(HttpServletRequest req,Emailinfos email,RegisterInfo infos) throws MemberExistException, IllegalStateException, IOException {
		
		
		infos.setM_email(EMailUtil.getUserEmail(email));
		infos.setM_password(pwEncoder.encode(infos.getM_password()));
		String m_photo=infos.getPhoto()==null?"defaultprofile.png":String.valueOf(System.nanoTime());
		infos.setM_photo(m_photo);
		
		String savePath=req.getSession().getServletContext().getRealPath("/resources/files/member");
		File file =new File(savePath, m_photo);
		
		int insertResult=0;
		
		
		
		
		if(sqt.getMapper(MemberDao.class).selectByEmail(infos.getM_email())==null) {
			
			insertResult=sqt.getMapper(MemberDao.class).insertMember(infos);
			
			if(insertResult==1) {
				if(infos.getPhoto()!=null) {
					infos.getPhoto().transferTo(file);
					System.out.println("auto increment >>>>" +String.valueOf(infos.getM_idx()));
				}
			}
				
			
		}else {
			
			throw new MemberExistException();
		}
		
		return insertResult;
	}

	
	
}
