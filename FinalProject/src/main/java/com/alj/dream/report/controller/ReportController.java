package com.alj.dream.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.report.domain.Report;
import com.alj.dream.report.service.ReportService;

@Controller
public class ReportController {

	@Autowired
	private ReportService service;
	
	
	// 하루 신고횟수확인
		@RequestMapping(value="/report/maxrprt", method=RequestMethod.POST)
		@ResponseBody
		public int chkReport(
				@RequestParam("myidx")int myidx,
				@RequestParam("matchidx")int matchidx
				) {
			
			System.out.println("ReportInsertController : chkReport메소드진입");
			
			int resultCnt = service.chkReport(myidx,matchidx);
			
			
			System.out.println("ReportInsertController : insertReport메소드 resultCnt리턴 전");
			return resultCnt;
			
		}
	
	
	// 신고 등록할 때
	@RequestMapping(value="/report/sendreport", method=RequestMethod.POST)
	@ResponseBody
	public int insertReport(Report r) {
		
		System.out.println("ReportInsertController : insertReport메소드진입");
		
		int resultCnt = service.insertReport(r);
		
		
		System.out.println("ReportInsertController : insertReport메소드 resultCnt리턴 전");
		return resultCnt;
		
	}
	
	
}
