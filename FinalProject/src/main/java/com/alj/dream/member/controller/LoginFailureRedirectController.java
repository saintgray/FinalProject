package com.alj.dream.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/loginfailed")
public class LoginFailureRedirectController {

	
	
	@GetMapping
	public String sendFailureInfos(HttpServletRequest req, RedirectAttributes ra) {
		
		Map<String, String> info=new HashMap<String, String>();
		
		info.put("insertedEmail", req.getParameter("insertedEmail"));
		info.put("msg",req.getParameter("msg"));
		
		ra.addFlashAttribute("error", info);
		
		
		
		
		return "redirect:/member/loginform";
	}
}
