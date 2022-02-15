package com.alj.dream.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.member.service.EditMemberService;

@Controller
@RequestMapping("/findaccount")
public class FindAccountController {

	
	private JavaMailSender ms;
	private EditMemberService emService;
	
	public FindAccountController() {
		
	}
	
	@Autowired
	public FindAccountController(JavaMailSender ms, EditMemberService emService) {
		this.ms = ms;
		this.emService = emService;
	}
	
	
	@GetMapping
	public String showFindMeForm() {
		
		return "member/findaccountform";
	}
	
	
	
	
	
	
	
	
}
