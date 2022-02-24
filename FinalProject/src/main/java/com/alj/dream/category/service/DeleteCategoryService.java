package com.alj.dream.category.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.category.dao.CategoryDao;

@Service
public class DeleteCategoryService {
	
	private SqlSessionTemplate sst;
	
	public DeleteCategoryService() {

	}
	
	@Autowired
	public DeleteCategoryService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	
	public int deleteCategory(String idx) {
		
		int result= sst.getMapper(CategoryDao.class).deleteCategory(idx);
		return result;
	}
	

}
