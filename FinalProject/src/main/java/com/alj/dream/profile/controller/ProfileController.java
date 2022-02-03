package com.alj.dream.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.profile.service.ProfileService;

import security.AccountDetails;

@Controller
@RequestMapping("/member/profile")
public class ProfileController {
	
	private ProfileService profService;
	
	public ProfileController() {}

	@Autowired
	public ProfileController(ProfileService profService) {
		this.profService = profService;
	}






	@GetMapping("/main")
	public String showProfileMain(Authentication authentication, Model model) {
		AccountDetails logininfo= (AccountDetails)authentication.getPrincipal();
		model.addAttribute("profile", profService.getUserProfile(logininfo.getM_idx()));
		
		
		return "member/profile/profilemain";
	}

}
