package com.alj.dream.match.dao;


import java.util.List;

import com.alj.dream.match.domain.Match;
import com.alj.dream.match.domain.MatchInfo;
public interface MatchDao {

	// 작성자 : 정지원
	
	// 사용 분야 : 채팅
	public int insertMatch(Match match);
	
	public Match selectMatch(int postidx, int menteeidx, int mentoridx);
	
	
	
	public List<MatchInfo> selectMatchInfo(int post_idx);
	
}
