package com.alj.dream.request.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.request.service.RequestGroupService;

@Controller
public class RequestGroupContorller {

	@Autowired
	private RequestGroupService groupService;
	//받은 요청 페이지에 들어갈 그룹을 가져온다.
	
	@RequestMapping("/post/requestgroup")
	public String getGroupPage(Model model,
			Authentication auth) {
		try {
		model.addAttribute("requestGroup", groupService.getRequestGroup(auth));	// 그룹 리스트부분
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "post/requestgroup";
	}
		
	
}
