package com.alj.dream.post.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.post.domain.PostListInfo;
import com.alj.dream.post.domain.SearchParams;
import com.alj.dream.post.service.PostListService;

@Controller
@RequestMapping("/post/search")
public class PostSearchController {

	@Autowired
	private PostListService service;
	
	@GetMapping
	public String searchPost() {
		return "post/search";
	}
	
	@PostMapping
	public List<PostListInfo> searchResult(
			SearchParams params,
			Model model
			) {
		
		return service.getList(params);

	}
	
}
