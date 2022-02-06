package com.alj.dream.profile.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.profile.service.ProfileService;

import security.AccountDetails;

@Controller
@RequestMapping("/member/profile/main")
public class ProfileMainController {
	
	private ProfileService profService;
	
	public ProfileMainController() {}

	@Autowired
	public ProfileMainController(ProfileService profService) {
		this.profService = profService;
	}






	@GetMapping
	public String showProfileMain(HttpServletRequest req, Authentication authentication, Model model) {
		AccountDetails logininfo= (AccountDetails)authentication.getPrincipal();
		
		String response="member/profile/profilemain";
		
		System.out.println();
		// 프로필을 등록하다가 멘티로 전환을 할때
		// 멘티로는 프로필을 등록할 수 없으므로 홈으로 보낸다.
		if(logininfo.getM_type().equals("mentee")) {
			response="redirect:/";
			System.out.println(response);
		}else {
			try {
				model.addAttribute("profile", profService.getUserProfile(logininfo.getM_idx()));
				//model.addAttribute("error", "일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요");
			} catch (Exception e) {
				model.addAttribute("error", "일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요");
				e.printStackTrace();
			}
		}
		
		
		
		
		
		return response;
	}
	
	

}
