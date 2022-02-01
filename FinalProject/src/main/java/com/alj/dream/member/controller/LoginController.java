package com.alj.dream.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/loginform")
public class LoginController {
	
	
	@GetMapping
	public String showLoginForm() {
		return "member/loginform";
	}

}