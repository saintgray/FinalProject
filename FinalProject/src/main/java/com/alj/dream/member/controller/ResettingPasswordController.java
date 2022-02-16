package com.alj.dream.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.member.service.ResettingNewPwService;

@Controller
@RequestMapping("/requestpassword")
public class ResettingPasswordController {

	private ResettingNewPwService rsService;
	
	
	public ResettingPasswordController() {

	}
	
	
	@Autowired
	public ResettingPasswordController(ResettingNewPwService rsService) {
		this.rsService = rsService;
	}


	@GetMapping
	public String showEditPwForm(HttpServletRequest req, @Param("keycode")String keyCode) {
		req.setAttribute("keyCode", keyCode);
		
		return "member/resettingpwform";
	}
	
	@PostMapping
	public int editToNewPassword(String keyCode, String newPw) {
		
		int result=0;
		result=rsService.resettingPw(keyCode, newPw);
		
		
		return result;
		
	}
}
