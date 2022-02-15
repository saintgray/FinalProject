package com.alj.dream.match.dao;


import com.alj.dream.match.domain.Match;
public interface MatchDao {

	// 작성자 : 정지원
	
	// 사용 분야 : 채팅
	public int insertMatch(Match match);
	
	public Match selectMatch(int postidx, int menteeidx, int mentoridx);
	
	
	
}
