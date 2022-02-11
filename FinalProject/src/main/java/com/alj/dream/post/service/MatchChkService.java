package com.alj.dream.post.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.Match;

import security.AccountDetails;
import sockethandler.MatchService;
@Service
public class MatchChkService {
	// 게시글에서 문의하기를 누름>> ajax통신
	// myidx,(나), midx(글쓴이), postidx, wanted를 넘겨받아 match테이블의 존재유무 확인.
	// 없으면 match테이블 생성 후 결과 리턴
	
	private PostDao dao;
	@Autowired 
	private SqlSessionTemplate template;
	
	
public int getMatch(int postidx, int midx, int myidx, String wanted) {
		System.out.println("postidx : "+postidx);
		System.out.println("midx : "+midx);
		System.out.println("myidx : "+myidx);
		System.out.println("wanted : "+wanted);
		
		System.out.println("MatchCheckService서비스 : checkMatch메소드 진입 성공");
		
		dao = template.getMapper(PostDao.class);
		
		int menteeIdx = 0;
		int mentorIdx = 0;
		
		if (wanted.equalsIgnoreCase("mentee")) {						// wanted = mentee면 상대방은 mentoridx
			mentorIdx = midx;
			menteeIdx = myidx;
		}else if(wanted.equalsIgnoreCase("mentor")) {
			menteeIdx = midx;
			mentorIdx = myidx;;
		}
		System.out.println("menteeIdx : "+menteeIdx);
		System.out.println("mentorIdx : "+mentorIdx);
		
		
		int matchIdx = 0;
		Match match=dao.selectMatch(postidx, menteeIdx, mentorIdx);		// 매칭테이블 가져오기
		System.out.println("매칭테이블가져오기성공");
		
		if(match == null) {
			match = new Match(0, null, null, null, null, postidx, menteeIdx, mentorIdx);
			System.out.println("매칭테이블 null");							// 매칭테이블이 존재하지 않는다면 테이블을 생성한다.
			matchIdx = dao.insertMatch(match);	
			System.out.println("매칭테이블저장성공");
			match=dao.selectMatch(postidx, menteeIdx, mentorIdx);	
			matchIdx = match.getMatch_idx();
		}
		System.out.println("return matchIdx : " + matchIdx);
		// 테이블존재O : insert불필요 > 0
		// 테이블존재X : insert필요  >  matchIdx가져옴
		return matchIdx;
	}
	

}
