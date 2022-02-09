package com.alj.dream.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.member.domain.PageRequest;
import com.alj.dream.member.service.MemberListService;

@Controller
@RequestMapping("/admin/member/list")
public class MemberListController {
	
	@Autowired
	private MemberListService memberListService;
	
	@GetMapping
	public String showMemberPage(HttpServletRequest request, PageRequest pageReq) {
		
		if(request.getParameter("selectPage") == null) {
			request.setAttribute("selectPage", "1");
		}
		request.setAttribute("member", memberListService.getMemberList(pageReq));
		
		
		return "admin/member/membermain";
		
	}
	

}
