package com.alj.dream.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alj.dream.post.service.PostListService;

import security.AccountDetails;

@Controller
@RequestMapping("/post/list")
public class PostListController {

	@Autowired
	PostListService listService;
	
	public String getPostList(
			@RequestParam(value = "p", defaultValue = "1") int pageNum,
			Model model
			) {
		
		// model.addAttribute("listView", listService.getPage(m_idx, wanted, pageNum));
		
		return "post/list";
	}
	
}
