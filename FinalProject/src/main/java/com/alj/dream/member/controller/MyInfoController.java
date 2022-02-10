package com.alj.dream.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/myinfo")
public class MyInfoController {
	
	
	@GetMapping
	public String showUserInfo() {
		
		
		return "member/myinfo";
	}

}
