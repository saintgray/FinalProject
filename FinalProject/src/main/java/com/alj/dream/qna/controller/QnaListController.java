package com.alj.dream.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.qna.domain.PageRequest;
import com.alj.dream.qna.service.QnaListService;

@Controller
@RequestMapping("/qna/list")
public class QnaListController {
	
	private QnaListService listService;
	
	public QnaListController() {
		// TODO Auto-generated constructor stub
	}
	@Autowired
	public QnaListController(QnaListService listService) {
		this.listService = listService;
	}
	
	@GetMapping
	public String getQnaList(PageRequest pageReq, Model model) {
		
		
		try {
			model.addAttribute("pageView", listService.getQnaList(pageReq));
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "qna/qnalist";
		
	}
	

}
