package com.alj.dream.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.member.domain.PageRequest;
import com.alj.dream.member.service.MemberListService;

@Controller

public class MemberListController {
	
	@Autowired
	private MemberListService memberListService;
	
	@RequestMapping("/admin/member/list")
	public String showMemberPage(HttpServletRequest request, PageRequest pageReq) {
		System.out.println("selectPage>>>");
		System.out.println(pageReq.getSelectPage());
		
		try {
			request.setAttribute("member", memberListService.getMemberList(pageReq));
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "admin/member/membermain";
		
	}
	

}
