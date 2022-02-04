package com.alj.dream.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice/content")
public class NoticeContentController {
	
	
	
	@GetMapping
	public String getNoticeContent(String notice_idx) {
		
		System.out.println(notice_idx);
		//////////////
		
		
		///////////////
		
		
		return "notice/noticecontent";
	}

}
