package com.alj.dream.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.member.dao.MemberDao;
import com.alj.dream.member.domain.RegisterInfo;
import com.alj.dream.member.exception.MemberExistException;

@Service
public class RegisterService {
	
	private SqlSessionTemplate sqt;

	public RegisterService() {}
	
	@Autowired
	public RegisterService(SqlSessionTemplate sqt) {
		this.sqt = sqt;
	}

	public int insertMember(RegisterInfo info) throws MemberExistException {
		
		int insertResult=0;
		
		if(sqt.getMapper(MemberDao.class).selectByEmail(info.getM_email())!=null) {
			insertResult=sqt.getMapper(MemberDao.class).insertMember(info);
		}else {
			throw new MemberExistException();
		}
		
		return insertResult;
	}
	

}
