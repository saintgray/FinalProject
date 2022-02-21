package com.alj.dream.match.dao;


import java.util.List;

import com.alj.dream.match.domain.Match;
import com.alj.dream.match.domain.MatchInfo;
public interface MatchDao {

	
	public int insertMatch(Match match);
	
	public Match selectMatch(int postidx, int menteeidx, int mentoridx);
	
	public List<MatchInfo> selectMatchInfo(int post_idx);
	
	public int updateMatchOutyn(int myidx, int matchidx, int menteeidx, int mentoridx);

	public Match getMatchByMatchidx(int matchidx);

	public int getMatchDateDiff(int matchidx);

	public int updateMatchYN(String matchYN, int matchidx);
	
}
