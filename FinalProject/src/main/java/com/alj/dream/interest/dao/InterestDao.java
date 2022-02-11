package com.alj.dream.interest.dao;

import java.util.List;

import com.alj.dream.category.domain.ChildCategory;
import com.alj.dream.interest.domain.Interest;


public interface InterestDao {
	
	int registerUserInterest(List<Interest> interest);
	List<ChildCategory> getUserInterest(String principal_idx);
	int deleteAllInterest(String m_idx);

}
