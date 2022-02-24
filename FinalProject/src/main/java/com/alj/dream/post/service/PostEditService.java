package com.alj.dream.post.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.file_post.domain.PostFileRequest;
import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.file_post.dao.PostFilesDao;
import com.alj.dream.profile.dao.ProfileDao;
import com.alj.dream.profile.domain.ProfileRequest;

@Service
public class PostEditService {

	private PostDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public PostWriteRequest getPost(int post_idx) {
		
		PostWriteRequest wRequest = template.getMapper(PostDao.class).selectWriteRequestByPostIdx(post_idx);
		
		// 첨부파일 있는지 확인
		int file_count = template.getMapper(PostFilesDao.class).selectCountByPostIdx(post_idx);
		
		if(file_count>0) {
			// 파일이 있을 경우 첨부파일리스트 추가하기
			List<PostFileRequest> fileList = template.getMapper(PostFilesDao.class).selectByPostIdx(post_idx);
			wRequest.setFileList(fileList);
		}
		
		return wRequest;
	}

	public int editPost(PostWriteRequest wRequest) {
		int resultCnt = 0;
		
		dao = template.getMapper(PostDao.class);
		resultCnt = dao.updatePost(wRequest);
		
		return resultCnt;
	}
	
	public ProfileRequest getWriterProfile(int m_idx) {
		return template.getMapper(ProfileDao.class).getWriterProfile(m_idx);
	}
	
}
