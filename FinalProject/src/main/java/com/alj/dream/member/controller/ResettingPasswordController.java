package com.alj.dream.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.member.exception.KeyCodeExpiredException;
import com.alj.dream.member.service.ResettingNewPwService;

@Controller
@RequestMapping("/resettingpassword")
public class ResettingPasswordController {

	private ResettingNewPwService rsService;
	
	
	public ResettingPasswordController() {

	}
	
	
	@Autowired
	public ResettingPasswordController(ResettingNewPwService rsService) {
		this.rsService = rsService;
	}


	@GetMapping
	public String showEditPwForm(HttpServletRequest req) {
		
		
		return "member/resettingpwform";
	}
	
	@PostMapping
	@ResponseBody
	public int editToNewPassword(String keycode, String newPw) {
		
		int result=0;
		
		try {
			result=rsService.resettingPw(keycode, newPw);
		}catch(KeyCodeExpiredException e) {
			result=-1;
		}
		
		
		return result;
		
	}
}
