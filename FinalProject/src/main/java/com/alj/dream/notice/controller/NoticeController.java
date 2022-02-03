package com.alj.dream.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.notice.domain.NoticePageView;
import com.alj.dream.notice.domain.PageRequest;
import com.alj.dream.notice.service.NoticeListService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeListService noticeListService;
	
	

	@GetMapping
	public String showNoticePage(Model model, PageRequest pageReq) {
		//데이터의 처리는 서비스에서
		System.out.println(pageReq.getNumOfNoticesPerPage());
		System.out.println(pageReq.getSelectPage());
//		List<Notice> list =null;
//		
//		list=noticeListService.getNoticeList();
//		
//		model.addAttribute("notices", list);
		
		model.addAttribute("notices", noticeListService.getNoticeList(pageReq));
		
		
		
		//경로만 반환
		return "notice/noticemain";
	}

	
}
