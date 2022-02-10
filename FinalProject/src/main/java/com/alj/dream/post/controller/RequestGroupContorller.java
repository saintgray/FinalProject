package com.alj.dream.post.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.post.service.RequestGroupService;

@Controller
public class RequestGroupContorller {

	@Autowired
	private RequestGroupService groupService;
	//받은 요청 페이지에 들어갈 그룹을 가져온다.
	
	@RequestMapping("/post/requestgroup")
	public String getGroupPage(Authentication auth,									// session에 현재 사용자 idx와 m_type을가져온다
						Model model) {
		try {
		model.addAttribute("requestGroup", groupService.getRequestGroup(auth));	// 그룹 리스트부분
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "post/requestgroup";
	}
		
	
}
