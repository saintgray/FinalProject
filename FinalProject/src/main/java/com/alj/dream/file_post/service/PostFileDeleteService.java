package com.alj.dream.file_post.service;

import java.io.File;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.file_post.dao.PostFilesDao;

@Service
public class PostFileDeleteService {

	private PostFilesDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 해당 게시글에 첨부되었으며 deldate가 null 인 파일의 개수
	public int getCountFile(int post_idx) {

		dao = template.getMapper(PostFilesDao.class);

		return dao.selectCountByPostIdx(post_idx);

	}

	// 해당 게시글에 첨부되었으며 deldate가 null 인 파일에 deldate 추가
	public int deleteFile(int post_idx) {

		dao = template.getMapper(PostFilesDao.class);

		return dao.deletePostFile(post_idx);

	}

	// 파일 삭제
	public int deletePostFile(String saveDir, String filename) {
		
		// 업로드한 파일 삭제를 위한 파일객체
		File file;

		file = new File(saveDir, filename);
		file.delete();
		
		System.out.println("파일 삭제");
		
		return 1;

	}

}
