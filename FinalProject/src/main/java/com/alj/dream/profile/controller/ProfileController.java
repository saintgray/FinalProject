package com.alj.dream.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.review.domain.AverageStarService;

import security.AccountDetails;

@Controller
@RequestMapping("/member/profile")
public class ProfileController {
	
	private AverageStarService avgService;
	public ProfileController() {
		// TODO Auto-generated constructor stub
	}
	
	@Autowired
	public ProfileController(AverageStarService avgService) {
		this.avgService = avgService;
	}


	@GetMapping("/main")
	public String showProfileMain(Authentication authentication) {
		AccountDetails logininfo= (AccountDetails)authentication.getPrincipal();
		return "member/profilemain";
	}

}
