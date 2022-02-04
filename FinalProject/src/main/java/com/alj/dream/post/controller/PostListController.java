package com.alj.dream.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alj.dream.post.service.PostListService;

@Controller
@RequestMapping("/post/list")
public class PostListController {
	//새로운주석

	@Autowired
	PostListService listService;
	
	public void getPostList(
			@RequestParam(value = "p", defaultValue = "1") int pageNum,
			Model model
			) {
		
		//model.addAttribute("listView", listService.getPage(pageNum));
		
		
		
	}
	
}
