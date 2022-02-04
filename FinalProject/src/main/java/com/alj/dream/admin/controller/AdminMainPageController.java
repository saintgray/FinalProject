package com.alj.dream.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/manage")
public class AdminMainPageController {
	
	
	@GetMapping
	public String showadminpage() {
		System.out.println("called showadminpage()");
		return "admin/adminpage";
	}
}
