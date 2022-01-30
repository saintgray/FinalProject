package com.alj.dream.category.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.category.dao.CategoryDao;
@Service
public class CategoryIdxService {
	
	private SqlSessionTemplate sst;
	
	
	public CategoryIdxService() {
		// TODO Auto-generated constructor stub
	}

	@Autowired
	public CategoryIdxService(SqlSessionTemplate sst) {
	
		this.sst = sst;
	}
	
	public String getCategoryIdxByName(String cat_nm) {
		return sst.getMapper(CategoryDao.class).getCategoryIdxByName(cat_nm);
	}
	

}
