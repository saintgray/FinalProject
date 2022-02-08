package com.alj.dream.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.alj.dream.post.domain.PostViewRequest;
import com.alj.dream.post.service.PostViewService;
import com.alj.dream.profile.domain.ProfileRequest;

@Controller
public class PostViewController {

	@Autowired
	private PostViewService service;

	@GetMapping("/post/view")
	public String getPost(@RequestParam("idx") String idx, Model model) {

		int post_idx = Integer.parseInt(idx);

		PostViewRequest viewRequest = service.viewPost(post_idx);

		if (viewRequest != null) {
			// 글쓴이의 프로필 가져오기
			ProfileRequest writerProfile = service.getWriterProfile(viewRequest.getM_idx());

			model.addAttribute("writerProfile", writerProfile);
		}

		model.addAttribute("viewRequest", viewRequest);

		return "post/view";

	}

}
