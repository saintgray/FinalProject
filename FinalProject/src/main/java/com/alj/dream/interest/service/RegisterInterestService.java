package com.alj.dream.interest.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.interest.dao.InterestDao;
import com.alj.dream.member.domain.RegisterInfo;

@Service
public class RegisterInterestService {

	
	private SqlSessionTemplate sst;
	
	public RegisterInterestService() {
	
	}
	@Autowired
	public RegisterInterestService(SqlSessionTemplate sst) {
	
		this.sst = sst;
	}
	
	
	public int insertInterest(RegisterInfo infos) {
		
		int result=0;
		
		sst.getMapper(InterestDao.class).registerUserInterest(infos.getInterest(), String.valueOf(infos.getM_idx()));
			
		return result;
		
	}	
	
}
