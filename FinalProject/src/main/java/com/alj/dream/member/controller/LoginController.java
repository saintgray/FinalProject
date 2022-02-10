package com.alj.dream.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	
	
	@RequestMapping("/member/loginform")
	public String showLoginForm(HttpServletRequest req, HttpServletResponse resp) {
		
		req.setAttribute("urlfrom", req.getHeader("referer"));
		return "member/loginform";
	}

}