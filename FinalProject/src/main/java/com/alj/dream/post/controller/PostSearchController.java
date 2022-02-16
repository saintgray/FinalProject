package com.alj.dream.post.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.post.domain.PostListInfo;
import com.alj.dream.post.domain.PostListView;
import com.alj.dream.post.domain.SearchParams;
import com.alj.dream.post.service.PostListService;

@Controller
public class PostSearchController {

	@Autowired
	private PostListService service;
	
	@GetMapping("/post/search")
	public String searchPost() {
		return "post/search";
	}
	
	@PostMapping("/post/search")
	@ResponseBody
	public PostListView searchResult(
			@RequestBody Map<String, String> searchParams
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
	
	@PostMapping("/post/recommend")
	@ResponseBody
	public List<PostListInfo> getRecommend(String m_idx, String wanted){
		
		return service.getRecommend(Integer.parseInt(m_idx), wanted);

	}
	
}
