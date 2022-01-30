package com.alj.dream.category.controller;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alj.dream.category.domain.CategoryRequested;
import com.alj.dream.category.domain.ChildCategory;
import com.alj.dream.category.service.CategoryListService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	
	
	private CategoryListService listService;
	
	public CategoryController() {
		
	}
	
	@Autowired
	public CategoryController(CategoryListService listService) {
		
		this.listService = listService;
	}


	@GetMapping("/list")
	@ResponseBody
	public List<ChildCategory> getChildCategory(CategoryRequested cat_request) {
		
		
		
		System.out.println(cat_request.getInterest());
		if(cat_request.getInterest()==null) {
			List<String> interest= new ArrayList<String>();
			interest.add("30");
			cat_request=new CategoryRequested(interest);
		}
		List<ChildCategory> result=null;
		result= listService.getList(cat_request.getInterest());
		System.out.println(result);
		
		
	
		
		
		return 	result;
			
	}
	

}
