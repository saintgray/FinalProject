package com.alj.dream.file_post.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alj.dream.file_post.dao.PostFilesDao;
import com.alj.dream.file_post.domain.PostFileRequest;

@Service
public class PostFileUploadService {

	private PostFilesDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public void uploadfile(HttpServletRequest request, int post_idx, List<MultipartFile> fileList) {

		String saveDir = request.getSession().getServletContext().getRealPath("/resources/files/post/");

		for (MultipartFile multipartFile : fileList) {
			System.out.println("-----------------------------");
			System.out.println("Upload file name : " + multipartFile.getOriginalFilename());
			System.out.println("Upload file size : " + multipartFile.getSize());

			int file_size = (int) multipartFile.getSize();

			String[] files = multipartFile.getOriginalFilename().split("\\.");
			String file_exet = files[files.length - 1];

			String file_nm = String.valueOf(System.nanoTime());

			File saveFile = new File(saveDir, file_nm + "." + file_exet);

			try {
				multipartFile.transferTo(saveFile);
				System.out.println("파일 업로드 성공");
				
				// 이미지인지 확인 후 썸네일 만들기
				if(checkImageType(saveFile)) {
					
				}
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}

			// file_post 테이블에 insert
			PostFileRequest fileRequest = new PostFileRequest(file_nm, post_idx, file_exet, file_size);
			insertPostFile(fileRequest);
			System.out.println("파일 DB에 저장");
			System.out.println("=====================================\n");

		}
	}

	public int insertPostFile(PostFileRequest fileRequest) {

		int resultCnt = 0;

		dao = template.getMapper(PostFilesDao.class);

		resultCnt = dao.insertPostFile(fileRequest);

		return resultCnt;

	}

	private boolean checkImageType(File file) {

		try {

			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;

	}

}
