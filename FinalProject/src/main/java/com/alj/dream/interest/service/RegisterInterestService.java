package com.alj.dream.interest.service;

import java.util.LinkedList;
import java.util.List;

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
		
		List<Interest> interest =null;
		
		if(infos.getInterest()!=null) {	
			
			interest=new LinkedList<Interest>();
			
			for(String cat_idx:infos.getInterest()) {
				interest.add(new Interest(String.valueOf(infos.getM_idx()), cat_idx));
			}		
		}
		
		sst.getMapper(InterestDao.class).registerUserInterest(interest);
			
		return 0;
		
	}	
	
}
