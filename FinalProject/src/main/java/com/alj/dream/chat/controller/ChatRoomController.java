package com.alj.dream.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alj.dream.chat.domain.Chat;
import com.alj.dream.chat.service.ChatInsertService;
import com.alj.dream.match.service.MatchChkService;

import sockethandler.ChatRoomService;


@Controller
public class ChatRoomController {

	@Autowired
	ChatInsertService service;
	
	
	@RequestMapping(value="/post/insertchat", method=RequestMethod.POST)
	@ResponseBody
	public int insertChat(Chat chat
			){
		
		//서비스에서 채팅 바로 insert
		System.out.println("ChatController진입성공");
		
		int resultCnt=service.insertChat(chat);
		
		return resultCnt;
	}

	
	
		@RequestMapping(value="/chat/chatroom", method=RequestMethod.GET)
		@ResponseBody
		public ModelAndView intoChat(
				ModelAndView mv,
				@RequestParam("myidx") int myIdx,
				@RequestParam("matchidx") int matchidx,
				@RequestParam("reciever") int reciever,
				HttpSession session
				) {
				
			System.out.println("ChatRoomController : intoChat진입");
			
			session.setAttribute("myIdx", myIdx);
			
			System.out.println("matchidx : " + matchidx);
			System.out.println("reciever : " + reciever);
	
			// 채팅 시 필요한 정보 보내주기
			//mv.setViewName("chat/chatRoom");
			mv.addObject("matchidx", matchidx);
			mv.addObject("reciever", reciever);
			
			System.out.println("mv.addObject(matchidx, matchidx) : " + matchidx);
			System.out.println("mv.addObject(reciever, reciever) : " + reciever);
		
			System.out.println("return mv 하기 전");
			
			return mv;
		}
	
}
