package com.alj.dream.category.dao;

import java.util.List;

import com.alj.dream.category.domain.ChildCategory;

public interface CategoryDao {
	
	List<ChildCategory> getChildCategory(List<String> interest);

}
