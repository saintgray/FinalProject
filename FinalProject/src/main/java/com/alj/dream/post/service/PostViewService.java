package com.alj.dream.post.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.PostViewRequest;
import com.alj.dream.profile.dao.ProfileDao;
import com.alj.dream.profile.domain.ProfileRequest;

@Service
public class PostViewService {

	private PostDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public PostViewRequest viewPost(int post_idx) {
		
		dao = template.getMapper(PostDao.class);
		
		return dao.selectPostByPostIdx(post_idx);
		
	}
	
	public ProfileRequest getWriterProfile(int m_idx) {
		return template.getMapper(ProfileDao.class).getWriterProfile(m_idx);
	}
	
}
