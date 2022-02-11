package com.alj.dream.post.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.Chat;

@Service
public class ChatInsertService {

	private PostDao dao;
	@Autowired 
	private SqlSessionTemplate template;
	
	// 문의하기에서 ajax로 
	// myidx, midx, matchidx, message받음 > chat생성
	public int InsertChat(Chat chat) {
		
		int resultCnt = 0;
		
		dao = template.getMapper(PostDao.class);
		resultCnt = dao.insertChat(chat);
		
		return resultCnt;
	}
	
}
