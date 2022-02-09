package com.alj.dream;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test2")
public class TestController {

	
	@PostMapping
	public String showtest() {
		return "test";
	}
}
