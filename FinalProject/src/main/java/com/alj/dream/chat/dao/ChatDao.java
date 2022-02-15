package com.alj.dream.chat.dao;


import java.util.List;

import com.alj.dream.chat.domain.Chat;
import com.alj.dream.chat.domain.ChatList;
public interface ChatDao {

	
	public int insertChat(Chat chat);
	public List<ChatList> selectChaListtByIdx(String mytype, int myidx);
}
