package com.alj.dream.category.dao;

import java.util.List;

import com.alj.dream.category.domain.Category;
import com.alj.dream.category.domain.CategoryInfo;
import com.alj.dream.category.domain.ChildCategory;

public interface CategoryDao {
	
	List<ChildCategory> getChildCategory(List<String> interest);
	List<CategoryInfo> selectAll();
	List<ChildCategory> getSiblings(String idx);
	String getCatIdxByName(String cat_nm);
	Category getParentInfo(String idx);
	int editCategory(String name,String idx);
	int deleteCategory(String idx);
	int register(Category data);

}
