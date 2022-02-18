package com.alj.dream.review.dao;

import java.util.List;

import com.alj.dream.review.domain.Review;
import com.alj.dream.review.domain.StarsInfo;

public interface ReviewDao {
	
	StarsInfo getStars(String m_idx);
	List<Review> getReviewList(String mentor_idx);

}
