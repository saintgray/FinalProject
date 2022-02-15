package com.alj.dream.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.file_post.service.PostFileDeleteService;
import com.alj.dream.post.service.PostDeleteService;

@Controller
@RequestMapping("/post/delete")
public class PostDeleteController {

	@Autowired
	private PostDeleteService service;
	
	@Autowired
	private PostFileDeleteService fileService;
	
	@PostMapping
	@ResponseBody
	public int deletePost(int post_idx) {
		
		// 게시물 첨부파일 존재유무 확인 후 있으면 file_deldate 추가하기
		int file_yn = fileService.getCountFile(post_idx);
		
		if(file_yn > 0) {
			fileService.deletePostFile(post_idx);
		}
		
		return service.deletePost(post_idx);
		
	}
	
}
