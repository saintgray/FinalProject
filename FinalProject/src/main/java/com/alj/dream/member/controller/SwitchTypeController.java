package com.alj.dream.member.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import security.AccountDetails;

// 멘토/멘티 전환 요청을 처리하는 SwitchTypeController
@Controller
@RequestMapping("/member/switchType")
public class SwitchTypeController {
	
	@GetMapping
	public void switchType(HttpServletRequest req, HttpServletResponse resp, Authentication authentication) throws IOException {
		//System.out.println(req.getHeader("referer"));
	
		String host= req.getHeader("host");
		String contextPath=req.getContextPath();
		
		
		String refToContextpath="http://".concat(host).concat(contextPath);
		String refererType=req.getHeader("referer").substring(refToContextpath.length());
		System.out.println(refererType);
		
		// 유저의 허가증 객체를 받아 멘토일시 멘티로 멘티일시 멘토로 변경한다.
		AccountDetails logininfo=(AccountDetails)authentication.getPrincipal();
	
//		System.out.println(logininfo==null);
//		System.out.println(logininfo.getM_type());
		
		logininfo.setM_type(logininfo.getM_type().equals("mentee")?"mentor":"mentee");
		
		// 보던 페이지로 리다이렉트
		if(refererType.startsWith("/chat/chatroom")) {
			resp.sendRedirect(req.getContextPath().concat("/"));
		}else {
			resp.sendRedirect(req.getHeader("referer"));
		}
		
	}
	

}
