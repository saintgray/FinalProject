package com.alj.dream.profile.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.profile.dao.ProfileDao;
import com.alj.dream.profile.domain.MyProfileInfo;

@Service
public class ProfileService {
	
	
	private SqlSessionTemplate sst;
	
	public ProfileService() {
	
	}
	@Autowired
	public ProfileService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	
	public MyProfileInfo getUserProfile(String m_idx) {
		
		
		//String avgStars = sst.getMapper(ReviewDao.class).getStars(m_idx);
		MyProfileInfo prof= null;
		prof=sst.getMapper(ProfileDao.class).getProfile(m_idx);
		
		System.out.println("내 프로필이 비었나요?>>");
		System.out.println(prof==null);
		
		
		return prof;
		
	}
	
	
	
}
