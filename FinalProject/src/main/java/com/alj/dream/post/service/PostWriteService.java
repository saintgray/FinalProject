package com.alj.dream.post.service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.PostWriteRequest;

@Service
public class PostWriteService {

	private PostDao dao;

	@Autowired
	private SqlSessionTemplate template;
	
	public int insertPost(
			PostWriteRequest wRequest,
			HttpServletRequest request
			) {
		
		int resultCnt = 0;
		
		dao = template.getMapper(PostDao.class);
		
		resultCnt = dao.insertPost(wRequest);
		
		return resultCnt;
		
	}
	
}
