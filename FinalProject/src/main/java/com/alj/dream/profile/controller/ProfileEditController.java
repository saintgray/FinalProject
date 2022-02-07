package com.alj.dream.profile.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/member/profile/edit")
public class ProfileEditController {

	
	
	@PostMapping("/line")
	public int editLine(String line) {
		System.out.println("line>>>"+line);
		return 1;
	}
	
	@PostMapping("/career")
	public int editCareer(String career) {
		System.out.println(career);
		return 1;
	}
	
	@PostMapping("/qna")
	public int editQna(String qna) {
		System.out.println(qna);
		return 1;
	}
	
	@PostMapping("/calltime")
	public int editCalltime(String calltime) {
		System.out.println(calltime);
		return 1;
	}
	
	
}
