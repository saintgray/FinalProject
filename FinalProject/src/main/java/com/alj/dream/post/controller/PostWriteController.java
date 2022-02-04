package com.alj.dream.post.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.post.service.PostWriteService;

@Controller
public class PostWriteController {
	
	@Autowired
	private PostWriteService writeService;

	@GetMapping("/post/write")
	public String getWriteForm() {
		return "post/writeform";
	}
	
	@PostMapping("/post/write")
	public String writePost(
			PostWriteRequest wRequest,
			HttpServletRequest request
			) {

		writeService.insertPost(wRequest, request);
		
		return "redirect:/post/list";
		
	}
	
}
