package com.alj.dream;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/manage")
public class AdminPageController {
	
	
	@GetMapping
	public String showadminpage() {
		return "adminpage";
	}
}
