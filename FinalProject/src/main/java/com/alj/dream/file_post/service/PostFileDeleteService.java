package com.alj.dream.file_post.service;

import java.io.File;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.file_post.dao.PostFilesDao;
import com.alj.dream.file_post.domain.PostFileRequest;

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
	
	// 해당 게시물에 첨부되었으며 deldate 가 null 인 파일 리스트
	public List<PostFileRequest> selectAllFilesByPostIdx(int post_idx){
		return template.getMapper(PostFilesDao.class).selectByPostIdx(post_idx);
	}

	// 해당 게시글에 첨부되었으며 deldate가 null 인 파일에 deldate 추가
	public int addDeldate(int post_idx) {

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
	
	// 게시물이 삭제될 때 해당 게시물에 첨부된 모든 파일을 삭제
	public void deleteFiles(String saveDir, List<PostFileRequest> fileList) {
		
		if(fileList == null || fileList.size() == 0) {
			return;
		}
		
		System.out.println("========삭제할 파일리스트=========");
		System.out.println(fileList);
		System.out.println("----------------------------------");
		
		for(int i=0; i<fileList.size(); i++) {
			PostFileRequest attachFile = fileList.get(i);
			String fileName = attachFile.getFile_nm()+"."+attachFile.getFile_exet();
			File file = new File(saveDir, fileName);
			file.delete();
			System.out.println(fileName + " 삭제");
		}
		
		System.out.println("============삭제 완료=============");

	}

}
