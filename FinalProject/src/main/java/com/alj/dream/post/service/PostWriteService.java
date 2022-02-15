package com.alj.dream.post.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.profile.dao.ProfileDao;
import com.alj.dream.profile.domain.MyProfileInfo;
import com.alj.dream.profile.domain.ProfileRequest;

@Service
public class PostWriteService {

	private PostDao dao;

	@Autowired
	private SqlSessionTemplate template;
	
	public int insertPost(
			PostWriteRequest wRequest
			) {
		
		int resultCnt = 0;
		
		dao = template.getMapper(PostDao.class);
		
		resultCnt = dao.insertPost(wRequest);
		
		return resultCnt;
		
	}
	
	public MyProfileInfo getProfile(String m_idx) {
		return template.getMapper(ProfileDao.class).getProfile(m_idx);
	}
	
	public ProfileRequest getWriterProfile(int m_idx) {
		return template.getMapper(ProfileDao.class).getWriterProfile(m_idx);
	}
	
}
