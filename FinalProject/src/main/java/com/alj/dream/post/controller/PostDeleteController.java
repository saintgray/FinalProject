package com.alj.dream.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.post.service.PostDeleteService;

@Controller
public class PostDeleteController {

	@Autowired
	private PostDeleteService service;
	
	@RequestMapping("/post/delete")
	public String deletePost(int post_idx) {
		
		service.deletePost(post_idx);
		
		// 성공시 메시지 출력 후 리다이렉트
		
		return "";
		
	}
	
}
