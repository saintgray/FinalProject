package com.alj.dream.admin.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/edit")
public class AdminEditController {

	@PostMapping
	public int editAdminInfo() {
		
		
		return 0;
	}
}
