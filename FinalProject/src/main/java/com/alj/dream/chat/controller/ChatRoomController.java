package com.alj.dream.chat.controller;

import java.util.List;

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
import com.alj.dream.chat.service.ChatRoomService;
import com.alj.dream.match.service.MatchChkService;


@Controller
public class ChatRoomController {

	@Autowired
	ChatRoomService service;
	
	// 채팅방으로 입장했을 때 : 필요한 데이터 보내주기
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
		
		session.setAttribute("myIdx", myIdx);			// 에코핸들러에서 사용하기 위해 필요한 정보들 세션에 저장.
		session.setAttribute("matchidx", matchidx);
		session.setAttribute("reciever", reciever);
		
		// 채팅 시 필요한 정보 보내주기
		mv.addObject("matchidx", matchidx);
		mv.addObject("reciever", reciever);
		
		// 매칭테이블도 필요하다
		mv.addObject("match", service.getMatch(matchidx));
		
		// 채팅데이터를 확인해봐서 데이터가 있다면 가져온다.(채팅방 입장시, 채팅했던 메세지들이 출력할 수 있도록)
		mv.addObject("chatlist", service.getChat(myIdx,matchidx,reciever));
		
		System.out.println("return mv 하기 전");
		
		return mv;
	}
	
	
	// 채팅메세지 DB에 저장하는 메소드
	@RequestMapping(value="/post/insertchat", method=RequestMethod.POST)
	@ResponseBody
	public int insertChat(Chat chat
			){
		
		//서비스에서 채팅 바로 insert
		System.out.println("ChatController진입성공");
		
		int resultCnt=service.insertChat(chat);
		
		return resultCnt;
	}
	
	
	// 채팅방 나갈때의 컨트롤러
	@RequestMapping(value="/chat/leavechat", method=RequestMethod.POST)
	@ResponseBody
	public int leaveChat(
			@RequestParam("matchidx") int matchidx,
			@RequestParam("myidx") int myidx,
			@RequestParam("reciever") int reciever,
			@RequestParam("mytype") String mytype
			) {
		System.out.println("ChatRoomController : leaveChat");
		
		System.out.println(mytype);
		
		
		int resultCnt = service.updateMatchOutyn(matchidx,myidx,reciever,mytype);
		// 예외처리 미완
		return resultCnt;
	}
	
}
