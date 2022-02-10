package com.alj.dream.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.post.service.PostEditService;

@Controller
@RequestMapping("/post/edit")
public class PostEditController {
	
	@Autowired
	private PostEditService service;
	
	@GetMapping
	public String getEditForm(int post_idx) {
		
		// PostViewRequest ... 
		
		return "post/editform";
	}
	
	@PostMapping
	public String editPost(PostWriteRequest wRequest) {
		
		int resultCnt = service.editPost(wRequest);
		
		if(resultCnt==0) {
			// 수정 실패 메시지
			
			
		}
		
		return "redirect:/post/view?idx="+wRequest.getPost_idx();
		
	}

}
