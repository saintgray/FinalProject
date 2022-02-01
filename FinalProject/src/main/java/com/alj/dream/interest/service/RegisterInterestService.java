package com.alj.dream.interest.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.interest.dao.InterestDao;
import com.alj.dream.interest.domain.Interest;
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
		
		
		if(infos.getInterest()!=null) {
			
			for(String cat_idx: infos.getInterest()) {
				sst.getMapper(InterestDao.class).registerUserInterest(new Interest(String.valueOf(infos.getM_idx()), cat_idx));
			}
			
		}
		
		
		
		return 0;
		
	}
	
	
}
