package com.alj.dream.home.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.TestContext;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import scheduler.TestScheduler;


@Controller
@RequestMapping("/")
public class HomeController {

	
	private TestScheduler ts;
	
	public HomeController() {
		// TODO Auto-generated constructor stub
	}
	
	
	
	@Autowired
	public HomeController(TestScheduler ts) {
		this.ts = ts;
	}




	@GetMapping
	public String home(Locale locale, Model model) {
		System.out.println(ts==null);
		return "home/home";
	}

	
}
