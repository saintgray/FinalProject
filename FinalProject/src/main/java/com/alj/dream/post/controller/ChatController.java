package com.alj.dream.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.alj.dream.post.domain.Match;

import sockethandler.ChatService;

@Controller
@RequestMapping("/post/chat")
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	// 게시글에서 문의하기를 누름으로써 m_idx와 post_idx를 넘겨받아 match테이블 생성 / 채팅화면으로 돌림.
	@GetMapping
	public ModelAndView intoChat(
			ModelAndView mv,
			@RequestParam("postidx") int postidx,
			@RequestParam("midx") int midx,
			Authentication auth) {
				
		// 매칭테이블 만들기
		System.out.println("컨트롤러진입성공");
		Match match = chatService.getMatch(postidx, midx, auth);
		System.out.println("컨트롤러 : 매칭테이블 가져오기 성공");

		// 채팅 시 필요한 정보 보내주기
		mv.setViewName("post/chat");
		mv.addObject("match", match);
		return mv;
	}
	

}
