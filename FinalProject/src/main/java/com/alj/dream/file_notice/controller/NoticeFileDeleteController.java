package com.alj.dream.file_notice.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.file_notice.service.NoticeFileDeleteService;

@Controller
public class NoticeFileDeleteController {
	@Autowired
	NoticeFileDeleteService delService;
	
	@PostMapping("/notice/deleteFile")
	@ResponseBody
	public String deleteFile(HttpServletRequest request, String file_nm, String file_exet) {
		
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/files/notice/attachfiles");
		String filename = file_nm + '.' + file_exet;
		
		System.out.println(saveDir);
		
		System.out.println("삭제할 파일 : " + filename);
		
		int resultCnt = delService.deleteNoticeFile(saveDir, filename);
		
		if(resultCnt==0) {
			return "error";
		}
		
		
		
		return "deleted";
	}

}
