package com.alj.dream.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alj.dream.report.domain.Report;
import com.alj.dream.report.service.ReportInsertService;

@Controller
public class ReportInsertController {

	@Autowired
	ReportInsertService service;
	
	@GetMapping("/chat/report")
	@ResponseBody
	public ModelAndView getReportPage(
			ModelAndView mv,
			@RequestParam("matchidx") int matchidx,
			@RequestParam("sender") int reporter,
			@RequestParam("reciever") int reported) {
		
		mv.addObject("matchidx", matchidx);
		mv.addObject("reporter", reporter);
		mv.addObject("reported", reported);
		
		return mv;
	}
	
	@PostMapping("/chat/sendreport")
	public int insertReport(Report r) {
		
		System.out.println("ReportInsertController : insertReport메소드진입");
		
		int resultCnt = service.insertReport(r);
		
		
		System.out.println("ReportInsertController : insertReport메소드 resultCnt리턴 전");
		return resultCnt;
		
	}
	
	
	
}
