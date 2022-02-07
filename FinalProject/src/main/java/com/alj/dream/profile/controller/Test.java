package com.alj.dream.profile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alj.dream.profile.domain.TestFiles;

@Controller
public class Test {

	
	
	
	
	@PostMapping("/test")
	@ResponseBody
	public String test(TestFiles files) {
		
		System.out.println(files==null);
		for(MultipartFile file : files.getFiles()) {
			System.out.println(file);
		}
		return "123";
	}
	
}
