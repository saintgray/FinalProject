package com.alj.dream.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.alj.dream.admin.service.QnaListService;

@Controller
public class QnaListController {
	
	@Autowired
	private QnaListService listService;
	
	public void getGuestBookList(
			@RequestParam(value = "p", defaultValue = "1") int pageNum,
			Model model
			) {
		
		model.addAttribute("listView", listService.getPage(pageNum));
				
	}
}
