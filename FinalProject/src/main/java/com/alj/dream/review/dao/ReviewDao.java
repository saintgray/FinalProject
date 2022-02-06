package com.alj.dream.review.dao;

import com.alj.dream.review.domain.StarsInfo;

public interface ReviewDao {
	
	StarsInfo getStars(String m_idx);

}
