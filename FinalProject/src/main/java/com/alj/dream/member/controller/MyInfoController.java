package com.alj.dream.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.member.service.MyInfoService;

import security.AccountDetails;

@Controller
@RequestMapping("/member/myinfo")
public class MyInfoController {
	
	
	
	private MyInfoService miService;
	
	public MyInfoController() {

	}
	
	@Autowired
	public MyInfoController(MyInfoService miService) {
		this.miService = miService;
	}




	@GetMapping
	public String showUserInfo(Authentication auth, Model model) {
		
		
		
		String principal_idx=((AccountDetails)auth.getPrincipal()).getM_idx();
		
		// 허가증에 본인의 idx, email, photo 가 모두 들어가 있으므로 DB 에서는 그 사람의 관심사만 가져오면 된다.
		model.addAttribute("info", miService.getPrincipalInfos(principal_idx));
		
		
		return "member/myinfo";
	}

}
