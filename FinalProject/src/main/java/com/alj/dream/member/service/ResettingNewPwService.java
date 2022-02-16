package com.alj.dream.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.member.dao.MemberDao;

@Service
public class ResettingNewPwService {
	
	private SqlSessionTemplate sst;
	
	public ResettingNewPwService() {
		// TODO Auto-generated constructor stub
	}
	@Autowired
	public ResettingNewPwService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	
	public int resettingPw(String keyCode,String newPw) {
		
		return sst.getMapper(MemberDao.class).updateMemberPwByKeyCode(keyCode, newPw);
		
	}
	
	

}
