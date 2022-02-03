package com.alj.dream.review.domain;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.review.dao.ReviewDao;

@Service
public class AverageStarService {
	
	private SqlSessionTemplate sst;
	
	public AverageStarService() {

	}
	
	@Autowired
	public AverageStarService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	public String getStars(String m_idx) {
		return sst.getMapper(ReviewDao.class).getStars(m_idx);
	}
	
}
