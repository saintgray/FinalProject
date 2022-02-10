package com.alj.dream.post.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	@ResponseBody
	public int writePost(PostWriteRequest wRequest) {
		
		int resultCnt = 0;
		
		// 글 업로드
		resultCnt = writeService.insertPost(wRequest);
		
		// 파일업로드 처리
		List<MultipartFile> list = wRequest.getFileList();
		System.out.println(list);
		
		return resultCnt;
		
		// return "redirect:/post/list";
		// return "redirect:".concat(request.getContextPath().concat("/post/content?post_idx").concat(String.valueOf(wRequest.getPost_idx())));
		
	}
	
}
