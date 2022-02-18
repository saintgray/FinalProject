package com.alj.dream.file_post.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.file_post.dao.PostFilesDao;
import com.alj.dream.file_post.domain.PostFileRequest;

@Service
public class PostFileUploadService {

	private PostFilesDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int insertPostFile(PostFileRequest fileRequest) {

		int resultCnt = 0;

		dao = template.getMapper(PostFilesDao.class);

		resultCnt = dao.insertPostFile(fileRequest);

		return resultCnt;

	}
	
}
