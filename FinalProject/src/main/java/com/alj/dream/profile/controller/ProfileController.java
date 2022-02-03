package com.alj.dream.profile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/profile")
public class ProfileController {

	@GetMapping("/main")
	public String showProfileMain() {

		return "member/profilemain";
	}

}
