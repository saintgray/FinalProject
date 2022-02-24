package com.alj.dream.chat.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.alj.dream.chat.dao.ChatDao;
import com.alj.dream.chat.domain.ChatRoom;

import security.AccountDetails;

@Service
public class ChatRoomListService {

	private ChatDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	
	public List<ChatRoom> getChatRoomList(Authentication auth){
		
		System.out.println("ChatListService : getChatRoomList진입");
		
		AccountDetails logininfo = (AccountDetails)auth.getPrincipal();
		int myidx = Integer.parseInt(logininfo.getM_idx());
		String mytype = logininfo.getM_type();
		
		dao = template.getMapper(ChatDao.class);
		
		List<ChatRoom> chatList = dao.selectChatRoomByIdx(mytype, myidx);
		System.out.println("ChatListService : chatList출력"+chatList);
		
		return chatList;
	}
	
	
	
}
