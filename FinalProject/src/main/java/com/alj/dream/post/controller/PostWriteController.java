package com.alj.dream.post.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
//		ProfileRequest writerProfile = service.getWriterProfile(viewRequest.getM_idx());
//
//		model.addAttribute("writerProfile", writerProfile);
		
		return "post/writeform";
	}
	
	@PostMapping("/post/write")
	@ResponseBody
	public Map<String, Integer> writePost(PostWriteRequest wRequest) {
		
		Map<String, Integer> result = new HashMap<String, Integer>();
		
		int resultCnt = 0;
		
		// 글 업로드
		resultCnt = writeService.insertPost(wRequest);
		
		// 파일업로드 처리
		List<MultipartFile> list = wRequest.getFileList();
		System.out.println(list);
		
		result.put("cnt", resultCnt);
		result.put("idx", wRequest.getPost_idx());
		
		return result;
		
		// return "redirect:/post/list";
		// return "redirect:".concat(request.getContextPath().concat("/post/content?post_idx").concat(String.valueOf(wRequest.getPost_idx())));
		
	}
	
}
