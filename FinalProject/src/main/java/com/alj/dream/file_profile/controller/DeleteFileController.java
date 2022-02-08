package com.alj.dream.file_profile.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alj.dream.file_profile.domain.DeleteFileRequest;

@RestController
@RequestMapping("/member/profile/deletefiles")
public class DeleteFileController {
	
	
	
	@PostMapping
	public int deleteAttachFile(DeleteFileRequest delFileReq) {
		
		int result=0;
		
		return result;
	}

}
