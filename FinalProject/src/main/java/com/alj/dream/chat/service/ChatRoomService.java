package com.alj.dream.chat.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.chat.dao.ChatDao;
import com.alj.dream.chat.domain.Chat;
import com.alj.dream.match.dao.MatchDao;
import com.alj.dream.match.domain.Match;
import com.alj.dream.member.dao.MemberDao;
import com.alj.dream.member.domain.MemberInfo;
import com.alj.dream.report.dao.ReportDao;
import com.alj.dream.report.domain.Report;
import com.alj.dream.review.dao.ReviewDao;

@Service
public class ChatRoomService {

	private ChatDao dao;
	private MatchDao mdao;
	private MemberDao memdao;
	private ReviewDao rvdao;
	private ReportDao rpdao;
	
	@Autowired 
	private SqlSessionTemplate template;
	
	// DB에 채팅데이터 가져오기(이전대화)
	public List<Chat> getChat(int matchidx) {
		
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
		
		mdao=template.getMapper(MatchDao.class);
		
		
		int menteeidx=0;
		int mentoridx=0;
		String outyn = null;
		int resultCnt = 0;
		
		
		if(mytype.equalsIgnoreCase("mentee")) {
			menteeidx = myidx;
			mentoridx = reciever;
		
			resultCnt = mdao.updateMatchOutyn(matchidx, myidx, menteeidx, mentoridx);
			
		}else if(mytype.equalsIgnoreCase("mentor")){
			menteeidx = reciever;
			mentoridx = myidx;
			
			resultCnt = mdao.updateMatchOutyn(matchidx, myidx, menteeidx, mentoridx);
			
		}
		return resultCnt;
	}

	
	
	// 매칭 가능여부 구하기
	public String getMatchDateDiff(int matchidx, String matchdate) {
		
		mdao = template.getMapper(MatchDao.class);
		
		int datediff = 0;
		String unmatchYN = null;
	
		if(matchdate == null) {
			// 매칭 날짜가 null인 것
			unmatchYN = "Y";
		}else {
			// 매칭한지 며칠 지났는지 구하기
			datediff = mdao.getMatchDateDiff(matchidx);
			
			if(datediff>3) {
				// 3일이 지나면 매칭취소가 불가능함
				unmatchYN = "N";
			}else if(datediff <=3) {
				// 3일이 지나지 않았다면 매칭취소가 가능함
				unmatchYN ="Y";
			}
		}
		return unmatchYN;
	}

	// 매칭 여부 업데이트
	public int updateMatchYN(String matchYN, int matchidx) {
		
		mdao = template.getMapper(MatchDao.class);
		
		int resultCnt = mdao.updateMatchYN(matchYN, matchidx);
		
		return resultCnt;
	}


	public MemberInfo getMemInfo(int myIdx) {
		
		memdao = template.getMapper(MemberDao.class);
		
		String m_idx = String.valueOf(myIdx);
		
		MemberInfo memInfo= memdao.getMemberInfo(m_idx);
		
		return memInfo;
	}

	// 리뷰 등록할 때
	public int regReview(int rating, String comment, int matchidx) {
		
		rvdao = template.getMapper(ReviewDao.class);
		
		int resultCnt = rvdao.insertReview(rating, comment, matchidx);
		
		return resultCnt;
	}


	// 신고 등록할 때
	public int insertReport(Report r) {
		
		rpdao = template.getMapper(ReportDao.class);
		
		int resultCnt = rpdao.insertReport(r);
		
		return resultCnt;
		
	}
	
	
}
