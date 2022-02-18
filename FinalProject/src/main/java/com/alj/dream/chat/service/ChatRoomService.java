package com.alj.dream.chat.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.chat.dao.ChatDao;
import com.alj.dream.chat.domain.Chat;
import com.alj.dream.match.dao.MatchDao;
import com.alj.dream.match.domain.Match;

@Service
public class ChatRoomService {

	private ChatDao dao;
	private MatchDao mdao;
	
	@Autowired 
	private SqlSessionTemplate template;
	
	// DB에 채팅데이터 가져오기(이전대화)
	public List<Chat> getChat(int myIdx, int matchidx, int reciever) {
		
		dao = template.getMapper(ChatDao.class);
		
		List<Chat> chatlist = dao.selectChatByMatchidx(matchidx);
		System.out.println("ChatRoomService : getChat :"+chatlist);
		return chatlist;
	}
	
	
	// DB에 match테이블 가져오기
	public Match getMatch(int matchidx) {
		
		mdao=template.getMapper(MatchDao.class);
		Match match = mdao.getMatchByMatchidx(matchidx);
		
		return match;
		
	}
	
	
	
	// DB에 채팅데이터 insert
	public int insertChat(Chat chat) {
		
		System.out.println(chat.getM_reciever());
		System.out.println(chat.getM_sender());
		System.out.println(chat.getMessage());
		System.out.println(chat.getMatch_idx());
		
		System.out.println("ChatInsertService : insertChat메소드");
		
		dao = template.getMapper(ChatDao.class);
		int resultCnt = dao.insertChat(chat);
		//System.out.println("Chat_IDX>>>".concat(String.valueOf(chat.getChat_idx())));
		
		System.out.println("chatinsert성공. 리턴합니다");
		
		return resultCnt;
	}


	// 채팅 나감을 표시
	public int updateMatchOutyn(int matchidx, int myidx, int reciever, String mytype) {
		System.out.println("ChatRoomService : updateMatchOutyn 진입");
		
		System.out.println(mytype);
		
		mdao=template.getMapper(MatchDao.class);
		
		System.out.println("어디야1");
		
		int menteeidx=0;
		int mentoridx=0;
		String outyn = null;
		int resultCnt = 0;
		
		System.out.println("어디야2");
		
		if(mytype.equalsIgnoreCase("mentee")) {
			menteeidx = myidx;
			mentoridx = reciever;
			
			System.out.println("어디야3");
			
			resultCnt = mdao.updateMatchOutyn(matchidx, myidx, menteeidx, mentoridx);
			
			System.out.println("어디야4");
			
//			outyn = match.getMentee_outyn();
//			System.out.println(outyn);
			
		}else if(mytype.equalsIgnoreCase("mentor")){
			menteeidx = reciever;
			mentoridx = myidx;
			
			System.out.println("어디야5");
			
			resultCnt = mdao.updateMatchOutyn(matchidx, myidx, menteeidx, mentoridx);
			
			System.out.println("어디야6");
			
//			outyn = match.getMentor_outyn();
//			System.out.println(outyn);
		}
		
	
//		if(outyn.equalsIgnoreCase("y")) {
//			//업데이트 성공. 채팅방 나감
//			resultCnt = 1;
//		}else {
//			//업데이트 실패. 채팅방 나감 업데이트 안됨
//			resultCnt = 0;
//		}
//		
		return resultCnt;
	}


	
	
	
}
