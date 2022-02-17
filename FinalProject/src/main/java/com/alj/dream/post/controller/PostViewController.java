package com.alj.dream.post.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alj.dream.match.domain.MatchInfo;
import com.alj.dream.match.service.MatchInfoService;
import com.alj.dream.post.domain.PostViewRequest;
import com.alj.dream.post.service.PostViewService;
import com.alj.dream.profile.domain.ProfileRequest;

import security.AccountDetails;

@Controller
public class PostViewController {

	@Autowired
	private PostViewService service;

	@Autowired
	private MatchInfoService matchService;

	@GetMapping("/post/view")
	public String getPost(@RequestParam("idx") String idx, Authentication authentication, Model model) {

		int post_idx = Integer.parseInt(idx);

		PostViewRequest viewRequest = service.viewPost(post_idx);

		if (viewRequest != null) {
			// 글쓴이의 프로필 가져오기
			ProfileRequest writerProfile = service.getWriterProfile(viewRequest.getM_idx());

			model.addAttribute("writerProfile", writerProfile);

			// 생성된 채팅이 있을 경우 채팅정보 가져오기
			if (viewRequest.getMatch_count()>0) {

				List<MatchInfo> matchInfos = matchService.getMatchInfos(post_idx);
				System.out.println(matchInfos);
				
				viewRequest.setMatchInfos(matchInfos);

			}

		}

		model.addAttribute("viewRequest", viewRequest);

		return "post/view";

	}

}
