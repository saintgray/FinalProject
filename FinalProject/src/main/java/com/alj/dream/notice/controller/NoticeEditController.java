package com.alj.dream.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.notice.service.NoticeEditService;

@Controller
@RequestMapping("/admin/notice/edit")
public class NoticeEditController {

	@Autowired
	private NoticeEditService editService;
	
	@GetMapping
	public String NoticeEditPage(String notice_idx) {
		
		System.out.println(notice_idx);
		
		return "notice/noticeeditform";
	}
}
