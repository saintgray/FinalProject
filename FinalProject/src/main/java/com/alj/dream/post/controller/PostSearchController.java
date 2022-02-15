package com.alj.dream.post.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.post.domain.PostListView;
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
	@ResponseBody
	public PostListView searchResult(
			@RequestBody Map<String, String> searchParams,
			Model model
			) {
		
		int m_idx = Integer.parseInt(searchParams.get("m_idx"));
		String wanted = searchParams.get("wanted");
		int cat_idx = Integer.parseInt(searchParams.get("cat_idx"));
		int loc_idx = Integer.parseInt(searchParams.get("loc_idx"));
		int pageNum = Integer.parseInt(searchParams.get("pageNum"));
		
		SearchParams params = new SearchParams(m_idx, wanted, cat_idx, loc_idx);
		params.setPageNum(pageNum);
		System.out.println(params);
		
		return service.getSearchResult(params);

	}
	
}
