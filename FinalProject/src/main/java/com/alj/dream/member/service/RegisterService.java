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
		
		

		int insertResult=0;
		
		
		
		
		if(sqt.getMapper(MemberDao.class).selectByEmail(infos.getM_email())==null) {
			
			
			
				
				
// Tomcat 서버에 클라이언트의 파일을 저장시 코드				
				infos.setM_nm((infos.getM_nm()==null || infos.getM_nm().length()==0)? email.getM_email_prefix(): infos.getM_nm() );
				infos.setM_email(EMailUtil.getUserEmail(email));
				infos.setM_password(pwEncoder.encode(infos.getM_password()));
				String m_photo=infos.getPhoto()==null?"defaultprofile.png":String.valueOf(System.nanoTime());
				infos.setM_photo(m_photo);
				
				String savePath=req.getSession().getServletContext().getRealPath("/resources/files/member");
				File file =new File(savePath, m_photo);
				
				
// AWS S3 를 사용시 코드
//				
//				infos.setM_email(EMailUtil.getUserEmail(email));
//				infos.setM_password(pwEncoder.encode(infos.getM_password()));		
//				infos.setM_nm(infos.getM_nm().length()==0?email.getM_email_prefix():infos.getM_nm());
//				
//				
//				String originalName=infos.getPhoto().getOriginalFilename();
//				String uploadPath="member";
//				byte[] byteData= infos.getPhoto().getBytes();
//				
//				String filePath=UploadFileUtil.uploadFile(uploadPath, originalName, byteData);
//				System.out.println("DB에 저장될 프로필 사진의 경로 입니다");
//				System.out.println(filePath);
//				
//				
//				infos.setM_photo(filePath);	
				
				if(infos.getPhoto()!=null) {
					infos.getPhoto().transferTo(file);
					System.out.println("auto increment >>>>" +String.valueOf(infos.getM_idx()));
				}
				
				insertResult=sqt.getMapper(MemberDao.class).insertMember(infos);
			
				
			
		}else {
			
			throw new MemberExistException();
		}
		
		return insertResult;
		
	}

	
	
}
