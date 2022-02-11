package com.alj.dream.post.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.PostWriteRequest;

@Service
public class PostEditService {

	private PostDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public PostWriteRequest getPost(int post_idx) {
		dao = template.getMapper(PostDao.class);
		
		PostWriteRequest wRequest = dao.selectWriteRequestByPostIdx(post_idx);
		
		// 첨부파일리스트 추가하기
		// List<MultipartFile> fileList = ;
		// wRequest.setFileList(fileList);
		
		return wRequest;
	}

	public int editPost(PostWriteRequest wRequest) {
		int resultCnt = 0;
		
		dao = template.getMapper(PostDao.class);
		resultCnt = dao.updatePost(wRequest);
		
		return resultCnt;
	}
	
}
